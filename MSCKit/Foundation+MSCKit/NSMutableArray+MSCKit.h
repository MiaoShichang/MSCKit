//
//  NSMutableArray+MSCKit.h
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/3.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (MSCKit)

/**
 添加对象
 */
- (void)ex_addObject:(id)anObject;

/**
 插入对象
 */
- (void)ex_insertObject:(id)anObject atIndex:(NSUInteger)index;

/**
 移除对象
 */
- (void)ex_removeObjectAtIndex:(NSUInteger)index;

@end
