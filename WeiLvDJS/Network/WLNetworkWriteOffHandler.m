//
//  WLNetworkWriteOffHandler.m
//  WeiLvDJS
//
//  Created by ternence on 2017/1/4.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLNetworkWriteOffHandler.h"

#import "WLWriteOffListObject.h"
#import "WLWriteOffDetailObject.h"


@implementation WLNetworkWriteOffHandler

+ (void)writeOffWithCode:(NSString *)code resultBlock:(void (^)(WLResponseType responseType, WLWriteOffObject *,WLWriteOffObjectBuyUser *, NSString *))resultBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:WriteOffURL];

    NSDictionary *params = @{@"code": code,
                             @"company_id": [WLKeychainTool readKeychainValue:@"CompanyID"]};
    
    [WLNetworkTool requestWithRequestType:WLRequestTypeGet
                                      url:urlString
                                   params:params
                                  success:^(id responseObject) {
                                      WlLog(@"%@",responseObject);
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      
                                      if (status==200) {
                                          
                                          WLWriteOffObject *userModel = [WLWriteOffObject mj_objectWithKeyValues:data];
                                          
                                          WLWriteOffObjectBuyUser *userModell = [WLWriteOffObjectBuyUser mj_objectWithKeyValues:[data objectForKey:@"buy_user"]];
                                          
                                          return resultBlock(WLResponseTypeSuccess, userModel,userModell, message);
                                      }
                                      return resultBlock(WLResponseTypeSuccess, nil,nil, message);
                                      
                                  }
                                  failure:^(NSError *error) {
                                      
                                      NSString *message = [WLNetworkTool getFailureMessageWithError:error];
                                      NSUInteger status = [WLNetworkTool getFailureStatusWithError:error];
                                      if (status == 404) {
                                          return resultBlock(WLResponseType2, nil,nil, message);
                                      }
                                      else if (status == 422)
                                      {
                                          return resultBlock(WLResponseType1, nil,nil, message);
                                      }
                                      if (error.code == -1009) {
                                          return resultBlock(WLResponseTypeNoNetwork, nil,nil, message);
                                      }
                                      return resultBlock(WLResponseTypeServerError, nil,nil, message);
                                      
                                  }];
}

+ (void)requestWriteOffListWithResultBlock:(CompletionDataBlock)resultBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:WriteOffListURL];
    
    [WLNetworkTool requestWithRequestType:WLRequestTypeGet
                                      url:urlString
                                   params:nil
                                  success:^(id responseObject) {
                                      WlLog(@"%@",responseObject);
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      NSArray *data = [dict objectForKey:@"data"];
                                      
                                      if (status==200) {
                                          NSMutableArray *objectArray = [NSMutableArray array];
                                          if ([data isKindOfClass:[NSArray class]]) {
                                              for (NSDictionary *dict1 in data) {
                                                  WLWriteOffListObject *object = [[WLWriteOffListObject alloc] initWithDict:dict1];
                                                  [objectArray addObject:object];
                                              }
                                          }
                                          return resultBlock(WLResponseTypeSuccess, objectArray, message);
                                          
                                      }
                                      return resultBlock(WLResponseTypeSuccess, nil, message);
                                      
                                  }
                                  failure:^(NSError *error) {
                                      
                                      if (error.code == -1009) {
                                          return resultBlock(WLResponseTypeNoNetwork, nil, nil);
                                      }
                                      return resultBlock(WLResponseTypeServerError, nil, nil);
                                      
                                  }];
}

+ (void)requestWriteOffDetailWithDate:(NSString *)date nextUrl:(NSString *)nextUrl resultBlock:(void (^)(BOOL, NSArray *, NSString * , NSString *))resultBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:WriteOffDetailURL];
    
    NSDictionary *params = @{@"date": date};
    
    if (nextUrl) {
        urlString = nextUrl;
        params = nil;
    }
    
    [WLNetworkTool requestWithRequestType:WLRequestTypeGet
                                      url:urlString
                                   params:params
                                  success:^(id responseObject) {
                                      WlLog(@"%@",responseObject);
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      
                                      if (status==200) {
                                          NSArray *items = [data objectForKey:@"items"];
                                          NSDictionary *links = [data objectForKey:@"_meta"];
                                          NSMutableArray *objectArray = [NSMutableArray array];
                                          if ([items isKindOfClass:[NSArray class]]) {
                                              for (NSDictionary *dict1 in items) {
                                                  WLWriteOffDetailObject *object = [[WLWriteOffDetailObject alloc] initWithDict:dict1];
                                                  [objectArray addObject:object];
                                              }
                                          }
                                          NSString *nextUrl = [links objectForKey:@"totalCount"];
                                          return resultBlock(YES, objectArray,nextUrl, message);
                                          
                                      }
                                      return resultBlock(YES, nil, nil, message);
                                      
                                  }
                                  failure:^(NSError *error) {
                                      
                                      if (error.code == -1009) {
                                          return resultBlock(NO, nil, nil, nil);
                                      }
                                      return resultBlock(NO, nil, nil, nil);
                                      
                                  }];
}

+ (void)requestWriteOffDetailgetGoWithDate:(NSString *)Id resultBlock:(void (^)(BOOL, WLWriteOffObject *,WLWriteOffObjectBuyUser *, NSString *))resultBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:[NSString stringWithFormat:@"/verify/record/detail/%@",Id]];
    
    [WLNetworkTool requestWithRequestType:WLRequestTypeGet
                                      url:urlString
                                   params:nil
                                  success:^(id responseObject) {
                                      WlLog(@"%@",responseObject);
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      
                                      if (status==200) {
                                          WLWriteOffObject *userModel = [WLWriteOffObject mj_objectWithKeyValues:data];
                                          
                                          WLWriteOffObjectBuyUser *userModell = [WLWriteOffObjectBuyUser mj_objectWithKeyValues:[data objectForKey:@"buy_user"]];
                                          
                                          return resultBlock(YES, userModel,userModell, message);
                                          
                                      }
                                      return resultBlock(YES, nil,nil, message);
                                      
                                  }
                                  failure:^(NSError *error) {
                                      
                                      if (error.code == -1009) {
                                          return resultBlock(NO, nil,nil, nil);
                                      }
                                      return resultBlock(NO, nil,nil, nil);
                                      
                                  }];
}

@end
