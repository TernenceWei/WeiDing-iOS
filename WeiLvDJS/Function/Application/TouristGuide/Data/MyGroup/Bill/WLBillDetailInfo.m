//
//  WLBillDetailInfo.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/14.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLBillDetailInfo.h"
#import "NSDictionary+DefaultValue.h"

@implementation WLBillFailMessageInfo
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.itemName         = [dict objectForKey:@"_item_name" defaultValue:@"0"];
    self.itemType         = [dict objectForKey:@"item_type" defaultValue:@"0"];
    self.message          = [dict objectForKey:@"remark" defaultValue:@"0"];
    
    return self;
}


@end

@implementation WLBillCarInfo
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.orderID              = [dict objectForKey:@"sj_order_id" defaultValue:@"0"];
    self.date                 = [dict objectForKey:@"_date" defaultValue:@"0"];
    self.companyName          = [dict objectForKey:@"company_name" defaultValue:@"0"];
    self.actualSpend          = [dict objectForKey:@"actual_amount" defaultValue:@"0"];
    self.actualPay            = [dict objectForKey:@"amount" defaultValue:@"0"];
    
    return self;
}


@end

@implementation WLBillHotelInfo

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.checkListID          = [dict objectForKey:@"checklist_id" defaultValue:@"0"];
    self.itemType             = [dict objectForKey:@"item_type" defaultValue:@"0"];
    self.date                 = [dict objectForKey:@"_date" defaultValue:@"0"];
    self.companyName          = [dict objectForKey:@"name" defaultValue:@"0"];
    self.payMode              = [[dict objectForKey:@"settlement_mode" defaultValue:@"0"] integerValue];
    self.actualSpend          = [dict objectForKey:@"spend" defaultValue:@"0"];
    return self;
}

@end

@implementation WLBillShoppingInfo

- (instancetype)initWithDict:(NSDictionary *)dict shopping:(BOOL)shopping
{
    self = [super init];
    
    self.checkListID              = [dict objectForKey:@"checklist_id" defaultValue:@"0"];
    self.resourceID              = [dict objectForKey:@"resource_id" defaultValue:@"0"];
    self.itemType                 = [dict objectForKey:@"item_type" defaultValue:@"0"];
    self.guideID                 = [dict objectForKey:@"guide_id" defaultValue:@"0"];
    self.date          = [dict objectForKey:@"_date" defaultValue:@"0"];
    self.companyName          = [dict objectForKey:@"name" defaultValue:@"0"];
    if (shopping) {
        self.actualSpend            = [dict objectForKey:@"spend" defaultValue:@"0"];
    }else{
        self.actualSpend            = [dict objectForKey:@"_jieyu" defaultValue:@"0"];
    }
    self.rate          = [dict objectForKey:@"_rate" defaultValue:@"0"];
    self.cashBack            = [dict objectForKey:@"cashback" defaultValue:@"0"];
    return self;
}

@end


@implementation WLBillDetailInfo
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.imprestShouKuan     = [dict objectForKey:@"imprest_shou" defaultValue:@"0"];
    self.imprestXianFu       = [dict objectForKey:@"imprest_pay" defaultValue:@"0"];
    self.imprestChaoE        = [dict objectForKey:@"imprest_chao" defaultValue:@"0"];
    self.shopSpend           = [dict objectForKey:@"shopFanXian_spend" defaultValue:@"0"];
    self.shopRebate          = [dict objectForKey:@"shopFanXian_rebate" defaultValue:@"0"];
    self.shopBack            = [dict objectForKey:@"shopFanXian_ying" defaultValue:@"0"];
    self.additionalTotal     = [dict objectForKey:@"PlusPointItem_total" defaultValue:@"0"];
    self.additionalPerson    = [dict objectForKey:@"PlusPointItem_person" defaultValue:@"0"];
    self.additionalBack      = [dict objectForKey:@"PlusPointItem_ying" defaultValue:@"0"];
    self.serviceFree         = [dict objectForKey:@"guide_service_fee" defaultValue:@"0"];
    self.settle              = [dict objectForKey:@"dai_settle" defaultValue:@"0"];
    
    self.failDate            = [dict objectForKey:@"audit_fail_date" defaultValue:@"0"];
    self.additionalRebate    = [dict objectForKey:@"PlusPointItem_fandian" defaultValue:@"0"];
    self.status              = [[dict objectForKey:@"status" defaultValue:@"0"] integerValue];
    self.companyName         = [dict objectForKey:@"company_name" defaultValue:@"0"];
    self.groupNO             = [dict objectForKey:@"group_number" defaultValue:@"0"];
    
    if ([[dict allKeys] containsObject:@"audit_fail_message"]) {
        
        NSDictionary *failDict = [dict objectForKey:@"audit_fail_message" defaultValue:@"0"];
        NSMutableArray *failArray = [NSMutableArray array];
        for (NSDictionary *dict0 in failDict) {
            WLBillFailMessageInfo *carInfo = [[WLBillFailMessageInfo alloc] initWithDict:dict0];
            [failArray addObject:carInfo];
        }
        self.failMessage = [failArray copy];
    }
    
    if ([[dict allKeys] containsObject:@"car"]) {
        
        NSDictionary *carDict = [dict objectForKey:@"car" defaultValue:@"0"];
        NSDictionary *carDict1 = [carDict objectForKey:@"list" defaultValue:@"0"];
        NSMutableArray *carArray = [NSMutableArray array];
        for (NSDictionary *dict0 in carDict1) {
            
            WLBillCarInfo *carInfo = [[WLBillCarInfo alloc] initWithDict:dict0];
            carInfo.payAmount = [carDict objectForKey:@"pay_amount" defaultValue:@"0"];
            [carArray addObject:carInfo];
        }
        self.carList = [carArray copy];
    }
    
    
    if ([[dict allKeys] containsObject:@"hotel"]) {
        
        NSDictionary *hotelDict = [dict objectForKey:@"hotel" defaultValue:@"0"];
        NSDictionary *hotelDict1 = [hotelDict objectForKey:@"list" defaultValue:@"0"];
        NSMutableArray *hotelArray = [NSMutableArray array];
        for (NSDictionary *dict0 in hotelDict1) {
            WLBillHotelInfo *hotelInfo = [[WLBillHotelInfo alloc] initWithDict:dict0];
            hotelInfo.payAmount = [hotelDict objectForKey:@"pay_amount" defaultValue:@"0"];
            [hotelArray addObject:hotelInfo];
        }
        self.hotelList = [hotelArray copy];
    }
    
    
    if ([[dict allKeys] containsObject:@"dinner"]) {
        
        NSDictionary *mealDict = [dict objectForKey:@"dinner" defaultValue:@"0"];
        NSDictionary *mealDict1 = [mealDict objectForKey:@"list" defaultValue:@"0"];
        NSMutableArray *mealArray = [NSMutableArray array];
        for (NSDictionary *dict0 in mealDict1) {
            WLBillHotelInfo *hotelInfo = [[WLBillHotelInfo alloc] initWithDict:dict0];
            hotelInfo.payAmount = [mealDict objectForKey:@"pay_amount" defaultValue:@"0"];
            [mealArray addObject:hotelInfo];
        }
        self.mealList = [mealArray copy];
    }
    
    
    if ([[dict allKeys] containsObject:@"scenery"]) {
        
        NSDictionary *playDict = [dict objectForKey:@"scenery" defaultValue:@"0"];
        NSDictionary *playDict1 = [playDict objectForKey:@"list" defaultValue:@"0"];
        NSMutableArray *playArray = [NSMutableArray array];
        for (NSDictionary *dict0 in playDict1) {
            WLBillHotelInfo *hotelInfo = [[WLBillHotelInfo alloc] initWithDict:dict0];
            hotelInfo.payAmount = [playDict objectForKey:@"pay_amount" defaultValue:@"0"];
            [playArray addObject:hotelInfo];
        }
        self.playList = [playArray copy];
    }
    
    
    
    if ([[dict allKeys] containsObject:@"shop"]) {
        
        NSDictionary *shopDict = [dict objectForKey:@"shop" defaultValue:@"0"];
        NSDictionary *shopDict1 = [shopDict objectForKey:@"list" defaultValue:@"0"];
        NSMutableArray *shopArray = [NSMutableArray array];
        for (NSDictionary *dict0 in shopDict1) {
            WLBillShoppingInfo *shopInfo = [[WLBillShoppingInfo alloc] initWithDict:dict0 shopping:YES];
            shopInfo.payAmount = [shopDict objectForKey:@"pay_amount" defaultValue:@"0"];
            [shopArray addObject:shopInfo];
        }
        self.shoppingList = [shopArray copy];
    }
    
    
    
    if ([[dict allKeys] containsObject:@"adds"]) {
        
        NSDictionary *additionalDict = [dict objectForKey:@"adds" defaultValue:@"0"];
        NSDictionary *addDict1 = [additionalDict objectForKey:@"list" defaultValue:@"0"];
        NSMutableArray *additionalArray = [NSMutableArray array];
        for (NSDictionary *dict0 in addDict1) {
            WLBillShoppingInfo *shopInfo = [[WLBillShoppingInfo alloc] initWithDict:dict0 shopping:NO];
            shopInfo.payAmount = [additionalDict objectForKey:@"pay_amount" defaultValue:@"0"];
            [additionalArray addObject:shopInfo];
        }
        self.additionalList = [additionalArray copy];
    }
    
    
    return self;
}

@end
