//
//  WLDataHotelHandler.m
//  WeiLvDJS
//
//  Created by ternence on 16/11/14.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLDataHotelHandler.h"

#define SearchHistoryPath @"hotelSearchHistory.plist"

static WLDataHotelHandler* sharedInstance;

@implementation WLDataHotelHandler

+ (instancetype)sharedInstance{
    if (sharedInstance == nil) {
        sharedInstance = [[WLDataHotelHandler alloc] init];
    }
    return sharedInstance;
}

- (NSString*)getSearchHistoryPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    return [docDir stringByAppendingPathComponent:SearchHistoryPath];
}

- (NSArray *)getHotelSearchHistory
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *listPath = [self getSearchHistoryPath];
    NSArray *array;
    if (![fm fileExistsAtPath:listPath]) {
        array = [NSArray array];
    }else{
        array = [NSArray arrayWithContentsOfFile:listPath];
    }
    return array;
}

- (void)addNewHotelSearchItem:(NSString *)string
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *listPath = [self getSearchHistoryPath];
    NSMutableArray *array;
    if ([fm fileExistsAtPath:listPath]) {
        array = [NSMutableArray arrayWithContentsOfFile:listPath];
    }else{
        [fm createDirectoryAtPath:[listPath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];
        array = [NSMutableArray array];
    }
    if (![array containsObject:string]) {
        [array insertObject:string atIndex:0];
    }
    if (array.count > 10) {
        [array removeLastObject];
    }
    [array writeToFile:listPath atomically:YES];
}

- (void)clearHotelSearchHistory
{
    NSString *listPath = [self getSearchHistoryPath];
    [[NSFileManager defaultManager] removeItemAtPath:listPath error:nil];
}

+ (NSString *)getYMStringWithYMDString:(NSString *)timeString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:timeString];
    NSDateComponents *dateComps = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:date];
    NSInteger month = [dateComps month];
    NSInteger day = [dateComps day];
    return [NSString stringWithFormat:@"%ld月%ld日", (long)month,(long)day];
    
}

+ (NSString *)TimeIntervalChangeWithYMDString:(NSString *)timeString
{
    NSDate * Timedate = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString * strr = [dateFormatter stringFromDate:Timedate];
    return strr;//[NSString stringWithFormat:@"%ld月%ld日", month,day];
}

+ (NSString *)TimeIntervalChangeWithYMDString222:(NSString *)timeString
{
    NSDate * Timedate = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd"];
    NSString * strr = [dateFormatter stringFromDate:Timedate];
    return strr;//[NSString stringWithFormat:@"%ld月%ld日", month,day];
}

+ (NSString *)TimeIntervalChangeWithYYString:(NSString *)timeString
{
    NSDate * Timedate = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY"];
    NSString * strr = [dateFormatter stringFromDate:Timedate];
    return strr;//[NSString stringWithFormat:@"%ld月%ld日", month,day];
}

+ (NSString *)TimeIntervalChangeWithhhmmssString:(NSString *)timeString
{
    NSDate * Timedate = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString * strr = [dateFormatter stringFromDate:Timedate];
    return strr;//[NSString stringWithFormat:@"%ld月%ld日", month,day];
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
    return [NSString stringWithFormat:@"%ld.%ld.%ld %ld:%02ld",(long)year, (long)month,(long)day,(long)hour,(long)minute];
}

+ (NSInteger)getcountdownData:(NSString *)timeStr
{
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//    NSDate* datee = [formatter dateFromString:timeStr];
//    NSTimeInterval timeStamp= [datee timeIntervalSince1970];
    
    //取出现在的时间
    NSDate *nowDate = [NSDate date];
    NSTimeInterval nowtimeStamp= [nowDate timeIntervalSince1970];
    
    //--
    //__block int timeout = timeStamp - nowtimeStamp; //倒计时时间
    __block int timeout = [timeStr integerValue] - nowtimeStamp; //倒计时时间
    
    return (timeout < 0)?0:timeout;
}


@end
