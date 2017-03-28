//
//  WLDateManager.h
//  WeiLvDJS
//
//  Created by whw on 17/3/8.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KDateManager  [WLDateManager dateDefault]

@interface WLDateManager : NSObject

+ (instancetype)dateDefault;
//*< 将时间戳转换成指定格式的时间字符串
- (NSString *)getDateStringWithTimeString:(NSString *)timeStr andFormatter:(NSString *)formatterString;
/**< 判断是不是今天 */
- (BOOL) isTodayWithTimeString:(NSString *)timeString;
/**< 判断当前日期是否大于等于所给的时间戳日期 */
- (BOOL) isOverTodayOfTimeString:(NSString *)timeString;
/**< 将date转换成指定日期格式的字符串 */
- (NSString *)changeDateToStringWith:(NSDate *)date andFormatter:(NSString *)formatterString;
/**< 计算倒计时起始时间 */
- (double)setupDifferentTime:(NSString *)failureTime;
/**< 将指定格式的时间字符串转换成时间戳 */
- (NSString *)timeIntervalWithTimeString:(NSString *)timeString formatter:(NSString *)formatterString;

/**< 将date转换成指定日期格式的date */
- (NSDate *)changeDateToDateWith:(NSDate *)date andFormatter:(NSString *)formatterString;


- (BOOL)currentDateIsLaterThanTimeInterval:(NSTimeInterval)timeInterval;
@end
