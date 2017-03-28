//
//  WSDateTool.m
//  WSExtension
//
//  Created by ternence on 16/11/21.
//  Copyright © 2016年 ternence. All rights reserved.
//

#import "WSDateTool.h"

@implementation WSDateTool

+ (NSInteger)getCurrentYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =  NSCalendarUnitYear;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:[NSDate date]];
    return [dateComponent year];
}

+ (NSInteger)getCurrentMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =  NSCalendarUnitMonth;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:[NSDate date]];
    return [dateComponent month];
}

+ (NSInteger)getCurrentDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =  NSCalendarUnitDay;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:[NSDate date]];
    return [dateComponent day];
}

+ (int)getTotalDaysOfMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
    return (int)range.length;
}

+ (NSString *)getYMStringWithYMDString:(NSString *)timeString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:timeString];
    NSDateComponents *dateComps = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:date];
    NSInteger month = [dateComps month];
    NSInteger day = [dateComps day];
    return [NSString stringWithFormat:@"%ld月%ld日", (long)month,day];
    
}

+ (NSString *)getYMDHMStringWithYMDHMSString:(NSString *)timeString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:timeString];
    NSDateComponents *dateComps = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:date];
    NSInteger year = [dateComps year];
    NSInteger month = [dateComps month];
    NSInteger day = [dateComps day];
    NSInteger minute = [dateComps minute];
    NSInteger hour = [dateComps hour];
    return [NSString stringWithFormat:@"%ld.%ld.%ld %ld:%ld",(long)year, month,day,hour,minute];
}
@end
