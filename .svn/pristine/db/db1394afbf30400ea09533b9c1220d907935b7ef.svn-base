//
//  WLCurrentGroupInfo.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/24.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLCurrentGroupInfo.h"
#import "NSDictionary+DefaultValue.h"

@implementation WLCurrentGroupCarObject
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.contactName         = [dict objectForKey:@"_contact_name" defaultValue:@"0"];
    self.contactMobile       = [dict objectForKey:@"_contact_mobile" defaultValue:@"0"];
    self.contactRole         = [dict objectForKey:@"_contact_role" defaultValue:@"0"];
    self.driverID            = [dict objectForKey:@"driver_id" defaultValue:@"0"];
    self.orderID             = [dict objectForKey:@"sj_order_id" defaultValue:@"0"];
    self.carNO               = [dict objectForKey:@"car_number" defaultValue:@"0"];
    self.carAmount           = [dict objectForKey:@"car_mode" defaultValue:@"0"];
    self.companyName         = [dict objectForKey:@"company_name" defaultValue:@"0"];
    self.price               = [dict objectForKey:@"amount" defaultValue:@"0"];
    
    self.buttonName          = [dict objectForKey:@"_button_name" defaultValue:@"0"];
    self.groupStatus         = [(NSString *)[dict objectForKey:@"_grouplist_status" defaultValue:@"0"] integerValue];
    self.checklistID         = [dict objectForKey:@"checklist_id" defaultValue:@"0"];
    self.orderNO             = [dict objectForKey:@"order_number" defaultValue:@"0"];
    
    return self;
}
@end

@implementation WLCurrentGroupListObject

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.checklistID      = [dict objectForKey:@"checklist_id" defaultValue:@"0"];
    self.resourceID       = [dict objectForKey:@"resource_id" defaultValue:@"0"];
    self.itemType         = [dict objectForKey:@"item_type" defaultValue:@"0"];
    self.priceListName    = [dict objectForKey:@"pricelist_name" defaultValue:@"0"];
    self.checkCount       = [dict objectForKey:@"check_count" defaultValue:@"0"];
    self.checkPrice       = [dict objectForKey:@"check_price" defaultValue:@"0"];
    self.unit             = [dict objectForKey:@"unit" defaultValue:@"0"];
    self.whichDay         = [dict objectForKey:@"which_date" defaultValue:@"0"];
    
    return self;
}

@end

@implementation WLCurrentGroupHotelObject
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.contactName      = [dict objectForKey:@"_contact_name" defaultValue:@"0"];
    self.contactMobile    = [dict objectForKey:@"_contact_mobile" defaultValue:@"0"];
    self.contactRole      = [dict objectForKey:@"_contact_role" defaultValue:@"0"];
    self.resourceID       = [dict objectForKey:@"resource_id" defaultValue:@"0"];
    self.itemType         = [dict objectForKey:@"item_type" defaultValue:@"0"];
    self.groupID          = [dict objectForKey:@"grouplist_id" defaultValue:@"0"];
    self.date             = [dict objectForKey:@"_date" defaultValue:@"0"];
    self.whichDay         = [dict objectForKey:@"which_day" defaultValue:@"0"];
    self.companyName      = [dict objectForKey:@"name" defaultValue:@"0"];
    self.settlementMode   = [dict objectForKey:@"settlement_mode" defaultValue:@"0"];
    self.spend            = [dict objectForKey:@"spend" defaultValue:@"0"];
    
    self.buttonName       = [dict objectForKey:@"_button_name" defaultValue:@"0"];
    self.groupStatus      = [(NSString *)[dict objectForKey:@"_grouplist_status" defaultValue:@"0"] integerValue];
    self.checklistID      = [dict objectForKey:@"checklist_id" defaultValue:@"0"];
    self.guideID          = [dict objectForKey:@"guide_id" defaultValue:@"0"];
    self.pricelistID      = [dict objectForKey:@"pricelist_id" defaultValue:@"0"];
    
    NSArray *carArray = [dict objectForKey:@"list" defaultValue:[NSArray array]];
    NSMutableArray *objectArray1 = [NSMutableArray array];
    if ([carArray isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dict in carArray) {
            WLCurrentGroupListObject *object = [[WLCurrentGroupListObject alloc] initWithDict:dict];
            [objectArray1 addObject:object];
        }
        self.itemList = [objectArray1 copy];
    }
    

    return self;
}


@end

@implementation WLCurrentGroupShopObject
- (instancetype)initWithDict:(NSDictionary *)dict isShopping:(BOOL)isShopping
{
    self = [super init];
    
    self.contactName      = [dict objectForKey:@"_contact_name" defaultValue:@"0"];
    self.contactMobile    = [dict objectForKey:@"_contact_mobile" defaultValue:@"0"];
    self.contactRole      = [dict objectForKey:@"_contact_role" defaultValue:@"0"];
    self.resourceID       = [dict objectForKey:@"resource_id" defaultValue:@"0"];
    self.guideID          = [dict objectForKey:@"guide_id" defaultValue:@"0"];
    self.checklistID      = [dict objectForKey:@"checklist_id" defaultValue:@"0"];
    self.itemType         = [dict objectForKey:@"item_type" defaultValue:@"0"];
    self.supplierID       = [dict objectForKey:@"supplier_id" defaultValue:@"0"];
    self.date             = [dict objectForKey:@"_date" defaultValue:@"0"];
    self.whichDay         = [dict objectForKey:@"which_date" defaultValue:@"0"];
    self.companyName      = [dict objectForKey:@"name" defaultValue:@"0"];
    self.rate             = [dict objectForKey:@"_rate" defaultValue:@"0"];
    self.cashBack         = [dict objectForKey:@"cashback" defaultValue:@"0"];
    self.buttonName       = [dict objectForKey:@"_button_name" defaultValue:@"0"];
    self.groupStatus      = [(NSString *)[dict objectForKey:@"_grouplist_status" defaultValue:@"0"] integerValue];
    if (isShopping) {
        self.cashBack     = [dict objectForKey:@"cashback" defaultValue:@"0"];
    }else{
        self.cashBack     = [dict objectForKey:@"_jieyu" defaultValue:@"0"];
    }
    return self;
}


@end

@implementation WLCurrentGroupInfo
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];

    self.message = [dict objectForKey:@"tip" defaultValue:@""];
    
    NSArray *carArray = [dict objectForKey:@"car" defaultValue:[NSArray array]];
    NSMutableArray *objectArray1 = [NSMutableArray array];
    if ([carArray isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dict in carArray) {
            WLCurrentGroupCarObject *object = [[WLCurrentGroupCarObject alloc] initWithDict:dict];
            [objectArray1 addObject:object];
        }
        self.carList = [objectArray1 copy];
    }
    
    
    NSArray *hotelArray = [dict objectForKey:@"hotel" defaultValue:[NSArray array]];
    NSMutableArray *objectArray2 = [NSMutableArray array];
    for (NSDictionary *dict in hotelArray) {
        WLCurrentGroupHotelObject *object = [[WLCurrentGroupHotelObject alloc] initWithDict:dict];
        [objectArray2 addObject:object];
    }
    self.hotelList = [objectArray2 copy];
    
    NSArray *mealArray = [dict objectForKey:@"restaurant" defaultValue:[NSArray array]];
    NSMutableArray *objectArray3 = [NSMutableArray array];
    for (NSDictionary *dict in mealArray) {
        WLCurrentGroupHotelObject *object = [[WLCurrentGroupHotelObject alloc] initWithDict:dict];
        [objectArray3 addObject:object];
    }
    self.mealList = [objectArray3 copy];
    
    NSArray *ticketArray = [dict objectForKey:@"scenery" defaultValue:[NSArray array]];
    NSMutableArray *objectArray4 = [NSMutableArray array];
    for (NSDictionary *dict in ticketArray) {
        WLCurrentGroupHotelObject *object = [[WLCurrentGroupHotelObject alloc] initWithDict:dict];
        [objectArray4 addObject:object];
    }
    self.ticketList = [objectArray4 copy];
    
    NSArray *shopArray = [dict objectForKey:@"shop" defaultValue:[NSArray array]];
    NSMutableArray *objectArray5 = [NSMutableArray array];
    for (NSDictionary *dict in shopArray) {
        WLCurrentGroupShopObject *object = [[WLCurrentGroupShopObject alloc] initWithDict:dict isShopping:YES];
        [objectArray5 addObject:object];
    }
    self.shopList = [objectArray5 copy];
    
    NSArray *addArray = [dict objectForKey:@"pk" defaultValue:[NSArray array]];
    NSMutableArray *objectArray6 = [NSMutableArray array];
    for (NSDictionary *dict in addArray) {
        WLCurrentGroupShopObject *object = [[WLCurrentGroupShopObject alloc] initWithDict:dict isShopping:NO];
        [objectArray6 addObject:object];
    }
    self.addList = [objectArray6 copy];
    
    return self;
}
@end
