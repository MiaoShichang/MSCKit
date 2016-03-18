//
//  UIButton+MSCKit.h
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/23.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 * @brief 一些简单实用的方法
 */

@interface UIButton (MSCKit)

/**
 * @brief 根据一些参数，创建按钮
 */
+ (UIButton *)ex_buttonWithFrame:(CGRect)aFrame title:(NSString *)title;
+ (UIButton *)ex_buttonWithFrame:(CGRect)aFrame image:(UIImage *)image;
+ (UIButton *)ex_buttonWithFrame:(CGRect)frame image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage;

/**
 * @brief 设置按钮的标题字体
 * 
 * @param font 标题字体
 */
- (void)ex_setTitleFont:(UIFont *)font;

/**
 * @brief 设置按钮标题的颜色
 *
 * @param color 正常标题颜色
 * @param highlightedColor 高亮标题颜色
 */
- (void)ex_setTitleColor:(UIColor *)color;
- (void)ex_setTitleColor:(UIColor *)color highlightedColor:(UIColor *)highlightedColor;

/**
 * @brief 设置按钮标题的背景图片
 *
 * @param bgImage 按钮的背景图片
 * @param highlightedBgImage 按钮的高亮背景图片
 */
- (void)ex_setBackgroundImage:(UIImage *)bgImage;
- (void)ex_setBackgroundImage:(UIImage *)bgImage highlighted:(UIImage *)highlightedBgImage;

@end
