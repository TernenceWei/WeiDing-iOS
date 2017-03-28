//
//  WLDataHotelHandler.h
//  WeiLvDJS
//
//  Created by ternence on 16/11/14.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLDataHotelHandler : NSObject
+ (instancetype)sharedInstance;

- (NSArray *)getHotelSearchHistory;
- (void)addNewHotelSearchItem:(NSString *)string;
- (void)clearHotelSearchHistory;


/**
 @param timeString @"2016-10-01"
 @return @"10月01日"
 */
+ (NSString *)getYMStringWithYMDString:(NSString *)timeString;

/**
 @param timeString @"时间戳"
 @return @"10月01日"
 */
+ (NSString *)TimeIntervalChangeWithYMDString:(NSString *)timeString;

+ (NSString *)TimeIntervalChangeWithYYString:(NSString *)timeString;

+ (NSString *)TimeIntervalChangeWithhhmmssString:(NSString *)timeString;

+ (NSString *)TimeIntervalChangeWithYMDString222:(NSString *)timeString;

/**

 @param timeString @"2016-10-01 10:20:20"
 @return @"2016.10.01 10:20"
 */
+ (NSString *)getYMDHMStringWithYMDHMSString:(NSString *)timeString;

/**
 @param  2016-11-22 18:00:00
 @return  5天 16:29:47
 */
+ (NSInteger)getcountdownData:(NSString *)timeStr;
@end
