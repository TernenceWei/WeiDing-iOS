//
//  WLNetworkHotelHandler.m
//  WeiLvDJS
//
//  Created by ternence on 16/11/8.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLNetworkHotelHandler.h"
#import "WLNetworkUrlHeader.h"
#import "WLNetworkManager.h"
#import "WLHotelOrderInfo.h"
#import "WLHotelBillListInfo.h"


static WLNetworkHotelHandler* sharedInstance;
@implementation WLNetworkHotelHandler
+ (instancetype)sharedInstance{
    if (sharedInstance == nil) {
        sharedInstance = [[WLNetworkHotelHandler alloc] init];
    }
    return sharedInstance;
}

- (NSString *)getUserPassword
{
    NSString *password = [DEFAULTS objectForKey:@"userPassword"];
    NSString *RSAPassword =[MyRSA encryptString:password publicKey:RSAKey];
    return RSAPassword;
}

- (NSString *)getUserID
{
    return [DEFAULTS objectForKey:@"user_id"];
}

- (NSString *)getCompanyID
{
    return [DEFAULTS objectForKey:@"currentCompanyID"];;
}

- (void)requestHotelListWithStatus:(HotelListStatus)status page:(NSUInteger)page result:(void (^)(BOOL, NSArray *, NSUInteger, NSUInteger))resultBlock
{
    NSString *urlString = [HotelBaseURL stringByAppendingString:HotelRequestOrderListURL];
    NSString *userID = [self getUserID];
    NSString *password = [self getUserPassword];
    NSString *companyID = [self getCompanyID];
    
    NSMutableDictionary *params = [@{@"user_id": userID,
                                     @"user_password": password,
                                     @"company_id": companyID,
                                     @"status": [NSString stringWithFormat:@"%ld",status],
                                     @"page": [NSString stringWithFormat:@"%ld",page]} mutableCopy];

    
    [WLNetworkManager requestWithMethod:@"POST"
                                    url:urlString
                                 params:params
                                success:^(id responseObject) {
                                    
                                    NSDictionary *dict = (NSDictionary *)responseObject;
                                    NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                                    NSUInteger currentPage = 0;
                                    NSUInteger totalPage = 0;
                                    if (status == 1) {//成功
                                        NSDictionary *dict0 = [dict objectForKey:@"data"];
                                        NSArray *data = [dict0 objectForKey:@"data"];
                                        NSMutableArray *objectArray = [NSMutableArray array];
                                        for (NSDictionary *dict in data) {
                                            WLHotelOrderInfo *order = [[WLHotelOrderInfo alloc] initWithDict:dict];
                                            [objectArray addObject:order];
                                        }
                                        currentPage = [[dict0 objectForKey:@"page"] integerValue];
                                        totalPage = [[dict0 objectForKey:@"count_page"] integerValue];
                                        return resultBlock(YES, [objectArray copy], currentPage, totalPage);
                                        
                                    }
                                    return resultBlock(YES, nil, currentPage, totalPage);
                                    
                                }
                                failure:^(NSError *error) {
                                    
                                    return  resultBlock(NO, nil , 0, 0);
                                    
                                    
                                }];

}

- (void)searchHotelListWithID:(NSString *)ID result:(void (^)(BOOL, NSArray *))resultBlock
{
    NSString *urlString = [HotelBaseURL stringByAppendingString:HotelRequestOrderListURL];
    NSString *userID = [self getUserID];
    NSString *password = [self getUserPassword];
    NSString *companyID = [self getCompanyID];
    
    NSMutableDictionary *params = [@{@"user_id": userID,
                                     @"user_password": password,
                                     @"company_id": companyID,
                                     @"search": ID} mutableCopy];
    
    
    [WLNetworkManager requestWithMethod:@"POST"
                                    url:urlString
                                 params:params
                                success:^(id responseObject) {
                                    
                                    NSDictionary *dict = (NSDictionary *)responseObject;
                                    NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                                    if (status == 1) {//成功
                                        NSDictionary *dict0 = [dict objectForKey:@"data"];
                                        NSArray *data = [dict0 objectForKey:@"data"];
                                        NSMutableArray *objectArray = [NSMutableArray array];
                                        for (NSDictionary *dict in data) {
                                            WLHotelOrderInfo *order = [[WLHotelOrderInfo alloc] initWithDict:dict];
                                            [objectArray addObject:order];
                                        }
                                        return resultBlock(YES, [objectArray copy]);
                                        
                                    }
                                    return resultBlock(YES, nil);
                                    
                                }
                                failure:^(NSError *error) {
                                    
                                    return resultBlock(NO, nil);
                                    
                                    
                                }];

}

- (void)deleteAOrderWithChecklistID:(NSString *)checklistID result:(void (^)(BOOL, BOOL))resultBlock
{
    NSString *urlString = [HotelBaseURL stringByAppendingString:HotelDeleteOrderURL];
    NSString *userID = [self getUserID];
    NSString *password = [self getUserPassword];
    NSString *companyID = [self getCompanyID];
    
    NSMutableDictionary *params = [@{@"user_id": userID,
                                     @"user_password": password,
                                     @"company_id": companyID,
                                     @"checklist_id": checklistID} mutableCopy];
    
    
    [WLNetworkManager requestWithMethod:@"POST"
                                    url:urlString
                                 params:params
                                success:^(id responseObject) {
                                    
                                    NSDictionary *dict = (NSDictionary *)responseObject;
                                    NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                                    BOOL success = NO;
                                    if (status == 1) {//成功
                                        success = YES;
                                    }
                                    return resultBlock(YES, success);
                                    
                                }
                                failure:^(NSError *error) {
                                    
                                    return  resultBlock(NO, NO);
                                    
                                    
                                }];
}

- (void)modifyOrderStatusWithChecklistID:(NSString *)checklistID actionType:(HotelActionType)type remark:(NSString *)remark result:(void (^)(BOOL, BOOL, NSString *))resultBlock
{
    NSString *urlString = [HotelBaseURL stringByAppendingString:HotelModifyOrderStatusURL];
    NSString *userID = [self getUserID];
    NSString *password = [self getUserPassword];
    NSString *companyID = [self getCompanyID];
    
    NSMutableDictionary *params = [@{@"user_id": userID,
                                     @"user_password": password,
                                     @"company_id": companyID,
                                     @"checklist_id": checklistID,
                                     @"status": [NSString stringWithFormat:@"%ld",type]} mutableCopy];
    if (remark != nil && ![remark isEqualToString:@""]) {
        [params setObject:remark forKey:@"remark"];
    }
    
    [WLNetworkManager requestWithMethod:@"POST"
                                    url:urlString
                                 params:params
                                success:^(id responseObject) {
                                    
                                    NSDictionary *dict = (NSDictionary *)responseObject;
                                    NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                                    BOOL success = NO;
                                    NSString *message = nil;
                                    if (status == 1) {//成功
                                        success = YES;
                                    }else{
                                        message = [dict objectForKey:@"msg"];
                                    }
                                    return resultBlock(YES, success, message);
                                    
                                }
                                failure:^(NSError *error) {
                                    
                                    return  resultBlock(NO, NO, nil);
                                    
                                    
                                }];
    
}

- (void)quoteTheOrderWithChecklistID:(NSString *)checklistID acceptSplit:(BOOL)acceptSplit price:(NSString *)price count:(NSString *)cout expiryDate:(NSString *)expiryDate result:(void (^)(BOOL, BOOL, NSString *))resultBlock
{
    NSString *urlString = [HotelBaseURL stringByAppendingString:HotelQuoteURL];
    NSString *userID = [self getUserID];
    NSString *password = [self getUserPassword];
    
    NSMutableDictionary *params = [@{@"user_id": userID,
                                     @"user_password": password,
                                     @"checklist_id": checklistID,
                                     @"is_split_accept": [NSString stringWithFormat:@"%d",acceptSplit]} mutableCopy];
    if (price != nil && ![price isEqualToString:@""]) {
        [params setObject:price forKey:@"forecast_price"];
    }
    if (cout != nil && ![cout isEqualToString:@""]) {
        [params setObject:cout forKey:@"forecast_count"];
    }
    if (expiryDate != nil && ![expiryDate isEqualToString:@""]) {
        [params setObject:expiryDate forKey:@"dispatch_expiry_date"];
    }
    
    [WLNetworkManager requestWithMethod:@"POST"
                                    url:urlString
                                 params:params
                                success:^(id responseObject) {
                                    
                                    NSDictionary *dict = (NSDictionary *)responseObject;
                                    NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                                    BOOL success = NO;
                                    NSString *message = nil;
                                    if (status == 1) {//成功
                                        success = YES;
                                        
                                    }else{
                                        message = [dict objectForKey:@"msg"];
                                    }
                                    return resultBlock(YES, success,message);
                                    
                                }
                                failure:^(NSError *error) {
                                    
                                    return  resultBlock(NO, NO, nil);
                                    
                                    
                                }];
}

- (void)requestHotelBillListWithPage:(NSUInteger)page result:(void (^)(BOOL, NSArray *, NSUInteger, NSUInteger))resultBlock
{
    NSString *urlString = [HotelBaseURL stringByAppendingString:HotelBillListURL];
    NSString *userID = [self getUserID];
    NSString *password = [self getUserPassword];
    NSString *companyID = [self getCompanyID];
    
    NSMutableDictionary *params = [@{@"user_id": userID,
                                     @"user_password": password,
                                     @"company_id": companyID,
                                     @"page": [NSString stringWithFormat:@"%ld",page]} mutableCopy];
    
    
    [WLNetworkManager requestWithMethod:@"POST"
                                    url:urlString
                                 params:params
                                success:^(id responseObject) {
                                    
                                    NSDictionary *dict = (NSDictionary *)responseObject;
                                    NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                                    NSUInteger currentPage = 0;
                                    NSUInteger totalPage = 0;
                                    if (status == 1) {//成功
                                        NSDictionary *dict0 = [dict objectForKey:@"data"];
                                        NSArray *data = [dict0 objectForKey:@"data"];
                                        NSMutableArray *objectArray = [NSMutableArray array];
                                        for (NSDictionary *dict in data) {
                                            WLHotelBillListInfo *order = [[WLHotelBillListInfo alloc] initWithDict:dict];
                                            [objectArray addObject:order];
                                        }
                                        currentPage = [[dict0 objectForKey:@"page"] integerValue];
                                        totalPage = [[dict0 objectForKey:@"count_page"] integerValue];
                                        return resultBlock(YES, [objectArray copy], currentPage, totalPage);
                                        
                                    }
                                    return resultBlock(YES, nil, currentPage, totalPage);
                                    
                                }
                                failure:^(NSError *error) {
                                    
                                    return  resultBlock(NO, nil, 0, 0);
                                    
                                    
                                }];

}

- (void)requestHotelBillDetailWithGroupID:(NSString *)groupID groupNO:(NSString *)groupNO checklistID:(NSString *)checklistID companyID:(NSString *)companyID date:(NSString *)date result:(void (^)(BOOL, WLHotelBillDetailInfo *))resultBlock
{
    NSString *urlString = [HotelBaseURL stringByAppendingString:HotelBillDetailURL];
    NSString *userID = [self getUserID];
    NSString *password = [self getUserPassword];
    
    NSMutableDictionary *params = [@{@"user_id": userID,
                                     @"user_password": password,
                                     @"grouplist_id":groupID,
                                     @"group_number": groupNO,
                                     @"checker_id": checklistID,
                                     @"dj_company_id":companyID ,
                                     @"date":date } mutableCopy];
    
    
    [WLNetworkManager requestWithMethod:@"POST"
                                    url:urlString
                                 params:params
                                success:^(id responseObject) {
                                    
                                    NSDictionary *dict = (NSDictionary *)responseObject;
                                    NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
                                    if (status == 1) {//成功
                                        NSDictionary *dict0 = [dict objectForKey:@"data"];
                                        WLHotelBillDetailInfo *detailInfo = [[WLHotelBillDetailInfo alloc] initWithDict:dict0];
                                        return resultBlock(YES, detailInfo);
                                        
                                    }
                                    resultBlock(YES, nil);
                                    
                                }
                                failure:^(NSError *error) {
                                    
                                    resultBlock(NO, nil);
                                    
                                    
                                }];
}
@end
