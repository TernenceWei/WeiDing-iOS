//
//  WLBookingCarResultObject.m
//  WeiLvDJS
//
//  Created by ternence on 2017/1/19.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLBookingCarResultObject.h"
#import "NSDictionary+DefaultValue.h"

@implementation WLBookingCarResultObject
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.orderID = [dict objectForKey:@"id" defaultValue:@"0"];
    self.orderPice = [dict objectForKey:@"order_price" defaultValue:@"0"];
    self.driverCount = [dict objectForKey:@"num" defaultValue:@"0"];
    self.nowTime = [dict objectForKey:@"now_time" defaultValue:@"0"];
    
    return self;
}
@end
