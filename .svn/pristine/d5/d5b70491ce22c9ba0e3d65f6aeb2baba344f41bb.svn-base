//
//  WLItemDetailHotelObject.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/24.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLItemDetailHotelObject.h"
#import "NSDictionary+DefaultValue.h"



@implementation WLItemDetailScheduleObject

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.checkCount        = [dict objectForKey:@"check_count" defaultValue:@"0"];
    self.checkPrice        = [dict objectForKey:@"check_price" defaultValue:@"0"];
    self.priceName         = [dict objectForKey:@"price_name" defaultValue:@"0"];

    return self;
}

@end

@implementation WLItemDetailHotelObject
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.checklistID        = [dict objectForKey:@"checklist_id" defaultValue:@"0"];
    self.groupID            = [dict objectForKey:@"grouplist_id" defaultValue:@"0"];
    self.resourceID         = [dict objectForKey:@"resource_id" defaultValue:@"0"];
    self.whichDate          = [dict objectForKey:@"which_date" defaultValue:@"0"];
    self.companyName        = [dict objectForKey:@"company_name" defaultValue:@"0"];
    self.settlementMode     = [(NSString *)[dict objectForKey:@"settlement_mode" defaultValue:@"0"] integerValue];
    self.type               = [dict objectForKey:@"type" defaultValue:@"0"];
    self.address            = [dict objectForKey:@"address" defaultValue:@"0"];
    self.city               = [dict objectForKey:@"city" defaultValue:@"0"];
    self.contactName        = [dict objectForKey:@"contacts_name" defaultValue:@"0"];
    self.contactMobile      = [dict objectForKey:@"contacts_mobile" defaultValue:@"0"];
    self.details            = [dict objectForKey:@"details" defaultValue:@"0"];
    self.province           = [dict objectForKey:@"province" defaultValue:@"0"];
    self.actualPerson       = [dict objectForKey:@"actual_persons" defaultValue:@"0"];
    self.guideID            = [dict objectForKey:@"guide_id" defaultValue:@"0"];
    self.rate               = [dict objectForKey:@"rate" defaultValue:@"0"];

    NSArray *tirpArray = [dict objectForKey:@"scheduled_list" defaultValue:[NSArray array]];
    NSMutableArray *objectArray1 = [NSMutableArray array];
    for (NSDictionary *dict in tirpArray) {
        WLItemDetailScheduleObject *object = [[WLItemDetailScheduleObject alloc] initWithDict:dict];
        [objectArray1 addObject:object];
    }
    self.scheduleList = [objectArray1 copy];
    
    return self;
}
@end
