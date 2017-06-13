//
//  NSMutableArray+MSCKit.m
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/3.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import "NSMutableArray+MSCKit.h"

@implementation NSMutableArray (MSCKit)

- (void)ex_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (anObject && index<=self.count)
    {
        [self insertObject:anObject atIndex:index];
    }
}

- (void)ex_addObject:(id)anObject
{
    if (anObject)
    {
        [self addObject:anObject];
    }
}

- (void)ex_removeObjectAtIndex:(NSUInteger)index
{
    if (index < self.count)
    {
        [self removeObjectAtIndex:index];
    }
}

@end
