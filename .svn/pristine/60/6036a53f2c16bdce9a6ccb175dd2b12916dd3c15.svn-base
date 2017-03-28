//
//  WLHotelOrderInfo.m
//  WeiLvDJS
//
//  Created by ternence on 16/11/15.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLHotelOrderInfo.h"
#import "NSDictionary+DefaultValue.h"

@implementation WLHotelOrderInfo
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.checkCount           = [dict objectForKey:@"check_count" defaultValue:@"0"];
    self.checkoutDate         = [dict objectForKey:@"check_out_date" defaultValue:@"0"];
    self.checkPrice           = [dict objectForKey:@"check_price" defaultValue:@"0"];
    self.checkListID          = [dict objectForKey:@"checklist_id" defaultValue:@"0"];
    self.djCompany            = [dict objectForKey:@"dj_company" defaultValue:@"0"];
    self.djCompanyPhone       = [dict objectForKey:@"dj_company_phone" defaultValue:@"0"];
    self.expiryDate           = [dict objectForKey:@"expiry_date" defaultValue:@"0"] ;
    self.forcastPrice         = [dict objectForKey:@"forecast_price" defaultValue:@"0"];
    self.forcastCount         = [dict objectForKey:@"forecast_count" defaultValue:@"0"];
    self.forcastPriceCount    = [dict objectForKey:@"forecast_price_count" defaultValue:@"0"];
    self.groupNO              = [dict objectForKey:@"group_number" defaultValue:@"0"];
    self.orderNO              = [dict objectForKey:@"order_number" defaultValue:@"0"];
    self.isBidding            = [[dict objectForKey:@"is_bidding" defaultValue:@"0"] boolValue];
    self.isSplitSend          = [[dict objectForKey:@"is_split_send" defaultValue:@"0"] boolValue];
    self.isSplitAccept        = [[dict objectForKey:@"is_split_accept" defaultValue:@"0"] boolValue];
    self.priceListName        = [dict objectForKey:@"pricelist_name" defaultValue:@"0"];
    self.sendOrderDate        = [dict objectForKey:@"send_order_date" defaultValue:@"0"];
    self.whichDate            = [dict objectForKey:@"which_date" defaultValue:@"0"];
    self.dispatchExpiryDate   = [dict objectForKey:@"dispatch_expiry_date" defaultValue:@"0"];
    self.realName             = [dict objectForKey:@"real_name" defaultValue:@"0"];
    self.userMobile           = [dict objectForKey:@"user_mobile" defaultValue:@"0"];
    self.status               = [[dict objectForKey:@"status" defaultValue:@"0"] integerValue];
    self.jdCompany            = [dict objectForKey:@"jd_company" defaultValue:@"0"];
    self.jdCompanyPhone       = [dict objectForKey:@"jd_company_phone" defaultValue:@"0"];
    self.gCompanyID           = [dict objectForKey:@"g_company_id" defaultValue:@"0"];
    self.resourceCompanyID    = [dict objectForKey:@"resource_company_id" defaultValue:@"0"];
    self.isOpen = @"1";
    self.checkPriceCount      = [dict objectForKey:@"check_price_count" defaultValue:@"0"];
    self.dispatchStatus       = [dict objectForKey:@"dispatch_status" defaultValue:@"0"];
    self.checkerID            = [dict objectForKey:@"checker_id" defaultValue:@"0"];
    
    self.rz_status            = [[dict objectForKey:@"rz_status" defaultValue:@"0"] boolValue];
    self.type_status          = [[dict objectForKey:@"type_status" defaultValue:@"0"] integerValue];
    
    return self;
}

@end
