//
//  WLCarBookingOrderDetailObject.m
//  WeiLvDJS
//
//  Created by ternence on 2017/1/20.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLCarBookingOrderDetailObject.h"

@implementation WLCarBookingOrderDetailObject
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"cost_list" : @"WLCarBookingCostObject",
             @"order_bid_list" : @"WLCarBookingDriverObject",
             @"invalid_order_bid_list" : @"WLCarBookingDriverObject"};
}
@end
