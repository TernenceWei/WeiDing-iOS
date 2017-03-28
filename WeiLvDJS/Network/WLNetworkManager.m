//
//  WLNetworkManager.m
//  WeiLvDJS
//
//  Created by ternence on 16/9/29.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLNetworkManager.h"
#import "AFNetworking.h"
#import "WLNetworkTouristHandler.h"
#import "WLNetworkHotelHandler.h"
#import "WLNetworkTool.h"
#import "WLNetworkMessageHandler.h"

#define DemoServer @"http://api.sealtalk.im/" //线上正式环境
#define ContentType @"application/json"

static WLNetworkManager* sharedInstance;
@implementation WLNetworkManager
+ (instancetype)sharedInstance{
    if (sharedInstance == nil) {
        sharedInstance = [[WLNetworkManager alloc] init];
    }
    return sharedInstance;
}

+ (void)requestTouristGuideAuthenticationStatusWithResult:(void (^)(BOOL, TouristGuideOauthStatus, long long, NSString *))resultBlock
{
    [[WLNetworkTouristHandler sharedInstance] requestTouristGuideAuthenticationStatusWithResult:resultBlock];
}

+ (void)requestTouristGuidePersonalInfoWithResult:(void (^)(BOOL, WLTouristGuideInfo *))resultBlock
{
    [[WLNetworkTouristHandler sharedInstance] requestTouristGuidePersonalInfoWithResult:resultBlock];
}

+ (void)submmitTouristGuidePersonalInfoWithInfo:(WLTouristGuideInfo *)info needAudits:(BOOL)needAudits result:(void (^)(BOOL, BOOL))resultBlock
{
    [[WLNetworkTouristHandler sharedInstance] submmitTouristGuidePersonalInfoWithInfo:info needAudits:needAudits result:resultBlock];
}

+ (void)deleteTouristGuideImageWithInfo:(WLTouristGuideInfo *)info result:(void (^)(BOOL, BOOL))resultBlock
{
    [[WLNetworkTouristHandler sharedInstance] deleteTouristGuideImageWithInfo:info result:resultBlock];
}

+ (void)deleteTouristGuidePriceListWithInfo:(WLTouristGuideInfo *)info result:(void (^)(BOOL, BOOL))resultBlock
{
    [[WLNetworkTouristHandler sharedInstance] deleteTouristGuidePriceListWithInfo:info result:resultBlock];
}

+ (void)requestOrderListOrGroupListWithType:(GroupOrderType)type miniType:(NSUInteger)miniType page:(NSUInteger)page result:(void (^)(BOOL, NSArray *))resultBlock
{
    [[WLNetworkTouristHandler sharedInstance] requestOrderListOrGroupListWithType:type miniType:miniType page:page result:resultBlock];
}

+ (void)acceptOrDenyTheOrderWithOrderID:(NSString *)orderID accept:(BOOL)accept denyReason:(NSString *)reason result:(void (^)(BOOL, BOOL))resultBlock
{
    [[WLNetworkTouristHandler sharedInstance] acceptOrDenyTheOrderWithOrderID:orderID accept:accept denyReason:reason result:resultBlock];
}

+ (void)clearOutOfDateOrderListWithResult:(void (^)(BOOL, BOOL))resultBlock
{
    [[WLNetworkTouristHandler sharedInstance] clearOutOfDateOrderListWithResult:resultBlock];
}

+ (void)requestGroupInfoWithGroupNO:(NSString *)groupNO result:(void (^)(BOOL, WLGroupDetailInfo *))resultBlock
{
    [[WLNetworkTouristHandler sharedInstance] requestGroupInfoWithGroupNO:groupNO result:resultBlock];
}

+ (void)requestLineInfoWithGroupID:(NSString *)groupID result:(void (^)(BOOL, NSArray *))resultBlock
{
    [[WLNetworkTouristHandler sharedInstance] requestLineInfoWithGroupID:groupID result:resultBlock];
}

+ (void)requestTouristGuideListWithGroupID:(NSString *)groupID result:(void (^)(BOOL, NSArray *))resultBlock
{
    [[WLNetworkTouristHandler sharedInstance] requestTouristGuideListWithGroupID:groupID result:resultBlock];
}

+ (void)requestVisitorListWithGroupNO:(NSString *)groupNO result:(void (^)(BOOL, NSArray *))resultBlock
{
    [[WLNetworkTouristHandler sharedInstance] requestVisitorListWithGroupNO:groupNO result:resultBlock];
}

+ (void)requestVisitorDetailInfoWithVisitorID:(NSString *)visitorID result:(void (^)(BOOL, WLVisitorDetailInfo *))resultBlock
{
    [[WLNetworkTouristHandler sharedInstance] requestVisitorDetailInfoWithVisitorID:visitorID result:resultBlock];
}

+ (void)requestBillDetailInfoWithGroupID:(NSString *)groupID userID:(NSString *)guideUserID result:(void (^)(BOOL, WLBillDetailInfo *))resultBlock
{
    [[WLNetworkTouristHandler sharedInstance] requestBillDetailInfoWithGroupID:groupID userID:guideUserID result:resultBlock];
}

+ (void)requestMyScheduleWithSelectDate:(NSString *)date allDate:(BOOL)isAllDate groupID:(NSString *)groupID result:(void (^)(BOOL, WLMyScheduleInfo *))resultBlock
{
    [[WLNetworkTouristHandler sharedInstance] requestMyScheduleWithSelectDate:date allDate:isAllDate groupID:groupID result:resultBlock];
}

+ (void)setMyScheduleWithSelectDate:(NSString *)date receiveVisitors:(BOOL)receiveVisitors remark:(NSString *)remark result:(void (^)(BOOL, BOOL))resultBlock
{
    [[WLNetworkTouristHandler sharedInstance] setMyScheduleWithSelectDate:date receiveVisitors:receiveVisitors remark:remark result:resultBlock];
}

+ (void)modifyGroupStatusWithChecklistID:(NSString *)checklistID status:(ModifyGroupStatus)status result:(void (^)(BOOL, BOOL, NSString *))resultBlock
{
    [[WLNetworkTouristHandler sharedInstance] modifyGroupStatusWithChecklistID:checklistID status:status result:resultBlock];
}

+ (void)submmitBillDetailWithGroupID:(NSString *)groupID result:(void (^)(BOOL, BOOL, NSString *))resultBlock
{
    [[WLNetworkTouristHandler sharedInstance] submmitBillDetailWithGroupID:groupID result:resultBlock];
}

+ (void)refundWithGroupID:(NSString *)groupID amount:(NSString *)amount result:(void (^)(BOOL, BOOL, NSString *))resultBlock
{
    [[WLNetworkTouristHandler sharedInstance] refundWithGroupID:groupID amount:amount result:resultBlock];
}

+ (void)requestMyIncomeListWithSelectMonth:(NSString *)month isFinished:(BOOL)isFinished result:(void (^)(BOOL, WLMyIncomeListInfo *))resultBlock
{
    [[WLNetworkTouristHandler sharedInstance] requestMyIncomeListWithSelectMonth:month isFinished:isFinished result:resultBlock];
}

+ (void)requestMyIncomeStatisticsWithResult:(void (^)(BOOL, WLIncomeStatisInfo *))resultBlock
{
    [[WLNetworkTouristHandler sharedInstance] requestMyIncomeStatisticsWithResult:resultBlock];
}

+ (void)chargeUpWithType:(TouristItemType)type object:(WLChargeUpObject *)object result:(void (^)(BOOL, BOOL))resultBlock
{
    [[WLNetworkTouristHandler sharedInstance] chargeUpWithType:type object:object result:resultBlock];
}

+ (void)deleteChargeupImageWithFileID:(NSString *)fileID result:(void (^)(BOOL, BOOL, NSString *))resultBlock
{
    [[WLNetworkTouristHandler sharedInstance] deleteChargeupImageWithFileID:fileID result:resultBlock];
}

+ (void)deleteChargeupSchedulelistWithType:(TouristItemType)type checklistID:(NSString *)checklistID result:(void (^)(BOOL, BOOL, NSString *))resultBlock
{
    [[WLNetworkTouristHandler sharedInstance] deleteChargeupSchedulelistWithType:type checklistID:checklistID result:resultBlock];
}

+ (void)requestChargeUpInfoWithType:(TouristItemType)type resourceID:(NSString *)resourceID groupID:(NSString *)groupID date:(NSString *)date result:(void (^)(BOOL, id))resultBlock
{
    [[WLNetworkTouristHandler sharedInstance] requestChargeUpInfoWithType:type resourceID:resourceID groupID:groupID date:date result:resultBlock];
}

+ (void)requestCurrentGroupItemDetailWithType:(TouristItemType)type resourceID:(NSString *)resourceID groupID:(NSString *)groupID date:(NSString *)date result:(void (^)(BOOL, id))resultBlock
{
    [[WLNetworkTouristHandler sharedInstance] requestCurrentGroupItemDetailWithType:type resourceID:resourceID groupID:groupID date:date result:resultBlock];
}

+ (void)requestCurrentGroupSummaryDetailWithGroupID:(NSString *)groupID result:(void (^)(BOOL, WLChargeUpSummaryInfo *))resultBlock
{
    [[WLNetworkTouristHandler sharedInstance] requestCurrentGroupSummaryDetailWithGroupID:groupID result:resultBlock];
}

+ (void)requestCurrentGroupDetailWithGroupID:(NSString *)groupID date:(NSString *)date result:(void (^)(BOOL, WLCurrentGroupInfo *))resultBlock
{
    [[WLNetworkTouristHandler sharedInstance] requestCurrentGroupDetailWithGroupID:groupID date:date result:resultBlock];
}

+ (void)requestNowOnGroupIDWithResult:(void (^)(BOOL, NSString *))resultBlock
{
    [[WLNetworkTouristHandler sharedInstance] requestNowOnGroupIDWithResult:resultBlock];
}



#pragma mark 酒店
+ (void)requestHotelListWithStatus:(HotelListStatus)status page:(NSUInteger)page result:(void (^)(BOOL, NSArray *, NSUInteger, NSUInteger))resultBlock
{
    [[WLNetworkHotelHandler sharedInstance] requestHotelListWithStatus:status page:page result:resultBlock];
}

+ (void)deleteAOrderWithChecklistID:(NSString *)checklistID result:(void (^)(BOOL, BOOL))resultBlock
{

    [[WLNetworkHotelHandler sharedInstance] deleteAOrderWithChecklistID:checklistID result:resultBlock];
}

+ (void)searchHotelListWithID:(NSString *)ID result:(void (^)(BOOL, NSArray *))resultBlock
{
    [[WLNetworkHotelHandler sharedInstance] searchHotelListWithID:ID result:resultBlock];

}

+ (void)modifyOrderStatusWithChecklistID:(NSString *)checklistID actionType:(HotelActionType)type remark:(NSString *)remark result:(void (^)(BOOL, BOOL, NSString *))resultBlock
{
    [[WLNetworkHotelHandler sharedInstance] modifyOrderStatusWithChecklistID:checklistID actionType:type remark:remark result:resultBlock];
}

+ (void)quoteTheOrderWithChecklistID:(NSString *)checklistID acceptSplit:(BOOL)acceptSplit price:(NSString *)price count:(NSString *)cout expiryDate:(NSString *)expiryDate result:(void (^)(BOOL, BOOL, NSString *))resultBlock
{
    [[WLNetworkHotelHandler sharedInstance] quoteTheOrderWithChecklistID:checklistID acceptSplit:acceptSplit price:price count:cout expiryDate:expiryDate result:resultBlock];
}

+ (void)requestHotelBillListWithPage:(NSUInteger)page result:(void (^)(BOOL, NSArray *, NSUInteger, NSUInteger))resultBlock
{
    [[WLNetworkHotelHandler sharedInstance] requestHotelBillListWithPage:page result:resultBlock];
}

+ (void)requestHotelBillDetailWithGroupID:(NSString *)groupID groupNO:(NSString *)groupNO checklistID:(NSString *)checklistID companyID:(NSString *)companyID date:(NSString *)date result:(void (^)(BOOL, WLHotelBillDetailInfo *))resultBlock
{
    [[WLNetworkHotelHandler sharedInstance] requestHotelBillDetailWithGroupID:groupID groupNO:groupNO checklistID:checklistID companyID:companyID date:date result:resultBlock];
}


#pragma mark - 消息
+ (void)requestMessageBannerListWithType:(NSString *)type dataBlock:(CompletionDataBlock)dataBlock
{
    [WLNetworkMessageHandler requestMessageBannerListWithType:type dataBlock:dataBlock];
}
+ (void)requestMessageListWithRoleType:(NSString *)type dataBlock:(CompletionDataBlock)dataBlock
{
    [WLNetworkMessageHandler requestMessageListWithRoleType:type dataBlock:dataBlock];
}
//+ (void)searchMessageWithText:(NSString *)text dataBlock:(CompletionDataBlock)dataBlock
//{
//    [WLNetworkMessageHandler searchMessageWithText:text dataBlock:dataBlock];
//}

#pragma mark - 登录
+ (void)requestLoginWithPhoneNO:(NSString *)phoneNOStr password:(NSString *)psStr result:(void (^)(BOOL, BOOL, NSString *, WL_UserInfo_Model *))resultBlock
{
    [[WLNetworkLoginHandler sharedInstance] requestLoginWithPhoneNO:phoneNOStr password:psStr result:resultBlock];
}

+ (void)sendRequestToCaptchaWithPhoneNO:(NSString *)phoneNOStr codeType:(NSString *)type result:(void(^)(BOOL success,BOOL result,NSString * message,NSInteger minTimespan))resultBlock;
{
    [[WLNetworkLoginHandler sharedInstance] sendRequestToCaptchaWithPhoneNO:phoneNOStr codeType:type result:resultBlock];
}


#pragma mark - 司机-获取车辆信息
//+ (void)requestCarInfoWithResultBlock:(void (^)(BOOL, NSString *, NSDictionary *))resultBlock
//{
//    [[WLNetworkDriverHandler sharedInstance] requestCarInfoWithResultBlock:resultBlock];
//}

#pragma mark - 司机-获取司机信息
+ (void)requestDriverInfoWithResultBlock:(void (^)(BOOL, NSString *, NSDictionary *))resultBlock
{
    [[WLNetworkDriverHandler sharedInstance] requestDriverInfoWithResultBlock:resultBlock];
}


@end
