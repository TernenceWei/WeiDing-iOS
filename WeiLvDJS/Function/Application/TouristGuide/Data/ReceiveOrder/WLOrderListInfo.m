//
//  WLOrderListInfo.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/12.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLOrderListInfo.h"
#import "NSDictionary+DefaultValue.h"

@implementation WLOrderListInfo
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.checkListID          = [dict objectForKey:@"checklist_id" defaultValue:@"0"];
    self.resourceID           = [dict objectForKey:@"resource_id" defaultValue:@"0"];
    self.lineName             = [dict objectForKey:@"line_name" defaultValue:@"0"];
    self.checkPrice           = [dict objectForKey:@"check_price" defaultValue:@"0"];
    self.minRate              = [dict objectForKey:@"_min_rate" defaultValue:@"0"];
    self.maxRate              = [dict objectForKey:@"_max_rate" defaultValue:@"0"];
    self.groupListID          = [dict objectForKey:@"grouplist_id" defaultValue:@"0"] ;
    self.mainGuide            = [dict objectForKey:@"extend_attribute" defaultValue:@"0"];
    self.type                 = [dict objectForKey:@"type" defaultValue:@"0"];
    self.guideNums            = [dict objectForKey:@"guide_nums" defaultValue:@"0"];
    self.receiveDate          = [dict objectForKey:@"receive_date" defaultValue:@"0"];
    self.adults               = [dict objectForKey:@"adults" defaultValue:@"0"];
    self.sendDate             = [dict objectForKey:@"send_date" defaultValue:@"0"];
    self.acceptOrderDate      = [dict objectForKey:@"accept_order_date" defaultValue:@"0"];
    self.endDate              = [dict objectForKey:@"end_date" defaultValue:@"0"];
    self.submitDate           = [dict objectForKey:@"submit_date" defaultValue:@"0"];
    self.auditDate            = [dict objectForKey:@"audit_date" defaultValue:@"0"];
    self.settlementDate       = [dict objectForKey:@"settlement_date" defaultValue:@"0"];
    self.companyName          = [dict objectForKey:@"company_name" defaultValue:@"0"];
    self.groupNumber          = [dict objectForKey:@"group_number" defaultValue:@"0"];
    self.groupListStatus      = [[dict objectForKey:@"_dj_grouplist_status" defaultValue:@"0"] integerValue];
    self.checkListStatus      = [[dict objectForKey:@"_dj_checklist_status" defaultValue:@"0"] integerValue];
    self.expiryDate           = [dict objectForKey:@"expiry_date" defaultValue:@"0"];
    
    self.children             = [dict objectForKey:@"children" defaultValue:@"0"];
    self.journeyStatus        = [[dict objectForKey:@"journey_status" defaultValue:@"0"] integerValue];
    
    self.income               = [dict objectForKey:@"amount" defaultValue:@"0"];
    self.shoppingRebate       = [dict objectForKey:@"shopping_rebate" defaultValue:@"0"];
    self.additionalRebate     = [dict objectForKey:@"spots_rebate" defaultValue:@"0"];
    self.returnRate           = [dict objectForKey:@"return_rate" defaultValue:@"0"];
    self.orderReturnRate      = [dict objectForKey:@"_out_fanli_rate" defaultValue:@"0"];
    self.startCity            = [dict objectForKey:@"start_city" defaultValue:@"0"];
    return self;
}
@end
