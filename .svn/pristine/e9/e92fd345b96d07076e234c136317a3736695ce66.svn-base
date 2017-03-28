//
//  WLChargeUpShopObject.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/24.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLChargeUpShopObject.h"
#import "NSDictionary+DefaultValue.h"
#import "WLChargeUpCarObject.h"
#import "WLChargeUpHotelObject.h"

@implementation WLChargeUpRoleObject
- (instancetype)initWithDict:(NSDictionary *)dict additional:(BOOL)additional
{
    self = [super init];
    
    self.checklistID      = [dict objectForKey:@"checklist_id" defaultValue:@"0"];
    self.groupID          = [dict objectForKey:@"grouplist_id" defaultValue:@"0"];
    self.actualPersons    = [dict objectForKey:@"actual_persons" defaultValue:@"0"];
    self.companyName      = [dict objectForKey:@"company_name" defaultValue:@"0"];
    self.actualPrice      = [dict objectForKey:@"actual_price" defaultValue:@"0"];
    self.isMainGuide      = [dict objectForKey:@"extend_attribute" defaultValue:@"0"];
    self.userID           = [dict objectForKey:@"user_id" defaultValue:@"0"];
    self.whichDate        = [dict objectForKey:@"which_date" defaultValue:@"0"];
    self.userName         = [dict objectForKey:@"user_name" defaultValue:@"0"];
    self.remark           = [dict objectForKey:@"remark" defaultValue:@"0"];
    self.rate             = [dict objectForKey:@"rate" defaultValue:@"0"];
    self.headImage        = [dict objectForKey:@"head_img" defaultValue:@"0"];
    
    NSArray *tirpArray = [dict objectForKey:@"pic_list" defaultValue:[NSArray array]];
    if ([tirpArray isKindOfClass:[NSArray class]]) {
        NSMutableArray *objectArray1 = [NSMutableArray array];
        for (NSDictionary *dict in tirpArray) {
            WLChargeUpFileObject *object = [[WLChargeUpFileObject alloc] initWithDict:dict];
            [objectArray1 addObject:object];
        }
        self.picList = [objectArray1 copy];
    }
    
    self.resourceID           = [dict objectForKey:@"resource_id" defaultValue:@"0"];
    self.settlementMode       = [(NSString *)[dict objectForKey:@"settlement_mode" defaultValue:@"0"] integerValue];
    
    NSArray *scheduleArray = [dict objectForKey:@"scheduled_list" defaultValue:[NSArray array]];
    if ([scheduleArray isKindOfClass:[NSArray class]]) {
        NSMutableArray *objectArray2 = [NSMutableArray array];
        for (NSDictionary *dict in scheduleArray) {
            WLChargeUpScheduleObject *object = [[WLChargeUpScheduleObject alloc] initWithDict:dict additional:additional isSchedule:YES];
            [objectArray2 addObject:object];
        }
        self.scheduleList = objectArray2;
    }
    return self;
}
@end

@implementation WLChargeUpShopObject
- (instancetype)initWithDict:(NSDictionary *)dict additional:(BOOL)additional
{
    self = [super init];
    
    self.type           = [dict objectForKey:@"type" defaultValue:@"0"];
    
    NSMutableArray *objectArray = [NSMutableArray array];
    NSUInteger count = 1;
    if (additional) {
        count = 2;
    }
    for (int i = 0; i < [dict allKeys].count - count; i++) {
        NSDictionary *dict0 = [dict objectForKey:[NSString stringWithFormat:@"%d",i]];
        WLChargeUpRoleObject *object = [[WLChargeUpRoleObject alloc] initWithDict:dict0 additional:[self.type isEqualToString:@"added"]];
        
        
        NSArray *pricelist = [dict objectForKey:@"price_list" defaultValue:[NSArray array]];
        if ([pricelist isKindOfClass:[NSArray class]]) {
            NSMutableArray *objectArray2 = [NSMutableArray array];
            for (NSDictionary *dict in pricelist) {
                WLChargeUpScheduleObject *object = [[WLChargeUpScheduleObject alloc] initWithDict:dict additional:[self.type isEqualToString:@"added"] isSchedule:NO];
                [objectArray2 addObject:object];
            }
            object.pricelist = [objectArray2 copy];
        }
        
        [objectArray addObject:object];
    }
    
    NSMutableArray *array = [NSMutableArray array];
    WLChargeUpRoleObject *myselfInfo = nil;
    WLChargeUpRoleObject *mainInfo = nil;
    NSString *userID = [WLUserTools getUserId];////[DEFAULTS objectForKey:@"user_id"];
    for (WLChargeUpRoleObject *info in objectArray) {
        if ([info.userID isEqualToString:userID]) {
            myselfInfo = info;
        }
        if (info.isMainGuide.boolValue && ![info.userID isEqualToString:userID]) {
            mainInfo = info;
        }
    }
    [array insertObject:myselfInfo atIndex:0];
    if (mainInfo) {
        [array insertObject:mainInfo atIndex:1];
    }
    
    for (WLChargeUpRoleObject *info in objectArray) {
        if (![array containsObject:info]) {
            [array addObject:info];
        }
    }

    
    self.roleArray = [array copy];

    return self;
}
@end
