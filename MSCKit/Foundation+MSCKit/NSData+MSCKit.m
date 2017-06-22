//
//  NSData+MSCKit.m
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/3.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import "NSData+MSCKit.h"
#import <CommonCrypto/CommonDigest.h>


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

//
- (NSDictionary *)ex_convertToDictionary
{
    if (self.length == 0)
    {
        return @{};
    }
    
    NSError *err = nil;
     id dic = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableContainers error:&err];
    
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

//【判断是否是JPEG格式的图片】
- (BOOL)ex_isJPEG
{
    if (self.length > 4)
    {
        unsigned char buffer[4];
        [self getBytes:&buffer length:4];
        
        return  buffer[0]==0xff &&
                buffer[1]==0xd8 &&
                buffer[2]==0xff &&
                buffer[3]==0xe0;
    }
    
    return NO;
}

//【判断是否是PNG格式的图片】
- (BOOL)ex_isPNG
{
    if (self.length > 4)
    {
        unsigned char buffer[4];
        [self getBytes:&buffer length:4];
        
        return  buffer[0]==0x89 &&
                buffer[1]==0x50 &&
                buffer[2]==0x4e &&
                buffer[3]==0x47;
    }
    
    return NO;
}

//
- (NSString *)ex_MD5String
{
    const char *cstr = [self bytes];
    unsigned char result[16];
    CC_MD5(cstr, (CC_LONG)[self length], result);
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}



@end
