//
//  WL_Application_Driver_Bill_Model.h
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"

@interface WL_Application_Driver_Bill_Model : WL_BaseModel
/** 账单年月 */
@property(nonatomic, copy) NSString *dd;
/** 订单号 */
@property(nonatomic, copy) NSString *order_number;
/** 订单id */
@property(nonatomic, copy) NSString *sj_order_id;
/** 企业id */
@property(nonatomic, copy) NSString *company_id;
/** 计调表id */
@property(nonatomic, copy) NSString *checklist_id;
/** 成团单id */
@property(nonatomic, copy) NSString *grouplist_id;
/** 实际金额 */
@property(nonatomic, copy) NSString *actual_amount;
/** 派单金额 */
@property(nonatomic, copy) NSString *amount;
/** 已收款 */
@property(nonatomic, copy) NSString *receipted_amount;
/** 1 待接单，2已拒绝，3 已超时，4 已被抢，5 已接单，6已撤消 */
@property(nonatomic, copy) NSString *order_status;
/** 1 结算中，2已结清 */
@property(nonatomic, copy) NSString *pay_status;
/** 出行人数 */
@property(nonatomic, copy) NSString *persons_count;
/** 行程出发时间 */
@property(nonatomic, copy) NSString *start_time;
/** 行程结束时间 */
@property(nonatomic, copy) NSString *end_time;
/** 出发城市 */
@property(nonatomic, copy) NSString *start_name;
/** 结束城市 */
@property(nonatomic, copy) NSString *end_name;
/** 结算日期 */
@property(nonatomic, copy) NSString *settlement_date;
/** 企业名称 */
@property(nonatomic, copy) NSString *company_name;
/** 企业电话 */
@property(nonatomic, copy) NSString *admin_mobile;


@end
