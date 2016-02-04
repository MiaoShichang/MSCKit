//
//  NSDictionary+MSCKit.m
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/3.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import "NSDictionary+MSCKit.h"

@implementation NSDictionary (MSCKit)


- (NSDictionary *)ex_dictionaryForKey:(NSString *)aKey
{
    if (aKey) {
        id value = [self objectForKey:aKey];
        if (value && [value isKindOfClass:[NSDictionary class]]){
            return value;
        }
    }
    
    return nil;
}

- (NSArray *)ex_arrayForKey:(NSString *)aKey
{
    if (aKey) {
        id value = [self objectForKey:aKey];
        if (value && [value isKindOfClass:[NSArray class]]){
            return value;
        }
    }
    
    return nil;
}

- (NSString *)ex_stringForKey:(NSString*)aKey
{
    if (aKey){
        id value = [self objectForKey:aKey];
        if (value) {
            if ([value isKindOfClass:[NSString class]]){
                return value;
            }
            else if ([value isKindOfClass:[NSNumber class]]){
                return [value stringValue];
            }
        }
    }
    
    return nil;
}
//【如果不存在则返回NSIntegerMin，值是-9223372036854775808】
- (NSInteger)ex_integerForKey:(NSString *)aKey
{
    if (aKey) {
        id value = [self objectForKey:aKey];
        if (value) {
            if ([value isKindOfClass:[NSNumber class]]) {
                return [value integerValue];
            }
            else if ([value isKindOfClass:[NSString class]]){
                return [value integerValue];
            }
        }
    }

    return NSIntegerMin;
}

#pragma mark -------- json

- (NSString * _Nonnull)ex_convertToJsonString
{
    NSString *json = nil;
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    
    if (!jsonData) {
        return @"{}";
    }
    else if (!error) {
        json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }
    else {
        return error.localizedDescription;
    }
}

@end
