//
//  WLNetworkManager.h
//  WeiLvDJS
//
//  Created by ternence on 16/9/29.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLTouristGroupHeader.h"
#import "WLTouristGuideInfo.h"
#import "WLGroupDetailInfo.h"
#import "WLVisitorDetailInfo.h"
#import "WLBillDetailInfo.h"
#import "WLIncomeStatisInfo.h"
#import "WLMyIncomeListInfo.h"
#import "WLChargeUpObject.h"
#import "WLChargeUpSummaryInfo.h"
#import "WLCurrentGroupInfo.h"
#import "WLMyScheduleInfo.h"
#import "WLHotelBillDetailInfo.h"

#import "WLNetworkLoginHandler.h"
#import "WLNetworkDriverHandler.h"

#import "WLNetworkTool.h"
@interface WLNetworkManager : NSObject
+ (instancetype)sharedInstance;

#pragma mark 导游
#pragma mark 导游认证
/**
 获取导游认证的状态

 @param resultBlock 认证状态，接单数量
 */
+ (void)requestTouristGuideAuthenticationStatusWithResult:(void(^)(BOOL success, TouristGuideOauthStatus status, long long count, NSString *message))resultBlock;

/**
 获取导游个人信息

 @param resultBlock WLTouristGuideInfo对象
 */
+ (void)requestTouristGuidePersonalInfoWithResult:(void (^)(BOOL success, WLTouristGuideInfo *info))resultBlock;


/**
 新建或编辑导游信息

 @param info        导游信息通过WLTouristGuideInfo携带
 @param needAudits  需要重新提交审核的该项为yes，否则为no
 @param resultBlock 操作是否成功
 */
+ (void)submmitTouristGuidePersonalInfoWithInfo:(WLTouristGuideInfo *)info
                                     needAudits:(BOOL)needAudits
                                         result:(void (^)(BOOL success, BOOL result))resultBlock;

/**
 删除上传的图片信息

 @param info        通过WLTouristGuideInfo的delFileID传递要删除的图片信息
 @param resultBlock 操作是否成功
 */
+ (void)deleteTouristGuideImageWithInfo:(WLTouristGuideInfo *)info
                                 result:(void (^)(BOOL success, BOOL result))resultBlock;

/**
 删除上传的报价信息

 @param info        通过WLTouristGuideInfo的delPriceID传递要删除的报价信息
 @param resultBlock 操作是否成功
 */
+ (void)deleteTouristGuidePriceListWithInfo:(WLTouristGuideInfo *)info
                                     result:(void (^)(BOOL success, BOOL result))resultBlock;




#pragma mark 接单
/**
 获取订单列表和出团列表

 @param type        订单还是出团
 @param miniType    接单（待接单，已接单，已失效） 出团（未出团，未报账，未结账，0为所有出团）
 @param page        页数
 @param resultBlock WLOrderListInfo数组
 */
+ (void)requestOrderListOrGroupListWithType:(GroupOrderType)type
                                   miniType:(NSUInteger)miniType
                                       page:(NSUInteger)page
                                     result:(void(^)(BOOL success, NSArray *listArray/*WLOrderListInfo*/))resultBlock;


/**
 接单或拒单

 @param orderID     订单ID
 @param accept      接单/拒单
 @param reason      拒单原因
 @param resultBlock 操作是否成功
 */
+ (void)acceptOrDenyTheOrderWithOrderID:(NSString *)orderID
                                 accept:(BOOL)accept
                             denyReason:(NSString *)reason
                                 result:(void(^)(BOOL success, BOOL result))resultBlock;
/**
 清空已失效订单

 @param resultBlock 操作是否成功
 */
+ (void)clearOutOfDateOrderListWithResult:(void (^)(BOOL success, BOOL result))resultBlock;

/**
 获取团详情

 @param groupNO     groupNumber
 @param resultBlock WLGroupDetailInfo对象
 */
+ (void)requestGroupInfoWithGroupNO:(NSString *)groupNO
                             result:(void (^)(BOOL success, WLGroupDetailInfo *info))resultBlock;

/**
 获取线路详情

 @param groupID     groupID
 @param resultBlock 操作是否成功
 */
+ (void)requestLineInfoWithGroupID:(NSString *)groupID
                            result:(void (^)(BOOL success, NSArray *lineArray))resultBlock;



#pragma mark 出团

/**
 判断当前是否在出团

 @param resultBlock 在出团返回groupID
 */
+ (void)requestNowOnGroupIDWithResult:(void (^)(BOOL success, NSString *groupID))resultBlock;


/**
 获取导游列表

 @param groupID     groupID
 @param resultBlock WLGuideListInfo数组
 */
+ (void)requestTouristGuideListWithGroupID:(NSString *)groupID
                                    result:(void (^)(BOOL success, NSArray *guideList))resultBlock;

/**
 获取游客列表

 @param groupNO     groupNumber
 @param resultBlock WLVisitorListInfo数组
 */
+ (void)requestVisitorListWithGroupNO:(NSString *)groupNO
                               result:(void (^)(BOOL success, NSArray *visitorList))resultBlock;


/**
 获取游客详细信息

 @param visitorID   visitorID
 @param resultBlock WLVisitorDetailInfo对象
 */
+ (void)requestVisitorDetailInfoWithVisitorID:(NSString *)visitorID
                                       result:(void (^)(BOOL success, WLVisitorDetailInfo *visitorInfo))resultBlock;

#pragma mark 当前出团
/**
 获取当前出团的行程及各人员联系方式

 @param groupID     groupID
 @param resultBlock WLChargeUpSummaryInfo
 */
+ (void)requestCurrentGroupSummaryDetailWithGroupID:(NSString *)groupID
                                             result:(void (^)(BOOL success, WLChargeUpSummaryInfo *summaryInfo))resultBlock;


/**
 获取当前出团的酒店，用车信息等

 @param groupID     groupID
 @param date        date
 @param resultBlock WLCurrentGroupInfo
 */
+ (void)requestCurrentGroupDetailWithGroupID:(NSString *)groupID
                                        date:(NSString *)date
                                      result:(void (^)(BOOL success, WLCurrentGroupInfo *groupInfo))resultBlock;

/**
 获取用车，酒店等的详细信息
 
 @param type        类型，用车还是酒店
 @param resourceID  resourceID
 @param groupID     groupID
 @param date        时间
 @param resultBlock 返回不同类型的数据
 */
+ (void)requestCurrentGroupItemDetailWithType:(TouristItemType)type
                                   resourceID:(NSString *)resourceID
                                      groupID:(NSString *)groupID
                                         date:(NSString *)date
                                       result:(void (^)(BOOL success, id responseObject))resultBlock;
#pragma mark 记账

/**
 记账

 @param type        类型，用车还是酒店
 @param object      携带数据
 @param resultBlock 操作是否成功
 */
+ (void)chargeUpWithType:(TouristItemType)type
                  object:(WLChargeUpObject *)object
                  result:(void (^)(BOOL success, BOOL result))resultBlock;




/**
 记账时获取预置的或是之前记录的信息

 @param type        类型，用车还是酒店
 @param resourceID  resourceID
 @param groupID     groupID
 @param date        时间
 @param resultBlock 返回不同类型的数据
 */
+ (void)requestChargeUpInfoWithType:(TouristItemType)type
                         resourceID:(NSString *)resourceID
                            groupID:(NSString *)groupID
                               date:(NSString *)date
                             result:(void (^)(BOOL success, id responseObject))resultBlock;


/**
 删除记账图片

 @param fileID fileID
 @param resultBlock 
 */
+ (void)deleteChargeupImageWithFileID:(NSString *)fileID
                               result:(void (^)(BOOL success, BOOL result, NSString *message))resultBlock;


/**
 删除记账添加的价目列表

 @param type type 类型
 @param checklistID checklistID
 @param resultBlock 
 */
+ (void)deleteChargeupSchedulelistWithType:(TouristItemType)type
                               checklistID:(NSString *)checklistID
                                    result:(void (^)(BOOL success, BOOL result, NSString *message))resultBlock;


#pragma mark 账单
/**
 获取账单详情

 @param groupID     成团单号
 @param guideUserID 相应导游的userID
 @param resultBlock 
 */
+ (void)requestBillDetailInfoWithGroupID:(NSString *)groupID
                                  userID:(NSString *)guideUserID
                                  result:(void (^)(BOOL success, WLBillDetailInfo *billInfo))resultBlock;

/**
 主导游提交账单
 
 @param groupID     groupID
 @param resultBlock 是否提交成功
 */

+ (void)submmitBillDetailWithGroupID:(NSString *)groupID
                              result:(void (^)(BOOL success, BOOL result, NSString *message))resultBlock;


/**
 主导游退款
 
 @param groupID     groupID
 @param amount      退款金额
 @param resultBlock 退款是否成功
 */
+ (void)refundWithGroupID:(NSString *)groupID
                   amount:(NSString *)amount
                   result:(void (^)(BOOL success, BOOL result, NSString *message))resultBlock;

#pragma mark 日程
/**
 获取导游日程安排

 @param date        选择的日期 格式 "2016-10-01"
 @param isAllDate   是否获取整月的日程安排
 @param groupID     checklist_id
 @param resultBlock
 */
+ (void)requestMyScheduleWithSelectDate:(NSString *)date
                                allDate:(BOOL)isAllDate
                                groupID:(NSString *)groupID
                                 result:(void (^)(BOOL success, WLMyScheduleInfo *scheduleInfo))resultBlock;

/**
 设置行程

 @param date            选择的日期
 @param receiveVisitors 是否接单
 @param remark          备注
 @param resultBlock     操作是否成功
 */
+ (void)setMyScheduleWithSelectDate:(NSString *)date
                    receiveVisitors:(BOOL)receiveVisitors
                             remark:(NSString *)remark
                             result:(void (^)(BOOL success, BOOL result))resultBlock;


/**
 修改团状态

 @param groupID     groupID
 @param status      出团/下团
 @param resultBlock 操作是否成功
 */
+ (void)modifyGroupStatusWithChecklistID:(NSString *)checklistID
                                  status:(ModifyGroupStatus)status
                                  result:(void (^)(BOOL success, BOOL result, NSString *message))resultBlock;


#pragma mark 收入统计

/**
 我的收入列表

 @param month       月份（不传月份则返回本月数据及各月收入，传月份则返回该月数据）
 @param isFinished  已结账，待结账
 @param resultBlock WLMyIncomeListInfo
 */
+ (void)requestMyIncomeListWithSelectMonth:(NSString *)month
                                  isFinished:(BOOL)isFinished
                                      result:(void (^)(BOOL success, WLMyIncomeListInfo *info))resultBlock;


/**
 收入统计

 @param resultBlock WLIncomeStatisInfo
 */
+ (void)requestMyIncomeStatisticsWithResult:(void (^)(BOOL success, WLIncomeStatisInfo *info))resultBlock;











#pragma mark 酒店

/**
 获取接单列表

 @param status 订单状态
 @param page 页数
 @param resultBlock 返回订单数组及当前页数和总页数
 */
+ (void)requestHotelListWithStatus:(HotelListStatus)status
                              page:(NSUInteger)page
                            result:(void(^)(BOOL success, NSArray *listArray, NSUInteger currentPage, NSUInteger totalPage))resultBlock;


/**
 搜索订单

 @param ID 团号或订单号
 @param resultBlock 返回订单数组
 */
+ (void)searchHotelListWithID:(NSString *)ID
                       result:(void(^)(BOOL success, NSArray *listArray))resultBlock;


/**
 删除订单

 @param checklistID checklistID
 @param resultBlock 操作是否成功
 */
+ (void)deleteAOrderWithChecklistID:(NSString *)checklistID
                             result:(void(^)(BOOL success, BOOL result))resultBlock;



/**
 操作订单

 @param checklistID checklistID
 @param type 操作类型
 @param remark 备注
 @param resultBlock 操作是否成功
 */
+ (void)modifyOrderStatusWithChecklistID:(NSString *)checklistID
                              actionType:(HotelActionType)type
                                  remark:(NSString *)remark
                                  result:(void(^)(BOOL success, BOOL result, NSString *message))resultBlock;


/**
 报价

 @param checklistID checklistID
 @param acceptSplit 是否接受拆单
 @param price 报价(必填)
 @param cout 报价数量（接受拆单，cout必填）
 @param expiryDate 失效日期(时间戳)
 @param resultBlock 操作是否成功，失败原因
 */
+ (void)quoteTheOrderWithChecklistID:(NSString *)checklistID
                         acceptSplit:(BOOL)acceptSplit
                               price:(NSString *)price
                               count:(NSString *)cout
                          expiryDate:(NSString *)expiryDate
                              result:(void(^)(BOOL success, BOOL result, NSString *message))resultBlock;


/**
 获取账单列表

 @param page 页数
 @param resultBlock 返回账单数组及当前页数和总页数
 */
+ (void)requestHotelBillListWithPage:(NSUInteger)page
                              result:(void(^)(BOOL success, NSArray *listArray, NSUInteger currentPage, NSUInteger totalPage))resultBlock;


/**
 获取账单详情

 @param groupID groupID
 @param groupNO groupNO
 @param checklistID checklistID
 @param companyID companyID
 @param date 日期 (时间戳)
 @param resultBlock 返回账单详细信息
 */
+ (void)requestHotelBillDetailWithGroupID:(NSString *)groupID
                                  groupNO:(NSString *)groupNO
                              checklistID:(NSString *)checklistID
                                companyID:(NSString *)companyID
                                     date:(NSString *)date
                                   result:(void(^)(BOOL success, WLHotelBillDetailInfo *detailInfo))resultBlock;



#pragma mark - 消息

/**
 获取消息首页轮播图的数据及提醒的数据

 @param type 用户类型
 @param dataBlock 返回的数据
 */
+ (void)requestMessageBannerListWithType:(NSString *)type dataBlock:(CompletionDataBlock)dataBlock;

/**
 获取消息列表

 @param type 用户类型
 @param dataBlock 返回的数据
 */
+ (void)requestMessageListWithRoleType:(NSString *)type dataBlock:(CompletionDataBlock)dataBlock;

/**
 消息搜索

 @param text 要搜索的内容
 @param dataBlock 返回的数据
 */
//+ (void)searchMessageWithText:(NSString *)text dataBlock:(CompletionDataBlock)dataBlock;

#pragma mark 登录

/**
 登录返回数据
 
 @param phoneNOStr 登录手机号
 @param psStr 密码
 @param resultBlock 返回登录结果和用户信息
 */
+ (void)requestLoginWithPhoneNO:(NSString *)phoneNOStr
                       password:(NSString *)psStr
                         result:(void(^)(BOOL success,BOOL result,NSString * message,WL_UserInfo_Model * datamodel))resultBlock;

+ (void)sendRequestToCaptchaWithPhoneNO:(NSString *)phoneNOStr codeType:(NSString *)type result:(void(^)(BOOL success,BOOL result,NSString * message,NSInteger minTimespan))resultBlock;

#pragma mark 司机-获取车辆信息
/***获取车辆信息***/
//+ (void)requestCarInfoWithResultBlock:(void(^)(BOOL success,NSString * message,NSDictionary *dataDic))resultBlock;


#pragma mark 司机-获取司机信息
/***
 获取司机信息
 **/
+ (void)requestDriverInfoWithResultBlock:(void(^)(BOOL success,NSString * message,NSDictionary * dataDic))resultBlock;



@end
