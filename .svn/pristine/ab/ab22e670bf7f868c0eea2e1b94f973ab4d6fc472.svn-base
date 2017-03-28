//
//  WL_Application_OrderDetail_Model.h
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/20.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  应用->司机->接单->订单详情Model

#import "WL_BaseModel.h"
@class WL_Application_Driver_OrderDetail_Guide_Model;
@class WL_Application_Driver_OrderDetail_Dispatcher_Model;
@class WL_Application_Driver_OrderDetail_PayRecord_Model;

@interface WL_Application_Driver_OrderDetail_Model : WL_BaseModel

/** 订单id */
@property(nonatomic, copy)NSString *sj_order_id;
/** 公司id */
@property(nonatomic, copy)NSString *company_id;
/** 订单编号 */
@property(nonatomic, copy)NSString *order_number;
/** 调度员id */
@property(nonatomic, copy)NSString *dispatcher_id;
/** 导游报账的实际金额 */
@property(nonatomic, copy)NSString *actual_amount;
/** 金额 */
@property(nonatomic, copy)NSString *amount;
/** 已收款 */
@property(nonatomic, copy)NSString *receipted_amount;
/** 订单状态 */
@property(nonatomic, copy)NSString *order_status;
/** 行程状态 */
@property(nonatomic, copy)NSString *trip_status;
/** 支付状态 */
@property(nonatomic, copy)NSString *pay_status;
/** 订单备注 */
@property(nonatomic, copy)NSString *remark;
/** 取消订单备注 */
@property(nonatomic, strong)NSArray *cancel_remark;
/** 取消订单备注 */
@property(nonatomic, copy)NSString *revoke_reason;
/** 出行人数 */
@property(nonatomic, copy)NSString *persons_count;
/** 来源旅行社id */
@property(nonatomic, copy)NSString *from_agency_id;
/** 可取消订单的截止日期 */
@property(nonatomic, copy)NSString *cancel_expires;
/** 订单失效日期 */
@property(nonatomic, copy)NSString *failure_expires;
/** 行程里程 */
@property(nonatomic, copy)NSString *mileage;
/** 出发时间 */
@property(nonatomic, copy)NSString *start_time;
/** 出发城市 */
@property(nonatomic, copy)NSString *start_city;
/** 出发详细地址 */
@property(nonatomic, copy)NSString *start_address;
/** 结束时间 */
@property(nonatomic, copy)NSString *end_time;
/** 结束城市 */
@property(nonatomic, copy)NSString *end_city;
/** 结束详细地址 */
@property(nonatomic, copy)NSString *end_address;
/** 接单日期 */
@property(nonatomic, copy)NSString *accept_date;
/** 结算日期 */
@property(nonatomic, copy)NSString *settlement_date;
/** 创建日期 */
@property(nonatomic, copy)NSString *create_date;
/** 车队公司名称 */
@property(nonatomic, copy)NSString *order_source_Fleet;
/** 旅行社公司名称 */
@property(nonatomic, copy)NSString *order_source_travel;

@property(nonatomic,copy) NSString *beg_buttom;

@property(nonatomic,copy) NSString *end_buttom;
/** 计调模型 */
@property(nonatomic, strong)WL_Application_Driver_OrderDetail_Dispatcher_Model *dispatcher;
/** 导游模型 */
@property(nonatomic, strong) WL_Application_Driver_OrderDetail_Guide_Model *guide;
/** 付款记录 */
@property(nonatomic, copy)NSArray<WL_Application_Driver_OrderDetail_PayRecord_Model *> *pay_record;


/** cell的高度 */
@property (assign, nonatomic) CGFloat cellHeight;

@end
