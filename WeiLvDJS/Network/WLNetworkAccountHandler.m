//
//  WLNetworkAccountHandler.m
//  WeiLvDJS
//
//  Created by ternence on 16/12/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLNetworkAccountHandler.h"
#import "WL_Mine_UserInfoModel.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WL_BankCard_Model.h"
#import "WLFundAccountObject.h"
#import "WLDepositListObject.h"
#import "WLTradeRecordObject.h"
#import "WLTradeRecordListObject.h"
#import "WLTradeRecordDetailObject.h"
#import "WLCityItem.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "WLBindCardObject.h"
#import "AppManager.h"
#import "WLCarFrozenListObject.h"

@implementation WLNetworkAccountHandler
+ (void)requestFundAccountWithResultBlock:(CompletionDataBlock)dataBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:AccountHomeURL];
    
    [WLNetworkTool requestWithRequestType:WLRequestTypeGet
                                      url:urlString
                                   params:nil
                                  success:^(id responseObject) {
                                      
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      
                                      if (status==200) {
                                          
                                          WLFundAccountObject *userModel = [WLFundAccountObject mj_objectWithKeyValues:data];
                                          return dataBlock(WLResponseTypeSuccess, userModel, message);
                                      }
                                      return dataBlock(WLResponseTypeSuccess, nil, message);
                                      
                                  }
                                  failure:^(NSError *error) {
                                      
                                      if (error.code == -1009) {
                                          return dataBlock(WLResponseTypeNoNetwork, nil, nil);
                                      }
                                      return dataBlock(WLResponseTypeServerError, nil, nil);
                                      
                                  }];
 
}

+ (void)requestFrozenAccountWithResultBlock:(void (^)(WLResponseType, NSString *, NSString *, NSString *, NSString *))dataBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:AccountFrozenURL];
    
    [WLNetworkTool requestWithRequestType:WLRequestTypeGet
                                      url:urlString
                                   params:nil
                                  success:^(id responseObject) {
                                      
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      
                                      if (status==200) {
                                          
                                          NSString *frozenCount = [data objectForKey:@"frozen"];
                                          NSString *depositCount = [data objectForKey:@"withdraw_frozen"];
                                          NSString *carFrozenCount = [data objectForKey:@"carfare_frozen"];
                                          if ([depositCount isEqualToString:@""]) {
                                              depositCount = @"0";
                                          }
                                          return dataBlock(WLResponseTypeSuccess,frozenCount,depositCount,carFrozenCount, message);
                                      }
                                      return dataBlock(WLResponseTypeSuccess,nil, nil,nil, message);
                                      
                                  }
                                  failure:^(NSError *error) {
                                      
                                      if (error.code == -1009) {
                                          return dataBlock(WLResponseTypeNoNetwork,nil,nil, nil, nil);
                                      }
                                      return dataBlock(WLResponseTypeServerError,nil,nil, nil, nil);
                                      
                                  }];
}

+ (void)requestFrozenListWithResultBlock:(CompletionDataBlock)dataBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:AccountFrozenListURL];
    
    NSDictionary *params = @{@"page": @"1",
                             @"page_size": @"30"};
    
    [WLNetworkTool requestWithRequestType:WLRequestTypeGet
                                      url:urlString
                                   params:params
                                  success:^(id responseObject) {
                                      
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      
                                      if (status==200) {
                                          NSMutableArray *objectArray = [NSMutableArray array];
                                          
                                          if ([data isKindOfClass:[NSArray class]]) {
                                              for (NSDictionary *dict0 in data) {
                                                  WLCarFrozenListObject *userModel = [WLCarFrozenListObject mj_objectWithKeyValues:dict0];
                                                  userModel.frozenID = [dict0 objectForKey:@"id"];
                                                  [objectArray addObject:userModel];
                                              }
                                          }
                                          
                                          return dataBlock(WLResponseTypeSuccess, objectArray, message);
                                      }
                                      return dataBlock(WLResponseTypeSuccess, nil, message);
                                      
                                  }
                                  failure:^(NSError *error) {
                                      
                                      NSString *message = [WLNetworkTool getFailureMessageWithError:error];
//                                      NSUInteger status = [WLNetworkTool getFailureStatusWithError:error];
                                      if (error.code == -1009) {
                                          return dataBlock(WLResponseTypeNoNetwork, nil, message);
                                      }
                                      return dataBlock(WLResponseTypeServerError, nil, message);
                                      
                                  }];

}


+ (void)requestDepositingListWithDepositingStatus:(WLDepositingStatus)status resultBlock:(CompletionDataBlock)dataBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:AccountDepositListURL];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (status > 0) {
        [params setObject:[NSString stringWithFormat:@"%ld", status] forKey:@"audit_status"];
    }
    
    [WLNetworkTool requestWithRequestType:WLRequestTypeGet
                                      url:urlString
                                   params:nil
                                  success:^(id responseObject) {
                                      
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      
                                      if (status==200) {
                                          NSMutableArray *objectArray = [NSMutableArray array];
                                          
                                          if ([data isKindOfClass:[NSArray class]]) {
                                              for (NSDictionary *dict0 in data) {
                                                  WLDepositListObject *userModel = [WLDepositListObject mj_objectWithKeyValues:dict0];
                                                  userModel.depositID = [dict0 objectForKey:@"id"];
                                                  [objectArray addObject:userModel];
                                              }
                                          }
                                          
                                          return dataBlock(WLResponseTypeSuccess, objectArray, message);
                                      }
                                      return dataBlock(WLResponseTypeSuccess, nil, message);
                                      
                                  }
                                  failure:^(NSError *error) {
                                      
                                      if (error.code == -1009) {
                                          return dataBlock(WLResponseTypeNoNetwork, nil, nil);
                                      }
                                      return dataBlock(WLResponseTypeServerError, nil, nil);
                                      
                                  }];
    
}


+ (void)requestTradeRecordListWithResultBlock:(CompletionDataBlock)dataBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:AccountTradeListURL];

    [WLNetworkTool requestWithRequestType:WLRequestTypeGet
                                      url:urlString
                                   params:nil
                                  success:^(id responseObject) {
                                      
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      
                                      if (status==200) {
                                          NSMutableArray *objectArray = [NSMutableArray array];
                                          
                                          if ([data isKindOfClass:[NSArray class]]) {
                                              for (NSDictionary *dict0 in data) {
                                                  WLTradeRecordListObject *userModel = [[WLTradeRecordListObject alloc] initWithDict:dict0];
                                                  [objectArray addObject:userModel];
                                              }
                                          }
                                          
                                          return dataBlock(WLResponseTypeSuccess, objectArray, message);
                                      }
                                      return dataBlock(WLResponseTypeSuccess, nil, message);
                                      
                                  }
                                  failure:^(NSError *error) {
                                      
                                      if (error.code == -1009) {
                                          return dataBlock(WLResponseTypeNoNetwork, nil, nil);
                                      }
                                      return dataBlock(WLResponseTypeServerError, nil, nil);
                                      
                                  }];

}

+ (void)requestTradeRecordListWithTradeType:(WLTradeRecordType)tradeType resultBlock:(CompletionDataBlock)dataBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:AccountTradeTypeListURL];
    NSDictionary *params = @{@"trade_type": [NSString stringWithFormat:@"%ld", tradeType]};
    
    [WLNetworkTool requestWithRequestType:WLRequestTypeGet
                                      url:urlString
                                   params:params
                                  success:^(id responseObject) {
                                      
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      
                                      if (status==200) {
                                          NSMutableArray *objectArray = [NSMutableArray array];
                                          
                                          if ([data isKindOfClass:[NSArray class]]) {
                                              for (NSDictionary *dict0 in data) {
                                                  WLTradeRecordObject *userModel = [WLTradeRecordObject mj_objectWithKeyValues:dict0];
                                                  userModel.tradeID = [dict0 objectForKey:@"id"];
                                                  [objectArray addObject:userModel];
                                              }
                                          }
                                          
                                          return dataBlock(WLResponseTypeSuccess, objectArray, message);
                                      }
                                      return dataBlock(WLResponseTypeSuccess, nil, message);
                                      
                                  }
                                  failure:^(NSError *error) {
                                      
                                      if (error.code == -1009) {
                                          return dataBlock(WLResponseTypeNoNetwork, nil, nil);
                                      }
                                      return dataBlock(WLResponseTypeServerError, nil, nil);
                                      
                                  }];
}

+ (void)requestTradeRecordDetailWithTradeType:(WLTradeRecordType)tradeType tradeID:(NSString *)tradeID resultBlock:(CompletionDataBlock)dataBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:@"/account/recharge-info"];
    if (tradeType == WLTradeRecordTypeDeposit) {
        
        urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:@"/account/withdraw-info"];
    }else if (tradeType == WLTradeRecordTypeMemberShipMoney){
        
        urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:@"/account/group-cost-info"];
    }else if (tradeType == WLTradeRecordTypeDriverOrderPay){
        
        urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:@"/account/sjorder-info"];
    }else if (tradeType == WLTradeRecordTypeGrabOrderPay){
        
        urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:@"/account/carfare-info"];
        
    }else if (tradeType == WLTradeRecordTypeCarBookingOrderPay){
        
        urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:@"/account/carfare-info"];
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (tradeID) {
        [params setObject:tradeID forKey:@"id"];
    }
    
    
    [WLNetworkTool requestWithRequestType:WLRequestTypeGet
                                      url:urlString
                                   params:params
                                  success:^(id responseObject) {
                                      
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      
                                      if (status==200) {
                                          
                                          WLTradeRecordDetailObject *userModel = [[WLTradeRecordDetailObject alloc] initWithDict:data tradeType:tradeType];
                                          return dataBlock(WLResponseTypeSuccess, userModel, message);
                                      }
                                      return dataBlock(WLResponseTypeSuccess, nil, message);
                                      
                                  }
                                  failure:^(NSError *error) {
                                      
                                      if (error.code == -1009) {
                                          return dataBlock(WLResponseTypeNoNetwork, nil, nil);
                                      }
                                      return dataBlock(WLResponseTypeServerError, nil, nil);
                                      
                                  }];
}


+ (void)authenticateRealNameWithName:(NSString *)name IDCard:(NSString *)IDCard operationBlock:(OperationBlock)operationBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:AccountRealNameURL];
    
    NSDictionary *params = @{@"real_name":name,
                             @"id_card":IDCard};
    
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:urlString
                                   params:params
                                  success:^(id responseObject) {
                                      
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      
                                      BOOL success = (status == 200? YES: NO);
                                      
                                      return operationBlock(WLResponseTypeSuccess, success, message);
                                      
                                  }
                                  failure:^(NSError *error) {
                                      
                                      NSString *message = [WLNetworkTool getFailureMessageWithError:error];

                                      if (error.code == -1009) {
                                          return operationBlock(WLResponseTypeNoNetwork, 0, message);
                                      }
                                      return operationBlock(WLResponseTypeServerError, 0, message);
                                      
                                  }];
}

+ (void)bindBankCardWithBankName:(NSString *)bankName branchBankName:(NSString *)branchBankName bankCard:(NSString *)bankCard cityID:(NSString *)cityID operationBlock:(OperationBlock)operationBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:AccountBindBankURL];
    NSDictionary *params = @{@"city_id":cityID,
                             @"bank_name":bankName,
                             @"bank_branch_name":branchBankName,
                             @"bank_number":bankCard};
    
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:urlString
                                   params:params
                                  success:^(id responseObject) {
                                      
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      
                                      BOOL success = (status == 200? YES: NO);
                                      return operationBlock(WLResponseTypeSuccess, success, message);
                                      
                                  }
                                  failure:^(NSError *error) {
                                      
                                      if (error.code == -1009) {
                                          return operationBlock(WLResponseTypeNoNetwork, 0, nil);
                                      }
                                      return operationBlock(WLResponseTypeServerError, 0, nil);
                                      
                                  }];
}


+ (void)requestBankListWithResultBlock:(CompletionDataBlock)dataBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:AccountBankListURL];
 
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:urlString
                                   params:nil
                                  success:^(id responseObject) {
                                      
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      NSArray *data = [dict objectForKey:@"data"];
                                      
                                      if (status==200) {
                                          NSMutableArray *objectArray = [NSMutableArray array];
                                          
                                          if ([data isKindOfClass:[NSArray class]]) {
                                              for (NSDictionary *dict0 in data) {
                                                  NSString *bankName = [dict0 objectForKey:@"name"];
                                                  [objectArray addObject:bankName];
                                              }
                                          }
                                          
                                          return dataBlock(WLResponseTypeSuccess, objectArray, message);
                                      }
                                      return dataBlock(WLResponseTypeSuccess, nil, message);
                                      
                                  }
                                  failure:^(NSError *error) {
                                      
                                      if (error.code == -1009) {
                                          return dataBlock(WLResponseTypeNoNetwork, nil, nil);
                                      }
                                      return dataBlock(WLResponseTypeServerError, nil, nil);
                                      
                                  }];
}


+ (void)requestBindBankInfoWithResultBlock:(CompletionDataBlock)dataBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:AccountBindBankInfoURL];
    
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:urlString
                                   params:nil
                                  success:^(id responseObject) {
                                      
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      
                                      if (status==200) {
                                          WLBindCardObject *object = [[WLBindCardObject alloc] initWithDict:data];
                                          return dataBlock(WLResponseTypeSuccess, object, message);
                                      }
                                      return dataBlock(WLResponseTypeNoData, nil, message);
                                      
                                  }
                                  failure:^(NSError *error) {
                                      
                                      if (error.code == -1009) {
                                          return dataBlock(WLResponseTypeNoNetwork, nil, nil);
                                      }
                                      return dataBlock(WLResponseTypeServerError, nil, nil);
                                      
                                  }];
}

+ (void)setPaymentCodeWithPassword:(NSString *)password operationBlock:(OperationBlock)operationBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:AccountSetPasswordURL];
    NSDictionary *params = @{@"pay_pass":password};
    
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:urlString
                                   params:params
                                  success:^(id responseObject) {
                                      
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      
                                      BOOL success = (status == 200? YES: NO);
                                      return operationBlock(WLResponseTypeSuccess, success, message);
                                      
                                  }
                                  failure:^(NSError *error) {
                                      
                                      if (error.code == -1009) {
                                          return operationBlock(WLResponseTypeNoNetwork, 0, nil);
                                      }
                                      return operationBlock(WLResponseTypeServerError, 0, nil);
                                      
                                  }];
}


+ (void)resetPaymentCodeWithMobile:(NSString *)mobile code:(NSString *)code iDCard:(NSString *)idCard operationBlock:(OperationBlock)operationBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:AccountResetPasswordURL];
    NSDictionary *params = @{@"mobile":mobile,@"code":code,@"id_card":idCard};
    
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:urlString
                                   params:params
                                  success:^(id responseObject) {
                                      
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      
                                      BOOL success = (status == 200? YES: NO);
                                      return operationBlock(WLResponseTypeSuccess, success, message);
                                      
                                  }
                                  failure:^(NSError *error) {
                                      
                                      
                                      NSString *message = [WLNetworkTool getFailureMessageWithError:error];
                                      NSUInteger status = [WLNetworkTool getFailureStatusWithError:error];
                                      if (status == 400) {
                                          return operationBlock(WLResponseTypeSuccess, NO, message);
                                      }
                                      
                                      if (error.code == -1009) {
                                          return operationBlock(WLResponseTypeNoNetwork, NO, nil);
                                      }
                                      return operationBlock(WLResponseTypeServerError, NO, nil);
                                      
                                  }];
}

+ (void)checkRealNameAuthenticationCountWithOperationBlock:(OperationBlock)operationBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:AccountRealNameCountURL];

    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:urlString
                                   params:nil
                                  success:^(id responseObject) {
                                      
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      
                                      if (status==200) {
                                          
                                          return operationBlock(WLResponseTypeSuccess, NO, message);
                                      }
                                      return operationBlock(WLResponseTypeSuccess, YES, message);
                                      
                                  }
                                  failure:^(NSError *error) {
                                      
                                      if (error.code == -1009) {
                                          return operationBlock(WLResponseTypeNoNetwork, NO, nil);
                                      }
                                      return operationBlock(WLResponseTypeServerError, NO, nil);
                                      
                                  }];

    
}


//+ (void)requestAlipayOrderWithRechargeAmount:(NSString *)amount orderTitle:(NSString *)orderTitle orderContent:(NSString *)orderContent dataBlock:(CompletionDataBlock)dataBlock
//{
////    NSString *userId = [WLUserTools getUserId];
////    NSString *passWord =[WLUserTools getRSAUserPassword];
////    NSDictionary *params = @{@"user_id":userId,
////                             @"user_password":passWord,
////                             @"total_fee":amount,
////                             @"subject":orderTitle,
////                             @"body":orderContent};
////    
////    [WLNetworkTool requestWithRequestType:WLRequestTypePost
////                                      url:AlipayPayRsaUrl
////                                   params:params
////                                  success:^(id responseObject) {
////                                      
////                                      WL_Network_Model *model= [WL_Network_Model mj_objectWithKeyValues:responseObject];
////                                      NSString *orderString  = model.data[@"alipay_config"];
////                                      [WLNetworkAccountHandler rechargeWithAlipayOrder:orderString operationBlock:^(WLResponseType responseType, BOOL result, NSString *message) {
////                                          
////                                      }];
////                                      return dataBlock(WLResponseTypeSuccess, model, nil);
////                                      
////                                  }
////                                  failure:^(NSError *error) {
////                                      
////                                      if (error.code == -1009) {
////                                          return dataBlock(WLResponseTypeNoNetwork, 0, nil);
////                                      }
////                                      return dataBlock(WLResponseTypeServerError, 0, nil);
////                                      
////                                  }];
//}



+ (void)requestPaymentOrderWithPaymentMode:(WLPaymentMode)mode money:(NSString *)money content:(NSString *)content dataBlock:(CompletionDataBlock)dataBlock
{
    NSString *urlString;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (mode == WLPaymentModeAlipay) {
        
        urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:AccountAlipayRechargeURL];
        [params setObject:money forKey:@"amount"];
        
    }else if (mode == WLPaymentModeWeixin){
        
        urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:AccountWeixinRechargeURL];
        [params setObject:money forKey:@"amount"];
        [params setObject:content forKey:@"body"];
    }
    
    
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:urlString
                                   params:params
                                  success:^(id responseObject) {
                                      
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      NSString *data = [dict objectForKey:@"data"];
                                      
                                      if (status==200) {
                                          return dataBlock(WLResponseTypeSuccess, data, message);
                                      }
                                      return dataBlock(WLResponseTypeNoData, nil, message);
                                      
                                  }
                                  failure:^(NSError *error) {
                                      
                                      if (error.code == -1009) {
                                          return dataBlock(WLResponseTypeNoNetwork, nil, nil);
                                      }
                                      return dataBlock(WLResponseTypeServerError, nil, nil);
                                      
                                  }];
}


+ (void)rechargeWithPaymentMode:(WLPaymentMode)mode orderParams:(id)orderParams operationBlock:(OperationBlock)operationBlock
{
    NSString *appScheme = @"AliSDKWeiLvDJS";
    if (mode == WLPaymentModeAlipay || mode == WLPaymentModeAlipayOrder) {

        [[AlipaySDK defaultService] payOrder:orderParams fromScheme:appScheme callback:^(NSDictionary *resultDic){
            //未安装支付宝客户端
            [self alipayFinish:resultDic];

        }];
        
    }else if (mode == WLPaymentModeWeixin || mode == WLPaymentModeWeixinOrder){
        
        if (![WXApi isWXAppInstalled]) {
            [[WL_TipAlert_View sharedAlert] createTip:@"请先安装微信，再支付"];
            return;
        }
        
        NSDictionary *params = (NSDictionary *)orderParams;
        PayReq* request             = [[PayReq alloc] init];
        request.openID              = [params objectForKey:@"appid"];
        request.partnerId           = [params objectForKey:@"partnerid"];
        request.prepayId            = [params objectForKey:@"prepayid"];
        request.nonceStr            = [params objectForKey:@"noncestr"];
        request.timeStamp           = [[params objectForKey:@"timestamp"] intValue];
        request.package             = [params objectForKey:@"package"];
        request.sign                = [params objectForKey:@"sign"];
        [WXApi sendReq:request];
        
    }
    
}

+ (void)alipayFinish:(NSDictionary *)dict
{
    NSString *errorCode = [dict objectForKey:@"resultStatus"];
    WLPaymentCode code = WLPaymentCodeSuccess;
    if ([errorCode intValue] == 9000){
        
        code = WLPaymentCodeSuccess;
    }else if ([errorCode intValue] == 8000){
        
        code = WLPaymentCodeProcessed;
    }else if ([errorCode intValue] == 6001){
        
        code = WLPaymentCodeCancel;
    }else{
        code = WLPaymentCodeFailure;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:PaymentNotification object:nil userInfo:@{@"code":[NSString stringWithFormat:@"%ld",code]}];
    
}

+ (void)requestDepositingBankCardInfoWithDataBlock:(CompletionDataBlock)dataBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:AccountDepositCardInfoURL];
    
    [WLNetworkTool requestWithRequestType:WLRequestTypeGet
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
                                      return dataBlock(WLResponseTypeSuccess, nil, message);
                                      
                                  }
                                  failure:^(NSError *error) {
                                      
//                                      NSUInteger status = [WLNetworkTool getFailureStatusWithError:error];
                                      NSString *message = [WLNetworkTool getFailureMessageWithError:error];
                                      
                                      return dataBlock(WLResponseTypeServerError, nil, message);
                                      
                                  }];
}


+ (void)depositWithPaymentCode:(NSString *)paymentCode amount:(NSString *)amount balance:(NSString *)balance bankCard:(NSString *)bankCard dataBlock:(CompletionDataBlock)dataBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:AccountDepositURL];
    
    NSDictionary *params = @{@"amount": amount,
                             @"balance": balance,
                             @"bank_card_id": bankCard,
                             @"pay_pwd_hash": paymentCode};
    
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
                                      return dataBlock(WLResponseTypeSuccess, nil, message);
                                      
                                  }
                                  failure:^(NSError *error) {
                                      
                                      //NSUInteger status = [WLNetworkTool getFailureStatusWithError:error];
                                      NSString *message = [WLNetworkTool getFailureMessageWithError:error];
                                      return dataBlock(WLResponseTypeServerError, nil, message);
                                      
                                  }];
}

+ (void)requestCityListWithDataBlock:(CompletionDataBlock)dataBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:AccountCityListURL];
 
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:urlString
                                   params:nil
                                  success:^(id responseObject) {
                                      //WlLog(@"地区==%@",responseObject);
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      
                                      if (status==200) {
                                          NSMutableArray *provinceArray = [NSMutableArray array];
                                          NSArray *provinceDict = [data objectForKey:@"province"];
                                          for (NSDictionary *dict0 in provinceDict) {
                                              WLCityItem *item = [[WLCityItem alloc] initWithDict:dict0 type:nil];
                                              NSArray *cityDict = [dict0 objectForKey:@"city"];
                                              NSMutableArray *cityArray = [NSMutableArray array];
                                              for (NSDictionary *dict1 in cityDict) {
                                                  WLCityItem *item2 = [[WLCityItem alloc] initWithDict:dict1 type:nil];
                                                  item2.provinceID = item.cityID;
                                                  NSArray *areaDict = [dict1 objectForKey:@"county"];
                                                  NSMutableArray *areaArray = [NSMutableArray array];
                                                  for (NSDictionary *dict2 in areaDict) {
                                                      WLCityItem *item = [[WLCityItem alloc] initWithDict:dict2 type:nil];
                                                      [areaArray addObject:item];
                                                  }
                                                  item2.cityItems = [areaArray copy];
                                                  [cityArray addObject:item2];
                                              }
                                              item.cityItems = [cityArray copy];
                                              [provinceArray addObject:item];
                                              
                                          }
                                          
                                          return dataBlock(WLResponseTypeSuccess, provinceArray, message);
                                      }
                                      return dataBlock(WLResponseTypeSuccess, nil, message);
                                      
                                  }
                                  failure:^(NSError *error) {
                                      
                                      if (error.code == -1009) {
                                          return dataBlock(WLResponseTypeNoNetwork, nil, nil);
                                      }
                                      return dataBlock(WLResponseTypeServerError, nil, nil);
                                      
                                  }];
}






//+ (void)updateAlipayStatusWithTradeNumber:(NSString *)tradeNumber operationBlock:(OperationBlock)operationBlock
//{
//    NSString *userId = [WLUserTools getUserId];
//    NSString *passWord =[WLUserTools getRSAUserPassword];
//    NSDictionary *params = @{@"user_id":userId,
//                             @"user_password":passWord,
//                             @"out_trade_no":tradeNumber};
//    
//    [WLNetworkTool requestWithRequestType:WLRequestTypePost
//                                      url:AlipayPayUpdateRechargeFUrl
//                                   params:params
//                                  success:^(id responseObject) {
//                                      
//                                      WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
//                                      BOOL success = NO;
//                                      if ([net_model.result isEqualToString:@"1"]) {
//                                          
//                                          success = YES;
//                                      }
//                                      return operationBlock(WLResponseTypeSuccess, success, net_model.msg);
//                                      
//                                  }
//                                  failure:^(NSError *error) {
//                                      
//                                      if (error.code == -1009) {
//                                          return operationBlock(WLResponseTypeNoNetwork, 0, nil);
//                                      }
//                                      return operationBlock(WLResponseTypeServerError, 0, nil);
//                                      
//                                  }];
//
//}

@end
