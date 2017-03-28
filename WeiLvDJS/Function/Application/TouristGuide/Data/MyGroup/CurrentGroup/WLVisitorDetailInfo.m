//
//  WLVisitorDetailInfo.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLVisitorDetailInfo.h"
#import "NSDictionary+DefaultValue.h"

@implementation WLVisitorDetailInfo

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.name              = [dict objectForKey:@"name" defaultValue:@"0"];
    self.phoneNO           = [dict objectForKey:@"phone" defaultValue:@"0"];
    self.IDNO              = [dict objectForKey:@"id_card" defaultValue:@"0"];
    self.orderID           = [dict objectForKey:@"order_id" defaultValue:@"0"];
    self.lineName          = [dict objectForKey:@"line_name" defaultValue:@"0"];
    self.adults            = [dict objectForKey:@"adults" defaultValue:@"0"];
    self.comeDate          = [dict objectForKey:@"come_date" defaultValue:@"0"];
    self.comePlace         = [dict objectForKey:@"come_to" defaultValue:@"0"];
    self.backDate          = [dict objectForKey:@"return_date" defaultValue:@"0"];
    self.backPlace         = [dict objectForKey:@"return_from" defaultValue:@"0"];
    self.remark            = [dict objectForKey:@"remark" defaultValue:@"0"];
    self.customerName      = [dict objectForKey:@"customer_name" defaultValue:@"0"];
    self.contactName       = [dict objectForKey:@"contacts_name" defaultValue:@"0"];
    self.contactPhoneNO    = [dict objectForKey:@"contacts_mobile" defaultValue:@"0"];
    return self;
}
@end
