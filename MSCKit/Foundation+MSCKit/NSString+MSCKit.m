//
//  NSString+MSCKit.m
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/3.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import "NSString+MSCKit.h"
#import <CommonCrypto/CommonDigest.h>
#import "MSCCoreUtils+NSString.h"
#import "NSData+MSCKit.h"

@implementation NSString (MSCKitd)

//【MD5】
- (NSString *)ex_toMD5
{
    if(self.length == 0) return nil;
    
    const char *value = [self UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

//【去除两端空格】
- (NSString *)ex_trimmingWhiteSpaceCharacter
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

//【去除两端空格和回车】
- (NSString *)ex_trimmingWhiteSpaceAndNewlineCharacter
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

//【是否包含Emoji表情】
- (BOOL)ex_containsEmoji
{
    __block BOOL isEomji = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     isEomji = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 isEomji = YES;
             }
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 isEomji = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 isEomji = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 isEomji = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 isEomji = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 isEomji = YES;
             }
         }
     }];

    return isEomji;
}

//【邮箱验证】
-(BOOL)ex_validateEmail
{
    NSString *email = [self ex_trimmingWhiteSpaceAndNewlineCharacter];
    // 现在的域名后缀的长度有所增加，所以长度最长修改为8（@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"）
//    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,8}";
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
//    return [predicate evaluateWithObject:email];
    
    NSString *emailRegEx = @"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    return [regExPredicate evaluateWithObject:[email lowercaseString]];
}


//【验证身份证】
- (BOOL)ex_verifyIDCard
{
    return [MSCCoreUtils verifyIDCard:self];
}

//【获取拼音的首字母】
- (char)ex_firstLetter
{
    return [MSCCoreUtils firstLetter:self];
}

//【将字符串转换成NSUTF8StringEncoding编码的NSData】
- (NSData *)ex_convertToNSDataByUTF8
{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

//【将字符串转换成NSASCIIStringEncoding编码的NSData】
- (NSData *)ex_convertToNSDataByASCII
{
    return [self dataUsingEncoding:NSASCIIStringEncoding];
}

//【将字符串转换成NSDictionary】
- (NSDictionary *)ex_convertToDictionary
{
    if (self.length == 0)
    {
        return @{};
    }
    
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err = nil;
    id dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    
    if(err)
    {
        NSLog(@"ex_convertToDictionary error：%@",err);
        return nil;
    }
    
    if ([dic isKindOfClass:[NSDictionary class]])
    {
        return dic;
    }
    
    return nil;
}

//【Base64编码】
- (NSString *)ex_encodeToBase64
{
    NSData *data = [self ex_convertToNSDataByUTF8];
    return [data base64EncodedStringWithOptions:0];
}

//【Base64解码】
- (NSString *)ex_decodeFromBase64
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    return [data ex_convertToUTF8String];
}

//【生成UUID】
+ (NSString *)ex_generateUUID
{
    NSString *result = nil;
    
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    if (uuid)
    {
        result = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, uuid);
        CFRelease(uuid);
    }
    
    return result;
}

//【生成UUID字符串】
+ (NSString *)ex_generateUUIDString
{
    NSString *result = [[self class]ex_generateUUID];
    result = [result stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    return result;
}

@end
