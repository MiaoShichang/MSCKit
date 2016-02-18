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

@end
