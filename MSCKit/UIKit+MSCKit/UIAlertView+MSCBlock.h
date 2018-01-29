//
//  UIAlertView+MSCBlock.h
//  MSCActionSheetDemo
//
//  Created by MiaoShichang on 16/3/23.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import <UIKit/UIKit.h>


/*
 * 对UIAlertView点击事件的封装
 */
@interface UIAlertView (MSCBlock)

- (void)handlerClickedButton:(void (^)(NSInteger btnIndex))aBlock;

@end
