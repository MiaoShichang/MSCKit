//
//  NSFileManager+MSCKit.m
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/23.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import "NSFileManager+MSCKit.h"

@implementation NSFileManager (MSCKit)


+ (NSString *)p_pathForDirectory:(NSSearchPathDirectory)directory
{
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES)[0];
}


+ (NSString *)ex_documentsDirectory
{
    return [self p_pathForDirectory:NSDocumentDirectory];
}

+ (NSString *)ex_libraryDirectory
{
    return [self p_pathForDirectory:NSLibraryDirectory];
}

+ (NSString *)ex_cachesDirectory
{
    return [self p_pathForDirectory:NSCachesDirectory];
}

+ (NSString *)ex_temporaryDirectory
{
    return NSTemporaryDirectory();
}


@end
