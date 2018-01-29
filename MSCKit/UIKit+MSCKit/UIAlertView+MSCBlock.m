//
//  UIAlertView+MSCBlock.m
//  MSCActionSheetDemo
//
//  Created by MiaoShichang on 16/3/23.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import "UIAlertView+MSCBlock.h"

#import <objc/runtime.h>

static const char *UIAlertViewMSCBlockKey;

@implementation UIAlertView (MSCBlock)

- (void)handlerClickedButton:(void (^)(NSInteger btnIndex))aBlock
{
    self.delegate = self;
    objc_setAssociatedObject(self, &UIAlertViewMSCBlockKey, aBlock, OBJC_ASSOCIATION_COPY);
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    void (^block)(NSInteger btnIndex) = objc_getAssociatedObject(self, &UIAlertViewMSCBlockKey);
    
    if (block) {
        block(buttonIndex);
    }
}


@end
