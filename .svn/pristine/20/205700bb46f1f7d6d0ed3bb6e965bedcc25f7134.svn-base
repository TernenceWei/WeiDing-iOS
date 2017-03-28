//
//  NSString+Utils.h
//  WeChatContacts-demo
//
//  Created by shen_gh on 16/3/12.
//  Copyright © 2016年 com.joinup(Beijing). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)

/**
 *  汉字的拼音
 *
 *  @return 拼音
 */
- (NSString *)pinyin;

/**< 将时间戳转换成指定 月 日 */
+ (NSString *)getDateStringWithTime:(NSString *)time andFormatter:(NSString *)formatterString;
/**< 判断是不是今天 */
+ (BOOL) isTodayWithTimeString:(NSString *)timeString;
/**< 判断时间是否超过指定日期 */
+ (BOOL) isTodayOfTimeString:(NSString *)timeString;
/**< 将date转换成指定格式的字符串 */
+ (NSString *)changeDateToStringWith:(NSDate *)date andFormatter:(NSString *)formatterString;

/***包含表情的字符串编码***/
+ (NSString *)SendStringNSUTF8StringEncodingANDEmoji:(NSString *)content;

/***包含表情的字符串解码***/
+ (NSString *)GetStringNSUTF8StringEncodingANDEmoji:(NSString *)Servercontent;

@end
