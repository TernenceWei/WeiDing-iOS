//
//  WLChargeUpSummaryInfo.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/24.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLChargeUpSummaryInfo.h"
#import "NSDictionary+DefaultValue.h"

@implementation WLChargeUpTripObject
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.date         = [dict objectForKey:@"date" defaultValue:@"0"];
    self.day          = [dict objectForKey:@"day" defaultValue:@"0"];
    self.dayText      = [dict objectForKey:@"name" defaultValue:@"0"];
    
    return self;
}
@end

@implementation WLChargeUpNameCardObject
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.name         = [dict objectForKey:@"_name" defaultValue:@"0"];
    self.mobile       = [dict objectForKey:@"user_mobile" defaultValue:@"0"];
    self.roleName     = [dict objectForKey:@"role_name" defaultValue:@"0"];
    self.roleID       = [dict objectForKey:@"id" defaultValue:@"0"];
    
    return self;
}
@end

@implementation WLChargeUpSummaryInfo
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.type         = [dict objectForKey:@"type" defaultValue:@"0"];
    self.lineName     = [dict objectForKey:@"line_name" defaultValue:@"0"];
    self.groupNO      = [dict objectForKey:@"group_number" defaultValue:@"0"] ;
    self.receiveDate  = [dict objectForKey:@"receive_date" defaultValue:@"0"];
    self.sendDate     = [dict objectForKey:@"send_date" defaultValue:@"0"];
    self.peopleCount  = [dict objectForKey:@"_total" defaultValue:@"0"];
    self.guideNums    = [dict objectForKey:@"_guide_num" defaultValue:@"0"];
    self.isMainGuide  = [dict objectForKey:@"_is_main_guide" defaultValue:@"0"];
    self.days         = [dict objectForKey:@"_days" defaultValue:@"0"];
    
    self.status       = [[dict objectForKey:@"journey_status" defaultValue:@"0"] integerValue];
    self.statusString = [dict objectForKey:@"journey_status_reamrk" defaultValue:@"0"];
    
    NSArray *tirpArray = [dict objectForKey:@"trip_list" defaultValue:[NSArray array]];
    NSMutableArray *objectArray1 = [NSMutableArray array];
    for (NSDictionary *dict in tirpArray) {
        WLChargeUpTripObject *object = [[WLChargeUpTripObject alloc] initWithDict:dict];
        [objectArray1 addObject:object];
    }
    self.tripList = [objectArray1 copy];
    
    NSArray *cardArray = [dict objectForKey:@"card_list" defaultValue:[NSArray array]];
    NSMutableArray *objectArray2 = [NSMutableArray array];
    for (NSDictionary *dict in cardArray) {
        WLChargeUpNameCardObject *object = [[WLChargeUpNameCardObject alloc] initWithDict:dict];
        [objectArray2 addObject:object];
    }
    self.nameCardList = [objectArray2 copy];
    
    return self;
}
@end
