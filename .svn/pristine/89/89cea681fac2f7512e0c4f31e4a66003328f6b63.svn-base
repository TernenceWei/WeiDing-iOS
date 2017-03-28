//
//  WLGroupDetailInfo.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/12.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLSubLineInfo : NSObject
@property (nonatomic, copy)   NSString *lineName;//线路名称
@property (nonatomic, copy)   NSString *peopleCount;//出行人数
@property (nonatomic, copy)   NSString *comeDate;//接站时间
@property (nonatomic, copy)   NSString *comeAddress;//接站地点
@property (nonatomic, copy)   NSString *backDate;//送站时间
@property (nonatomic, copy)   NSString *backAddress;//送站地点

- (instancetype)initWithDict:(NSDictionary*)dict;
@end

@interface WLGroupDetailInfo : NSObject
@property (nonatomic, copy)   NSString *groupListName;//线路名称
@property (nonatomic, copy)   NSString *peopleNums;//总人数
@property (nonatomic, copy)   NSString *guideMoney;//导服费用
@property (nonatomic, copy)   NSString *spareMoney;//备用金
@property (nonatomic, copy)   NSString *companyName;//旅行社
@property (nonatomic, copy)   NSString *returnRate;//购物返利
@property (nonatomic, copy)   NSString *remark;//备注
@property (nonatomic, copy)   NSString *sendTime;//派单时间
@property (nonatomic, copy)   NSString *orderStatus;//订单状态-
@property (nonatomic, copy)   NSString *statusInfo;//状态描述
@property (nonatomic, copy)   NSString *groupStatus;//出团状态
@property (nonatomic, copy)   NSString *expiryDate;//倒计时
@property (nonatomic, strong) NSArray *lineArray;/*WLSubLineInfo*/


@property (nonatomic, copy)   NSString *acceptTime;//接单时间
@property (nonatomic, copy)   NSString *checklistID;
@property (nonatomic, copy)   NSString *grouplistID;
@property (nonatomic, copy)   NSString *expiryTime;//失效时间
@property (nonatomic, copy)   NSString *isActivated;//备用金状态(0 待确认,1 冻结，2 已激活)
@property (nonatomic, copy)   NSString *refuseReason;//拒绝原因
- (instancetype)initWithDict:(NSDictionary*)dict;
@end
