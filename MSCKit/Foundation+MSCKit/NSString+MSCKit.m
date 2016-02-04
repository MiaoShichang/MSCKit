//
//  NSString+MSCKit.m
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/3.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import "NSString+MSCKit.h"
#import <CommonCrypto/CommonDigest.h>
#import "MSCCoreUtils.h"
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
/*
必须满足以下规则
1. 长度必须是18位，前17位必须是数字，第十八位可以是数字或X
2. 前两位必须是以下情形中的一种：11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82,91
3. 第7到第14位出生年月日。第7到第10位为出生年份；11到12位表示月份，范围为01-12；13到14位为合法的日期
4. 第17位表示性别，双数表示女，单数表示男
5. 第18位为前17位的校验位
    算法如下：
    （1）校验和 = (n1 + n11) * 7 + (n2 + n12) * 9 + (n3 + n13) * 10 + (n4 + n14) * 5 + (n5 + n15) * 8 + (n6 + n16) * 4 + (n7 + n17) * 2 + n8 + n9 * 6 + n10 * 3，其中n数值，表示第几位的数字
    （2）余数 ＝ 校验和 % 11
    （3）如果余数为0，校验位应为1，余数为1到10校验位应为字符串“0X98765432”(不包括分号)的第余数位的值（比如余数等于3，校验位应为9）
6. 出生年份的前两位必须是19或20
 */
- (BOOL)ex_verifyIDCard
{
    NSString *value = [self ex_trimmingWhiteSpaceAndNewlineCharacter];
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([value length] != 18) {return NO;}
    
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![regexTest evaluateWithObject:value]) {return NO;}
    
    int summary =
    ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue)*7 +
    ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue)*9 +
    ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue)*10 +
    ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue)*5 +
    ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue)*8 +
    ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue)*4 +
    ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue)*2 +
    ([value substringWithRange:NSMakeRange(7,1)].intValue)*1 +
    ([value substringWithRange:NSMakeRange(8,1)].intValue)*6 +
    ([value substringWithRange:NSMakeRange(9,1)].intValue)*3;
    
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    return [checkBit isEqualToString:[[value substringWithRange:NSMakeRange(17,1)] uppercaseString]];
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

//【Base64编码】
- (NSString *)ex_encodeToBase64
{
    NSData *data = [self ex_convertToNSDataByUTF8];
    return [data base64EncodedStringWithOptions:0];
}

//【Base64解码】
- (NSString *)ex_decodeBase64
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    return [data ex_convertToUTF8String];
}






















































@end
