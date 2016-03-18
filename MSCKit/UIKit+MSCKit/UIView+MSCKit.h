//
//  UIView+MSCKit.h
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/18.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MSCKit)

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - frame
////////////////////////////////////////////////////////////////////////////////////////////////////
/**
 *@brief 简化UIView的坐标操作
 */
@property(nonatomic, assign) CGFloat ex_left;   // = view.frame.x
@property(nonatomic, assign) CGFloat ex_top;    // = view.frame.y
@property(nonatomic, assign) CGFloat ex_width;
@property(nonatomic, assign) CGFloat ex_height;
@property(nonatomic, readonly) CGFloat ex_right;
@property(nonatomic, readonly) CGFloat ex_bottom;

@property (nonatomic, assign)CGPoint ex_origin;  // = view.frame.origin
@property (nonatomic, assign)CGSize ex_size;     // = view.frame.size

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 *@brief 设置圆角半径
 *
 *@param radius 半径值
 */
- (void)ex_setCornerRadius:(CGFloat)radius;




@end
