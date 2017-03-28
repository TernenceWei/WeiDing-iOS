//
//  WL_TradeRecord_Model.h
//  WeiLvDJS
//
//  Created by jyc on 16/9/18.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"

@interface WL_TradeRecord_Model : WL_BaseModel

@property(nonatomic,copy)NSString *amount;

@property(nonatomic,copy)NSString *create_date;

@property(nonatomic,copy)NSString *finance_log_id;

@property(nonatomic,copy)NSString *finance_status;

@property(nonatomic,copy)NSString *finance_type;

@property(nonatomic,copy)NSString *is_income;

@property(nonatomic,copy)NSString *leave_amount_new;

@property(nonatomic,copy)NSString *remark;

@property(nonatomic,copy)NSString *user_id;

@end

