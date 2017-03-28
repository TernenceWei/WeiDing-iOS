//
//  WLDriverBillListObject.m
//  WeiLvDJS
//
//  Created by ternence on 2016/12/28.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLDriverBillListObject.h"
#import "NSDictionary+DefaultValue.h"

@implementation WLDriverBillItemObject
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.no_pay          = [dict objectForKey:@"no_pay" defaultValue:@"0"];
    self.orderID         = [dict objectForKey:@"id" defaultValue:@"0"];
    self.start_at        = [dict objectForKey:@"start_at" defaultValue:@"0"];
    self.end_at          = [dict objectForKey:@"end_at" defaultValue:@"0"];
    self.order_price     = [dict objectForKey:@"order_price" defaultValue:@"0"];
    self.trip_end_at     = [dict objectForKey:@"trip_end_at" defaultValue:@"0"];
    self.actual_pay      = [dict objectForKey:@"actual_pay" defaultValue:@"0"];
    self.pay             = [dict objectForKey:@"pay" defaultValue:@"0"];
    self.pay_at             = [dict objectForKey:@"pay_at" defaultValue:@"0"];
    
    self.order_type             = [[dict objectForKey:@"order_type" defaultValue:@"0"] integerValue];
    self.driver_price             = [dict objectForKey:@"driver_price" defaultValue:@"0"];
    self.dispatch_price             = [dict objectForKey:@"dispatch_price" defaultValue:@"0"];
    
    self.no_confirm             = [dict objectForKey:@"no_confirm" defaultValue:@"0"];
    self.is_local             = [dict objectForKey:@"is_local" defaultValue:@"0"];

    return self;
}

@end

@implementation WLDriverBillListObject
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.pay       = [dict objectForKey:@"pay" defaultValue:@"0"];
    self.no_pay       = [dict objectForKey:@"no_pay" defaultValue:@"0"];
    self.date         = [dict objectForKey:@"date" defaultValue:@"0"];
    self.year         = [dict objectForKey:@"year" defaultValue:@"0"];
    self.month        = [dict objectForKey:@"month" defaultValue:@"0"];
    
    NSArray *dictArray = [dict objectForKey:@"items" defaultValue:[NSArray array]];
    NSMutableArray *objectArray = [NSMutableArray array];
    if ([dictArray isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dict in dictArray) {
            WLDriverBillItemObject *object = [[WLDriverBillItemObject alloc] initWithDict:dict];
            [objectArray addObject:object];
        }
        self.items = [objectArray copy];
    }
    
    return self;
}
@end
