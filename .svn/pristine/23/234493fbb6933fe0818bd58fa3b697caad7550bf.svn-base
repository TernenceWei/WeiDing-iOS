//
//  WLMainMessageSearchHandler.m
//  WeiLvDJS
//
//  Created by whw on 16/12/16.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLMainMessageSearchHandler.h"

@implementation WLMainMessageSearchHandler
/**< 获取消息首页搜索历史的数组 */
+ (NSMutableArray *)getMainMessageSearchData
{
    
    NSString *plistPath = [self getFilePath];
    return [NSMutableArray arrayWithContentsOfFile:plistPath];
}
/**< 保存消息首页搜索历史 */
+ (void)saveMainMessageSearchWithData:(NSString *)dataString;
{
    NSMutableArray *searchHistory = [self getMainMessageSearchData];
    if ([searchHistory containsObject:dataString])
    {
        //包含这条记录 先移除
        [searchHistory removeObject:dataString];
    } else //不包含这条记录
    {
        if (searchHistory.count > 5) {//如果记录数组大于5,那么,移除最后一个记录
            [searchHistory removeLastObject];
        }
    }
    [searchHistory insertObject:dataString atIndex:0];
    
    [searchHistory writeToFile:[self getFilePath] atomically:YES];
}
/**< 删除保存的数据 */
+ (void)clearAllMessageSearchData
{
    NSMutableArray *array = [self getMainMessageSearchData];
    [array removeAllObjects];
    [array writeToFile:[self getFilePath] atomically:YES];
}

+ (NSString *)getFilePath
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [pathArray objectAtIndex:0];
    return [filePath stringByAppendingPathComponent:@"SearchHistory.plist"];
}

+ (void)creatFile
{
    
    NSString *plistPath = [self getFilePath];
    NSFileManager *fileManager = [NSFileManager  defaultManager];
    if (![fileManager fileExistsAtPath:plistPath]) {
        
        [fileManager createFileAtPath:plistPath contents:nil attributes:nil];
        NSMutableArray *arr =[[NSMutableArray alloc]init];
        [arr writeToFile:plistPath atomically:YES];
    }
}
@end
