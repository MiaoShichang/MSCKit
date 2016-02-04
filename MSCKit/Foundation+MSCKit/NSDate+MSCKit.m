//
//  NSDate+MSCKit.m
//  MSCKitDemo
//
//  Created by MiaoShichang on 16/2/3.
//  Copyright © 2016年 MiaoShichang. All rights reserved.
//

#import "NSDate+MSCKit.h"

@implementation NSDate (MSCKit)


#pragma mark -------- 时间间隔

//【获取从1970开始之间的间隔时间，单位为毫秒】
- (double)timeIntervalSince1970InMilliSecond
{
    double ret = [self timeIntervalSince1970] * 1000;
    return ret;
}

//【获取从1970开始的NSDate，参数单位为毫秒】
+ (NSDate *_Nonnull)ex_dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond
{
    NSDate *ret = nil;
    double timeInterval = timeIntervalInMilliSecond;
    // judge if the argument is in secconds(for former data structure).
    //【判断参数值是否为秒】
    if(timeIntervalInMilliSecond > 140000000000) {
        timeInterval = timeIntervalInMilliSecond / 1000;
    }
    ret = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    return ret;
}

#pragma mark -------- 调整
//【调整时间】
- (NSDate *)dateByAddingDays: (NSInteger) dDays
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + MSCKIT_DATE_DAY * dDays;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

//【明天日期】
+ (NSDate *_Nonnull)ex_tomorrowDate
{
    return [[NSDate date] dateByAddingDays:1];
}

//【昨天日期】
+ (NSDate *_Nonnull)ex_yesterdayDate
{
    return [[NSDate date] dateByAddingDays:-1];
}


#pragma mark -------- 判断
//【是否是同一天】
- (BOOL)ex_isSameDay:(NSDate * _Nonnull)anotherDate
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components1 = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    NSDateComponents* components2 = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:anotherDate];
    
    return ([components1 year] == [components2 year] && [components1 month] == [components2 month] && [components1 day] == [components2 day]);
}

//【是否时今天】
- (BOOL)ex_isToday
{
    return [self ex_isSameDay:[NSDate date]];
}

//【是否是非工作日】
- (BOOL)ex_isWeekend
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:self];
    if ((components.weekday == 1) || (components.weekday == 7))
        return YES;
    
    return NO;
}

//【是否是工作日】
- (BOOL)ex_isWorkday
{
    return ![self ex_isWeekend];
}

#pragma mark -------- 日期中各组成部分

- (NSDateComponents *)components
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
                          NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond |
                          NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear) fromDate:self];
    return components;
}

- (NSInteger)ex_year
{
    return [self components].year;
}

- (NSInteger)ex_month
{
    return [self components].month;
}

- (NSInteger)ex_day
{
    return [self components].day;
}

- (NSInteger)ex_hour
{
    return [self components].hour;
}

- (NSInteger)ex_minute
{
    return [self components].minute;
}

- (NSInteger)ex_second
{
    return [self components].second;
}

- (NSInteger)ex_weekOfYear
{
    return [self components].weekOfYear;
}

- (NSInteger)ex_weekday
{
    return [self components].weekday;
}

- (NSInteger)ex_weekOfMonth
{
    return [self components].weekOfMonth;
}

#pragma mark -------- 日期时间描述

- (NSString *_Nonnull)ex_dateFormatterWithFormat:(NSString *_Nonnull)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = dateFormat;
    return  [dateFormatter stringFromDate:self];
}

- (NSString *_Nonnull)ex_defaultDateTimeString
{
    return [self ex_dateFormatterWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSString *_Nonnull)ex_dateString
{
    return [self ex_dateFormatterWithFormat:@"yyyy-MM-dd"];
}

- (NSString *_Nonnull)ex_timeString
{
    return [self ex_dateFormatterWithFormat:@"HH:mm:ss"];
}

//【格式化日期描述】
- (NSString *_Nonnull)ex_formattedDateDescription
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *theDay = [dateFormatter stringFromDate:self];//日期的年月日
    NSString *currentDay = [dateFormatter stringFromDate:[NSDate date]];//当前年月日
    NSInteger timeInterval = -[self timeIntervalSinceNow];
    
    if (timeInterval < MSCKIT_DATE_MINUTE) {
        return @"1分钟内";
    }
    else if (timeInterval < MSCKIT_DATE_HOUR) {//1小时内
        return [NSString stringWithFormat:@"%.f分钟前", timeInterval / 60.0];
    }
    else if (timeInterval < MSCKIT_DATE_HOUR*6) {//6小时内
        return [NSString stringWithFormat:@"%.f小时前", timeInterval / 3600.0];
    }
    else if ([theDay isEqualToString:currentDay]) {//当天
        [dateFormatter setDateFormat:@"HH:mm"];
        return [NSString stringWithFormat:@"今天 %@", [dateFormatter stringFromDate:self]];
    }
    else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] == 86400) {//昨天
        [dateFormatter setDateFormat:@"HH:mm"];
        return [NSString stringWithFormat:@"昨天 %@", [dateFormatter stringFromDate:self]];
    }
    else {//以前
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        return [dateFormatter stringFromDate:self];
    }
    
    return @"";
}



@end
