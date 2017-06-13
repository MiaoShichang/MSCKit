//
//  NSNumber+MSCKit.h
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/3.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSNumber (MSCKit)

/**获取随机数*/
+ (CGFloat)ex_randomFloatBetweenMin:(CGFloat)minValue andMax:(CGFloat)maxValue;

+ (NSInteger)ex_randomIntBetweenMin:(NSInteger)minValue andMax:(NSInteger)maxValue;

+ (CGFloat)ex_randomFloat;

@end
