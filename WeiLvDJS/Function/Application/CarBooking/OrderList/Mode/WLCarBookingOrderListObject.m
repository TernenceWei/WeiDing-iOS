//
//  WLCarBookingOrderListObject.m
//  WeiLvDJS
//
//  Created by hsliang on 2017/1/19.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLCarBookingOrderListObject.h"

@implementation WLCarBookingOrderListObject
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"cost_list" : @"WLCarBookingCostObject",
             @"order_bid_list" : @"WLCarBookingDriverObject"};
}
@end

@implementation WLCarBookingOrderListObjectcost_list

@end

@implementation WLCarBookingOrderListObjectcompany

@end

@implementation WLCarBookingOrderListObjectData

@end
