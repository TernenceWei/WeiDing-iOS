//
//  WLDataManager.h
//  WeiLvDJS
//
//  Created by ternence on 16/9/29.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLDataManager : NSObject
+ (instancetype)sharedInstance;

+ (NSArray *)getHotelSearchHistory;
+ (void)addNewHotelSearchItem:(NSString *)string;
+ (void)clearHotelSearchHistory;


+ (void)saveObjectWithKey:(NSString *)key;

#pragma mark - 消息首页文件存储
/**< 获取消息首页搜索历史的数组 */
+ (NSMutableArray *)getMainMessageSearchData;
/**< 保存消息首页搜索历史 */
+ (void)saveMainMessageSearchWithData:(NSString *)dataString;
/**< 删除保存的数据 */
+ (void)clearAllMessageSearchData;
/**< 创建文件路径 */
+ (void)creatFile;

//NSUserDefault

//keychain

//文件存储

//数据库存储
@end
