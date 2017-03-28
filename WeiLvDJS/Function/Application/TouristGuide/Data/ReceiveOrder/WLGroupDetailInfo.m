//
//  WLGroupDetailInfo.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/12.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLGroupDetailInfo.h"
#import "NSDictionary+DefaultValue.h"

@implementation WLSubLineInfo
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.lineName        = [dict objectForKey:@"line_name" defaultValue:@"0"];
    NSString *adults     = [dict objectForKey:@"adults" defaultValue:@"0"];
    NSString *children   = [dict objectForKey:@"children" defaultValue:@"0"];
    self.peopleCount     = [adults stringByAppendingFormat:@"+%@",children];
    self.comeDate        = [dict objectForKey:@"come_date" defaultValue:@"0"];
    NSString *comeProv   = [dict objectForKey:@"come_province" defaultValue:@"0"];
    NSString *comeCity   = [dict objectForKey:@"come_city" defaultValue:@"0"];
    self.comeAddress     = [comeProv stringByAppendingFormat:@"%@",comeCity];
    self.backDate        = [dict objectForKey:@"return_date" defaultValue:@"0"];
    NSString *backProv   = [dict objectForKey:@"return_province" defaultValue:@"0"];
    NSString *backCity   = [dict objectForKey:@"return_city" defaultValue:@"0"];
    self.backAddress     = [backProv stringByAppendingFormat:@"%@",backCity];
    
    return self;
}


@end

@implementation WLGroupDetailInfo
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.groupListName        = [dict objectForKey:@"groupListName" defaultValue:@"0"];
    self.peopleNums           = [dict objectForKey:@"people_num" defaultValue:@"0"];
    self.guideMoney           = [dict objectForKey:@"guide_money" defaultValue:@"0"];
    self.spareMoney           = [dict objectForKey:@"spare_money" defaultValue:@"0"];
    self.companyName          = [dict objectForKey:@"company_name" defaultValue:@"0"];
    self.returnRate           = [dict objectForKey:@"return_rate" defaultValue:@"0"];
    self.remark               = [dict objectForKey:@"remark" defaultValue:@"0"] ;
    self.sendTime             = [dict objectForKey:@"send_time" defaultValue:@"0"];
    self.orderStatus          = [dict objectForKey:@"status" defaultValue:@"0"];
    self.statusInfo           = [dict objectForKey:@"start_sign" defaultValue:@"0"];
    self.groupStatus          = [dict objectForKey:@"trip_sign" defaultValue:@"0"];
    self.expiryDate           = [dict objectForKey:@"expiry_date" defaultValue:@"0"];
    
    self.acceptTime           = [dict objectForKey:@"accept_time" defaultValue:@"0"];
    self.checklistID          = [dict objectForKey:@"checklist_id" defaultValue:@"0"];
    self.grouplistID          = [dict objectForKey:@"grouplist_id" defaultValue:@"0"];
    self.expiryTime           = [dict objectForKey:@"expiry_time" defaultValue:@"0"];
    self.isActivated          = [dict objectForKey:@"is_activated" defaultValue:@"0"];
    self.refuseReason         = [dict objectForKey:@"revoke_reason" defaultValue:@"0"];
    
    NSArray *dictArray = [dict objectForKey:@"group_list"];
    NSMutableArray *objectArray = [NSMutableArray array];
    for (NSDictionary *dict in dictArray) {
        WLSubLineInfo *info = [[WLSubLineInfo alloc] initWithDict:dict];
        [objectArray addObject:info];
    }
    self.lineArray = [objectArray copy];
    
    return self;
}
@end
