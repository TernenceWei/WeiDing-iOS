//
//  WLCarBookingViewMode.m
//  WeiLvDJS
//
//  Created by ternence on 2017/3/27.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLCarBookingViewMode.h"

@implementation WLCarBookingViewMode


- (NSDate *)updateDateWithDate:(NSDate *)date
{
    NSString *year = [self selectYearName:date];
    NSString *month = [self selectMonthName:date];
    NSString *day = [self selectDayName:date];
    NSString *hour = [self selectHourName:date];
    NSString *minute = [self selectMinuteName:date];

    NSUInteger minuteInteger = minute.integerValue;
    
    if (minuteInteger > 0 && minuteInteger <= 15) {
        minuteInteger = 15;
    }else if (minuteInteger > 15 && minuteInteger <= 30){
        minuteInteger = 30;
    }else if (minuteInteger > 30 && minuteInteger <= 45){
        minuteInteger = 45;
    }else if (minuteInteger > 45){
        hour = [NSString stringWithFormat:@"%ld",hour.integerValue + 1];
        minuteInteger = 0;
        
    }else{
        minuteInteger = 0;
    }
    minute = [NSString stringWithFormat:@"%ld",minuteInteger];
    
    NSDate *tempDate;
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy M d H m"];
    tempDate = [formatter dateFromString:[NSString stringWithFormat:@"%@ %@ %@ %@ %@", year, month, day, hour,minute]];
    return tempDate;
}

- (NSDate *)updateEndDateWithDate:(NSDate *)date
{
    NSString *year = [self selectYearName:date];
    NSString *month = [self selectMonthName:date];
    NSString *day = [self selectDayName:date];
    NSString *hour = @"23";
    
    NSDate *tempDate;
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy M d H"];
    tempDate = [formatter dateFromString:[NSString stringWithFormat:@"%@ %@ %@ %@", year, month, day, hour]];
    return tempDate;
}



-(NSString *)selectYearName:(NSDate *)date
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy"];
    return [formatter stringFromDate:date];
}

-(NSString *)selectMonthName:(NSDate *)date
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [formatter setLocale:usLocale];
    [formatter setDateFormat:@"M"];
    return [formatter stringFromDate:date];
}

-(NSString *)selectDayName:(NSDate *)date
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"d"];
    return [formatter stringFromDate:date];
}

-(NSString *)selectHourName:(NSDate *)date
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"H"];
    return [formatter stringFromDate:date];
}

-(NSString *)selectMinuteName:(NSDate *)date
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"m"];
    return [formatter stringFromDate:date];
}
@end
