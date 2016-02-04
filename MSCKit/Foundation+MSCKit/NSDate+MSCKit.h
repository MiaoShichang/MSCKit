//
//  NSDate+MSCKit.h
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/3.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import <Foundation/Foundation.h>


#define MSCKIT_DATE_MINUTE      60          // 60
#define MSCKIT_DATE_HOUR		3600        // 60*60
#define MSCKIT_DATE_DAY         86400       // 60*60*24
#define MSCKIT_DATE_WEEK		604800      // 60*60*24*7
#define MSCKIT_DATE_YEAR		31556926    //


@interface NSDate (MSCKit)

@property (nonatomic, readonly)NSInteger ex_year;
@property (nonatomic, readonly)NSInteger ex_month;
@property (nonatomic, readonly)NSInteger ex_day;
@property (nonatomic, readonly)NSInteger ex_hour;
@property (nonatomic, readonly)NSInteger ex_minute;
@property (nonatomic, readonly)NSInteger ex_second;
@property (nonatomic, readonly)NSInteger ex_weekday;  //【一周中的第几天】
@property (nonatomic, readonly)NSInteger ex_weekOfMonth;
@property (nonatomic, readonly)NSInteger ex_weekOfYear;
@property (nonatomic, readonly)double timeIntervalSince1970InMilliSecond; //【获取从1970开始之间的间隔时间，单位为毫秒】


#pragma mark -------- 调整日期

/**调整日期：从1970开始的NSDate+时间间隔，参数单位为毫秒*/
+ (NSDate *_Nonnull)ex_dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond;

/**明天日期*/
+ (NSDate *_Nonnull)ex_tomorrowDate;

/**昨天日期*/
+ (NSDate *_Nonnull)ex_yesterdayDate;


#pragma mark -------- 判断

/**是否是同一天*/
- (BOOL)ex_isSameDay:(NSDate * _Nonnull)anotherDate;

/**是否时今天*/
- (BOOL)ex_isToday;

/**是否是 非工作日*/
- (BOOL)ex_isWeekend;

/**是否是 工作日*/
- (BOOL)ex_isWorkday;


#pragma mark -------- 日期时间描述

/**
 *@brief 格式化日期
 *@param dataFormat 是想要的输出格式
 */
- (NSString *_Nonnull)ex_dateFormatterWithFormat:(NSString *_Nonnull)dateFormat;

/**默认的日期时间格式化: yyyy-MM-dd HH:mm:ss */
- (NSString *_Nonnull)ex_defaultDateTimeString;

/**默认的日期格式化：yyyy-MM-dd */
- (NSString *_Nonnull)ex_dateString;

/**默认的时间格式化：HH:mm:ss  */
- (NSString *_Nonnull)ex_timeString;

/**格式化日期描述*/
- (NSString *_Nonnull)ex_formattedDateDescription;

@end





/**
 小知识：一年有多少秒
 
 按365天算，有365*24*60*60=31536000秒；
 按366天算，有366*24*60*60=31622400秒；
 按恒星年(公转360度)365天6时9分10秒算，有31558150秒；
 按回归年365天5时48分46秒算，有31556926秒
 
 */