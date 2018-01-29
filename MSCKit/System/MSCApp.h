//
//  MSCApp.h
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/23.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSCApp : NSObject

/**
 * @brief APP的显示名字
 */
+ (NSString *)appName;

/**
 * @brief APP的版本号
 */
+ (NSString *)appVersion;

/**
 * @brief APP的编译版本号
 */
+ (NSString *)appBuildVersion;

/**
 * @brief APP的identifier
 */
+ (NSString *)appIdentifier;

/**
 * @brief 是否是第一次启动当前版本
 */
+ (void)onFirstStartAPPForCurrentVersion:(void (^)(BOOL isFirst))block;

@end
