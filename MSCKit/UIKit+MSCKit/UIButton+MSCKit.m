//
//  UIButton+MSCKit.m
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/23.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import "UIButton+MSCKit.h"

@implementation UIButton (MSCKit)

+ (UIButton *)ex_buttonWithFrame:(CGRect)aFrame title:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:aFrame];
    [button setTitle:title forState:UIControlStateNormal];
    
    return button;
}

+ (UIButton *)ex_buttonWithFrame:(CGRect)aFrame image:(UIImage *)image
{
    return [self ex_buttonWithFrame:aFrame image:image highlightedImage:nil];
}

+ (UIButton *)ex_buttonWithFrame:(CGRect)frame image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highlightedImage forState:UIControlStateHighlighted];
    
    return button;
}

- (void)ex_setTitleFont:(UIFont *)font
{
    [self.titleLabel setFont:font];
}

- (void)ex_setTitleColor:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateNormal];
}

- (void)ex_setTitleColor:(UIColor *)color highlightedColor:(UIColor *)highlightedColor
{
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitleColor:highlightedColor forState:UIControlStateHighlighted];
}

- (void)ex_setBackgroundImage:(UIImage *)bgImage
{
    [self setBackgroundImage:bgImage forState:UIControlStateNormal];
}

- (void)ex_setBackgroundImage:(UIImage *)bgImage highlighted:(UIImage *)highlightedBgImage
{
    [self setBackgroundImage:bgImage forState:UIControlStateNormal];
    [self setBackgroundImage:highlightedBgImage forState:UIControlStateHighlighted];
}

@end
