//
//  WLTripOrderModel.h
//  WeiLvDJS
//
//  Created by xiaobai2268 on 2016/10/31.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"

@interface WLTripOrderModel : WL_BaseModel

@property (nonatomic,copy) NSString *trip_statusss;
@property (nonatomic,copy) NSString *start_province_id;
@property (nonatomic,copy) NSString *order_source_Fleet;
@property (nonatomic,copy) NSString *patcher_mobile;
@property (nonatomic,copy) NSString *remark;
@property (nonatomic,copy) NSString *end_time;
@property (nonatomic,copy) NSString *from_agency_id;
@property (nonatomic,copy) NSString *company_id;
@property (nonatomic,copy) NSString *prepaid_amount;
@property (nonatomic,copy) NSString *dispatcher_id;
@property (nonatomic,copy) NSString *receipted_amount;
@property (nonatomic,copy) NSString *order_status;
@property (nonatomic,copy) NSString *pay_status;
@property (nonatomic,copy) NSString *grouplist_id;
@property (nonatomic,copy) NSString *sj_order_id;
@property (nonatomic,copy) NSString *mileage;
@property (nonatomic,copy) NSString *end_province_id;
@property (nonatomic,copy) NSString *end_address;
@property (nonatomic,copy) NSString *create_date;
@property (nonatomic,copy) NSString *guide_mobile;
@property (nonatomic,copy) NSString *order_number;
@property (nonatomic,copy) NSString *order_source_travel;
@property (nonatomic,copy) NSString *checklist_id;
@property (nonatomic,copy) NSString *end_city_id;
@property (nonatomic,copy) NSString *failure_expires;
@property (nonatomic,copy) NSString *start_address;
@property (nonatomic,copy) NSString *accept_date;
@property (nonatomic,copy) NSString *persons_count;
@property (nonatomic,copy) NSString *start_city_id;
@property (nonatomic,copy) NSString *driver_id;
@property (nonatomic,copy) NSString *cancel_expires;
@property (nonatomic,copy) NSString *start_time;
@property (nonatomic,copy) NSString *settlement_date;
@property (nonatomic,copy) NSString *start_city;
@property (nonatomic,copy) NSString *cancel_remark;
@property (nonatomic,copy) NSString *end_city;
@property (nonatomic,copy) NSString *update_date;
@property (nonatomic,copy) NSString *amount;

@end
