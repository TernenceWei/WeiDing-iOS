//
//  WLGroupDetailInfo1.h
//  WeiLvDJS
//
//  Created by ternence on 16/11/23.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WLGroupDetailInfo1 : NSObject
@property (nonatomic, copy)   NSString *accept_time;//线路名称
@property (nonatomic, copy)   NSString *checklist_id;//总人数
@property (nonatomic, copy)   NSString *company_name;//导服费用
@property (nonatomic, copy)   NSString *expiry_date;//备用金
@property (nonatomic, copy)   NSString *groupListName;//旅行社
@property (nonatomic, copy)   NSString *guide_money;//购物返利
@property (nonatomic, copy)   NSString *people_num;//备注
@property (nonatomic, copy)   NSString *remark;//派单时间
@property (nonatomic, copy)   NSString *return_rate;//订单状态-
@property (nonatomic, copy)   NSString *revoke_reason;//状态描述
@property (nonatomic, copy)   NSString *send_time;//出团状态
@property (nonatomic, copy)   NSString *spare_money;//失效时间
@property (nonatomic, copy)   NSString *start_sign;//状态描述
@property (nonatomic, copy)   NSString *status;//出团状态
@property (nonatomic, copy)   NSString *trip_sign;//失效时间

@property (nonatomic, strong) NSArray *group_list;/*WLSubLineInfo*/

@end
