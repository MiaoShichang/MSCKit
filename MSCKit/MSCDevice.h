//
//  MSCSystem.h
//  MSCKitDemo
//
//  Created by MiaoShichang on 15/10/29.
//  Copyright © 2015年 MiaoShichang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSCDevice : NSObject

// 设备名称
+ (NSString *)name;

// 设备型号 @"iPhone", @"iPod touch"
+ (NSString *)model;
// 设备型号--例如：iPhone7,2
+ (NSString *)modelType;
// 设备具体型号--例如：iPhone 6 (A1549/A1586)
+ (NSString *)modelName;

// 当前连接无线网的名称
+ (NSString *)currentWiFiName;
// 手机运营商名称，例如：中国移动
+ (NSString *)carrierName;


@end
