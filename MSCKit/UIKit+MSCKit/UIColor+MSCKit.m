//
//  UIColor+MSCKit.m
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/18.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import "UIColor+MSCKit.h"

@implementation UIColor (MSCKit)

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 【+方法】
////////////////////////////////////////////////////////////////////////////////////////////////////

+ (UIColor *)ex_colorWithHexString:(NSString *)hexString
{
    if (hexString.length < 4 || hexString.length > 9)
    {
        return nil;
    }
    
    if (![[hexString substringToIndex:1] isEqualToString:@"#"])
    {
        return nil;
    }
    
    NSString *colorString = [[hexString substringFromIndex:1] uppercaseString];
    // 正则表达式 -- [0-9, a-f, A-F]
    
    CGFloat alpha = 0.f, red = 0.f, blue = 0.f, green = 0.f;
    switch ([colorString length]) {
        case 3: // #RGB
        {
            alpha = 1.0f;
            red =   [self p_colorComponent:colorString fromIndex:0 length:1];
            green = [self p_colorComponent:colorString fromIndex:1 length:1];
            blue =  [self p_colorComponent:colorString fromIndex:2 length:1];
        }
            break;
        case 4: // #ARGB
        {
            alpha = [self p_colorComponent:colorString fromIndex:0 length:1];
            red =   [self p_colorComponent:colorString fromIndex:1 length:1];
            green = [self p_colorComponent:colorString fromIndex:2 length:1];
            blue =  [self p_colorComponent:colorString fromIndex:3 length:1];
        }
            break;
        case 6: // #RRGGBB
        {
            alpha = 1.0f;
            red =   [self p_colorComponent:colorString fromIndex:0 length:2];
            green = [self p_colorComponent:colorString fromIndex:2 length:2];
            blue =  [self p_colorComponent:colorString fromIndex:4 length:2];
        }
            break;
        case 8: // #AARRGGBB
        {
            alpha = [self p_colorComponent:colorString fromIndex:0 length:2];
            red =   [self p_colorComponent:colorString fromIndex:2 length:2];
            green = [self p_colorComponent:colorString fromIndex:4 length:2];
            blue =  [self p_colorComponent:colorString fromIndex:6 length:2];
        }
            break;
        default:
            return nil;
    }
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)ex_colorWithRRGGBBHexString:(NSString *)hexString alpha:(float)alpha
{
    if (hexString.length != 6) {
        return nil;
    }
    
    UIColor *color = [self ex_colorWithHexString:hexString];
    
    if (color) {
        [color colorWithAlphaComponent:alpha];
        
        return color;
    }
    
    return nil;
}

+ (CGFloat)p_colorComponent:(NSString *)string fromIndex:(NSUInteger)start length:(NSUInteger)length
{
    if (string.length < start + length)
    {
        return 0.f;
    }
    
    NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat:@"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString:fullHex] scanHexInt:&hexComponent];
    
    return hexComponent / 255.0;
}

//【随机颜色】
+ (UIColor *)ex_randomColor
{
    int r = arc4random() % 256;
    int g = arc4random() % 256;
    int b = arc4random() % 256;
    
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}

+ (UIColor *)ex_colorWithHexValue:(NSUInteger)hexValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((hexValue >> 16) & 0x000000FF)/255.0f
                           green:((hexValue >> 8) & 0x000000FF)/255.0f
                            blue:((hexValue) & 0x000000FF)/255.0
                           alpha:alpha];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 【property】
////////////////////////////////////////////////////////////////////////////////////////////////////

- (BOOL)p_canProvideRGBComponents
{
    switch (CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor))) {
        case kCGColorSpaceModelRGB:
        case kCGColorSpaceModelMonochrome:
            return YES;
        default:
            return NO;
    }
}

- (CGFloat)ex_red
{
    if (self.p_canProvideRGBComponents) {
        const CGFloat *c = CGColorGetComponents(self.CGColor);
        return c[0];
    }
    
    return 0.0;
}

- (CGFloat)ex_green
{
    if (self.p_canProvideRGBComponents) {
        const CGFloat *c = CGColorGetComponents(self.CGColor);
        if (CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor)) == kCGColorSpaceModelMonochrome)
            return c[0];
        return c[1];
    }
    
    return 0.0;
}

- (CGFloat)ex_blue
{
    if (self.p_canProvideRGBComponents) {
        const CGFloat *c = CGColorGetComponents(self.CGColor);
        if (CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor)) == kCGColorSpaceModelMonochrome)
            return c[0];
        return c[2];
    }
    
    return 0.0;
}

- (CGFloat)ex_alpha
{
    return CGColorGetAlpha(self.CGColor);
}



////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 【-方法】
////////////////////////////////////////////////////////////////////////////////////////////////////

- (UIColor *)ex_colorWithAlphaComponent:(CGFloat)alpha
{
    return [self colorWithAlphaComponent:alpha];
}




@end
