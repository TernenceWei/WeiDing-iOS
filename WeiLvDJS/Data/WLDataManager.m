//
//  WLDataManager.m
//  WeiLvDJS
//
//  Created by ternence on 16/9/29.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLDataManager.h"
#import "WLDataHotelHandler.h"
#import "WLDataTouristHandler.h"
#import "WLMainMessageSearchHandler.h"
static WLDataManager* sharedInstance;
@implementation WLDataManager
+ (instancetype)sharedInstance{
    if (sharedInstance == nil) {
        sharedInstance = [[WLDataManager alloc] init];
    }
    return sharedInstance;
}

+ (NSArray *)getHotelSearchHistory
{
   return [[WLDataHotelHandler sharedInstance] getHotelSearchHistory];
}

+ (void)addNewHotelSearchItem:(NSString *)string
{
    [[WLDataHotelHandler sharedInstance] addNewHotelSearchItem:string];
}

+ (void)clearHotelSearchHistory
{
    [[WLDataHotelHandler sharedInstance] clearHotelSearchHistory];
}

+ (void)saveObjectWithKey:(NSString *)key
{
}
#pragma mark - 消息首页文件存储
/**< 获取消息首页搜索历史的数组 */
+ (NSMutableArray *)getMainMessageSearchData
{
    return [WLMainMessageSearchHandler getMainMessageSearchData];
}
/**< 保存消息首页搜索历史 */
+ (void)saveMainMessageSearchWithData:(NSString *)dataString;
{
    [WLMainMessageSearchHandler saveMainMessageSearchWithData:dataString];
}
/**< 删除保存的数据 */
+ (void)clearAllMessageSearchData
{
    [WLMainMessageSearchHandler clearAllMessageSearchData];
}
+ (void)creatFile
{
   [WLMainMessageSearchHandler creatFile];
}
@end
