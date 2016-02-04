//
//  NSData+MSCKit.m
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/3.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import "NSData+MSCKit.h"

@implementation NSData (MSCKit)

//【转换成UTF8编码字符串】
- (NSString *)ex_convertToUTF8String
{
    return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}

//【转换成ASCII编码字符串】
- (NSString *)ex_convertToASCIIString
{
    return [[NSString alloc] initWithData:self encoding:NSASCIIStringEncoding];
}

@end
