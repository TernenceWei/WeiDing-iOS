//
//  WLNetworkCarBookingHandler.m
//  WeiLvDJS
//
//  Created by ternence on 2017/1/18.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLNetworkCarBookingHandler.h"
#import "WLCarBookingOrderListObject.h"
#import "WLCarBookingDriverObject.h"

@implementation WLNetworkCarBookingHandler

+ (void)bookingCarWithCarObject:(WLBookingCarObject *)object imageArray:(NSArray *)imageArray dataBlock:(CompletionDataBlock)dataBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:CarBookingBookingCarURL];
    
    NSMutableDictionary *params = [object mj_keyValues];
    
    [WLNetworkTool requestWithUrl:urlString
                           params:params
                        fileArray:imageArray
                         fileName:@"image_files"
                          success:^(id responseObject) {
                              
                              NSDictionary *dict = (NSDictionary *)responseObject;
                              NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                              NSString *message = [dict objectForKey:@"message"];
                              NSDictionary *data = [dict objectForKey:@"data"];
                              
                              if (status==200) {
                                  WLBookingCarResultObject *object = [[WLBookingCarResultObject alloc] initWithDict:data];
                                  return dataBlock(WLResponseTypeSuccess, object, message);
                              }
                              return dataBlock(WLResponseTypeNoData, nil, message);
                          }
                          failure:^(NSError *error) {
                              
                              NSString *message = [WLNetworkTool getFailureMessageWithError:error];
                              NSUInteger status = [WLNetworkTool getFailureStatusWithError:error];
                              if (status == 404) {
                                  return dataBlock(WLResponseType2, nil, message);
                              }else if (status == 422){
                                  return dataBlock(WLResponseType1, nil, message);
                              }
                              if (error.code == -1009) {
                                  return dataBlock(WLResponseTypeNoNetwork, nil, message);
                              }
                              return dataBlock(WLResponseTypeServerError, nil, message);
                          }];
    

}

+ (void)addCostWithOrderID:(NSString *)orderID price:(NSString *)price companyID:(NSString *)companyID operationBlock:(OperationBlock)operationBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:CarBookingAddCostURL];
    
    NSMutableDictionary *params = [@{@"id": orderID,
                                     @"price": price} mutableCopy];
    if (companyID) {
        [params setObject:companyID forKey:@"company_id"];
    }
    
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:urlString
                                   params:params
                                  success:^(id responseObject) {
                                      
                                      
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
//                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      
                                      if (status==200) {
                                          
                                          return operationBlock(WLResponseTypeSuccess, YES, message);
                                      }
                                      return operationBlock(WLResponseTypeNoData, NO, message);
                                      
                                  }
                                  failure:^(NSError *error) {
                                      
                                      NSString *message = [WLNetworkTool getFailureMessageWithError:error];
//                                      NSUInteger status = [WLNetworkTool getFailureStatusWithError:error];
                                      if (error.code == -1009) {
                                          return operationBlock(WLResponseTypeNoNetwork, NO, message);
                                      }
                                      return operationBlock(WLResponseTypeServerError, NO, message);
                                      
                                  }];
}


+ (void)cancelOrderWithOrderID:(NSString *)orderID dataBlock:(CompletionDataBlock)dataBlock
{
    NSString *url = [[WLNetworkTool getBaseUrl] stringByAppendingFormat:@"v1%@/%@",CarBookingCancelOrderURL,orderID];
    NSString *accessToken = [WLUserTools getAccessToken];
    url = [url stringByAppendingFormat:@"?access-token=%@",accessToken];

    NSDictionary *params = @{@"reception_status": [NSString stringWithFormat:@"4"]};

    [WLNetworkTool requestWithRequestType:WLRequestTypePut
                                      url:url
                                   params:params
                                  success:^(id responseObject) {
                                      
                                      
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      
                                      if (status==200) {
                                          WLCarBookingOrderDetailObject *object = [WLCarBookingOrderDetailObject mj_objectWithKeyValues:data];
                                          object.orderID = [data objectForKey:@"id"];
                                          return dataBlock(WLResponseTypeSuccess, object, message);
                                      }
                                      return dataBlock(WLResponseTypeNoData, nil, message);
                                      
                                  }
                                  failure:^(NSError *error) {
                                      
                                      NSString *message = [WLNetworkTool getFailureMessageWithError:error];
                                      if (error.code == -1009) {
                                          return dataBlock(WLResponseTypeNoNetwork, nil, message);
                                      }
                                      return dataBlock(WLResponseTypeServerError, nil, message);
                                      
                                  }];
}

+ (void)requestPaymentOrderWithPaymentMode:(WLPaymentMode)mode orderID:(NSString *)orderID driverID:(NSString *)driverID dataBlock:(CompletionDataBlock)dataBlock
{
    NSString *urlString;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (mode == WLPaymentModeAlipayOrder) {
        
        urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:CarBookingPayOrderURL];
        [params setObject:orderID forKey:@"sj_order_id"];
        [params setObject:driverID forKey:@"sj_driver_id"];
        [params setObject:@"微叮_叫车订单" forKey:@"subject"];
        
    }else if (mode == WLPaymentModeWeixinOrder){
        
        urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:CarBookingWeixinPayOrderURL];
        [params setObject:orderID forKey:@"sj_order_id"];
        [params setObject:driverID forKey:@"sj_driver_id"];
    }
    
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:urlString
                                   params:params
                                  success:^(id responseObject) {
                                      
                                      
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      
                                      if (status==200) {
                                          
                                          return dataBlock(WLResponseTypeSuccess, data, message);
                                      }
                                      return dataBlock(WLResponseTypeNoData, nil, message);
                                      
                                  }
                                  failure:^(NSError *error) {
                                      
                                      NSString *message = [WLNetworkTool getFailureMessageWithError:error];
                                      if (error.code == -1009) {
                                          return dataBlock(WLResponseTypeNoNetwork, nil, message);
                                      }
                                      return dataBlock(WLResponseTypeServerError, nil, message);
                                      
                                  }];
}

+ (void)requestOrderDetailWithOrderID:(NSString *)orderID dataBlock:(CompletionDataBlock)dataBlock
{
    NSString *url = [[WLNetworkTool getBaseUrl] stringByAppendingFormat:@"v1%@/%@",CarBookingOrderDetailURL,orderID];
    NSString *accessToken = [WLUserTools getAccessToken];
    url = [url stringByAppendingFormat:@"?access-token=%@",accessToken];
    
    [WLNetworkTool requestWithRequestType:WLRequestTypeGet
                                      url:url
                                   params:nil
                                  success:^(id responseObject) {
                                      
                                      
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      
                                      if (status==200) {
                                          
                                          WLCarBookingOrderDetailObject *object = [WLCarBookingOrderDetailObject mj_objectWithKeyValues:data];
                                          object.orderID = [data objectForKey:@"id"];
                                          
                                          return dataBlock(WLResponseTypeSuccess, object, message);
                                      }
                                      return dataBlock(WLResponseTypeNoData, nil, message);
                                      
                                  }
                                  failure:^(NSError *error) {
                                      
                                      NSString *message = [WLNetworkTool getFailureMessageWithError:error];
                                      if (error.code == -1009) {
                                          return dataBlock(WLResponseTypeNoNetwork, nil, message);
                                      }
                                      return dataBlock(WLResponseTypeServerError, nil, message);
                                      
                                  }];
}


+ (void)CarbookingOrderListWithType:(NSString *)type companyID:(NSString *)companyID nextUrl:(NSString *)nextUrl dataBlock:(void (^)(WLResponseType, id, NSString *, NSString *))dataBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:CarBookingBookingCarOrderListURL];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"type"] = type;
    if (companyID) {
        [params setObject:companyID forKey:@"company_id"];
    }
    if (nextUrl) {
        urlString = nextUrl;
        [params removeAllObjects];
    }
    
    [WLNetworkTool requestWithRequestType:WLRequestTypeGet
                                      url:urlString
                                   params:params
                                  success:^(id responseObject) {
                                      
                                      //WlLog(@"%@",responseObject);
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      
                                      NSDictionary *links = [data objectForKey:@"_links"];
                                      NSString *nextUrl = [[links objectForKey:@"next"] objectForKey:@"href"];
                                      NSString *lastUrl = [[links objectForKey:@"last"] objectForKey:@"href"];
                                      
                                      NSMutableArray * dataArr = [[NSMutableArray alloc] init];
                                                                            
                                      if (status==200) {
                                          
                                          WLCarBookingOrderListObjectData * datamodel = [WLCarBookingOrderListObjectData mj_objectWithKeyValues:data];
                                          if (datamodel.items.count != 0) {
                                              for (NSInteger i = 0 ;i < datamodel.items.count;i ++) {
                                                  WLCarBookingOrderListObject * model = [WLCarBookingOrderListObject mj_objectWithKeyValues:datamodel.items[i]];
                                                  model.thisid = datamodel.items[i][@"id"];
                                                  [dataArr addObject:model];
                                              }
                                          }
                                          if (lastUrl == nil) {//没有更多数据
                                              return dataBlock(WLResponseTypeNoMoreData,dataArr,nil,message);
                                          }
                                          
                                          return dataBlock(WLResponseTypeSuccess, dataArr, nextUrl, message);
                                      }
                                      return dataBlock(WLResponseTypeNoData, nil,nextUrl, message);
                                      
                                  }
                                  failure:^(NSError *error) {
                                      
                                      NSString *message = [WLNetworkTool getFailureMessageWithError:error];
                                      NSUInteger status = [WLNetworkTool getFailureStatusWithError:error];
                                      if (status == 404) {
                                          return dataBlock(WLResponseType2, nil,nil, message);
                                      }else if (status == 422){
                                          return dataBlock(WLResponseType1, nil,nil, message);
                                      }
                                      if (error.code == -1009) {
                                          return dataBlock(WLResponseTypeNoNetwork, nil,nil, message);
                                      }
                                      return dataBlock(WLResponseTypeServerError, nil,nil, message);
                                      
                                  }];
}

+ (void)someDriversHadBidPriceWithOrderID:(NSString *)orderID resultBlock:(void (^)(BOOL, BOOL, NSString *))resultBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:CarBookingHadBidPriceURL];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"order_id"] = orderID;
    
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:urlString
                                   params:params
                                  success:^(id responseObject) {
                                      
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      
                                      if (status==200 && [[data objectForKey:@"bool"] boolValue]) {
                                          return resultBlock(YES, YES, message);
                                      }
                                      return resultBlock(YES, NO, message);
                                      
                                  }
                                  failure:^(NSError *error) {
                                      
                                      NSString *message = [WLNetworkTool getFailureMessageWithError:error];
                                      return resultBlock(NO, NO, message);
                                      
                                  }];

}

+ (void)requestCarSeatNumbersWithResultBlock:(CompletionDataBlock)dataBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:CarBookingCarSeatURL];

    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:urlString
                                   params:nil
                                  success:^(id responseObject) {
                                      
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      
                                      if (status==200) {
                                          return dataBlock(WLResponseTypeSuccess, data, message);
                                      }
                                      return dataBlock(WLResponseTypeNoData, nil, message);
                                      
                                  }
                                  failure:^(NSError *error) {
                                      
                                      NSString *message = [WLNetworkTool getFailureMessageWithError:error];
                                      NSUInteger status = [WLNetworkTool getFailureStatusWithError:error];
                                      if (status == 404) {
                                          return dataBlock(WLResponseType2, nil, message);
                                      }else if (status == 422){
                                          return dataBlock(WLResponseType1, nil, message);
                                      }
                                      if (error.code == -1009) {
                                          return dataBlock(WLResponseTypeNoNetwork, nil, message);
                                      }
                                      return dataBlock(WLResponseTypeServerError, nil, message);
                                      
                                  }];
}

+ (void)doChooseDriverWithOrderID:(NSString *)orderID driverID:(NSString *)driverID Block:(StatusBlock)dataBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:CarBookingdoChoosedriverURL];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"order_id"] = orderID;
    params[@"sj_driver_id"] = driverID;
    
    [WLNetworkTool requestWithRequestType:WLRequestTypePost url:urlString params:params success:^(id responseObject) {
        
//        WlLog(@"选择司机responseObject==%@",responseObject);
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSUInteger status = [[dict objectForKey:@"status"] integerValue];
        //NSString *message = [dict objectForKey:@"message"];
        NSDictionary *data = [dict objectForKey:@"data"];
        NSString *message = [data objectForKey:@"message"];
        
        return dataBlock(WLResponseTypeSuccess,status,message);
        
    } failure:^(NSError *error) {
        NSString *message = [WLNetworkTool getFailureMessageWithError:error];
        NSUInteger status = [error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
        return dataBlock(WLResponseTypeServerError,status,message);
    }];
}
@end
