//
//  MSCDataCache.h
//  MSCKitDemo
//
//  Created by miaoshichang on 2018/1/29.
//  Copyright © 2018年 MiaoShichang. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * 数据缓存封装，目前只实现了对Dictionary类型的数据缓存，其他数据的缓存以后补充
 * 注意，此次封装的数据缓存，在遇到内容警告时会释放缓存的数据，请谨慎使用
 */
@interface MSCDataCache : NSObject
+ (MSCDataCache *)sharedDataCache;
@end



@interface MSCDataCache (Dictionary)
- (void)storeDictionary:(NSDictionary *)dict forKey:(NSString *)key;
- (void)dictionaryForKey:(NSString *)key complete:(void(^)(NSDictionary *result))complete;
- (void)deleteDictionaryForKey:(NSString *)key;
@end
