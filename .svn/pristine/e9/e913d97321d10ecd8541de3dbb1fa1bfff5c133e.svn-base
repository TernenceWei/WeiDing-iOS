//
//  WLChargeUpHotelObject.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/24.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLChargeUpHotelObject.h"
#import "NSDictionary+DefaultValue.h"
#import "WLChargeUpCarObject.h"

@implementation WLChargeUpScheduleObject

- (instancetype)initWithDict:(NSDictionary *)dict additional:(BOOL)additional isSchedule:(BOOL)isSchedule
{
    self = [super init];

    if (additional) {
        self.pricelistID         = [dict objectForKey:@"pricelist_id" defaultValue:@""];
        self.priceName           = [dict objectForKey:@"price_name" defaultValue:@""];
        self.checklistID         = [dict objectForKey:@"checklist_id" defaultValue:@""];
        self.actualDanJia        = [dict objectForKey:@"actual_sell_price" defaultValue:@""];
        self.actualCount         = [dict objectForKey:@"actual_count" defaultValue:@""];
        self.actualPrice         = [dict objectForKey:@"actual_price" defaultValue:@""];
        self.primePrice          = [dict objectForKey:@"prime_price" defaultValue:@""];
        if (!isSchedule) {
            self.priceName       = [dict objectForKey:@"pricelist_name" defaultValue:@""];
        }
        
    }else{
        self.pricelistID         = [dict objectForKey:@"pricelist_id" defaultValue:@""];
        self.checklistID         = [dict objectForKey:@"checklist_id" defaultValue:@""];
        self.priceName           = [dict objectForKey:@"price_name" defaultValue:@""];
        self.actualCount         = [dict objectForKey:@"actual_count" defaultValue:@""];
        self.actualPrice         = [dict objectForKey:@"actual_price" defaultValue:@""];
        self.checkCount          = [dict objectForKey:@"check_count" defaultValue:@""];
        if (!isSchedule) {
            self.priceName       = [dict objectForKey:@"pricelist_name" defaultValue:@""];
        }
    }
    NSUInteger checker = [[dict objectForKey:@"checker_id" defaultValue:@""] integerValue];
    self.canDelete = (checker == 0);
    return self;
}
@end



@implementation WLChargeUpHotelObject
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.checklistID      = [dict objectForKey:@"checklist_id" defaultValue:@"0"];
    self.groupID     = [dict objectForKey:@"grouplist_id" defaultValue:@"0"];
    self.resourceID         = [dict objectForKey:@"resource_id" defaultValue:@"0"];
    self.companyName         = [dict objectForKey:@"company_name" defaultValue:@"0"];
    self.registerTime        = [dict objectForKey:@"register_time" defaultValue:@"0"];
    self.registerName       = [dict objectForKey:@"register_name" defaultValue:@"0"];
    self.settlementMode           = ((NSString *)[dict objectForKey:@"settlement_mode" defaultValue:@"0"]).integerValue;
    self.whichDay           = [dict objectForKey:@"which_date" defaultValue:@"0"];
    self.type              = [dict objectForKey:@"type" defaultValue:@"0"];
    self.remark            = [dict objectForKey:@"remark" defaultValue:@"0"];
    self.actualPerson            = [dict objectForKey:@"actual_persons" defaultValue:@"0"];

    
    NSArray *tirpArray = [dict objectForKey:@"pic_list" defaultValue:[NSArray array]];
    if ([tirpArray isKindOfClass:[NSArray class]]) {
        NSMutableArray *objectArray1 = [NSMutableArray array];
        for (NSDictionary *dict in tirpArray) {
            WLChargeUpFileObject *object = [[WLChargeUpFileObject alloc] initWithDict:dict];
            [objectArray1 addObject:object];
        }
        self.picList = [objectArray1 copy];
    }
    
    
    NSArray *scheduleArray = [dict objectForKey:@"scheduled_list" defaultValue:[NSArray array]];
    NSMutableArray *objectArray2 = [NSMutableArray array];
    for (NSDictionary *dict in scheduleArray) {
        WLChargeUpScheduleObject *object = [[WLChargeUpScheduleObject alloc] initWithDict:dict additional:NO isSchedule:YES];
        [objectArray2 addObject:object];
    }
    self.scheduleList = objectArray2;
    
    
    NSArray *priceArray = [dict objectForKey:@"price_list" defaultValue:[NSArray array]];
    if ([priceArray isKindOfClass:[NSArray class]]) {
        NSMutableArray *objectArray3 = [NSMutableArray array];
        for (NSDictionary *dict in priceArray) {
            WLChargeUpScheduleObject *object = [[WLChargeUpScheduleObject alloc] initWithDict:dict additional:NO isSchedule:NO];
            [objectArray3 addObject:object];
        }
        self.priceList = [objectArray3 copy];
    }
    
    return self;
}
@end
