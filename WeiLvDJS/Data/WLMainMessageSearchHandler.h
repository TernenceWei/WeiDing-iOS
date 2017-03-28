//
//  WLMainMessageSearchHandler.h
//  WeiLvDJS
//
//  Created by whw on 16/12/16.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLMainMessageSearchHandler : NSObject
/**< 获取消息首页搜索历史的数组 */
+ (NSMutableArray *)getMainMessageSearchData;
/**< 保存消息首页搜索历史 */
+ (void)saveMainMessageSearchWithData:(NSString *)dataString;
/**< 删除保存的数据 */
+ (void)clearAllMessageSearchData;
/**< 创建文件路径 */
+ (void)creatFile;
@end
