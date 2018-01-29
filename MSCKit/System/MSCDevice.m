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
    
    if ([model isEqualToString:@"iPhone7,2"])                return @"iPhone 6 (A1549/A1586)";
    else if ([model isEqualToString:@"iPhone7,1"])           return @"iPhone 6 Plus (A1522/A1524)";
    else if ([model isEqualToString:@"iPhone8,2"])           return @"iPhone 6s Plus (A1634/A1687)";
    else if ([model isEqualToString:@"iPhone8,1"])           return @"iPhone 6s (A1633/A1688)";
    else if ([model isEqualToString:@"iPhone9,1"] || [model isEqualToString:@"iPhone9,3"])       return @"iPhone 7";
    else if ([model isEqualToString:@"iPhone9,2"] || [model isEqualToString:@"iPhone9,4"])       return @"iPhone 7 Plus";
    else if ([model isEqualToString:@"iPhone10,1"] || [model isEqualToString:@"iPhone10,4"])     return @"iPhone 8";
    else if ([model isEqualToString:@"iPhone10,2"] || [model isEqualToString:@"iPhone10,5"])     return @"iPhone 8 Plus";
    else if ([model isEqualToString:@"iPhone10,3"] || [model isEqualToString:@"iPhone10,6"])     return @"iPhone X";
    // 老设备
    else if ([model isEqualToString:@"iPhone1,1"])           return @"iPhone 1G";
    else if ([model isEqualToString:@"iPhone1,2"])           return @"iPhone 3G";
    else if ([model isEqualToString:@"iPhone2,1"])           return @"iPhone 3GS";
    else if ([model isEqualToString:@"iPhone3,1"])           return @"iPhone 4";
    else if ([model isEqualToString:@"iPhone3,3"])           return @"Verizon iPhone 4";
    else if ([model isEqualToString:@"iPhone4,1"])           return @"iPhone 4S";
    else if ([model isEqualToString:@"iPhone5,1"])           return @"iPhone 5 (A1428)";
    else if ([model isEqualToString:@"iPhone5,2"])           return @"iPhone 5 (A1429/A1442)";
    else if ([model isEqualToString:@"iPhone5,3"])           return @"iPhone 5c (A1456/A1532)";
    else if ([model isEqualToString:@"iPhone5,4"])           return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    else if ([model isEqualToString:@"iPhone6,1"])           return @"iPhone 5s (A1453/A1533)";
    else if ([model isEqualToString:@"iPhone6,2"])           return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    
    // iPod
    if ([model isEqualToString:@"iPod1,1"])                  return @"iPod Touch 1G";
    else if ([model isEqualToString:@"iPod2,1"])             return @"iPod Touch 2G";
    else if ([model isEqualToString:@"iPod3,1"])             return @"iPod Touch 3G";
    else if ([model isEqualToString:@"iPod4,1"])             return @"iPod Touch 4G";
    else if ([model isEqualToString:@"iPod5,1"])             return @"iPod Touch 5G";
    //
    else if ([model isEqualToString:@"iPad1,1"])             return @"iPad";
    else if ([model isEqualToString:@"iPad2,1"])             return @"iPad 2 (WiFi)";
    else if ([model isEqualToString:@"iPad2,2"])             return @"iPad 2 (GSM)";
    else if ([model isEqualToString:@"iPad2,3"])             return @"iPad 2 (CDMA)";
    else if ([model isEqualToString:@"iPad2,4"])             return @"iPad 2";
    else if ([model isEqualToString:@"iPad2,5"])             return@"iPad Mini 1G";
    else if ([model isEqualToString:@"iPad2,6"])             return@"iPad Mini 1G";
    else if ([model isEqualToString:@"iPad2,7"])             return@"iPad Mini 1G";
    //
    else if ([model isEqualToString:@"iPad3,1"])             return@"iPad 3";
    else if ([model isEqualToString:@"iPad3,2"])             return@"iPad 3";
    else if ([model isEqualToString:@"iPad3,3"])             return@"iPad 3";
    else if ([model isEqualToString:@"iPad3,4"])             return@"iPad 4";
    else if ([model isEqualToString:@"iPad3,5"])             return@"iPad 4";
    else if ([model isEqualToString:@"iPad3,6"])             return@"iPad 4";
    else if ([model isEqualToString:@"iPad4,1"])             return@"iPad Air";
    else if ([model isEqualToString:@"iPad4,2"])             return@"iPad Air";
    else if ([model isEqualToString:@"iPad4,3"])             return@"iPad Air";
    else if ([model isEqualToString:@"iPad4,4"])             return@"iPad Mini 2G";
    else if ([model isEqualToString:@"iPad4,5"])             return@"iPad Mini 2G";
    else if ([model isEqualToString:@"iPad4,6"])             return@"iPad Mini 2G";
    else if ([model isEqualToString:@"iPad4,7"])             return@"iPad Mini 3";
    else if ([model isEqualToString:@"iPad4,8"])             return@"iPad Mini 3";
    else if ([model isEqualToString:@"iPad4,9"])             return@"iPad Mini 3";
    else if ([model isEqualToString:@"iPad5,1"])             return@"iPad Mini 4";
    else if ([model isEqualToString:@"iPad5,2"])             return@"iPad Mini 4";
    else if ([model isEqualToString:@"iPad5,3"])             return@"iPad Air 2";
    else if ([model isEqualToString:@"iPad5,4"])             return@"iPad Air 2";
    else if ([model isEqualToString:@"iPad6,3"])             return@"iPad Pro 9.7";
    else if ([model isEqualToString:@"iPad6,4"])             return@"iPad Pro 9.7";
    else if ([model isEqualToString:@"iPad6,7"])             return@"iPad Pro 12.9";
    else if ([model isEqualToString:@"iPad6,8"])             return@"iPad Pro 12.9";
    
    
    else if ([model isEqualToString:@"i386"])                return @"Simulator";
    else if ([model isEqualToString:@"x86_64"])              return @"Simulator";
    
    
    return model ? model : @"";
}

+ (BOOL)isIPhoneX
{
    NSString *model = [self modelType];
    return ([model isEqualToString:@"iPhone10,3"] || [model isEqualToString:@"iPhone10,6"]);
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
