//
//  FlowmeterTool.m
//  PrivacyGuard
//
//  Created by Ternence on 15/7/31.
//  Copyright (c) 2015年 LEO. All rights reserved.
//

#import "FlowmeterTool.h"

@implementation FlowmeterTool
- (int)getCurrentMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =  NSCalendarUnitMonth;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:[NSDate date]];
    int month = (int)[dateComponent month];
    return month;
}

- (int)getTotalDaysOfMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
    return (int)range.length;
}

- (NSString *)getCurrentDate:(NSString *)type{
    NSDate *now = [NSDate date];

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =  NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    int month = (int)[dateComponent month];
    int day = (int)[dateComponent day];
    int hour = (int)[dateComponent hour];
    int minute = (int)[dateComponent minute];
    int weekDay = (int)[dateComponent weekday];
    if ([type isEqualToString:@"time"]) {
        return [NSString stringWithFormat:@"%02d:%02d",hour,minute];
    }else{
        NSString *weekdayFormatter;
        switch (weekDay) {
            case 2:
                weekdayFormatter = NSLocalizedString(@"device monitor charge - date weekDay - monday", nil);
                break;
            case 3:
                weekdayFormatter = NSLocalizedString(@"device monitor charge - date weekDay - tuesday", nil);
                break;
            case 4:
                weekdayFormatter = NSLocalizedString(@"device monitor charge - date weekDay - wednesday", nil);
                break;
            case 5:
                weekdayFormatter = NSLocalizedString(@"device monitor charge - date weekDay - thursday", nil);
                break;
            case 6:
                weekdayFormatter = NSLocalizedString(@"device monitor charge - date weekDay - friday", nil);
                break;
            case 7:
                weekdayFormatter = NSLocalizedString(@"device monitor charge - date weekDay - saturday", nil);
                break;
            case 1:
                weekdayFormatter = NSLocalizedString(@"device monitor charge - date weekDay - sunday", nil);
                break;
            default:
                break;
        }
    
        NSString *monthFormatter;
        switch (month) {
            case 1:
                monthFormatter = NSLocalizedString(@"device monitor month - January", nil);
                break;
            case 2:
                monthFormatter = NSLocalizedString(@"device monitor month - February", nil);
                break;
            case 3:
                monthFormatter = NSLocalizedString(@"device monitor month - March", nil);
                break;
            case 4:
                monthFormatter = NSLocalizedString(@"device monitor month - April", nil);
                break;
            case 5:
                monthFormatter = NSLocalizedString(@"device monitor month - May", nil);
                break;
            case 6:
                monthFormatter = NSLocalizedString(@"device monitor month - June", nil);
                break;
            case 7:
                monthFormatter = NSLocalizedString(@"device monitor month - July", nil);
                break;
            case 8:
                monthFormatter = NSLocalizedString(@"device monitor month - August", nil);
                break;
            case 9:
                monthFormatter = NSLocalizedString(@"device monitor month - September", nil);
                break;
            case 10:
                monthFormatter = NSLocalizedString(@"device monitor month - October", nil);
                break;
            case 11:
                monthFormatter = NSLocalizedString(@"device monitor month - November", nil);
                break;
            case 12:
                monthFormatter = NSLocalizedString(@"device monitor month - December", nil);
                break;
        }
        NSString *formatter = NSLocalizedString(@"device monitor charge - date weekDay", nil);
        return [NSString stringWithFormat:formatter,monthFormatter,day,weekdayFormatter];
    }
    
}

- (NSNumber *)getMaxFlowCount:(NSArray *)dataArray
{
    if (dataArray.count == 0) {
        return [NSNumber numberWithInt:0];
    }
    float max = [(NSNumber *)dataArray[0] floatValue];
    for (int i = 0; i < dataArray.count; i++) {
        float currentValue = [(NSNumber *)dataArray[i] floatValue];
        if (max < currentValue) {
            max = currentValue;
        }
    }
    return [NSNumber numberWithFloat:max];
}

- (NSNumber *)getMinFlowCount:(NSArray *)dataArray
{
    long long min = [(NSNumber *)dataArray[0] longLongValue];
    for (int i = 0; i < dataArray.count; i++) {
        long long currentValue = [(NSNumber *)dataArray[i] longLongValue];
        if (min > currentValue) {
            min = currentValue;
        }
    }
    return [NSNumber numberWithLongLong:min];

}
@end
