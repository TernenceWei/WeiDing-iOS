//
//  WL_Pay_RecordModel.h
//  WeiLvDJS
//
//  Created by jyc on 16/9/29.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"

@interface WL_Pay_RecordModel : WL_BaseModel

@property (nonatomic,copy) NSString *amount;
@property (nonatomic,copy) NSString *create_date;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *pay_mode;

@property (nonatomic,copy) NSString *pay_source;
@property (nonatomic,copy) NSString *payer_id;

@end
