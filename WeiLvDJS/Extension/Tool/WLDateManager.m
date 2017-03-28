//
//  WLDateManager.m
//  WeiLvDJS
//
//  Created by whw on 17/3/8.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLDateManager.h"

#define DATE_COMPONENTS (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]

@interface WLDateManager ()

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

static WLDateManager *instance = nil;

@implementation WLDateManager

+ (instancetype)dateDefault
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[WLDateManager alloc]init];
    });
    return instance;
}

#pragma mark - 将时间戳转换成指定格式的时间字符串
- (NSString *)getDateStringWithTimeString:(NSString *)timeStr andFormatter:(NSString *)formatterString
{
    NSDate *detaildate = [self getDateFromTimeString:timeStr];
   
    //设定时间格式,这里可以设置成自己需要的格式
    
    [self.dateFormatter setDateFormat:formatterString];
    
    return  [self.dateFormatter stringFromDate:detaildate];
}
#pragma mark - 判断是不是今天
- (BOOL) isTodayWithTimeString:(NSString *)timeString
{
    NSDate *detaildate = [self getDateFromTimeString:timeString];
    return [self isEqualToDateIgnoringTime:detaildate];
}
#pragma mark - 判断是不是超过所给日期
- (BOOL) isOverTodayOfTimeString:(NSString *)timeString
{
    
    NSDate *detaildate = [self getDateFromTimeString:timeString];
    NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:[NSDate date]];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:detaildate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day >= components2.day));
}

#pragma mark - 将date转换成指定日期格式的字符串
- (NSString *)changeDateToStringWith:(NSDate *)date andFormatter:(NSString *)formatterString
{
    self.dateFormatter.dateFormat = formatterString;
    return [self.dateFormatter stringFromDate:date];
}

- (NSDate *)changeDateToDateWith:(NSDate *)date andFormatter:(NSString *)formatterString
{
    self.dateFormatter.dateFormat = formatterString;
    NSString *tempString = [self.dateFormatter stringFromDate:date];
    return [self.dateFormatter dateFromString:tempString];
}

- (BOOL)currentDateIsLaterThanTimeInterval:(NSTimeInterval)timeInterval
{
    NSDate *currentDate = [NSDate date];
    NSUInteger currentInterval = [currentDate timeIntervalSince1970];
    if (currentInterval > timeInterval) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark -计算倒计时起始时间
- (double)setupDifferentTime:(NSString *)failureTime
{

    NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
    return [failureTime doubleValue] - nowTime;
}
#pragma mark -将指定格式的时间字符串转换成时间戳
- (NSString *)timeIntervalWithTimeString:(NSString *)timeString formatter:(NSString *)formatterString
{
    [self.dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [self.dateFormatter setTimeZone:timeZone];
    [self.dateFormatter setDateFormat:formatterString];
    NSDate* date = [self.dateFormatter dateFromString:timeString];
    NSTimeInterval timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] doubleValue];
    return [NSString stringWithFormat:@"%lld",(long long)timeSp];
}
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:[NSDate date]];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}
- (NSDate *)getDateFromTimeString:(NSString *)timeStr
{
    return [NSDate dateWithTimeIntervalSince1970:[timeStr doubleValue]];
}
- (NSDateFormatter *)dateFormatter
{
    if (_dateFormatter == nil) {
        _dateFormatter = [[NSDateFormatter alloc]init];
    }
    return _dateFormatter;
}
@end
