//
//  MSCNetworkMonitor.m
//  MSCKitDemo
//
//  Created by miaoshichang on 2018/1/29.
//  Copyright © 2018年 MiaoShichang. All rights reserved.
//

#import "MSCNetworkMonitor.h"
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <UIKit/UIKit.h>


NSString * const kMSCNetworkChangedNotification = @"kMSCNetworkChangedNotification";

static void msc_reachabilityCallback(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void* info)
{
    NSCAssert(info != NULL, @"info was NULL in msc_reachabilityCallback");
    
    if ([(__bridge NSObject *)info isKindOfClass:MSCNetworkMonitor.class])
    {
        MSCNetworkMonitor* noteObject = (__bridge MSCNetworkMonitor *)info;
        
        // Post a notification to notify the client that the network reachability changed.
        [[NSNotificationCenter defaultCenter] postNotificationName: kMSCNetworkChangedNotification object: noteObject];
    }
    else {
#if DEBUG
        NSLog(@"【info was wrong class in msc_reachabilityCallback】");
#endif
    }
}


// class MSCNetworkMonitor
@interface MSCNetworkMonitor ()
{
    SCNetworkReachabilityRef _reachabilityRef;
}

@end

@implementation MSCNetworkMonitor

+ (instancetype)sharedInstance
{
    static dispatch_once_t s_onceToken;
    static id s_sharedInstance;
    
    dispatch_once(&s_onceToken, ^{
        s_sharedInstance = [self new];
    });
    
    return s_sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self setupMonitor];
    }
    
    return self;
}

#pragma mark - 辅助函数
- (void)setupMonitor
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr *)&zeroAddress);
    
    if (reachability != NULL)
    {
        self->_reachabilityRef = reachability;
    }
}

#pragma mark - Start and stop monitor
// 启动网络状态的监测
- (BOOL)startMonitor
{
    BOOL returnValue = NO;
    SCNetworkReachabilityContext context = {0, (__bridge void *)(self), NULL, NULL, NULL};
    
    if (SCNetworkReachabilitySetCallback(_reachabilityRef, msc_reachabilityCallback, &context))
    {
        if (SCNetworkReachabilityScheduleWithRunLoop(_reachabilityRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode))
        {
            returnValue = YES;
        }
    }
    
    return returnValue;
}


// 停止网络状态的监测
- (void)stopMonitor
{
    if (_reachabilityRef != NULL)
    {
        SCNetworkReachabilityUnscheduleFromRunLoop(_reachabilityRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
    }
}


- (void)dealloc
{
    [self stopMonitor];
    
    if (_reachabilityRef != NULL)
    {
        CFRelease(_reachabilityRef);
    }
}

#pragma mark - Network Flag Handling
- (MSCNetworkType)networkTypeForFlags:(SCNetworkReachabilityFlags)flags
{
    if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
    {
        return kMSCNetworkTypeNone;
    }
    
    MSCNetworkType returnValue = kMSCNetworkTypeNone;
    
    if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
    {
        returnValue = kMSCNetworkTypeWiFi;
    }
    
    if (((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
        ((flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
    {
        if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
        {
            returnValue = kMSCNetworkTypeWiFi;
        }
    }
    
    if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
    {
        if (floor(NSFoundationVersionNumber) > floor(993.00)) // iOS 7+ (NSFoundationVersionNumber_iOS_6_1)
        {
            CTTelephonyNetworkInfo * info = [[CTTelephonyNetworkInfo alloc] init];
            NSString *currentRadioAccessTechnology = info.currentRadioAccessTechnology;
            
            if (currentRadioAccessTechnology)
            {
                if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE])
                {
                    returnValue =  kMSCNetworkType4G;
                }
                else if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyEdge] || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyGPRS])
                {
                    returnValue =  kMSCNetworkType2G;
                }
                else
                {
                    returnValue =  kMSCNetworkType3G;
                }
                
                return returnValue;
            }
        }
        
        if ((flags & kSCNetworkReachabilityFlagsTransientConnection) == kSCNetworkReachabilityFlagsTransientConnection)
        {
            if((flags & kSCNetworkReachabilityFlagsConnectionRequired) == kSCNetworkReachabilityFlagsConnectionRequired)
            {
                returnValue =  kMSCNetworkType2G;
                return returnValue;
            }
            
            returnValue =  kMSCNetworkType3G;
            return returnValue;
        }
        
        returnValue = kMSCNetworkTypeWWAN;
    }
    
    return returnValue;
}

- (MSCNetworkType)currentNetworkType
{
    NSAssert(_reachabilityRef != NULL, @"currentNetworkType called with NULL SCNetworkReachabilityRef");
    
    MSCNetworkType returnValue = kMSCNetworkTypeNone;
    SCNetworkReachabilityFlags flags;
    
    if (SCNetworkReachabilityGetFlags(_reachabilityRef, &flags))
    {
        returnValue = [self networkTypeForFlags:flags];
    }
    
    return returnValue;
}

- (MSCNetworkType)networkType
{
    return [self currentNetworkType];
}

- (NSString *)networkName
{
    NSString *string = @"NONE";
    switch (self.networkType)
    {
        case kMSCNetworkTypeNone:
            string = @"NONE";
            break;
        case kMSCNetworkTypeWiFi:
            string = @"WIFI";
            break;
        case kMSCNetworkTypeWWAN:
            string = @"CELL";
            break;
        case kMSCNetworkType2G:
            string = @"2G";
            break;
        case kMSCNetworkType3G:
            string = @"3G";
            break;
        case kMSCNetworkType4G:
            string = @"4G";
            break;
        default:
            string = @"NONE";
            break;
    }
    
    return string;
}

- (BOOL)isNone
{
    return self.networkType == kMSCNetworkTypeNone;
}

- (BOOL)isWIFI
{
    return self.networkType == kMSCNetworkTypeWiFi;
}

- (BOOL)isCELL
{
    return self.networkType == kMSCNetworkTypeWWAN;
}

- (BOOL)is4G
{
    return self.networkType == kMSCNetworkType4G;
}

- (BOOL)is3G
{
    return self.networkType == kMSCNetworkType3G;
}

- (BOOL)is2G
{
    return self.networkType == kMSCNetworkType2G;
}

- (BOOL)start
{
    return [self startMonitor];
}

@end
