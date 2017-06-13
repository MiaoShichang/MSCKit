//
//  NSMutableDictionary+MSCKit.m
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/3.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import "NSMutableDictionary+MSCKit.h"

@implementation NSMutableDictionary (MSCKit)

- (void)ex_setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (anObject && aKey)
    {
        [self setObject:anObject forKey:aKey];
    }
}

@end
