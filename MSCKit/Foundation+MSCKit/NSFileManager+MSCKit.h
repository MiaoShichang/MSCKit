//
//  NSFileManager+MSCKit.h
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/23.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (MSCKit)


+ (NSString *)ex_documentsDirectory;

+ (NSString *)ex_libraryDirectory;

+ (NSString *)ex_cachesDirectory;

+ (NSString *)ex_temporaryDirectory;


@end
