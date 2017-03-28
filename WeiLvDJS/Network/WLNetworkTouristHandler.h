//
//  WLNetworkTouristHandler.h
//  WeiLvDJS
//
//  Created by ternence on 16/9/30.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLNetworkUrlHeader.h"
#import "WLTouristGroupHeader.h"
#import "WLTouristGuideInfo.h"
#import "WLGroupDetailInfo.h"
#import "WLGuideListInfo.h"
#import "WLVisitorDetailInfo.h"
#import "WLVisitorListInfo.h"
#import "WLBillDetailInfo.h"
#import "WLIncomeStatisInfo.h"
#import "WLMyIncomeListInfo.h"
#import "WLChargeUpObject.h"
#import "WLChargeUpSummaryInfo.h"
#import "WLCurrentGroupInfo.h"
#import "WLMyScheduleInfo.h"

@interface WLNetworkTouristHandler : NSObject
+ (instancetype)sharedInstance;

//导游认证
- (void)requestTouristGuideAuthenticationStatusWithResult:(void(^)(BOOL success, TouristGuideOauthStatus status, long long count, NSString *message))resultBlock;

- (void)requestTouristGuidePersonalInfoWithResult:(void (^)(BOOL success, WLTouristGuideInfo *info))resultBlock;

- (void)submmitTouristGuidePersonalInfoWithInfo:(WLTouristGuideInfo *)info
                                     needAudits:(BOOL)needAudits
                                         result:(void (^)(BOOL success, BOOL result))resultBlock;

- (void)deleteTouristGuideImageWithInfo:(WLTouristGuideInfo *)info
                                         result:(void (^)(BOOL success, BOOL result))resultBlock;

- (void)deleteTouristGuidePriceListWithInfo:(WLTouristGuideInfo *)info
                                 result:(void (^)(BOOL success, BOOL result))resultBlock;

//接单/
- (void)requestOrderListOrGroupListWithType:(GroupOrderType)type
                                   miniType:(NSUInteger)miniType
                                       page:(NSUInteger)page
                                     result:(void(^)(BOOL success, NSArray *listArray))resultBlock;

- (void)acceptOrDenyTheOrderWithOrderID:(NSString *)orderID
                                 accept:(BOOL)accept
                             denyReason:(NSString *)reason
                                 result:(void(^)(BOOL success, BOOL result))resultBlock;

- (void)clearOutOfDateOrderListWithResult:(void (^)(BOOL success, BOOL result))resultBlock;

- (void)requestGroupInfoWithGroupNO:(NSString *)groupNO
                             result:(void (^)(BOOL success, WLGroupDetailInfo *info))resultBlock;

- (void)requestLineInfoWithGroupID:(NSString *)groupID
                             result:(void (^)(BOOL success, NSArray *lineArray))resultBlock;


- (void)requestTouristGuideListWithGroupID:(NSString *)groupID
                            result:(void (^)(BOOL success, NSArray *guideList))resultBlock;


- (void)requestVisitorListWithGroupNO:(NSString *)groupNO
                               result:(void (^)(BOOL success, NSArray *visitorList))resultBlock;

- (void)requestVisitorDetailInfoWithVisitorID:(NSString *)visitorID
                               result:(void (^)(BOOL success, WLVisitorDetailInfo *visitorInfo))resultBlock;

- (void)requestBillDetailInfoWithGroupID:(NSString *)groupID
                                  userID:(NSString *)guideUserID
                                       result:(void (^)(BOOL success, WLBillDetailInfo *billInfo))resultBlock;

- (void)submmitBillDetailWithGroupID:(NSString *)groupID
                              result:(void (^)(BOOL success, BOOL result, NSString *message))resultBlock;

- (void)refundWithGroupID:(NSString *)groupID
                   amount:(NSString *)amount
                   result:(void (^)(BOOL success, BOOL result, NSString *message))resultBlock;

- (void)requestMyScheduleWithSelectDate:(NSString *)date
                                allDate:(BOOL)isAllDate
                                groupID:(NSString *)groupID
                                 result:(void (^)(BOOL success, WLMyScheduleInfo *scheduleInfo))resultBlock;

- (void)setMyScheduleWithSelectDate:(NSString *)date
                    receiveVisitors:(BOOL)receiveVisitors
                             remark:(NSString *)remark
                                  result:(void (^)(BOOL success, BOOL result))resultBlock;

- (void)modifyGroupStatusWithChecklistID:(NSString *)checklistID
                                  status:(ModifyGroupStatus)status
                                  result:(void (^)(BOOL success, BOOL result, NSString *message))resultBlock;

//我的收入
- (void)requestMyIncomeListWithSelectMonth:(NSString *)month
                                isFinished:(BOOL)isFinished
                                   result:(void (^)(BOOL success, WLMyIncomeListInfo *info))resultBlock;

- (void)requestMyIncomeStatisticsWithResult:(void (^)(BOOL success, WLIncomeStatisInfo *info))resultBlock;


- (void)chargeUpWithType:(TouristItemType)type
                  object:(WLChargeUpObject *)object
                  result:(void (^)(BOOL success, BOOL result))resultBlock;

- (void)deleteChargeupImageWithFileID:(NSString *)fileID
                               result:(void (^)(BOOL success, BOOL result, NSString *message))resultBlock;

- (void)deleteChargeupSchedulelistWithType:(TouristItemType)type
                               checklistID:(NSString *)checklistID
                                    result:(void (^)(BOOL success, BOOL result, NSString *message))resultBlock;


- (void)requestChargeUpInfoWithType:(TouristItemType)type
                         resourceID:(NSString *)resourceID
                            groupID:(NSString *)groupID
                               date:(NSString *)date
                             result:(void (^)(BOOL, id responseObject))resultBlock;

- (void)requestCurrentGroupItemDetailWithType:(TouristItemType)type
                                   resourceID:(NSString *)resourceID
                                      groupID:(NSString *)groupID
                                         date:(NSString *)date
                                       result:(void (^)(BOOL success, id responseObject))resultBlock;


- (void)requestCurrentGroupSummaryDetailWithGroupID:(NSString *)groupID
                                             result:(void (^)(BOOL success, WLChargeUpSummaryInfo *summaryInfo))resultBlock;

- (void)requestCurrentGroupDetailWithGroupID:(NSString *)groupID
                                        date:(NSString *)date
                                      result:(void (^)(BOOL success, WLCurrentGroupInfo *groupInfo))resultBlock;

- (void)requestNowOnGroupIDWithResult:(void (^)(BOOL success, NSString *groupID))resultBlock;






@end
