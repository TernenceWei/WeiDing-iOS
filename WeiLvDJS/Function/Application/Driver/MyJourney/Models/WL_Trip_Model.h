//
//  WL_Trip_Model.h
//  WeiLvDJS
//
//  Created by jyc on 16/9/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"

@interface WL_Trip_Model : WL_BaseModel

@property(nonatomic,copy)NSString *start_time;

@property(nonatomic,copy)NSString *end_time;

@property(nonatomic,copy)NSString *status;

@property(nonatomic,copy)NSString *relation_order_id;

@property(nonatomic,copy)NSString *trip_status;

@end
