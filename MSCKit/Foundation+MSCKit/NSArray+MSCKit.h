//
//  NSArray+MSCKit.h
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/3.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (MSCKit)

/**安全获取对象，判断了数组越界*/
- (id)ex_objectAtIndex:(NSUInteger)index;

/**转换成JSON字符串*/
- (NSString *)ex_convertToJsonString;

@end
