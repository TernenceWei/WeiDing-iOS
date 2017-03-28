//
//  WLOrderListInfo.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/12.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLTouristGroupHeader.h"

@interface WLOrderListInfo : NSObject
@property (nonatomic, copy)   NSString *checkListID;
@property (nonatomic, copy)   NSString *resourceID;

@property (nonatomic, copy)   NSString *lineName;//线路名称
@property (nonatomic, copy)   NSString *checkPrice;//导服费
@property (nonatomic, copy)   NSString *minRate;//最小返利
@property (nonatomic, copy)   NSString *maxRate;//最大返利
@property (nonatomic, copy)   NSString *groupListID;
@property (nonatomic, copy)   NSString *mainGuide;//是否为主导游
@property (nonatomic, copy)   NSString *type;//团类型（散客，定制团）
@property (nonatomic, copy)   NSString *guideNums;//导游数量
@property (nonatomic, copy)   NSString *receiveDate;//接团日期
@property (nonatomic, copy)   NSString *adults;//成人人数
@property (nonatomic, copy)   NSString *sendDate;//送团日期
@property (nonatomic, copy)   NSString *acceptOrderDate;//接单时间（接单之后就是未出团了）
@property (nonatomic, copy)   NSString *endDate;//下团时间（下团之后就是未报账了）
@property (nonatomic, copy)   NSString *submitDate;//提交时间（提交之后就是审核中了）
@property (nonatomic, copy)   NSString *auditDate;//审核时间（审核之后就是已审核了）
@property (nonatomic, copy)   NSString *settlementDate;//结算时间（结算之后就是已结账了）
@property (nonatomic, copy)   NSString *companyName;//旅行社
@property (nonatomic, copy)   NSString *groupNumber;//订单号码
@property (nonatomic, assign) GroupStatus groupListStatus;//出团状态
@property (nonatomic, assign) OrderStatus checkListStatus;//订单状态
@property (nonatomic, copy)   NSString *expiryDate;//失效时间
@property (nonatomic, copy)   NSString *startCity;//出发城市


@property (nonatomic, copy)   NSString *returnRate;//返利（包括最小和最大返利，给日程使用）
@property (nonatomic, copy)   NSString *orderReturnRate;//返利（包括最小和最大返利，给接单和出团使用）

//我的日程
@property (nonatomic, copy)   NSString *children;//小孩
@property (nonatomic, assign) JourneyStatus journeyStatus;//出团状态
//我的收入
@property (nonatomic, copy)   NSString *income;//收入
@property (nonatomic, copy)   NSString *shoppingRebate;//购物返现
@property (nonatomic, copy)   NSString *additionalRebate;//加点返现
- (instancetype)initWithDict:(NSDictionary*)dict;
@end
