//
//  UIViewDrawRect.m
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/18.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import "UIViewDrawRect.h"

@implementation UIViewDrawRect


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    // Drawing code
//    UIBezierPath* p = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,0,100,100)];
//    
//    [[UIColor blueColor] setFill];
//    
//    [p fill];
//}


@end


@implementation MSCA

@end

@implementation MSCB

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"B -- %@", NSStringFromClass(self.class));
        NSLog(@"super-%@", NSStringFromClass([super class]));
    }
    return self;
}

@end