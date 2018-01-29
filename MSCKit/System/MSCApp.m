//
//  MSCApp.m
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/23.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import "MSCApp.h"



@implementation MSCApp

+ (NSString *)appName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

+ (NSString *)appVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appBuildVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+ (NSString *)appIdentifier
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

+ (void)onFirstStartAPPForCurrentVersion:(void (^)(BOOL isFirst))block
{
    NSString *MSCHasBeenOpenedCurrentVersionKey = [NSString stringWithFormat:@"MSC_Current_Version_%@", self.class.appVersion];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL hasBeenOpenedForCurrentVersion = [defaults boolForKey:MSCHasBeenOpenedCurrentVersionKey];
    if (hasBeenOpenedForCurrentVersion != true) {
        [defaults setBool:YES forKey:MSCHasBeenOpenedCurrentVersionKey];
        [defaults synchronize];
    }
    
    block(!hasBeenOpenedForCurrentVersion);
}


@end
