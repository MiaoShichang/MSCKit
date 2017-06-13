//
//  MSCSystem.m
//  MSCKitDemo
//
//  Created by MiaoShichang on 15/10/29.
//  Copyright © 2015年 MiaoShichang. All rights reserved.
//

#import "MSCDevice.h"
#import <UIKit/UIKit.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <sys/sysctl.h>
@import CoreTelephony;

@implementation MSCDevice

+ (NSString *)name
{
    return ([[UIDevice currentDevice] name] ?: @"");
}

// e.g. @"iPhone", @"iPod touch"
+ (NSString *)model
{
    return [[UIDevice currentDevice] model];
}

/*
 SSID 就是您搜索到的无线WIFI的名称，可以在路由器里面修改。
 SSID是Service Set Identifier的缩写，意思是：服务集标识
 */
+ (NSString *)currentWiFiName
{
    NSString *ssid = nil;
#if !TARGET_IPHONE_SIMULATOR
    NSArray *interfaces = CFBridgingRelease(CNCopySupportedInterfaces());
    for (NSString *name in interfaces) {
        CFStringRef interface = (__bridge CFStringRef)name; // @"en0"
        NSDictionary *info = CFBridgingRelease(CNCopyCurrentNetworkInfo(interface));
        if (info[@"SSID"]) {
            ssid = info[@"SSID"];
            break;
        }
    }
#endif
    return ssid ?: @"";
}

+ (NSString *)modelType
{
    static NSString *__gPlatfrom = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        char *machine = malloc(size);
        sysctlbyname("hw.machine", machine, &size, NULL, 0);
        NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
        free(machine);
        __gPlatfrom = platform ?: @"";
    });
    return __gPlatfrom;
}

+ (NSString *)modelName
{
    NSString *model = [self modelType];
    
    if ([model isEqualToString:@"iPhone1,1"]) {
        return @"iPhone 1G";
    }
    if ([model isEqualToString:@"iPhone1,2"]) {
        return @"iPhone 3G";
    }
    if ([model isEqualToString:@"iPhone2,1"]) {
        return @"iPhone 3GS";
    }
    if ([model isEqualToString:@"iPhone3,1"]) {
        return @"iPhone 4";
    }
    if ([model isEqualToString:@"iPhone3,3"]) {
        return @"Verizon iPhone 4";
    }
    if ([model isEqualToString:@"iPhone4,1"]) {
        return @"iPhone 4S";
    }
    if ([model isEqualToString:@"iPhone5,1"]) {
        return @"iPhone 5 (A1428)";
    }
    if ([model isEqualToString:@"iPhone5,2"]) {
        return @"iPhone 5 (A1429/A1442)";
    }
    if ([model isEqualToString:@"iPhone5,3"]) {
        return @"iPhone 5c (A1456/A1532)";
    }
    if ([model isEqualToString:@"iPhone5,4"]) {
        return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    }
    if ([model isEqualToString:@"iPhone6,1"]) {
        return @"iPhone 5s (A1453/A1533)";
    }
    if ([model isEqualToString:@"iPhone6,2"]) {
        return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    }
    if ([model isEqualToString:@"iPhone7,2"]) {
        return @"iPhone 6 (A1549/A1586)";
    }
    if ([model isEqualToString:@"iPhone7,1"]) {
        return @"iPhone 6 Plus (A1522/A1524)";
    }
    if ([model isEqualToString:@"iPhone8,2"]) {
        return @"iPhone 6s Plus (A1634/A1687)";
    }
    if ([model isEqualToString:@"iPhone8,1"]) {
        return @"iPhone 6s (A1633/A1688)";
    }
    if ([model isEqualToString:@"iPod1,1"]) {
        return @"iPod Touch 1G";
    }
    if ([model isEqualToString:@"iPod2,1"]) {
        return @"iPod Touch 2G";
    }
    if ([model isEqualToString:@"iPod3,1"]) {
        return @"iPod Touch 3G";
    }
    if ([model isEqualToString:@"iPod4,1"]) {
        return @"iPod Touch 4G";
    }
    if ([model isEqualToString:@"iPad1,1"]) {
        return @"iPad";
    }
    if ([model isEqualToString:@"iPad2,1"]) {
        return @"iPad 2 (WiFi)";
    }
    if ([model isEqualToString:@"iPad2,2"]) {
        return @"iPad 2 (GSM)";
    }
    if ([model isEqualToString:@"iPad2,3"]) {
        return @"iPad 2 (CDMA)";
    }
    if ([model isEqualToString:@"iPad2,4"]) {
        return @"iPad 2";
    }
    if ([model isEqualToString:@"iPad3,1"]) {
        return @"iPad-3G (WiFi)";
    }
    if ([model isEqualToString:@"iPad3,2"]) {
        return @"iPad-3G (4G)";
    }
    if ([model isEqualToString:@"iPad3,3"]) {
        return @"iPad-3G (4G)";
    }
    if ([model isEqualToString:@"i386"]) {
        return @"Simulator";
    }
    if ([model isEqualToString:@"x86_64"]) {
        return @"Simulator";
    }
    
    return model ? model : @"";
}

//
+ (NSString *)carrierName
{
    CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier_t = [netInfo subscriberCellularProvider];
    NSString *carrier = [carrier_t carrierName];
    return carrier ?: @"";
}

@end
