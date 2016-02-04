//
//  NSArray+MSCKit.m
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/3.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import "NSArray+MSCKit.h"

@implementation NSArray (MSCKit)

- (id _Nullable)ex_safeObjectAtIndex:(NSUInteger)index
{
    if ([self count] > 0 && [self count] > index) {
        return [self objectAtIndex:index];
    } else {
        return nil;
    }
}

//【转换成JSON字符串】
- (NSString * _Nonnull)ex_convertToJsonString
{
    NSString *json = nil;
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
    if (!error) {
        json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return json;
    } else {
        return error.localizedDescription;
    }
}

@end
