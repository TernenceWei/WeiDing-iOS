//
//  WLHotelBillDetailInfo.m
//  WeiLvDJS
//
//  Created by ternence on 16/11/16.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLHotelBillDetailInfo.h"
#import "NSDictionary+DefaultValue.h"

@implementation WLHotelBillDetailItemInfo
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.paymentTerm        = [dict objectForKey:@"payment_term" defaultValue:@"0"];
    self.checkPrice         = [dict objectForKey:@"check_price" defaultValue:@"0"];
    self.pricelistName      = [dict objectForKey:@"pricelist_name" defaultValue:@"0"];
    self.checkCount         = [dict objectForKey:@"check_count" defaultValue:@"0"];
    self.payDate            = [dict objectForKey:@"pay_date" defaultValue:@"0"];
    self.actualPrice        = [dict objectForKey:@"actual_price" defaultValue:@"0"];
    self.actualCountPrice   = [dict objectForKey:@"actual_count_price" defaultValue:@"0"];
    self.settlementMode     = [[dict objectForKey:@"settlement_mode" defaultValue:@"0"] integerValue];
    self.orderNO            = [dict objectForKey:@"order_number" defaultValue:@"0"];
    self.checkCountPrice    = [dict objectForKey:@"check_count_price" defaultValue:@"0"];
    self.actualCount        = [dict objectForKey:@"actual_count" defaultValue:@"0"];
    
    return self;
}

@end

@implementation WLHotelBillDetailInfo
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.companyName      = [dict objectForKey:@"company_name" defaultValue:@"0"];
    self.groupNO         = [dict objectForKey:@"group_number" defaultValue:@"0"];
    self.whichDate            = [dict objectForKey:@"which_date" defaultValue:@"0"];
    self.realName        = [dict objectForKey:@"real_name" defaultValue:@"0"];
    self.userMobile   = [dict objectForKey:@"user_mobile" defaultValue:@"0"];
    self.checkoutDate     = [dict objectForKey:@"check_out_date" defaultValue:@"0"];
    self.checkPayPrice            = [dict objectForKey:@"check_pay_price" defaultValue:@"0"];
    self.actualPayPrice    = [dict objectForKey:@"actual_pay_price" defaultValue:@"0"];
    
    NSArray *array1 = [dict objectForKey:@"data" defaultValue:[NSArray array]];
    if ([array1 isKindOfClass:[NSArray class]]) {
        NSMutableArray *companyArray= [NSMutableArray array];
        for (NSDictionary *dict in array1) {
            WLHotelBillDetailItemInfo *info = [[WLHotelBillDetailItemInfo alloc] initWithDict:dict];
            [companyArray addObject:info];
            
        }
        self.itemList = [companyArray copy];
    }
    
    return self;
}

@end
