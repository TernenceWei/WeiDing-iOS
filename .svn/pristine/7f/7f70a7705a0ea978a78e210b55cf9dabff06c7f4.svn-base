//
//  WLUITool.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/21.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CHECKNIL(object) (object == nil?@"":object)


@interface WLUITool : NSObject
+ (CGSize)sizeWithString:(NSString *)title font:(UIFont *)font;
+ (CGSize)sizeWithString:(NSString *)title font:(UIFont *)font constrainedToSize:(CGSize)size;
+ (CGSize)attributedSizeWithString:(NSString *)string constrainedToSize:(CGSize)size;


/**
 时间字符串转时间戳字符串

 @param timeString 时间字符串
 @return 时间戳
 */
+ (NSString *)timeIntervalWithTimeString:(NSString *)timeString;

+ (NSString *)timeIntervalWithTimeString:(NSString *)timeString formatter:(NSString *)formatterString;
/**
 时间戳转时间字符串

 @param timeInterval 时间戳
 @return 时间字符串
 */
+ (NSString *)timeStringWithTimeInterval:(NSUInteger)timeInterval;

+ (NSString *)timeStringWithTimeInterval:(NSUInteger)timeInterval formatter:(NSString *)formatterString;
@end
