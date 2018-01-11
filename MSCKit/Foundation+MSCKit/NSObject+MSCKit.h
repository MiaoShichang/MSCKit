//
//  NSObject+MSCKit.h
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/23.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MSCKit)

/**
 * @brief 当前对象的类名称字符串
 */
@property (nonatomic, strong, readonly)NSString *ex_className;

/**
 * @brief 类的名称字符串
 */
+ (NSString *)ex_className;


////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 关联对象
////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * @brief  关联一个stong对象
 *
 * @param value 被关联的对象
 * @param key   被关联对象的key
 */
- (void)ex_setAssociatedObject:(id)object withKey:(void *)key;

/**
 * @brief  根据关联对象的key取出关联对象
 *
 * @param key 关联对象的key
 * @return 关联对象
 */
- (id)ex_getAssociatedObjectForKey:(void *)key;

/**
 * @brief  根据关联对象的key移除关联对象
 *
 * @param key 关联对象的key
 */
- (void)ex_removeAssociatedObjectForKey:(void *)key;


/////////////////////////
/**
 * @brief  关联一个stong对象
 *
 * @param value 被关联的对象
 *
 * @note key值是默认值，每个对象只用唯一的一个key值。
 */
- (void)ex_setAssociatedObject:(id)object;

/**
 * @brief  根据关联对象的key取出关联对象
 *
 * @param key 关联对象的key
 *
 * @note key值是默认值，每个对象只用唯一的一个key值。
 */
- (id)ex_getAssociatedObject;


////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - exchange method
////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * @brief 交换本类中的两个方法的实现
 * @param srcSel 方法一
 * @param tarSel 方法二
 */
+ (void)ex_exchangeMethodForSel:(SEL)srcSel withSel:(SEL)tarSel;

/**
 * @brief 用其他类的方法替换本类的方法实现
 * @param srcSel        本类的方法
 * @param tarClass  其他的类
 * @param tarSel        其他类中的方法
 */
+ (void)ex_exchangeMethodForSel:(SEL)srcSel withSel:(SEL)tarSel ofClass:(Class)tarClass;

/**
 * @brief 交换两个类的方法的实现
 * @param srcClass  方法一所在的类
 * @param srcSel    方法一
 * @param tarClass  方法二所在的类
 * @param tarSel    方法二
 */
+ (void)ex_exchangeMethodForSel:(SEL)srcSel ofClass:(Class)srcClass withSel:(SEL)tarSel ofClass:(Class)tarClass;





@end
