//
//  NSData+MSCKit.h
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/3.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (MSCKit)

#pragma mark -------- to NSString
/**转换成UTF8编码字符串*/
- (NSString *)ex_convertToUTF8String;

/**转换成ASCII编码字符串*/
- (NSString *)ex_convertToASCIIString;


#pragma mark --------

@end
