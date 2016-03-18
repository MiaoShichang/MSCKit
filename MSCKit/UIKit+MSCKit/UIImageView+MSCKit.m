//
//  UIImageView+MSCKit.m
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/23.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import "UIImageView+MSCKit.h"

@implementation UIImageView (MSCKit)

+ (UIImageView *)ex_imageViewWithImage:(UIImage *)image frame:(CGRect)aFrame
{
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setFrame:aFrame];
    [imageView setImage:image];
    
    return imageView;
}

@end
