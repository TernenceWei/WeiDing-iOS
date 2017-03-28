//
//  WLNetworkMessageHandler.m
//  WeiLvDJS
//
//  Created by ternence on 16/12/11.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLNetworkMessageHandler.h"
#import "WL_CompanyList_Model.h"
#import "WL_UsuallyContactsList_Model.h"
#import "WL_SearchResultModel.h"
#import "WL_CompanyBanner_Model.h"
#import "WL_MessageList_Model.h"
#import "WL_Friendlist_Model.h"
#import "WL_PrivateDetail_Model.h"
#import "WL_privateLetter_Model.h"

@implementation WLNetworkMessageHandler
/**< 获取消息列表 */
+ (void)requestMessageListWithNextUrl:(NSString *)nextUrl andDataBlock:(CompletionDataBlock)block;
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:MessageListURL];
    
    if (nextUrl) {
        urlString = nextUrl;
    }
    
    [WLNetworkTool requestWithRequestType:WLRequestTypeGet
                                      url:urlString
                                   params:nil
                                  success:^(id responseObject) {
//                                        WlLog(@"responseObject %@",responseObject);
                                      
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      if (status == 200) {
                                          WL_MessageList_dataModel *dataModel = [[WL_MessageList_dataModel alloc]init];
                                          [dataModel setValuesForKeysWithDictionary:data];
                                          return block(WLResponseTypeSuccess, dataModel, message);
                                          
                                      }
                                      return block(WLResponseTypeSuccess, nil, message);
                                  }
                                  failure:^(NSError *error) {
                                      
                                      return block(WLResponseTypeNoNetwork, nil, nil);
                                  }];
}
/**< 搜索消息 */
+ (void)searchMessageListWithText:(NSString *)text andDataBlock:(CompletionDataBlock)block
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:MessageListURL];
    if(text == nil)
    {
        return;
    }
    NSDictionary *dict = @{
                           @"search":text
                           };
    
    [WLNetworkTool requestWithRequestType:WLRequestTypeGet
                                      url:urlString
                                   params:dict
                                  success:^(id responseObject) {
//                                      WlLog(@"responseObject %@",responseObject);
                                      
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      if (status == 200) {
                                          WL_MessageList_dataModel *dataModel = [[WL_MessageList_dataModel alloc]init];
                                          [dataModel setValuesForKeysWithDictionary:data];
                                          return block(WLResponseTypeSuccess, dataModel, message);
                                          
                                      }
                                      return block(WLResponseTypeSuccess, nil, message);
                                  }
                                  failure:^(NSError *error) {
                                      
                                      return block(WLResponseTypeNoNetwork, nil, nil);
                                  }];
}
+ (void)deleteMessageWithMessageID:(NSString *)messageID WithOperationBlock:(OperationBlock)operationBlock
{
     NSString *urlString = [[WLNetworkTool getBaseUrl] stringByAppendingString:MessageDeleteURL];
     urlString = [urlString stringByAppendingFormat:@"/%@",messageID];
    NSString *accessToken = [self getAccessToken];
    urlString = [urlString stringByAppendingFormat:@"?access-token=%@",accessToken];
    
    [WLNetworkTool requestWithRequestType:WLRequestTypeDelete
                                      url:urlString
                                   params:nil
                                  success:^(id responseObject) {
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      if (status == 200) {
                                          
                                          return operationBlock(WLResponseTypeSuccess, YES, message);
                                      }
                                      return operationBlock(WLResponseTypeSuccess, NO, message);
                                  }
                                  failure:^(NSError *error) {
                                      
                                      return operationBlock(WLResponseTypeNoNetwork, nil, nil);
                                  }];



}

//将消息标记为已读
+ (void)changeMessageStatusWithMessageID:(NSString *)messageID andStatus:(NSString *)orderStaus andDataBlock:(CompletionDataBlock)block;
{
     NSString *urlString = [[WLNetworkTool getBaseUrl] stringByAppendingString:MessageDeleteURL];
    urlString = [urlString stringByAppendingFormat:@"/%@",messageID];
    NSString *accessToken = [self getAccessToken];
    urlString = [urlString stringByAppendingFormat:@"?access-token=%@",accessToken];
    NSDictionary *params = @{ @"status":orderStaus };
    [WLNetworkTool requestWithRequestType:WLRequestTypePut url:urlString
                                   params:params
                                  success:^(id responseObject) {
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
//                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      if (status == 200) {
                                          
                                          return block(WLResponseTypeSuccess, nil, message);
                                          
                                      }
                                      return block(WLResponseTypeSuccess, nil, message);
                                  }
                                  failure:^(NSError *error) {
                                      
                                      return block(WLResponseTypeNoNetwork, nil, nil);
                                  }];
}

+ (NSString *)getAccessToken
{
    return [WLUserTools getAccessToken];
}










////*****分割线*****///
+ (void)requestWLFriendsCountWithResultBlock:(CompletionDataBlock)dataBlock
{
    NSString *userId = [WLUserTools getUserId];
    NSString *passWord =[WLUserTools getRSAUserPassword];
    NSDictionary *params = @{@"user_id":userId,
                                 @"user_password":passWord};
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                         url:SocialFriendCountFriendUrl
                                      params:params
                                     success:^(id responseObject) {
                                             
                                         WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
                                         return dataBlock(WLResponseTypeSuccess, netModel, nil);
                                     }
                                     failure:^(NSError *error) {
                                             
                                         return dataBlock(WLResponseTypeNoNetwork, nil, nil);
                                         
                                     }];
}

+ (void)requestWLFriendListWithSortMode:(NSString *)mode dataBlock:(CompletionDataBlock)dataBlock
{
    NSString *userId = [WLUserTools getUserId];
    NSString *passWord =[WLUserTools getRSAUserPassword];
    NSDictionary *params = @{@"user_id":userId,
                             @"user_password":passWord,
                             @"sort_mode":mode};
    
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                         url:MyFriendListUrl
                                      params:params
                                     success:^(id responseObject) {
                                         
                                         WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
                                         return dataBlock(WLResponseTypeSuccess, netModel, nil);
                                     }
                                     failure:^(NSError *error) {
                                         
                                         return dataBlock(WLResponseTypeNoNetwork, nil, nil);
                                         
                                     }];
}

+ (void)requestCompanyListWithResultBlock:(CompletionDataBlock)dataBlock
{
    NSString *userId = [WLUserTools getUserId];
    NSString *passWord =[WLUserTools getRSAUserPassword];
    NSDictionary *params = @{@"user_id":userId,
                             @"user_password":passWord};
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                         url:UserMyCompanyListUrl
                                      params:params
                                     success:^(id responseObject) {
                                             
                                         WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
                                         NSMutableArray *listArray = [NSMutableArray array];
                                         if ([netModel.result integerValue]==1) {
                                             
                                             for (NSDictionary *dic in netModel.data) {
                                                 WL_CompanyList_Model *model =[WL_CompanyList_Model mj_objectWithKeyValues:dic];
                                                 [listArray addObject:model];
                                             }
                                         }
                                         return dataBlock(WLResponseTypeSuccess, listArray, nil);
                                             
                                         
                                     }
                                     failure:^(NSError *error) {
                                             
                                         return dataBlock(WLResponseTypeNoNetwork, nil, nil);
                                         
                                     }];
}

+ (void)requestUsualFriendsListWithResultBlock:(DataCountBlock)dataBlock
{
    NSString *userId = [WLUserTools getUserId];
    NSString *passWord =[WLUserTools getRSAUserPassword];
    NSDictionary *params = @{@"user_id":userId,
                             @"user_password":passWord};
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                         url:ContactsUsuallyContactsListUrl
                                      params:params
                                     success:^(id responseObject) {
                                         
                                         WL_Network_Model *usuallyModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
                                         NSMutableArray *listArray = [NSMutableArray array];
                                         NSUInteger count = 0;
                                         if ([usuallyModel.result integerValue]==1) {
                                             
                                             for (NSDictionary *dic in usuallyModel.data[@"list"]) {
                                                 
                                                 WL_UsuallyContactsList_Model *model =[WL_UsuallyContactsList_Model mj_objectWithKeyValues:dic];
                                                 
                                                 [listArray addObject:model];
                                                 
                                             }
                                             count = [usuallyModel.data[@"count"] integerValue];
                                         }
                                         return dataBlock(WLResponseTypeSuccess, listArray,count, nil);
                                         
                                         
                                     }
                                     failure:^(NSError *error) {
                                         
                                         return dataBlock(WLResponseTypeNoNetwork, nil,0, nil);
                                         
                                     }];
}

+ (void)searchFriendOrGroupWithText:(NSString *)text type:(NSString *)type dataBlock:(CompletionDataBlock)dataBlock
{
    NSString *userId = [WLUserTools getUserId];
    NSString *passWord =[WLUserTools getRSAUserPassword];
    NSDictionary *params = @{@"user_id":userId,
                             @"user_password":passWord,
                             @"userName":text,
                             @"type":type};
    
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                         url:SearchSearchUrl
                                      params:params
                                     success:^(id responseObject) {
                                         
                                         WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
                                         NSMutableArray *array = [NSMutableArray array];
                                         if ([net_model.result integerValue] == 1) {
                                             array = [WL_SearchResultModel mj_objectArrayWithKeyValuesArray:net_model.data[@"contacts"]];
                                             
                                         }
                                         return dataBlock(WLResponseTypeSuccess, array, nil);
                                         
                                     }
                                     failure:^(NSError *error) {
                                         
                                         if (error.code == -1009) {
                                             return dataBlock(WLResponseTypeNoNetwork, nil, nil);
                                         }
                                         return dataBlock(WLResponseTypeServerError, nil, nil);
                                         
                                     }];
}

+ (void)requestMessageBannerListWithType:(NSString *)type dataBlock:(CompletionDataBlock)dataBlock
{

    return dataBlock(WLResponseTypeServerError, nil, nil);
//    NSString *userId = [WLUserTools getUserId];
//    NSString *passWord =[WLUserTools getRSAUserPassword];
//    NSDictionary *params = @{@"user_id":userId,
//                             @"user_password":passWord,
//                             @"type":type,
//                             @"company_id":@"1"};
//    
//    [WLNetworkTool requestWithRequestType:WLRequestTypePost
//                                      url:NoticeNoticeBannerUrl
//                                   params:params
//                                  success:^(id responseObject) {
//
//                                      
//                                      WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
//                                      NSMutableArray *array = [NSMutableArray array];
//                                      if ([net_model.result integerValue] == 1) {
//                                          array = [WL_CompanyBanner_Model mj_objectArrayWithKeyValuesArray:net_model.data];
//                                          
//                                      }
//                                      return dataBlock(WLResponseTypeSuccess, array, nil);
//                                      
//                                  }
//                                  failure:^(NSError *error) {
//                                      
//                                      
//                                      
//                                      if (error.code == -1009) {
//                                          return dataBlock(WLResponseTypeNoNetwork, nil, nil);
//                                      }
//                                      return dataBlock(WLResponseTypeServerError, nil, nil);
//                                      
//                                  }];
    
   
    
}

+ (void)requestMessageListWithRoleType:(NSString *)type dataBlock:(CompletionDataBlock)dataBlock
{
    NSString *userId = [WLUserTools getUserId];
    NSString *passWord =[WLUserTools getRSAUserPassword];
    NSDictionary *params = @{@"user_id":userId,
                             @"user_password":passWord,
                             @"role_type":type};
    
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:MessageGetMessageListUrl
                                   params:params
                                  success:^(id responseObject) {
                                      
                                      WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
                                      NSMutableArray *array = [NSMutableArray array];
                                      if ([net_model.result integerValue]==1) {
                                          
                                          for (NSDictionary *dic in net_model.data) {
                                              WL_MessageList_Model *model = [WL_MessageList_Model mj_objectWithKeyValues:dic];
                                              [array addObject:model];
                                          }
                                          
                                      }
                                      return dataBlock(WLResponseTypeSuccess, array, nil);
                                      
                                  }
                                  failure:^(NSError *error) {
                                      
                                      if (error.code == -1009) {
                                          return dataBlock(WLResponseTypeNoNetwork, nil, nil);
                                      }
                                      return dataBlock(WLResponseTypeServerError, nil, nil);
                                      
                                  }];
}

+ (void)searchMessageWithText:(NSString *)text dataBlock:(CompletionDataBlock)dataBlock
{
    NSString *userId = [WLUserTools getUserId];
    NSString *passWord =[WLUserTools getRSAUserPassword];
    NSDictionary *params = @{@"user_id":userId,
                             @"user_password":passWord,
                             @"keyword":text};
    
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:SearchsearchMessageUrl
                                   params:params
                                  success:^(id responseObject) {
                                      
                                      WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
                                      NSMutableArray *array = [NSMutableArray array];
                                      if ([net_model.result integerValue] == 1) {
                                          
                                          NSArray *wlArray = net_model.data[@"friendList"];
                                          if (wlArray.count > 0) {
                                              NSMutableArray *friendList =[WL_Friendlist_Model mj_objectArrayWithKeyValuesArray:wlArray];
                                              NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjectsAndKeys:friendList,@"微叮好友",nil];
                                              [array addObject:dic];
                                              
                                          }
                                          
                                          NSArray *letterArray = net_model.data[@"letterList"];
                                          if (letterArray.count>0) {
                                              NSMutableArray *letterList =[WL_Friendlist_Model mj_objectArrayWithKeyValuesArray:letterArray];
                                              NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjectsAndKeys:letterList,@"私信",nil];
                                              [array addObject:dic];
                                          }
                                          
                                          NSArray *messageArray = net_model.data[@"messageList"];
                                          if ([messageArray count]>0) {
                                              NSMutableArray *messageList =[WL_Friendlist_Model mj_objectArrayWithKeyValuesArray:messageArray];
                                              NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjectsAndKeys:messageList,@"消息",nil];
                                              [array addObject:dic];
                                              
                                          }
                                          
                                          NSArray *noticArray = net_model.data[@"noticeList"];
                                          if (noticArray.count >0) {
                                              NSMutableArray *noticeList =[WL_Friendlist_Model mj_objectArrayWithKeyValuesArray:noticArray];
                                              NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjectsAndKeys:noticeList,@"公告",nil];
                                              [array addObject:dic];
                                              
                                          }

                                      return dataBlock(WLResponseTypeSuccess, array, nil);
                                      }
                                      
                                  }
                                  failure:^(NSError *error) {
                                      
                                      if (error.code == -1009) {
                                          return dataBlock(WLResponseTypeNoNetwork, nil, nil);
                                      }
                                      return dataBlock(WLResponseTypeServerError, nil, nil);
                                      
                                  }];
}

//+ (void)deleteMessageWithMessageID:(NSString *)messageID operationBlock:(OperationBlock)operationBlock
//{
//    NSString *userId = [WLUserTools getUserId];
//    NSString *passWord =[WLUserTools getRSAUserPassword];
//    NSDictionary *params = @{@"user_id":userId,
//                             @"user_password":passWord,
//                             @"message_ids":messageID};
//    
//    [WLNetworkTool requestWithRequestType:WLRequestTypePost
//                                      url:MessageDeleteMessageUrl
//                                   params:params
//                                  success:^(id responseObject) {
//                                      
//                                      WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
//                                      BOOL success = NO;
//                                      if ([net_model.result integerValue]==1) {
//                                          success = YES;
//                                      }
//                                      return operationBlock(WLResponseTypeSuccess,success, nil);
//                                  }
//                                  failure:^(NSError *error) {
//                                      if (error.code == -1009) {
//                                          return operationBlock(WLResponseTypeNoNetwork, NO, nil);
//                                      }
//                                      return operationBlock(WLResponseTypeServerError, NO, nil);
//                                  }];
//
//}

+ (void)requestPrivateLetterDetailWithLetterID:(NSString *)letterID dataBlock:(CompletionDataBlock)dataBlock
{
    NSString *userId = [WLUserTools getUserId];
    NSString *passWord =[WLUserTools getRSAUserPassword];
    NSDictionary *params = @{@"user_id":userId,
                             @"user_password":passWord,
                             @"letterId":letterID};
    
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:LetterDetailUrl
                                   params:params
                                  success:^(id responseObject) {
                                      
                                      WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
                                      NSMutableArray *array = [NSMutableArray array];
                                      WL_PrivateDetail_Model *detailModel = [WL_PrivateDetail_Model mj_objectWithKeyValues:net_model.data];
                                      if ([net_model.result integerValue]==1) {
                                          
                                          for (NSDictionary *dic in detailModel.reply) {
                                              WL_authorInfo_Model *model = [WL_authorInfo_Model mj_objectWithKeyValues:dic];
                                              [array addObject:model];
                                          }
                                          detailModel.reply = [array mutableCopy];
                                          
                                      }
                                      return dataBlock(WLResponseTypeSuccess, detailModel, nil);
                                      
                                  }
                                  failure:^(NSError *error) {
                                      
                                      if (error.code == -1009) {
                                          return dataBlock(WLResponseTypeNoNetwork, nil, nil);
                                      }
                                      return dataBlock(WLResponseTypeServerError, nil, nil);
                                      
                                  }];

}

+ (void)postPrivateLetterWithLetterID:(NSString *)letterID content:(NSString *)content operationBlock:(OperationBlock)operationBlock
{
    NSString *userId = [WLUserTools getUserId];
    NSString *passWord =[WLUserTools getRSAUserPassword];
    NSDictionary *params = @{@"user_id":userId,
                             @"user_password":passWord,
                             @"letterId":letterID,
                             @"content":content};
    
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:LetterAddReplyUrl
                                   params:params
                                  success:^(id responseObject) {
                                      
                                      WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
                                      BOOL success = NO;
                                      if ([net_model.result integerValue]==1) {
                                          success = YES;
                                      }
                                      return operationBlock(WLResponseTypeSuccess,success, nil);
                                  }
                                  failure:^(NSError *error) {
                                      if (error.code == -1009) {
                                          return operationBlock(WLResponseTypeNoNetwork, NO, nil);
                                      }
                                      return operationBlock(WLResponseTypeServerError, NO, nil);
                                  }];
}

+ (void)requestPrivateLettersWithType:(NSUInteger)type page:(NSUInteger)page pageSize:(NSUInteger)pageSize dataBlock:(CompletionDataBlock)dataBlock
{
    NSString *userId = [WLUserTools getUserId];
    NSString *passWord =[WLUserTools getRSAUserPassword];
    NSDictionary *params = @{@"user_id":userId,
                             @"user_password":passWord,
                             @"type":[NSString stringWithFormat:@"%ld",type],
                             @"page":[NSString stringWithFormat:@"%ld",page],
                             @"pageSize":[NSString stringWithFormat:@"%ld",pageSize]};
    
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:LetterListUrl
                                   params:params
                                  success:^(id responseObject) {
                                      
                                      WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
                                      NSMutableArray *array = [NSMutableArray array];
                                      if ([net_model.result integerValue]==1) {
                                          
                                          for (NSDictionary *dic in net_model.data) {
                                              
                                              WL_privateLetter_Model *model =[WL_privateLetter_Model mj_objectWithKeyValues:dic];
                                              
                                              [array addObject:model];
                                              
                                          }
                                          
                                      }
                                      return dataBlock(WLResponseTypeSuccess, array, nil);
                                      
                                  }
                                  failure:^(NSError *error) {
                                      
                                      if (error.code == -1009) {
                                          return dataBlock(WLResponseTypeNoNetwork, nil, nil);
                                      }
                                      return dataBlock(WLResponseTypeServerError, nil, nil);
                                      
                                  }];
}

+ (void)deletePrivateLetterWithLetterID:(NSString *)letterID operationBlock:(OperationBlock)operationBlock
{
    NSString *userId = [WLUserTools getUserId];
    NSString *passWord =[WLUserTools getRSAUserPassword];
    NSDictionary *params = @{@"user_id":userId,
                             @"user_password":passWord,
                             @"letterId":letterID};
    
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:LetterDelLetterUrl
                                   params:params
                                  success:^(id responseObject) {
                                      
                                      WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
                                      BOOL success = NO;
                                      if ([net_model.result integerValue]==1) {
                                          success = YES;
                                      }
                                      return operationBlock(WLResponseTypeSuccess,success, nil);
                                  }
                                  failure:^(NSError *error) {
                                      if (error.code == -1009) {
                                          return operationBlock(WLResponseTypeNoNetwork, NO, nil);
                                      }
                                      return operationBlock(WLResponseTypeServerError, NO, nil);
                                  }];
}

+ (void)handlePrivateLetterWithLetterID:(NSString *)letterID type:(NSUInteger)type operationBlock:(OperationBlock)operationBlock
{
    NSString *userId = [WLUserTools getUserId];
    NSString *passWord =[WLUserTools getRSAUserPassword];
    NSDictionary *params = @{@"user_id":userId,
                             @"user_password":passWord,
                             @"letterId":letterID,
                             @"type":[NSString stringWithFormat:@"%ld",type]};
    
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:LetterHandelCollectUrl
                                   params:params
                                  success:^(id responseObject) {
                                      
                                      WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
                                      BOOL success = NO;
                                      if ([net_model.result integerValue]==1) {
                                          success = YES;
                                      }
                                      return operationBlock(WLResponseTypeSuccess,success, nil);
                                  }
                                  failure:^(NSError *error) {
                                      if (error.code == -1009) {
                                          return operationBlock(WLResponseTypeNoNetwork, NO, nil);
                                      }
                                      return operationBlock(WLResponseTypeServerError, NO, nil);
                                  }];

}
@end
