//
//  NSUserDefaults+MSCKit.m
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/23.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import "NSUserDefaults+MSCKit.h"

@implementation NSUserDefaults (MSCKit)

+ (BOOL)ex_setUserValue:(id)value forKey:(NSString *)key
{
    if (key.length == 0){
        return NO;
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:value forKey:key];
    return [userDefaults synchronize];
}

+ (id)ex_valueForKey:(NSString *)key
{
    if (key.length == 0){
        return nil;
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults valueForKey:key];
}

@end
