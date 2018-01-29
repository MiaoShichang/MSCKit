//
//  MSCDataCache.m
//  MSCKitDemo
//
//  Created by miaoshichang on 2018/1/29.
//  Copyright © 2018年 MiaoShichang. All rights reserved.
//

#import "MSCDataCache.h"
#import <CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>


#define MSCDataCacheSpace  @"MSCDataCacheSpace"

typedef void(^MSCDataCacheNoParamsBlock)();

// class MSCDataCache
@interface MSCDataCache ()
{
    NSFileManager *_fileManager;
}
@property (strong, nonatomic) NSCache *memCache;
@property (strong, nonatomic) NSString *diskCachePath;
@property (nonatomic, strong)dispatch_queue_t ioQueue;

@property (assign, nonatomic) NSInteger maxCacheAge;
@end

@implementation MSCDataCache

+ (MSCDataCache *)sharedDataCache
{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Create IO serial queue
        _ioQueue = dispatch_queue_create("com.360che.DataCache", DISPATCH_QUEUE_SERIAL);
        
        _memCache = [[NSCache alloc] init];
        _memCache.name = @"com.360che.DataCache";
        
        dispatch_sync(_ioQueue, ^{
            _fileManager = [NSFileManager new];
            _diskCachePath = [self cachePathForSaveData];
        });
        
        self.maxCacheAge = 60 * 60 * 24 * 3; // 3 day
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(cleanDisk)
                                                     name:UIApplicationWillTerminateNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(backgroundCleanDisk)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
    }
    return self;
}

#pragma mark - 路径管理
//【缓存的位置】
-(NSString *)cachePathForSaveData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths[0] stringByAppendingPathComponent:MSCDataCacheSpace];
    cachePath = [cachePath stringByAppendingPathComponent:@"cn.miaoshichang.dataCache"];
    if ([self existsPath:cachePath]) {
        return cachePath;
    }
    if ([self createDirectory:cachePath error:nil]) {
        return cachePath;
    }
    return nil;
}

//【路径是否存在】
- (BOOL)existsPath:(NSString *)path
{
    return [_fileManager fileExistsAtPath:path];
}

//【创建目录】
- (BOOL)createDirectory:(NSString *)directoryPath error:(NSError **)error
{
    NSString *pathLastChar = [directoryPath substringFromIndex:(directoryPath.length - 1)];
    
    if([pathLastChar isEqualToString:@"/"]){
        [NSException raise:@"Invalid path" format:@"file path can't have a trailing '/'."];
        return NO;
    }
    
    return [_fileManager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:error];
}

//【存储路径】
- (NSString *)cacheFilePathForKey:(NSString *)key
{
    NSString *filename = [self MD5From:key];
//    NSLog(@"【diskCachePath】---- %@", self.diskCachePath);
    return [self.diskCachePath stringByAppendingPathComponent:filename];
}


#pragma mark - 清理缓存
- (void)backgroundCleanDisk
{
    Class UIApplicationClass = NSClassFromString(@"UIApplication");
    if(!UIApplicationClass || ![UIApplicationClass respondsToSelector:@selector(sharedApplication)]) {
        return;
    }
    UIApplication *application = [UIApplication performSelector:@selector(sharedApplication)];
    __block UIBackgroundTaskIdentifier bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
        // Clean up any unfinished task business by marking where you
        // stopped or ending the task outright.
        [application endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }];
    
    // Start the long-running task and return immediately.
    [self cleanDiskWithCompletionBlock:^{
        [application endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }];
}

- (void)cleanDisk
{
    [self cleanDiskWithCompletionBlock:nil];
}

- (void)cleanDiskWithCompletionBlock:(MSCDataCacheNoParamsBlock)completionBlock {
    dispatch_async(self.ioQueue, ^{
        NSURL *diskCacheURL = [NSURL fileURLWithPath:self.diskCachePath isDirectory:YES];
        NSArray *resourceKeys = @[NSURLIsDirectoryKey, NSURLContentModificationDateKey, NSURLTotalFileAllocatedSizeKey];
        
        // This enumerator prefetches useful properties for our cache files.
        NSDirectoryEnumerator *fileEnumerator = [_fileManager enumeratorAtURL:diskCacheURL
                                                   includingPropertiesForKeys:resourceKeys
                                                                      options:NSDirectoryEnumerationSkipsHiddenFiles
                                                                 errorHandler:NULL];
        
        NSDate *expirationDate = [NSDate dateWithTimeIntervalSinceNow:-self.maxCacheAge];
        NSMutableDictionary *cacheFiles = [NSMutableDictionary dictionary];
        NSUInteger currentCacheSize = 0;
        
        // Enumerate all of the files in the cache directory.  This loop has two purposes:
        //
        //  1. Removing files that are older than the expiration date.
        //  2. Storing file attributes for the size-based cleanup pass.
        NSMutableArray *urlsToDelete = [[NSMutableArray alloc] init];
        for (NSURL *fileURL in fileEnumerator) {
            NSDictionary *resourceValues = [fileURL resourceValuesForKeys:resourceKeys error:NULL];
            
            // Skip directories.
            if ([resourceValues[NSURLIsDirectoryKey] boolValue]) {
                continue;
            }
            
            // Remove files that are older than the expiration date;
            NSDate *modificationDate = resourceValues[NSURLContentModificationDateKey];
            if ([[modificationDate laterDate:expirationDate] isEqualToDate:expirationDate]) {
                [urlsToDelete addObject:fileURL];
                continue;
            }
            
            // Store a reference to this file and account for its total size.
            NSNumber *totalAllocatedSize = resourceValues[NSURLTotalFileAllocatedSizeKey];
            currentCacheSize += [totalAllocatedSize unsignedIntegerValue];
            [cacheFiles setObject:resourceValues forKey:fileURL];
        }
        
        for (NSURL *fileURL in urlsToDelete) {
            [_fileManager removeItemAtURL:fileURL error:nil];
        }
        /*
         // If our remaining disk cache exceeds a configured maximum size, perform a second
         // size-based cleanup pass.  We delete the oldest files first.
         if (self.maxCacheSize > 0 && currentCacheSize > self.maxCacheSize) {
            // Target half of our maximum cache size for this cleanup pass.
            const NSUInteger desiredCacheSize = self.maxCacheSize / 2;
         
            // Sort the remaining cache files by their last modification time (oldest first).
            NSArray *sortedFiles = [cacheFiles keysSortedByValueWithOptions:NSSortConcurrent
            usingComparator:^NSComparisonResult(id obj1, id obj2) {
                return [obj1[NSURLContentModificationDateKey] compare:obj2[NSURLContentModificationDateKey]];
            }];
         
            // Delete files until we fall below our desired cache size.
             for (NSURL *fileURL in sortedFiles) {
                if ([_fileManager removeItemAtURL:fileURL error:nil]) {
                    NSDictionary *resourceValues = cacheFiles[fileURL];
                    NSNumber *totalAllocatedSize = resourceValues[NSURLTotalFileAllocatedSizeKey];
                    currentCacheSize -= [totalAllocatedSize unsignedIntegerValue];
         
                    if (currentCacheSize < desiredCacheSize) {
                        break;
                    }
                }
             }
         }
         */
        if (completionBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock();
            });
        }
    });
}

- (NSString *)MD5From:(NSString *)string
{
    if(string == nil || [string length] == 0){
        return nil;
    }
    
    const char *value = [string UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

@end



/************************************************************************************************/
@implementation MSCDataCache (Dictionary)

#pragma mark --
// bForce 如果文件存在是否覆盖原来的内容
- (void)writeContent:(NSDictionary *)content forKey:(NSString *)key force:(BOOL)bForce
{
    NSString *file = [self cacheFilePathForKey:key];
    if(![self existsPath:file]){
        [_fileManager createFileAtPath:file contents:nil attributes:nil];
        [content writeToFile:file atomically:YES];
    }
    else{
        if (bForce) {
            [content writeToFile:file atomically:YES];
        }
    }
}

#pragma mark - 公共接口

- (void)storeDictionary:(NSDictionary *)dict forKey:(NSString *)key
{
    if (key == nil || key.length == 0 || dict == nil) {
        return;
    }
    
    [self.memCache setObject:dict forKey:key];
    
    dispatch_async(self.ioQueue, ^{
        [self writeContent:dict forKey:key force:YES];
    });
}

- (void)dictionaryForKey:(NSString *)key complete:(void(^)(NSDictionary *result))complete
{
    if (complete == nil) {
        return;
    }
    
    if (key == nil && key.length == 0) {
        complete(nil);
        return;
    }
    
    NSDictionary *dict = [self.memCache objectForKey:key];
    if (dict) {
        complete(dict);
        return;
    }
    
    dispatch_async(self.ioQueue, ^{
        NSDictionary *result = [NSDictionary dictionaryWithContentsOfFile:[self cacheFilePathForKey:key]];
        complete(result);
        if (result) {
            [self.memCache setObject:result forKey:key];
        }
    });
}

- (void)deleteDictionaryForKey:(NSString *)key
{
    if (key == nil || key.length == 0) {
        return;
    }
    
    [self.memCache removeObjectForKey:key];
    
    dispatch_async(self.ioQueue, ^{
        NSString *file = [self cacheFilePathForKey:key];
        if ([self existsPath:file]) {
            NSError *error = nil;
            [_fileManager removeItemAtPath:file error:&error];
            NSLog(@"deleteDictionaryForKey error -- %@", error);
        }
    });
}

@end


