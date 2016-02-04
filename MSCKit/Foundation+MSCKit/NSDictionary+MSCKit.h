//
//  NSDictionary+MSCKit.h
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/3.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (MSCKit)

/**获取NSDictionary*/
- (NSDictionary *)ex_dictionaryForKey:(NSString *)aKey;

/**获取NSArray*/
- (NSArray *)ex_arrayForKey:(NSString *)aKey;

/**获取NSString*/
- (NSString *)ex_stringForKey:(NSString*)aKey;

/**
 *@brief 获取NSInteger
 *@note 如果不存在则返回NSIntegerMin，值是-9223372036854775808
 */
- (NSInteger)ex_integerForKey:(NSString *)aKey;



@end
