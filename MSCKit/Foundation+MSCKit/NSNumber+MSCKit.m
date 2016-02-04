//
//  NSNumber+MSCKit.m
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/3.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import "NSNumber+MSCKit.h"


#define MSCKIT_ARC4RANDOM_MAX      0x100000000

@implementation NSNumber (MSCKit)

+ (CGFloat)ex_randomFloatBetweenMin:(CGFloat)minValue andMax:(CGFloat)maxValue
{
    return (((float) (arc4random() % ((unsigned)MSCKIT_ARC4RANDOM_MAX + 1)) / MSCKIT_ARC4RANDOM_MAX) * (maxValue - minValue)) + minValue;
}

+ (NSInteger)ex_randomIntBetweenMin:(NSInteger)minValue andMax:(NSInteger)maxValue
{
    return (NSInteger)(minValue + [self ex_randomFloat] * (maxValue - minValue));
}

+ (CGFloat)ex_randomFloat
{
    return (float)arc4random() / MSCKIT_ARC4RANDOM_MAX;
}



@end
