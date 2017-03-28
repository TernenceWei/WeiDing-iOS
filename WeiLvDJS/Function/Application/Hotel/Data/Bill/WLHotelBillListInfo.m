//
//  WLHotelBillListInfo.m
//  WeiLvDJS
//
//  Created by ternence on 16/11/16.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLHotelBillListInfo.h"
#import "NSDictionary+DefaultValue.h"

@implementation WLHotelBillListItemInfo
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.groupNO             = [dict objectForKey:@"group_number" defaultValue:@"0"];
    self.djCompanyID         = [dict objectForKey:@"dj_company_id" defaultValue:@"0"];
    self.checkerID           = [dict objectForKey:@"checker_id" defaultValue:@"0"];
    self.grouplistID         = [dict objectForKey:@"grouplist_id" defaultValue:@"0"];
    self.price               = [dict objectForKey:@"price" defaultValue:@"0"];
    self.cDate               = [dict objectForKey:@"cdate" defaultValue:@"0"];
    
    
    return self;
}

@end

@implementation WLHotelBillListInfo
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.ymDate           = [dict objectForKey:@"ymdate" defaultValue:@"0"];
    self.totalPrice         = [dict objectForKey:@"sum_price" defaultValue:@"0"];
    
    NSArray *array1 = [dict objectForKey:@"data" defaultValue:[NSArray array]];
    if ([array1 isKindOfClass:[NSArray class]]) {
        NSMutableArray *companyArray= [NSMutableArray array];
        for (NSDictionary *dict in array1) {
            WLHotelBillListItemInfo *info = [[WLHotelBillListItemInfo alloc] initWithDict:dict];
            [companyArray addObject:info];
            
        }
        self.listArray = [companyArray copy];
    }

    return self;
}

@end
