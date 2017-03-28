//
//  WLNetworkTouristHandler.m
//  WeiLvDJS
//
//  Created by ternence on 16/9/30.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLNetworkTouristHandler.h"
#import "WLNetworkTool.h"
#import "WLOrderListInfo.h"
#import "WLMyScheduleInfo.h"
#import "WLItemDetailCarObject.h"
#import "WLItemDetailHotelObject.h"
#import "WLChargeUpCarObject.h"
#import "WLChargeUpHotelObject.h"
#import "WLChargeUpShopObject.h"
#import "WLGroupDetailInfo1.h"

static WLNetworkTouristHandler* sharedInstance;
@implementation WLNetworkTouristHandler
+ (instancetype)sharedInstance{
    if (sharedInstance == nil) {
        sharedInstance = [[WLNetworkTouristHandler alloc] init];
    }
    return sharedInstance;
}

#pragma mark 导游认证
- (void)requestTouristGuideAuthenticationStatusWithResult:(void (^)(BOOL, TouristGuideOauthStatus, long long, NSString *))resultBlock
{
    NSString *urlString = [TouristGuideBaseURL stringByAppendingString:TouristGuideOauthStatusURL];
    NSString *password = [self getUserPassword];
    NSString *userID = [self getUserID];
    NSString *companyID = [WLKeychainTool readKeychainValue:@"currentCompanyID"];////[DEFAULTS objectForKey:@"currentCompanyID"];
    
    NSDictionary *params = @{@"user_password": password,
                             @"user_id": userID,
                             @"user_company_id": companyID};
    
    [WLNetworkTool requestWithMethod:@"POST"
                                    url:urlString
                                 params:params
                                success:^(id responseObject) {
                                    
                                    
                                    NSDictionary *dict = (NSDictionary *)responseObject;
                                    NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                                    NSDictionary *data = [dict objectForKey:@"data"];
                                    
                                    TouristGuideOauthStatus touristStatus = TouristGuideOauthStatusUnknown;
                                    long long totalCount = 0;
                                    NSString *message = nil;
                                    if (status == 1) {//成功
                                        NSUInteger ostatus = ((NSString *)[data objectForKey:@"status"]).integerValue;
                                        
                                        if (ostatus == 1) {
                                            touristStatus = TouristGuideOauthStatusIning;
                                        }else if (ostatus == 2){
                                            touristStatus = TouristGuideOauthStatusAlready;
                                            totalCount = ((NSString *)[data objectForKey:@"count_order"]).longLongValue;
                                        }else if (ostatus == 3){
                                            touristStatus = TouristGuideOauthStatusFailure;

                                            message = [data objectForKey:@"status_remark"];
                                        }
                                        
                                    }
                                    
                                    resultBlock(YES, touristStatus, totalCount,message);
                                    
                                } failure:^(NSError *error) {
                                    
                                    resultBlock(NO, TouristGuideOauthStatusUnknown, 0, nil);
                                    
                                }];
}

- (void)requestTouristGuidePersonalInfoWithResult:(void (^)(BOOL, WLTouristGuideInfo *))resultBlock
{
    NSString *urlString = [TouristGuideBaseURL stringByAppendingString:TouristGuidePersonnalInfoURL];
    
    NSString *userID = [self getUserID];
    NSString *password = [self getUserPassword];
    NSString *companyID = [WLKeychainTool readKeychainValue:@"currentCompanyID"];////[DEFAULTS objectForKey:@"currentCompanyID"];
    
    NSDictionary *params = @{@"user_id": userID,
                             @"user_password": password,
                             @"user_company_id": companyID};
    
    [WLNetworkTool requestWithMethod:@"POST"
                                    url:urlString
                                 params:params
                                success:^(id responseObject) {
                                    
                                    NSDictionary *dict = (NSDictionary *)responseObject;
                                    NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                                    if (status == 1) {//成功
                                        NSDictionary *data = [dict objectForKey:@"data"];
                                        
                                        WLTouristGuideInfo *info = [[WLTouristGuideInfo alloc] initWithDict:data];
                                        return resultBlock(YES, info);
                                        
                                    }
                                    return resultBlock(YES, nil);
                                    
                                }
                                failure:^(NSError *error) {
                                    
                                    resultBlock(NO, nil);
                                    
                                }];
}

- (void)submmitTouristGuidePersonalInfoWithInfo:(WLTouristGuideInfo *)info needAudits:(BOOL)needAudits result:(void (^)(BOOL, BOOL))resultBlock
{
    NSString *urlString = [TouristGuideBaseURL stringByAppendingString:TouristGuideSubmmitInfoURL];
    NSString *companyID = [WLKeychainTool readKeychainValue:@"guideCompanyID"];////[DEFAULTS objectForKey:@"guideCompanyID"];
    NSString *usercompanyID = [WLKeychainTool readKeychainValue:@"currentCompanyID"];////[DEFAULTS objectForKey:@"currentCompanyID"];
    
    NSMutableDictionary *params = [info getDict];
    [params setObject:[self getUserID] forKey:@"user_id"];
    [params setObject:[self getUserPassword] forKey:@"user_password"];
    [params setObject:[NSString stringWithFormat:@"%d",needAudits] forKey:@"isModifyInfo"];
    [params setObject:companyID forKey:@"company_id"];
    [params setObject:usercompanyID forKey:@"user_company_id"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 60;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [manager POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData){

            if (info.IDFrontImg) {
                NSData *data1 = UIImageJPEGRepresentation(info.IDFrontImg, 0.8);
                NSString *fileName1 = [NSString stringWithFormat:@"%@.jpg",[self getCurrentTime]];
                [formData appendPartWithFileData:data1 name:@"img1" fileName:fileName1 mimeType:@"image/jpeg"];
            }
            if (info.IDBackImg) {
                NSData *data2 = UIImageJPEGRepresentation(info.IDBackImg, 0.8);
                NSString *fileName2 = [NSString stringWithFormat:@"%@.jpg",[self getCurrentTime]];
                [formData appendPartWithFileData:data2 name:@"img2" fileName:fileName2 mimeType:@"image/jpeg"];
            }
            if (info.cardIDFrontImg) {
                NSData *data3 = UIImageJPEGRepresentation(info.cardIDFrontImg, 0.8);
                NSString *fileName3 = [NSString stringWithFormat:@"%@.jpg",[self getCurrentTime]];
                [formData appendPartWithFileData:data3 name:@"img3" fileName:fileName3 mimeType:@"image/jpeg"];
            }
            if (info.cardIDBackImg) {
                NSData *data4 = UIImageJPEGRepresentation(info.cardIDBackImg, 0.8);
                NSString *fileName4 = [NSString stringWithFormat:@"%@.jpg",[self getCurrentTime]];
                [formData appendPartWithFileData:data4 name:@"img4" fileName:fileName4 mimeType:@"image/jpeg"];
            }
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary *dict = (NSDictionary *)responseObject;
                NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                BOOL success = NO;
                if (status == 1) {//成功
                    success = YES;
                }
                resultBlock(YES, success);
            });
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                resultBlock(NO, NO);
            });
            
            
        }];

    });
    
}

- (void)deleteTouristGuideImageWithInfo:(WLTouristGuideInfo *)info result:(void (^)(BOOL, BOOL))resultBlock
{
    NSString *urlString = [TouristGuideBaseURL stringByAppendingString:TouristGuideDeleteImgURL];
    
    NSString *userID = [self getUserID];
    NSString *password = [self getUserPassword];
    
    NSDictionary *params = @{@"user_id": userID,
                             @"user_password": password,
                             @"file_id": info.delFileID};
    
    [WLNetworkTool requestWithMethod:@"POST"
                                    url:urlString
                                 params:params
                                success:^(id responseObject) {
                                    
                                    NSDictionary *dict = (NSDictionary *)responseObject;
                                    NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                                    BOOL deleteSuccess = NO;
                                    if (status == 1) {//成功
                                        deleteSuccess = YES;
                                    }
                                    resultBlock(YES, deleteSuccess);
                                    
                                }
                                failure:^(NSError *error) {
                                    
                                    resultBlock(NO, NO);
                                    
                                }];
    
}

- (void)deleteTouristGuidePriceListWithInfo:(WLTouristGuideInfo *)info result:(void (^)(BOOL, BOOL))resultBlock
{
    NSString *urlString = [TouristGuideBaseURL stringByAppendingString:TouristGuideDeletePriceURL];
    
    NSString *userID = [self getUserID];
    NSString *password = [self getUserPassword];
    
    NSDictionary *params = @{@"user_id": userID,
                             @"user_password": password,
                             @"price_id": info.delPriceID};
    
    [WLNetworkTool requestWithMethod:@"POST"
                                    url:urlString
                                 params:params
                                success:^(id responseObject) {
                                    
                                    NSDictionary *dict = (NSDictionary *)responseObject;
                                    NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                                    BOOL deleteSuccess = NO;
                                    if (status == 1) {//成功
                                        deleteSuccess = YES;
                                    }
                                    resultBlock(YES, deleteSuccess);
                                    
                                }
                                failure:^(NSError *error) {
                                    
                                    resultBlock(NO, NO);
                                    
                                }];
}

#pragma mark common method
- (NSString *)getUserPhoneNo
{
    return [WLKeychainTool readKeychainValue:@"user_mobile"];////[DEFAULTS objectForKey:@"user_mobile"];
}

- (NSString *)getUserPassword
{
    NSString *password = [WLKeychainTool readKeychainValue:@"userPassword"];////[DEFAULTS objectForKey:@"userPassword"];
    NSString *RSAPassword =[MyRSA encryptString:password publicKey:RSAKey];
    return RSAPassword;
}

- (NSString *)getUserID
{
    return [WLKeychainTool readKeychainValue:@"user_id"];////[DEFAULTS objectForKey:@"user_id"];
}

- (NSString *)getCurrentTime
{
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    formatter1.dateFormat = @"yyyyMMddHHmmss";
    NSString *str1 = [formatter1 stringFromDate:[NSDate date]];
    return str1;
}


#pragma mark 接单
- (void)requestOrderListOrGroupListWithType:(GroupOrderType)type miniType:(NSUInteger)miniType page:(NSUInteger)page result:(void (^)(BOOL, NSArray *))resultBlock
{
    
    NSString *urlString = [TouristGuideBaseURL stringByAppendingString:TouristGuideOrderListURL];
    
    NSString *userID = [self getUserID];
    NSString *password = [self getUserPassword];
    NSString *companyID = [WLKeychainTool readKeychainValue:@"currentCompanyID"];////[DEFAULTS objectForKey:@"currentCompanyID"];

    NSMutableDictionary *params = [@{@"user_id": userID,
                                    @"user_password": password,
                                    @"user_company_id": companyID,
                                    @"type": [NSString stringWithFormat:@"%ld",(unsigned long)type],
                                    @"page": [NSString stringWithFormat:@"%ld",(unsigned long)page]} mutableCopy];
    if (miniType != 0) {
        [params setObject:[NSString stringWithFormat:@"%ld",(unsigned long)miniType] forKey:@"type_num"];
    }
    
    [WLNetworkTool requestWithMethod:@"POST"
                                    url:urlString
                                 params:params
                                success:^(id responseObject) {
                                    
                                    NSDictionary *dict = (NSDictionary *)responseObject;
                                    NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                                    if (status == 1) {//成功
                                        NSArray *data = [dict objectForKey:@"data"];
                                        NSMutableArray *objectArray = [NSMutableArray array];
                                        for (NSDictionary *dict in data) {
                                            WLOrderListInfo *info = [[WLOrderListInfo alloc] initWithDict:dict];
                                            [objectArray addObject:info];
                                        }
                                        return resultBlock(YES, [objectArray copy]);
                                        
                                    }
                                    resultBlock(YES, nil);
                                    
                                }
                                failure:^(NSError *error) {
                                    
                                    resultBlock(NO, nil);
                                    
                                    
                                }];
    
}

- (void)acceptOrDenyTheOrderWithOrderID:(NSString *)orderID accept:(BOOL)accept denyReason:(NSString *)reason result:(void (^)(BOOL, BOOL))resultBlock
{
    NSString *urlString = [TouristGuideBaseURL stringByAppendingString:TouristGuideAccpetOrderURL];
    
    NSString *userID = [self getUserID];
    NSString *password = [self getUserPassword];
    
    NSMutableDictionary *params = [@{@"user_id": userID,
                                     @"user_password": password,
                                     @"checklist_id": orderID,
                                     @"isAccep": [NSString stringWithFormat:@"%d",accept]} mutableCopy];
    if (reason) {
        [params setObject:reason forKey:@"revoke_reason"];
    }
    
    [WLNetworkTool requestWithMethod:@"POST"
                                    url:urlString
                                 params:params
                                success:^(id responseObject) {
                                    
                                    NSDictionary *dict = (NSDictionary *)responseObject;
                                    NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                                    BOOL success = NO;
                                    if (status == 1) {//成功
                                        success = YES;
                                    }
                                    resultBlock(YES, success);
                                    
                                }
                                failure:^(NSError *error) {
                                    
                                    resultBlock(NO, NO);
                                    
                                }];
}

- (void)clearOutOfDateOrderListWithResult:(void (^)(BOOL, BOOL))resultBlock
{
    NSString *urlString = [TouristGuideBaseURL stringByAppendingString:TouristGuideClearOrderListURL];
    
    NSString *userID = [self getUserID];
    NSString *password = [self getUserPassword];
    
    NSDictionary *params = @{@"user_id": userID,
                             @"user_password": password};
    
    
    [WLNetworkTool requestWithMethod:@"POST"
                                    url:urlString
                                 params:params
                                success:^(id responseObject) {
                                    
                                    NSDictionary *dict = (NSDictionary *)responseObject;
                                    NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                                    BOOL success = NO;
                                    if (status == 1) {//成功
                                        success = YES;
                                    }
                                    resultBlock(YES, success);
                                    
                                }
                                failure:^(NSError *error) {
                                    
                                    resultBlock(NO, NO);
                                    
                                }];
}

- (void)requestGroupInfoWithGroupNO:(NSString *)groupNO result:(void (^)(BOOL, WLGroupDetailInfo *))resultBlock
{
    NSString *urlString = [TouristGuideBaseURL stringByAppendingString:TouristGuideGroupInfoURL];
    
    NSString *userID = [self getUserID];
    NSString *password = [self getUserPassword];
    
    NSDictionary *params = @{@"user_id": userID,
                             @"user_password": password,
                             @"checklist_id": groupNO};
    
    [WLNetworkTool requestWithMethod:@"POST"
                                    url:urlString
                                 params:params
                                success:^(id responseObject) {
                                    
                                    NSDictionary *dict = (NSDictionary *)responseObject;
                                    NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                                    if (status == 1) {//成功
                                        NSDictionary *data = [dict objectForKey:@"data"];
//                                        WLGroupDetailInfo1 *info = [WLGroupDetailInfo1 mj_objectWithKeyValues:data];
                                        WLGroupDetailInfo *info = [[WLGroupDetailInfo alloc] initWithDict:data];
                                        return resultBlock(YES, info);
                                    }
                                    
                                    return resultBlock(YES, nil);
                                    
                                }
                                failure:^(NSError *error) {
                                    
                                    resultBlock(NO, nil);
                                    
                                }];
}

- (void)requestLineInfoWithGroupID:(NSString *)groupID result:(void (^)(BOOL, NSArray *))resultBlock
{
    NSString *urlString = [TouristGuideBaseURL stringByAppendingString:TouristGuideLineInfoURL];
    
    NSString *userID = [self getUserID];
    NSString *password = [self getUserPassword];
    
    NSDictionary *params = @{@"user_id": userID,
                             @"user_password": password,
                             @"grouplist_id": groupID};
    
    
    [WLNetworkTool requestWithMethod:@"POST"
                                    url:urlString
                                 params:params
                                success:^(id responseObject) {
                                    
                                    NSDictionary *dict = (NSDictionary *)responseObject;
                                    NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;

                                    if (status == 1) {//成功
                                        NSArray *dictArray = [dict objectForKey:@"data"];
                                        NSMutableArray *objectArray = [NSMutableArray array];
                                        for (NSDictionary *dict in dictArray) {
                                            NSString *text = [dict objectForKey:@"detail"];
                                            [objectArray addObject:text];
                                        }
                                        return resultBlock(YES, [objectArray copy]);
                                    }
                                    return resultBlock(YES, nil);
                                    
                                }
                                failure:^(NSError *error) {
                                    
                                    resultBlock(NO, nil);
                                    
                                }];
}

- (void)requestTouristGuideListWithGroupID:(NSString *)groupID result:(void (^)(BOOL, NSArray *))resultBlock
{
    NSString *urlString = [TouristGuideBaseURL stringByAppendingString:TouristGuideListURL];
    
    NSString *userID = [self getUserID];
    NSString *password = [self getUserPassword];
    
    NSDictionary *params = @{@"user_id": userID,
                             @"user_password": password,
                             @"grouplist_id": groupID};
    
    
    [WLNetworkTool requestWithMethod:@"POST"
                                    url:urlString
                                 params:params
                                success:^(id responseObject) {
                                    
                                    NSDictionary *dict = (NSDictionary *)responseObject;
                                    NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                                    if (status == 1) {//成功
                                        NSArray *dataArray = [dict objectForKey:@"data"];
                                        NSMutableArray *objectArray = [NSMutableArray array];
                                        for (NSDictionary *dict in dataArray) {
                                            WLGuideListInfo *info = [[WLGuideListInfo alloc] initWithDict:dict];
                                            [objectArray addObject:info];
                                        }
                                        
                                        NSMutableArray *array = [NSMutableArray array];
                                        WLGuideListInfo *myselfInfo = nil;
                                        WLGuideListInfo *mainInfo = nil;
                                        for (WLGuideListInfo *info in objectArray) {
                                            if ([info.userID isEqualToString:userID]) {
                                                myselfInfo = info;
                                            }
                                            if (info.isMainGuide.boolValue && ![info.userID isEqualToString:userID]) {
                                                mainInfo = info;
                                            }
                                        }
                                        [array insertObject:myselfInfo atIndex:0];
                                        if (mainInfo) {
                                            [array insertObject:mainInfo atIndex:1];
                                        }
                                        
                                        for (WLGuideListInfo *info in objectArray) {
                                            if (![array containsObject:info]) {
                                                [array addObject:info];
                                            }
                                        }
                                        return resultBlock(YES, [array copy]);
                                    }
                                    resultBlock(YES, nil);
                                    
                                }
                                failure:^(NSError *error) {
                                    
                                    resultBlock(NO, nil);
                                    
                                }];

}

- (void)requestVisitorListWithGroupNO:(NSString *)groupNO result:(void (^)(BOOL, NSArray *))resultBlock
{
    NSString *urlString = [TouristGuideBaseURL stringByAppendingString:TouristGuideVisitorListURL];
    
    NSString *userID = [self getUserID];
    NSString *password = [self getUserPassword];
    
    NSDictionary *params = @{@"user_id": userID,
                             @"user_password": password,
                             @"group_number": groupNO};
    
    
    [WLNetworkTool requestWithMethod:@"POST"
                                    url:urlString
                                 params:params
                                success:^(id responseObject) {
                                    
                                    NSDictionary *dict = (NSDictionary *)responseObject;
                                    NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                                    if (status == 1) {//成功
                                        NSArray *dataArray = [dict objectForKey:@"data"];
                                        NSMutableArray *objectArray = [NSMutableArray array];
                                        for (NSDictionary *dict in dataArray) {
                                            WLVisitorListInfo *info = [[WLVisitorListInfo alloc] initWithDict:dict];
                                            [objectArray addObject:info];
                                        }
                                        return resultBlock(YES, [objectArray copy]);
                                    }
                                    resultBlock(YES, nil);
                                    
                                }
                                failure:^(NSError *error) {
                                    
                                    resultBlock(NO, nil);
                                    
                                }];

}

- (void)requestVisitorDetailInfoWithVisitorID:(NSString *)visitorID result:(void (^)(BOOL, WLVisitorDetailInfo *))resultBlock
{
    NSString *urlString = [TouristGuideBaseURL stringByAppendingString:TouristGuideVisitorDetailURL];
    
    NSString *userID = [self getUserID];
    NSString *password = [self getUserPassword];
    
    NSDictionary *params = @{@"user_id": userID,
                             @"user_password": password,
                             @"visitor_id": visitorID};
    
    
    [WLNetworkTool requestWithMethod:@"POST"
                                    url:urlString
                                 params:params
                                success:^(id responseObject) {
                                    
                                    NSDictionary *dict = (NSDictionary *)responseObject;
                                    NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                                    if (status == 1) {//成功
                                        NSArray *dataArray = [dict objectForKey:@"data"];
                                        
                                        WLVisitorDetailInfo *info = [[WLVisitorDetailInfo alloc] initWithDict:[dataArray firstObject]];
                                        
                                        return resultBlock(YES, info);
                                    }
                                    resultBlock(YES, nil);
                                    
                                }
                                failure:^(NSError *error) {
                                    
                                    resultBlock(NO, nil);
                                    
                                }];
}

#pragma mark 账单详情
- (void)requestBillDetailInfoWithGroupID:(NSString *)groupID userID:(NSString *)guideUserID result:(void (^)(BOOL, WLBillDetailInfo *))resultBlock
{
    NSString *urlString = [TouristGuideBaseURL stringByAppendingString:TouristGuideBillDetailURL];
    
    NSString *userID = [self getUserID];
    NSString *password = [self getUserPassword];
    
    NSDictionary *params = @{@"user_id": userID,
                             @"user_password": password,
                             @"grouplist_id": groupID,
                             @"guide_user_id": guideUserID};
    
    
    [WLNetworkTool requestWithMethod:@"POST"
                                    url:urlString
                                 params:params
                                success:^(id responseObject) {
                                    
                                    NSDictionary *dict = (NSDictionary *)responseObject;
                                    NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                                    if (status == 1) {//成功
                                        NSDictionary *dict1 = [dict objectForKey:@"data"];
                                        
                                        WLBillDetailInfo *info = [[WLBillDetailInfo alloc] initWithDict:dict1];
                                        return resultBlock(YES, info);
                                    }
                                    resultBlock(YES, nil);
                                    
                                }
                                failure:^(NSError *error) {
                                    
                                    resultBlock(NO, nil);
                                    
                                }];
}

- (void)submmitBillDetailWithGroupID:(NSString *)groupID result:(void (^)(BOOL, BOOL, NSString *))resultBlock
{
    NSString *urlString = [TouristGuideBaseURL stringByAppendingString:TouristGuideSubmitBillDetailURL];
    
    NSString *userID = [self getUserID];
    NSString *password = [self getUserPassword];
    NSString *companyID = [WLKeychainTool readKeychainValue:@"currentCompanyID"];////[DEFAULTS objectForKey:@"currentCompanyID"];
    
    NSDictionary *params =  @{@"user_id": userID,
                              @"user_password": password,
                              @"grouplist_id": groupID,
                              @"user_company_id":companyID};

    
    
    [WLNetworkTool requestWithMethod:@"POST"
                                    url:urlString
                                 params:params
                                success:^(id responseObject) {
                                    
                                    NSDictionary *dict = (NSDictionary *)responseObject;
                                    NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                                    NSString *message = [dict objectForKey:@"msg"];
                                    BOOL result = NO;
                                    if (status == 1) {//成功
                                        
                                        result = YES;
                                    }
                                    resultBlock(YES, result, message);
                                    
                                }
                                failure:^(NSError *error) {
                                    
                                    resultBlock(NO, NO, nil);
                                    
                                }];

}

- (void)refundWithGroupID:(NSString *)groupID amount:(NSString *)amount result:(void (^)(BOOL, BOOL, NSString *))resultBlock
{
    NSString *urlString = [TouristGuideBaseURL stringByAppendingString:TouristGuideRefundURL];
    
    NSString *userID = [self getUserID];
    NSString *password = [self getUserPassword];
    NSString *companyID = [WLKeychainTool readKeychainValue:@"currentCompanyID"];////[DEFAULTS objectForKey:@"currentCompanyID"];
    
    NSDictionary *params =  @{@"user_id": userID,
                              @"user_password": password,
                              @"grouplist_id": groupID,
                              @"user_company_id":companyID,
                              @"amount": amount};
    
    
    
    [WLNetworkTool requestWithMethod:@"POST"
                                    url:urlString
                                 params:params
                                success:^(id responseObject) {
                                    
                                    NSDictionary *dict = (NSDictionary *)responseObject;
                                    NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                                    NSString *message = [dict objectForKey:@"msg"];
                                    BOOL result = NO;
                                    if (status == 1) {//成功
                                        
                                        result = YES;
                                    }
                                    resultBlock(YES, result, message);
                                    
                                }
                                failure:^(NSError *error) {
                                    
                                    resultBlock(NO, NO, nil);
                                    
                                }];
}

#pragma mark 我的日程
- (void)requestMyScheduleWithSelectDate:(NSString *)date allDate:(BOOL)isAllDate groupID:(NSString *)groupID result:(void (^)(BOOL, WLMyScheduleInfo *))resultBlock
{
    NSString *urlString = [TouristGuideBaseURL stringByAppendingString:TouristGuideRequestScheduleURL];
    
    NSString *userID = [self getUserID];
    NSString *password = [self getUserPassword];
    
    NSMutableDictionary *params = [@{@"user_id": userID,
                             @"user_password": password,
                             @"select_date": date,
                             @"isGetAllDate": [NSString stringWithFormat:@"%d",isAllDate]
                             } mutableCopy];
    if (groupID != nil && ![groupID isEqualToString:@""]) {
        [params setObject:groupID forKey:@"checklist_id"];
    }
    
    
    [WLNetworkTool requestWithMethod:@"POST"
                                    url:urlString
                                 params:params
                                success:^(id responseObject) {
                                    
                                    NSDictionary *dict = (NSDictionary *)responseObject;
                                    NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                                    if (status == 1) {//成功
                                        NSDictionary *dict1 = [dict objectForKey:@"data"];
                                        
                                        WLMyScheduleInfo *info = [[WLMyScheduleInfo alloc] initWithDict:dict1];
                                        
                                        return resultBlock(YES, info);
                                    }
                                    resultBlock(YES, nil);
                                    
                                }
                                failure:^(NSError *error) {
                                    
                                    resultBlock(NO, nil);
                                    
                                }];
}

- (void)setMyScheduleWithSelectDate:(NSString *)date receiveVisitors:(BOOL)receiveVisitors remark:(NSString *)remark result:(void (^)(BOOL, BOOL))resultBlock
{
    NSString *urlString = [TouristGuideBaseURL stringByAppendingString:TouristGuideSetScheduleURL];
    
    NSString *userID = [self getUserID];
    NSString *password = [self getUserPassword];
    
    NSMutableDictionary *params = [@{@"user_id": userID,
                                     @"user_password": password,
                                     @"select_date": date,
                                     @"isAccept": [NSString stringWithFormat:@"%d",receiveVisitors]} mutableCopy];
    if (remark) {
        [params setObject:remark forKey:@"remark"];
    }
    
    [WLNetworkTool requestWithMethod:@"POST"
                                    url:urlString
                                 params:params
                                success:^(id responseObject) {
                                    
                                    NSDictionary *dict = (NSDictionary *)responseObject;
                                    NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                                    BOOL success = NO;
                                    if (status == 1) {//成功
                                        success = YES;
                                    }
                                    resultBlock(YES, success);
                                    
                                }
                                failure:^(NSError *error) {
                                    
                                    resultBlock(NO, NO);
                                    
                                }];

}

- (void)modifyGroupStatusWithChecklistID:(NSString *)checklistID status:(ModifyGroupStatus)status result:(void (^)(BOOL, BOOL, NSString *))resultBlock
{
    NSString *urlString = [TouristGuideBaseURL stringByAppendingString:TouristGuideModifyGroupStatusURL];
    
    NSString *userID = [self getUserID];
    NSString *password = [self getUserPassword];
    
    NSDictionary *params = @{@"user_id": userID,
                             @"user_password": password,
                             @"checklist_id": checklistID,
                             @"type": [NSString stringWithFormat:@"%ld",status]} ;

    
    [WLNetworkTool requestWithMethod:@"POST"
                                    url:urlString
                                 params:params
                                success:^(id responseObject) {
                                    
                                    NSDictionary *dict = (NSDictionary *)responseObject;
                                    NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                                    BOOL success = NO;
                                    NSString *message = nil;
                                    if (status == 1) {//成功
                                        success = YES;
                                    }
                                    message = [dict objectForKey:@"msg"];
                                    
                                    return  resultBlock(YES, success, message);
                                    
                                }
                                failure:^(NSError *error) {
                                    
                                    return resultBlock(NO, NO, nil);
                                    
                                }];

}

#pragma mark 收入
- (void)requestMyIncomeListWithSelectMonth:(NSString *)month isFinished:(BOOL)isFinished result:(void (^)(BOOL, WLMyIncomeListInfo *))resultBlock
{
    NSString *urlString = [TouristGuideBaseURL stringByAppendingString:TouristGuideMyIncomelistURL];
    
    NSString *userID = [self getUserID];
    NSString *password = [self getUserPassword];
    NSString *companyID = [WLKeychainTool readKeychainValue:@"currentCompanyID"];////[DEFAULTS objectForKey:@"currentCompanyID"];
    
    NSMutableDictionary *params = [@{@"user_id": userID,
                             @"user_password": password,
                             @"user_company_id": companyID,
                             @"isFinished": [NSString stringWithFormat:@"%d",isFinished]} mutableCopy] ;
    if (month) {
        [params setObject:month forKey:@"select_date"];
    }
    
    
    [WLNetworkTool requestWithMethod:@"POST"
                                    url:urlString
                                 params:params
                                success:^(id responseObject) {
                                    
                                    NSDictionary *dict = (NSDictionary *)responseObject;
                                    NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                                    if (status == 1) {//成功
                                        NSDictionary *data = [dict objectForKey:@"data"];
                                        BOOL hasDate = NO;
                                        if (month) {
                                            hasDate = YES;
                                        }
                                        WLMyIncomeListInfo *info = [[WLMyIncomeListInfo alloc] initWithDict:data hasDate:hasDate];
                                        return resultBlock(YES, info);
                                    }
                                    resultBlock(YES, nil);
                                    
                                }
                                failure:^(NSError *error) {
                                    
                                    resultBlock(NO, nil);
                                    
                                }];
}

- (void)requestMyIncomeStatisticsWithResult:(void (^)(BOOL, WLIncomeStatisInfo *))resultBlock
{
    NSString *urlString = [TouristGuideBaseURL stringByAppendingString:TouristGuideStatisticsURL];
    
    NSString *userID = [self getUserID];
    NSString *password = [self getUserPassword];
    
    NSDictionary *params = @{@"user_id": userID,
                             @"user_password": password} ;
    
    
    [WLNetworkTool requestWithMethod:@"POST"
                                    url:urlString
                                 params:params
                                success:^(id responseObject) {
                                    
                                    NSDictionary *dict = (NSDictionary *)responseObject;
                                    NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                                    if (status == 1) {//成功
                                        NSDictionary *data = [dict objectForKey:@"data"];
                                        WLIncomeStatisInfo *info = [[WLIncomeStatisInfo alloc] initWithDict:data];
                                        return resultBlock(YES, info);
                                    }
                                    resultBlock(YES, nil);
                                    
                                }
                                failure:^(NSError *error) {
                                    
                                    resultBlock(NO, nil);
                                    
                                }];
}

- (void)chargeUpWithType:(TouristItemType)type object:(WLChargeUpObject *)object result:(void (^)(BOOL, BOOL))resultBlock
{
    NSString *urlString = [TouristGuideBaseURL stringByAppendingString:TouristGuideChargeUpURL];
    
    NSString *userID = [self getUserID];
    NSString *password = [self getUserPassword];
    NSDictionary *params0 = @{@"user_id": userID,
                              @"user_password": password,
                              @"type": [self getChargeUpTypeStringWithItemType:type]};
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:params0];

    if (type == TouristItemTypeCar) {

        [params setObject:object.resourceID forKey:@"id"];
        [params setObject:CHECKNIL(object.actualPrice) forKey:@"actual_amount"];
        [params setObject:CHECKNIL(object.remark) forKey:@"remark"];
        
    }else if (type == TouristItemTypeShopping) {
        
        [params setObject:object.resourceID forKey:@"id"];
        [params setObject:object.checklistID forKey:@"checklist_id"];
        [params setObject:object.groupID forKey:@"grouplist_id"];
        [params setObject:object.whichDate forKey:@"date"];
        if (object.actualPerson != nil && ![object.actualPerson isEqualToString:@""]) {
            [params setObject:CHECKNIL(object.actualPerson) forKey:@"actual_persons"];
        }
        if (object.actualPrice != nil && ![object.actualPrice isEqualToString:@""]) {
            [params setObject:CHECKNIL(object.actualPrice) forKey:@"actual_price"];
        }
        [params setObject:CHECKNIL(object.remark) forKey:@"remark"];
        
    }else{
        
        [params setObject:object.resourceID forKey:@"id"];
        [params setObject:object.checklistID forKey:@"checklist_id"];
        [params setObject:object.groupID forKey:@"grouplist_id"];
        [params setObject:CHECKNIL(object.whichDate) forKey:@"date"];
        
        if (object.actualPerson != nil && ![object.actualPerson isEqualToString:@""]) {
            [params setObject:CHECKNIL(object.actualPerson) forKey:@"actual_persons"];
        }
        if (object.priceList.count) {
            [params setObject:[self getStringArrayWithObjectArray:object.priceList type:type] forKey:@"pricelist"];

        }
        if (object.remark != nil && ![object.remark isEqualToString:@""]) {
            [params setObject:CHECKNIL(object.remark) forKey:@"remark"];
        }
        
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 60;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [manager POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData){
            
            for (int i = 0; i < object.uploadImgArray.count; i ++) {
                NSData *data1 = UIImageJPEGRepresentation(object.uploadImgArray[i], 0.2);
                NSString *fileName1 = [NSString stringWithFormat:@"%@.jpg",[self getCurrentTime]];
                [formData appendPartWithFileData:data1 name:[NSString stringWithFormat:@"img%d",i] fileName:fileName1 mimeType:@"image/jpeg"];
            }
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary *dict = (NSDictionary *)responseObject;
                NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                BOOL success = NO;
                if (status == 1) {//成功
                    success = YES;
                }
                resultBlock(YES, success);
            });
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                resultBlock(NO, NO);
            });
            
            
        }];
        
    });

}

- (NSArray *)getStringArrayWithObjectArray:(NSArray *)objectArray type:(TouristItemType)type
{
    NSMutableArray *stringArray = [NSMutableArray array];
    for (WLChargeUpScheduleObject *priceObject in objectArray) {
        NSString *string = @"";
        if (priceObject.checklistID) {
            string = priceObject.checklistID;
        }
        string = [string stringByAppendingString:@"|"];
        if (type != TouristItemTypeAdditional) {
            string = [[string stringByAppendingString:priceObject.pricelistID] stringByAppendingString:@"|"];
            string = [[string stringByAppendingString:priceObject.actualPrice] stringByAppendingString:@"|"];
            string = [string stringByAppendingString:priceObject.actualCount];
        }else{
            
            string = [[string stringByAppendingString:priceObject.pricelistID] stringByAppendingString:@"|"];
            string = [[string stringByAppendingString:priceObject.actualPrice] stringByAppendingString:@"|"];
            string = [[string stringByAppendingString:priceObject.actualDanJia] stringByAppendingString:@"|"];
            string = [string stringByAppendingString:priceObject.actualCount];
        }
        
        [stringArray addObject:string];
        
    }
    return [stringArray copy];
}

- (void)deleteChargeupImageWithFileID:(NSString *)fileID result:(void (^)(BOOL, BOOL, NSString *))resultBlock
{
    NSString *urlString = [TouristGuideBaseURL stringByAppendingString:TouristGuideDeleteChargeupImgURL];
    
    NSString *userID = [self getUserID];
    NSString *password = [self getUserPassword];
    
    NSDictionary *params = @{@"user_id": userID,
                             @"user_password": password,
                             @"file_id": fileID};
    
    [WLNetworkTool requestWithMethod:@"POST"
                                    url:urlString
                                 params:params
                                success:^(id responseObject) {
                                    
                                    NSDictionary *dict = (NSDictionary *)responseObject;
                                    NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                                    BOOL deleteSuccess = NO;
                                    NSString *message = [dict objectForKey:@"msg"];
                                    if (status == 1) {//成功
                                        deleteSuccess = YES;
                                    }
                                    resultBlock(YES, deleteSuccess, message);
                                    
                                }
                                failure:^(NSError *error) {
                                    
                                    resultBlock(NO, NO, nil);
                                    
                                }];

}

- (void)deleteChargeupSchedulelistWithType:(TouristItemType)type checklistID:(NSString *)checklistID result:(void (^)(BOOL, BOOL, NSString *))resultBlock
{
    NSString *urlString = [TouristGuideBaseURL stringByAppendingString:TouristGuideDeleteChargeupScheduleListURL];
    
    NSString *userID = [self getUserID];
    NSString *password = [self getUserPassword];
    
    NSDictionary *params = @{@"user_id": userID,
                             @"user_password": password,
                             @"checklist_id": checklistID,
                             @"type":[self getChargeUpTypeStringWithItemType:type]};
    
    [WLNetworkTool requestWithMethod:@"POST"
                                    url:urlString
                                 params:params
                                success:^(id responseObject) {
                                    
                                    NSDictionary *dict = (NSDictionary *)responseObject;
                                    NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                                    BOOL deleteSuccess = NO;
                                    NSString *message = [dict objectForKey:@"msg"];
                                    if (status == 1) {//成功
                                        deleteSuccess = YES;
                                    }
                                    resultBlock(YES, deleteSuccess, message);
                                    
                                }
                                failure:^(NSError *error) {
                                    
                                    resultBlock(NO, NO, nil);
                                    
                                }];
    
}

- (void)requestChargeUpInfoWithType:(TouristItemType)type resourceID:(NSString *)resourceID groupID:(NSString *)groupID date:(NSString *)date result:(void (^)(BOOL, id))resultBlock
{
    NSString *urlString = [TouristGuideBaseURL stringByAppendingString:TouristGuideRequestChargeUpURL];
    
    NSString *userID = [self getUserID];
    NSString *password = [self getUserPassword];
    
    NSDictionary *params0 = @{@"user_id": userID,
                              @"user_password": password,
                              @"type": [self getChargeUpTypeStringWithItemType:type]};
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:params0];
    if (type == TouristItemTypeCar) {
        
        [params setObject:resourceID forKey:@"id"];
        [params setObject:groupID forKey:@"grouplist_id"];
        
    }else{
        
        [params setObject:resourceID forKey:@"id"];
        [params setObject:groupID forKey:@"grouplist_id"];
        [params setObject:date forKey:@"date"];
    }
    
    
    [WLNetworkTool requestWithMethod:@"POST"
                                    url:urlString
                                 params:params
                                success:^(id responseObject) {
                                    
                                    NSDictionary *dict = (NSDictionary *)responseObject;
                                    NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                                    if (status == 1) {//成功
                                        NSDictionary *data = [dict objectForKey:@"data"];
                                        if (type == TouristItemTypeCar) {
                                            WLChargeUpCarObject *info = [[WLChargeUpCarObject alloc] initWithDict:data];
                                            return resultBlock(YES, info);
                                        }else if (type == TouristItemTypeHotel || type == TouristItemTypeMeal || type == TouristItemTypeTicket){
                                            WLChargeUpHotelObject *info = [[WLChargeUpHotelObject alloc] initWithDict:data];
                                            return resultBlock(YES, info);
                                            
                                        }else if (type == TouristItemTypeShopping){
                                            WLChargeUpShopObject *info = [[WLChargeUpShopObject alloc] initWithDict:data additional:NO];
                                            return resultBlock(YES, info);
                                        }else if (type == TouristItemTypeAdditional){
                                            WLChargeUpShopObject *info = [[WLChargeUpShopObject alloc] initWithDict:data additional:YES];
                                            return resultBlock(YES, info);
                                        }
                                        
                                    }
                                    resultBlock(YES, nil);
                                    
                                }
                                failure:^(NSError *error) {
                                    
                                    resultBlock(NO, nil);
                                    
                                }];
}

- (void)requestCurrentGroupItemDetailWithType:(TouristItemType)type resourceID:(NSString *)resourceID groupID:(NSString *)groupID date:(NSString *)date result:(void (^)(BOOL, id))resultBlock
{
    NSString *urlString = [TouristGuideBaseURL stringByAppendingString:TouristGuideRequestGroupInfoURL];
    
    NSString *userID = [self getUserID];
    NSString *password = [self getUserPassword];
    
    NSDictionary *params0 = @{@"user_id": userID,
                              @"user_password": password,
                              @"type": [self getChargeUpTypeStringWithItemType:type]};
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:params0];
    if (type == TouristItemTypeCar) {
        
        [params setObject:resourceID forKey:@"id"];
        [params setObject:groupID forKey:@"grouplist_id"];
        
    }else{
        
        [params setObject:resourceID forKey:@"id"];
        [params setObject:groupID forKey:@"grouplist_id"];
        [params setObject:date forKey:@"date"];
    }
    
    
    [WLNetworkTool requestWithMethod:@"POST"
                                    url:urlString
                                 params:params
                                success:^(id responseObject) {
                                    
                                    NSDictionary *dict = (NSDictionary *)responseObject;
                                    NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                                    if (status == 1) {//成功
                                        NSDictionary *data = [dict objectForKey:@"data"];
                                        if (type == TouristItemTypeCar) {
                                            WLItemDetailCarObject *info = [[WLItemDetailCarObject alloc] initWithDict:data];
                                            return resultBlock(YES, info);
                                        }else{
                                            WLItemDetailHotelObject *info = [[WLItemDetailHotelObject alloc] initWithDict:data];
                                            return resultBlock(YES, info);
                                        }
                                    }
                                    resultBlock(YES, nil);
                                    
                                }
                                failure:^(NSError *error) {
                                    
                                    resultBlock(NO, nil);
                                    
                                }];
}

- (NSString *)getChargeUpTypeStringWithItemType:(TouristItemType)type
{
    NSString *typeString = @"car";
    if (type == TouristItemTypeHotel) {
        
        typeString = @"hotel";
        
    } else if (type == TouristItemTypeMeal) {
        
        typeString = @"meal";
        
    }else if (type == TouristItemTypeTicket) {
        
        typeString = @"ticket";
        
    }else if (type == TouristItemTypeShopping) {
        
        typeString = @"shopping";
    }else if (type == TouristItemTypeAdditional) {
        
        typeString = @"added";
    }
    return typeString;
}

- (void)requestCurrentGroupSummaryDetailWithGroupID:(NSString *)groupID result:(void (^)(BOOL, WLChargeUpSummaryInfo *))resultBlock
{
    NSString *urlString = [TouristGuideBaseURL stringByAppendingString:TouristGuideGroupSummaryDetailURL];
    
    NSString *userID = [self getUserID];
    NSString *password = [self getUserPassword];
    
    NSDictionary *params = @{@"user_id": userID,
                             @"user_password": password,
                             @"grouplist_id":groupID} ;
    
    
    [WLNetworkTool requestWithMethod:@"POST"
                                    url:urlString
                                 params:params
                                success:^(id responseObject) {
                                    
                                    NSDictionary *dict = (NSDictionary *)responseObject;
                                    NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                                    if (status == 1) {//成功
                                        NSDictionary *data = [dict objectForKey:@"data"];
                                        WLChargeUpSummaryInfo *info = [[WLChargeUpSummaryInfo alloc] initWithDict:data];
                                        return resultBlock(YES, info);
                                    }
                                    resultBlock(YES, nil);
                                    
                                }
                                failure:^(NSError *error) {
                                    
                                    resultBlock(NO, nil);
                                    
                                }];
}

- (void)requestCurrentGroupDetailWithGroupID:(NSString *)groupID date:(NSString *)date result:(void (^)(BOOL, WLCurrentGroupInfo *))resultBlock
{
    NSString *urlString = [TouristGuideBaseURL stringByAppendingString:TouristGuideGroupDetailURL];
    
    NSString *userID = [self getUserID];
    NSString *password = [self getUserPassword];
    
    NSDictionary *params = @{@"user_id": userID,
                             @"user_password": password,
                             @"grouplist_id":groupID,
                             @"date":date};
    
    
    [WLNetworkTool requestWithMethod:@"POST"
                                    url:urlString
                                 params:params
                                success:^(id responseObject) {
                                    
                                    NSDictionary *dict = (NSDictionary *)responseObject;
                                    NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                                    if (status == 1) {//成功
                                        NSDictionary *data = [dict objectForKey:@"data"];
                                        WLCurrentGroupInfo *info = [[WLCurrentGroupInfo alloc] initWithDict:data];
                                        return resultBlock(YES, info);
                                    }
                                    resultBlock(YES, nil);
                                    
                                }
                                failure:^(NSError *error) {
                                    
                                    resultBlock(NO, nil);
                                    
                                }];
}

- (void)requestNowOnGroupIDWithResult:(void (^)(BOOL, NSString *))resultBlock
{
    NSString *urlString = [TouristGuideBaseURL stringByAppendingString:TouristGuideOnGroupIDURL];
    
    NSString *userID = [self getUserID];
    NSString *password = [self getUserPassword];
    
    NSDictionary *params = @{@"user_id": userID,
                             @"user_password": password};
    
    
    [WLNetworkTool requestWithMethod:@"POST"
                                    url:urlString
                                 params:params
                                success:^(id responseObject) {
                                    
                                    NSDictionary *dict = (NSDictionary *)responseObject;
                                    NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                                    if (status == 1) {//成功
                                        NSDictionary *data = [dict objectForKey:@"data"];
                                        NSString *groupID = [data objectForKey:@"grouplist_id"];
                                        return resultBlock(YES, groupID);
                                    }
                                    resultBlock(YES, nil);
                                    
                                }
                                failure:^(NSError *error) {
                                    
                                    resultBlock(NO, nil);
                                    
                                }];
}
@end
