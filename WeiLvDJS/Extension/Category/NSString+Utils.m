//
//  NSString+Utils.m
//  WeChatContacts-demo
//
//  Created by shen_gh on 16/3/12.
//  Copyright © 2016年 com.joinup(Beijing). All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)
#define DATE_COMPONENTS (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]
//汉字的拼音
- (NSString *)pinyin{
    NSMutableString *str = [self mutableCopy];
    CFStringTransform(( CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform(( CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    
    return [str stringByReplacingOccurrencesOfString:@" " withString:@""];
}
+ (NSString *)getDateStringWithTime:(NSString *)time andFormatter:(NSString *)formatterString
{
    return [KDateManager getDateStringWithTimeString:time andFormatter:formatterString];

}
+ (BOOL) isTodayWithTimeString:(NSString *)timeString
{
    return [KDateManager isTodayWithTimeString:timeString];
   
}

+ (BOOL) isTodayOfTimeString:(NSString *)timeString
{

    return [KDateManager isOverTodayOfTimeString:timeString];
}

+ (NSString *)changeDateToStringWith:(NSDate *)date andFormatter:(NSString *)formatterString
{
    return [KDateManager changeDateToStringWith:date andFormatter:formatterString];
}

+ (NSString *)SendStringNSUTF8StringEncodingANDEmoji:(NSString *)content
{
    NSString *uniStr = [NSString stringWithUTF8String:[content UTF8String]];
    NSData *uniData = [uniStr dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    NSString *SendStr = [[NSString alloc] initWithData:uniData encoding:NSUTF8StringEncoding];
    return SendStr;
}

+ (NSString *)GetStringNSUTF8StringEncodingANDEmoji:(NSString *)Servercontent
{
    const char *jsonString = [Servercontent UTF8String];
    NSData *jsonData = [NSData dataWithBytes:jsonString length:strlen(jsonString)];
    NSString *GetStr = [[NSString alloc] initWithData:jsonData encoding:NSNonLossyASCIIStringEncoding];
    return GetStr;
}

@end
