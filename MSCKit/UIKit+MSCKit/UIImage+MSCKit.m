//
//  UIImage+MSCKit.m
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/18.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import "UIImage+MSCKit.h"

@implementation UIImage (MSCKit)


+ (UIImage *)ex_imageWithColor:(UIColor *)color
{
    return [self ex_imageWithBounds:CGSizeMake(1, 1) color:color];
}

+ (UIImage *)ex_imageWithBounds:(CGSize)size color:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
