//
//  WLBookingCarObject.h
//  WeiLvDJS
//
//  Created by ternence on 2017/1/19.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CarModel) {
    CarModelBus      = 1,
    CarModelCar      = 4,
    CarModelVehicle  = 2,
    
};

@interface WLBookingCarObject : NSObject

@property (nonatomic, strong) NSString *car_model;
@property (nonatomic, strong) NSString *start_at;
@property (nonatomic, strong) NSString *end_at;
@property (nonatomic, strong) NSString *start_province_id;
@property (nonatomic, strong) NSString *start_city_id;
@property (nonatomic, strong) NSString *start_address;
@property (nonatomic, strong) NSString *via_address;
@property (nonatomic, strong) NSString *end_province_id;
@property (nonatomic, strong) NSString *end_city_id;
@property (nonatomic, strong) NSString *end_address;
@property (nonatomic, strong) NSString *car_seat_amount;

@property (nonatomic, strong) NSString *use_car_contacts;
@property (nonatomic, strong) NSString *use_car_mobile;
@property (nonatomic, strong) NSString *memo;
@property (nonatomic, strong) NSString *from_company_id;

@property (nonatomic, strong) NSString *start_memo_address;
@property (nonatomic, strong) NSString *end_memo_address;

@property (nonatomic, strong) NSMutableArray *order_image_files;

@end
