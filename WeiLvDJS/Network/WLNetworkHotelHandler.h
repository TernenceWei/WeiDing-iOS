//
//  WLNetworkHotelHandler.h
//  WeiLvDJS
//
//  Created by ternence on 16/11/8.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLTouristGroupHeader.h"
#import "WLHotelBillDetailInfo.h"

@interface WLNetworkHotelHandler : NSObject
+ (instancetype)sharedInstance;

- (void)requestHotelListWithStatus:(HotelListStatus)status
                              page:(NSUInteger)page
                            result:(void(^)(BOOL success, NSArray *listArray, NSUInteger currentPage, NSUInteger totalPage))resultBlock;

- (void)searchHotelListWithID:(NSString *)ID
                       result:(void(^)(BOOL success, NSArray *listArray))resultBlock;

- (void)deleteAOrderWithChecklistID:(NSString *)checklistID
                             result:(void(^)(BOOL success, BOOL result))resultBlock;

- (void)modifyOrderStatusWithChecklistID:(NSString *)checklistID
                              actionType:(HotelActionType)type
                                  remark:(NSString *)remark
                                  result:(void(^)(BOOL success, BOOL result, NSString *message))resultBlock;

- (void)quoteTheOrderWithChecklistID:(NSString *)checklistID
                         acceptSplit:(BOOL)acceptSplit
                               price:(NSString *)price
                               count:(NSString *)cout
                          expiryDate:(NSString *)expiryDate
                              result:(void(^)(BOOL success, BOOL result, NSString *message))resultBlock;

- (void)requestHotelBillListWithPage:(NSUInteger)page
                              result:(void(^)(BOOL success, NSArray *listArray, NSUInteger currentPage, NSUInteger totalPage))resultBlock;

- (void)requestHotelBillDetailWithGroupID:(NSString *)groupID
                                  groupNO:(NSString *)groupNO
                              checklistID:(NSString *)checklistID
                                companyID:(NSString *)companyID
                                     date:(NSString *)date
                                   result:(void(^)(BOOL success, WLHotelBillDetailInfo *detailInfo))resultBlock;
@end
