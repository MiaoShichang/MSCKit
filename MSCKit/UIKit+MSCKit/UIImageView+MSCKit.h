//
//  UIImageView+MSCKit.h
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/23.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * @brief 添加一些实用的方法
 */

@interface UIImageView (MSCKit)

/**
 * @brief 根据给定的参数创建 UIImageView 对象
 * 
 * @param image     UIImageView的image
 * @param aFrame    UIImageView的frame
 * @return          返回一个UIImageView对象
 */
+ (UIImageView *)ex_imageViewWithImage:(UIImage *)image frame:(CGRect)aFrame;

@end
