//
//  MSCNetworkMonitor.h
//  MSCKitDemo
//
//  Created by miaoshichang on 2018/1/29.
//  Copyright © 2018年 MiaoShichang. All rights reserved.
//

#import <Foundation/Foundation.h>



// 网络类型值
typedef NS_ENUM(NSInteger, MSCNetworkType) {
    kMSCNetworkTypeNone = 0, //当前没有网络
    kMSCNetworkTypeWiFi,
    kMSCNetworkTypeWWAN,
    kMSCNetworkType2G,
    kMSCNetworkType3G,
    kMSCNetworkType4G,
};

/**
 说明：该类是一个单例类，请不要创建和初始化
 */
@interface MSCNetworkMonitor : NSObject

/**
 *@brief 当前的网络状态
 */
@property (nonatomic, readonly)MSCNetworkType networkType;

/**
 *@brief 当前的网络名称（与类型相对应的字符串）
 */
@property (nonatomic, readonly)NSString *networkName;

/**
 *@brief 单例
 */
+ (instancetype)sharedInstance;

/**
 *@brief 开始监控
 */
- (BOOL)start;

/**
 * @brief 判断当前的网络类型
 */
- (BOOL)isWIFI;
- (BOOL)isCELL;
- (BOOL)is4G;
- (BOOL)is3G;
- (BOOL)is2G;
- (BOOL)isNone;

@end

/**
 *@brief 网络类型变化时的通知
 *通知中的object对象是MSCNetworkMonitor类型，
 */
extern  NSString *const kMSCNetworkChangedNotification;
