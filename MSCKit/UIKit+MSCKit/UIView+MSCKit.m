//
//  UIView+MSCKit.m
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/18.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import "UIView+MSCKit.h"

@implementation UIView (MSCKit)

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - fraem
////////////////////////////////////////////////////////////////////////////////////////////////////

- (CGFloat)ex_left
{
    return self.frame.origin.x;
}

- (void)setEx_left:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)ex_top
{
    return self.frame.origin.y;
}

- (void)setEx_top:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)ex_width
{
    return self.frame.size.width;
}

- (void)setEx_width:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)ex_height
{
    return self.frame.size.height;
}

- (void)setEx_height:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)ex_right
{
    return [self ex_left] + [self ex_width];
}

- (CGFloat)ex_bottom
{
    return [self ex_top] + [self ex_height];
}

- (CGPoint)ex_origin
{
    return self.frame.origin;
}

- (void)setEx_origin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)ex_size
{
    return self.frame.size;
}

- (void)setEx_size:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)ex_centerX
{
    return self.center.x;
}

- (void)setEx_centerX:(CGFloat)centerX
{
    CGPoint center = CGPointMake(centerX, self.center.y);
    self.center = center;
}

- (CGFloat)ex_centerY
{
    return self.center.y;
}

- (void)setEx_centerY:(CGFloat)centerY
{
    CGPoint center = CGPointMake(self.center.x, centerY);
    self.center = center;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 
////////////////////////////////////////////////////////////////////////////////////////////////////

//【设置圆角半径】
- (void)ex_setCornerRadius:(CGFloat)radius
{
    self.layer.cornerRadius = radius;
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
}







































@end
