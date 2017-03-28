//
//  WLItemDetailCarObject.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/24.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLItemDetailCarObject.h"
#import "NSDictionary+DefaultValue.h"

@implementation WLItemDetailCarObject
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.orderID        = [dict objectForKey:@"id" defaultValue:@"0"];
    self.companyName    = [dict objectForKey:@"company_name" defaultValue:@"0"];
    self.carAmount      = [dict objectForKey:@"car_mode" defaultValue:@"0"];
    self.carNO          = [dict objectForKey:@"car_number" defaultValue:@"0"];
    self.driverName     = [dict objectForKey:@"driver_name" defaultValue:@"0"];
    self.mobile         = [dict objectForKey:@"mobile" defaultValue:@"0"];
    self.carBrand       = [dict objectForKey:@"car_brand" defaultValue:@"0"];
    self.carProvince    = [dict objectForKey:@"car_province" defaultValue:@"0"];
    self.carCity        = [dict objectForKey:@"car_city" defaultValue:@"0"];
    self.startTime      = [dict objectForKey:@"start_time" defaultValue:@"0"];
    self.endTime        = [dict objectForKey:@"end_time" defaultValue:@"0"];
    
    self.startProvince  = [dict objectForKey:@"start_province" defaultValue:@"0"];
    self.startCity      = [dict objectForKey:@"start_city" defaultValue:@"0"];
    self.endProvince    = [dict objectForKey:@"end_province" defaultValue:@"0"];
    self.endCity        = [dict objectForKey:@"end_city" defaultValue:@"0"];
    self.startAddress   = [dict objectForKey:@"start_address" defaultValue:@"0"];
    self.endAddress     = [dict objectForKey:@"end_address" defaultValue:@"0"];
    self.actualAmount   = [dict objectForKey:@"actual_amount" defaultValue:@"0"];
    self.type           = [dict objectForKey:@"type" defaultValue:@"0"];
    
    NSArray *photoDict = [dict objectForKey:@"photo_list"];
    self.photolist = photoDict;
//    self.imgUrl1 = [photoDict objectForKey:@"img1" defaultValue:@"0"];
//    self.imgUrl2 = [photoDict objectForKey:@"img2" defaultValue:@"0"];
//    self.imgUrl3 = [photoDict objectForKey:@"img3" defaultValue:@"0"];
//    self.imgUrl4 = [photoDict objectForKey:@"img4" defaultValue:@"0"];
//    self.imgUrl5 = [photoDict objectForKey:@"img5" defaultValue:@"0"];
    return self;
}
@end
