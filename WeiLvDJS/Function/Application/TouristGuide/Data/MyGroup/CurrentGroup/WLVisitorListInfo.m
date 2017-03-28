//
//  WLVisitorListInfo.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLVisitorListInfo.h"
#import "NSDictionary+DefaultValue.h"

@implementation WLVisitorListHeaderInfo
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.orderID          = [dict objectForKey:@"order_id" defaultValue:@"0"];
    self.lineName         = [dict objectForKey:@"line_name" defaultValue:@"0"];
    self.comeDate         = [dict objectForKey:@"come_date" defaultValue:@"0"];
    self.lineID           = [dict objectForKey:@"line_id" defaultValue:@"0"];
    
    
    return self;
}


@end

@implementation WLVisitorListCellInfo
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.orderID           = [dict objectForKey:@"order_id" defaultValue:@"0"];
    self.visitorID         = [dict objectForKey:@"visitor_id" defaultValue:@"0"];
    self.phoneNO           = [dict objectForKey:@"phone" defaultValue:@"0"];
    self.name              = [dict objectForKey:@"name" defaultValue:@"0"];
    self.peopleCount       = [dict objectForKey:@"num" defaultValue:@"0"];
    
    
    return self;
}


@end

@implementation WLVisitorListInfo
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    NSArray *dictArray = [dict objectForKey:@"list"];
    NSMutableArray *objectArray = [NSMutableArray array];
    for (NSDictionary *dict0 in dictArray) {
        
        WLVisitorListCellInfo *cellInfo = [[WLVisitorListCellInfo alloc] initWithDict:dict0];
        [objectArray addObject:cellInfo];
    }
    self.list = [objectArray copy];
    
    self.headerInfo = [[WLVisitorListHeaderInfo alloc] initWithDict:[dict objectForKey:@"top"]];
    
    return self;
}
@end
