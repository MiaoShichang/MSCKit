//
//  NSUserDefaults+MSCKit.h
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/23.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (MSCKit)

+ (BOOL)ex_setUserValue:(id)value forKey:(NSString *)key;

+ (id)ex_valueForKey:(NSString *)key;

@end
