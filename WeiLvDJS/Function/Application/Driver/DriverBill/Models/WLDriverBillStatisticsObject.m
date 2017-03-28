//
//  WLDriverBillStatisticsObject.m
//  WeiLvDJS
//
//  Created by ternence on 2016/12/28.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLDriverBillStatisticsObject.h"
#import "NSDictionary+DefaultValue.h"

@implementation WLDriverBillStatisticsProportionObject

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.percent       = [dict objectForKey:@"percent" defaultValue:@"0"];
    self.price         = [dict objectForKey:@"price" defaultValue:@"0"];
    self.company_name  = [dict objectForKey:@"company_name" defaultValue:@"0"];
    
    return self;
}

@end

@implementation WLDriverBillStatisticsTrendObject

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.price       = [dict objectForKey:@"price" defaultValue:@"0"];
    self.year        = [dict objectForKey:@"year" defaultValue:@"0"];
    self.month       = [dict objectForKey:@"mon" defaultValue:@"0"];
    
    return self;
}

@end

@implementation WLDriverBillStatisticsObject
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.totalPrice   = [dict objectForKey:@"price" defaultValue:@"0"];
    self.year         = [dict objectForKey:@"year" defaultValue:@"0"];
    
    NSArray *dictProportionArray = [dict objectForKey:@"proportion" defaultValue:[NSArray array]];
    NSMutableArray *objectProportionArray = [NSMutableArray array];
    if ([dictProportionArray isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dict in dictProportionArray) {
            WLDriverBillStatisticsProportionObject *object = [[WLDriverBillStatisticsProportionObject alloc] initWithDict:dict];
            [objectProportionArray addObject:object];
        }
        self.proportionArray = [objectProportionArray copy];
    }
    
    NSArray *dictTrendArray = [dict objectForKey:@"trend" defaultValue:[NSArray array]];
    NSMutableArray *objectTrendArray = [NSMutableArray array];
    if ([dictTrendArray isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dict in dictTrendArray) {
            WLDriverBillStatisticsTrendObject *object = [[WLDriverBillStatisticsTrendObject alloc] initWithDict:dict];
            [objectTrendArray addObject:object];
        }
        self.trendArray = [objectTrendArray copy];
    }
    
    return self;
}
@end
