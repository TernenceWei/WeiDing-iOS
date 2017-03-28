//
//  WLCarFrozenListObject.h
//  WeiLvDJS
//
//  Created by ternence on 2017/2/28.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLCarFrozenListObject : NSObject
@property(nonatomic,copy)NSString *frozenID;//流水id,主键

@property(nonatomic,copy)NSString *order_no;//订单号

@property(nonatomic,copy)NSString *account_id;//帐户id

@property(nonatomic,copy)NSString *other_account_id;//对方的帐户id

@property(nonatomic,copy)NSString *amount;//金额

@property(nonatomic,copy)NSString *trade_balance;//交易后帐户的余额

@property(nonatomic,copy)NSString *is_income;///1 收入，0 支出

@property(nonatomic,copy)NSString *trade_type;//交易类型//读lookup 1 充值，2 提现,5 转账备用金，6 团费结算,7订单支付,8 店铺订单支付,9店铺订单退款 , 10 员工提成(C端下单后，员工提成),11司机订单支付(sj_order),12 抢单到账金额（司机拿到的，sj_order），13 抢单抽成（调度中心拿到的 sj_order）,14 叫车单支付（叫车人支付，sj_order）

@property(nonatomic,copy)NSString *trade_status;//资金状态//0 审核中，1 成功，2 撤销，3拒绝,4退回提现

@property(nonatomic,copy)NSString *relation_id;//关联id//交易类型对应的关联id

@property(nonatomic,copy)NSString *memo;//备注

@property(nonatomic,copy)NSString *created_at;//到账时间
@property(nonatomic,copy)NSString *updated_at;//冻结时间
@property(nonatomic,copy)NSString *company_name;//公司名称
@property(nonatomic,copy)NSString *company_logo;//公司logo
@property(nonatomic,copy)NSString *callcar_user;//叫车方名字

@end
