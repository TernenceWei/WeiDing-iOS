//
//  WLCarBookingDriverObject.h
//  WeiLvDJS
//
//  Created by ternence on 2017/2/12.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLCarBookingDriverObject : NSObject

//@property (nonatomic, strong) NSString * id;//暂不解析
@property (nonatomic, strong) NSString * sj_order_id;
@property (nonatomic, strong) NSString * company_id;
@property (nonatomic, strong) NSString * driver_user_id;
@property (nonatomic, strong) NSString * sj_driver_id;
@property (nonatomic, strong) NSString * driver_name;
@property (nonatomic, strong) NSString * driver_mobile;
@property (nonatomic, strong) NSString * sj_car_id;
@property (nonatomic, strong) NSString * car_model;
@property (nonatomic, strong) NSString * car_seat_amount;
@property (nonatomic, strong) NSString * car_brand;
@property (nonatomic, strong) NSString * car_number;
@property (nonatomic, strong) NSString * bid_price;
@property (nonatomic, strong) NSString * bid_status;
@property (nonatomic, strong) NSString * bid_at;
@property (nonatomic, strong) NSString * is_deleted;
@property (nonatomic, strong) NSString * created_at;
@property (nonatomic, strong) NSString * updated_at;
@property (nonatomic, strong) NSString * cost_memo;
@property (nonatomic, strong) NSString * driver_avatar;
@property (nonatomic, strong) NSArray * car_image;
@property (nonatomic, strong) NSString * age_limit;

@end
