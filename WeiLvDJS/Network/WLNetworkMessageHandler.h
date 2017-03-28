//
//  WLNetworkMessageHandler.h
//  WeiLvDJS
//
//  Created by ternence on 16/12/11.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLNetworkTool.h"


@interface WLNetworkMessageHandler : NSObject


#pragma mark 私信

/**< 获取消息列表 */
+ (void)requestMessageListWithNextUrl:(NSString *)nextUrl andDataBlock:(CompletionDataBlock)block;
/**< 搜索消息列表 */
+ (void)searchMessageListWithText:(NSString *)text andDataBlock:(CompletionDataBlock)block;
//删除消息
+ (void)deleteMessageWithMessageID:(NSString *)messageID WithOperationBlock:(OperationBlock)operationBlock;

+ (void)changeMessageStatusWithMessageID:(NSString *)messageID andStatus:(NSString *)orderStaus andDataBlock:(CompletionDataBlock)block;


///*******分割线******

//添加接收人
+ (void)requestWLFriendsCountWithResultBlock:(CompletionDataBlock)dataBlock;

+ (void)requestWLFriendListWithSortMode:(NSString *)mode
                              dataBlock:(CompletionDataBlock)dataBlock;

+ (void)requestCompanyListWithResultBlock:(CompletionDataBlock)dataBlock;

+ (void)requestUsualFriendsListWithResultBlock:(DataCountBlock)dataBlock;

+ (void)searchFriendOrGroupWithText:(NSString *)text
                               type:(NSString *)type
                          dataBlock:(CompletionDataBlock)dataBlock;

//消息
+ (void)requestMessageBannerListWithType:(NSString *)type
                               dataBlock:(CompletionDataBlock)dataBlock;

+ (void)requestMessageListWithRoleType:(NSString *)type
                             dataBlock:(CompletionDataBlock)dataBlock;

+ (void)searchMessageWithText:(NSString *)text
                    dataBlock:(CompletionDataBlock)dataBlock;

//+ (void)deleteMessageWithMessageID:(NSString *)messageID
//                    operationBlock:(OperationBlock)operationBlock;

//私信
+ (void)postPrivateLetterWithLetterID:(NSString *)letterID
                              content:(NSString *)content
                       operationBlock:(OperationBlock)operationBlock;

+ (void)requestPrivateLetterDetailWithLetterID:(NSString *)letterID
                                     dataBlock:(CompletionDataBlock)dataBlock;

+ (void)requestPrivateLettersWithType:(NSUInteger)type
                                 page:(NSUInteger)page
                             pageSize:(NSUInteger)pageSize
                            dataBlock:(CompletionDataBlock)dataBlock;

+ (void)deletePrivateLetterWithLetterID:(NSString *)letterID
                         operationBlock:(OperationBlock)operationBlock;

+ (void)handlePrivateLetterWithLetterID:(NSString *)letterID
                                   type:(NSUInteger)type
                         operationBlock:(OperationBlock)operationBlock;
@end
