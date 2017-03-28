//
//  ContactDataHelper.h
//  WeChatContacts-demo
//
//  Created by shen_gh on 16/3/12.
//  Copyright © 2016年 com.joinup(Beijing). All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  格式化联系人列表
 */

@interface ContactDataHelper : NSObject

+ (instancetype)shareManager;

//  将数组重复的对象去除，只保留一个
- (NSMutableArray *)arrayWithMemberIsOnly:(NSArray *)array;

/*将汉字转换为不带音调的拼音
 *string是要转换的字符串*/
- (NSString *)transformMandarinToLatin:(NSString *)string;

#pragma mark ----过滤电话
- (NSString *)trimmingString:(NSString *)string;
@end
