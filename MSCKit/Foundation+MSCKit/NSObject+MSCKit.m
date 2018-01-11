//
//  NSObject+MSCKit.m
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/23.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import "NSObject+MSCKit.h"
#import  <objc/runtime.h>


const char * const associatedObjectKey;

@implementation NSObject (MSCKit)

//
- (NSString *)ex_className
{
    return NSStringFromClass(self.class);
}

//
+ (NSString *)ex_className
{
    return NSStringFromClass(self.class); 
}

//
- (void)ex_setAssociatedObject:(id)object withKey:(void *)key
{
    objc_setAssociatedObject(self, key, object, OBJC_ASSOCIATION_RETAIN);
}

- (void)ex_setAssociatedObject:(id)object
{
    objc_setAssociatedObject(self, &associatedObjectKey, object, OBJC_ASSOCIATION_RETAIN);
}

//
- (id)ex_getAssociatedObjectForKey:(void *)key
{
    return objc_getAssociatedObject(self, key);
}

- (id)ex_getAssociatedObject
{
    return objc_getAssociatedObject(self, &associatedObjectKey);
}

//
- (void)ex_removeAssociatedObjectForKey:(void *)key
{
    [self ex_setAssociatedObject:nil withKey:key];
}

//
+ (void)ex_exchangeMethodForSel:(SEL)srcSel withSel:(SEL)tarSel
{
    Class srcClass = [self class];
    [self ex_exchangeMethodForSel:srcSel ofClass:srcClass withSel:tarSel ofClass:srcClass];
}

//
+ (void)ex_exchangeMethodForSel:(SEL)srcSel withSel:(SEL)tarSel ofClass:(Class)tarClass
{
    Class srcClass = [self class];
    [self ex_exchangeMethodForSel:srcSel ofClass:srcClass withSel:tarSel ofClass:tarClass];
}

//
+ (void)ex_exchangeMethodForSel:(SEL)srcSel ofClass:(Class)srcClass withSel:(SEL)tarSel ofClass:(Class)tarClass
{
    if (!srcClass || !srcSel || !tarClass || !tarSel) {
        return;
    }

    Method srcMethod = class_getInstanceMethod(srcClass,srcSel);
    Method tarMethod = class_getInstanceMethod(tarClass,tarSel);
    method_exchangeImplementations(srcMethod, tarMethod);
}


@end
