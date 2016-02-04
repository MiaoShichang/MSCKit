//
//  NSString+MSCKit.h
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/3.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MSCKitd)

/**获取32位小写的MD5字符串*/
- (NSString *)ex_toMD5;

/**去除两端空格*/
- (NSString *)ex_trimmingWhiteSpaceCharacter;

/**去除两端空格和回车*/
- (NSString *)ex_trimmingWhiteSpaceAndNewlineCharacter;


#pragma mark -------- 验证

/**是否包含Emoji表情*/
- (BOOL)ex_containsEmoji;

/**验证邮箱*/
- (BOOL)ex_validateEmail;

/**验证身份证*/
- (BOOL)ex_verifyIDCard;


#pragma mark -------- 汉字

/**获取拼音的首字母*/
- (char)ex_firstLetter;


#pragma mark -------- to NSData

/**将字符串转换成NSUTF8StringEncoding编码的NSData*/
- (NSData *)ex_convertToNSDataByUTF8;

/**将字符串转换成NSASCIIStringEncoding编码的NSData*/
- (NSData *)ex_convertToNSDataByASCII;


#pragma mark -------- base64

/**Base64编码*/
- (NSString *)ex_encodeToBase64;

/**Base64解码*/
- (NSString *)ex_decodeBase64;


@end
