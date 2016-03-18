//
//  UIColor+MSCKit.h
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/18.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (MSCKit)

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 【property】
////////////////////////////////////////////////////////////////////////////////////////////////////

@property (nonatomic, readonly)CGFloat ex_red;
@property (nonatomic, readonly)CGFloat ex_green;
@property (nonatomic, readonly)CGFloat ex_blue;
@property (nonatomic, readonly)CGFloat ex_alpha;


////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 【-方法】
////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * @brief Returns a color in the same color space as the receiver with the specified alpha component.
 */
- (UIColor *)ex_colorWithAlphaComponent:(CGFloat)alpha;



////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 【+方法】
////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * @brief 按照给定的十六进制的字符串创建一个UIColor
 *
 *  支持下面的字符串类型：
 *  - #RGB
 *  - #ARGB
 *  - #RRGGBB
 *  - #AARRGGBB
 *
 * @param hexString 十六进制字符串
 * @return 返回一个UIColor对象
 */
+ (UIColor *)ex_colorWithHexString:(NSString *)hexString;

/**
 * @brief 按照给定的十六进制的字符串和alpha值 创建一个UIColor , 主要是为了将颜色值和alpha值分开设置
 *
 *  仅支持下面的字符串类型：
 *  - #RRGGBB
 *
 * @param hexString 十六进制字符串
 * @param alpha alpha值
 * @return 返回UIColor对象
 */
+ (UIColor *)ex_colorWithRRGGBBHexString:(NSString *)hexString alpha:(float)alpha;

/**
 * @brief 获取一个随机颜色UIColor对象
 */
+ (UIColor *)ex_randomColor;

/**
 * @brief 根据给定的16进制的RGB颜色值 创建一个UIColor对象，
 * 
 * @param hexValue   十六进制的RBG值, 例如：0xAABBCC
 * @param aplpha     aplpha值 ,[0, 1]
 * @return  返回UIColor实例对象
 */
+ (UIColor *)ex_colorWithHexValue:(NSUInteger)hexValue alpha:(CGFloat)alpha;



@end
