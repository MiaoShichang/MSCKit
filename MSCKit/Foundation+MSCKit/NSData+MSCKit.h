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

/**转换成ASCII编码字符串*/
- (NSDictionary *)ex_convertToDictionary;

#pragma mark -------- 判断图片类型

/**判断是否是JPEG格式的图片*/
- (BOOL)ex_isJPEG;

/**判断是否是PNG格式的图片*/
- (BOOL)ex_isPNG;


#pragma mark -------- MD5

- (NSString *)ex_MD5String;


@end
