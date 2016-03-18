//
//  NSTimer+MSCKit.m
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/23.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import "NSTimer+MSCKit.h"

@implementation NSTimer (MSCKit)

/**
 * @brief  暂停NSTimer
 */
-(void)ex_pauseTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
}

/**
 *  @brief  开始NSTimer
 */
-(void)ex_resumeTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate date]];
}

/**
 *  @brief  延迟开始NSTimer
 */
- (void)ex_resumeTimerAfterTimeInterval:(NSTimeInterval)delayInterval
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:delayInterval]];
}

@end
