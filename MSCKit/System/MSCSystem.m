//
//  MSCSystem.m
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/23.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import "MSCSystem.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation MSCSystem


+ (void)vibrateDevice
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

@end
