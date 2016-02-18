//
//  MSCCoreUtils+NSString.h
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/4.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import "MSCCoreUtils.h"

@interface MSCCoreUtils (NSString)

/**获取拼音的首字母*/
+ (char)firstLetter:(NSString *)string;

/**验证身份证*/
+ (BOOL)verifyIDCard:(NSString *)idCard;

@end
