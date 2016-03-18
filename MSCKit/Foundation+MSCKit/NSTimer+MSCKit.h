//
//  NSTimer+MSCKit.h
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/23.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (MSCKit)

/**
 * @brief  暂停NSTimer
 */
-(void)ex_pauseTimer;

/**
 * @brief  重新开始NSTimer
 */
-(void)ex_resumeTimer;

/**
 * @brief  延迟重新开始NSTimer
 *
 * @param delayInterval 延迟时间
 */
- (void)ex_resumeTimerAfterTimeInterval:(NSTimeInterval)delayInterval;

@end
