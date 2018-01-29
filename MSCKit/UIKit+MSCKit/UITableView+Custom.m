//
//  UITableView+Custom.m
//  truckHome
//
//  Created by miaoshichang on 2017/5/15.
//  Copyright © 2017年 卡车之家. All rights reserved.
//

#import "UITableView+Custom.h"

@implementation UITableView (Custom)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)ex_scrollToBottom
{
    CGFloat yOffset = 0; //设置要滚动的位置 0最顶部 CGFLOAT_MAX最底部
    
    if (self.contentSize.height > self.bounds.size.height)
    {
        yOffset = self.contentSize.height - self.bounds.size.height;
    }
    
    [self setContentOffset:CGPointMake(0, yOffset) animated:NO];
}

- (void)ex_scrollToTop
{
    CGFloat yOffset = 0; //设置要滚动的位置 0最顶部 CGFLOAT_MAX最底部
    
    [self setContentOffset:CGPointMake(0, yOffset) animated:NO];
}

@end
