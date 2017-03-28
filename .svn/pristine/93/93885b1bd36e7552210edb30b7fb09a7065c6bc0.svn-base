//
//  WLTradeRecordListObject.m
//  WeiLvDJS
//
//  Created by ternence on 2017/1/4.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLTradeRecordListObject.h"
#import "NSDictionary+DefaultValue.h"
#import "WLTradeRecordObject.h"

@implementation WLTradeRecordListObject
- (instancetype)initWithDict:(NSDictionary *)dic
{
    self = [super init];

    self.current_date      = [dic objectForKey:@"current_date" defaultValue:@"0"];
    self.income            = [dic objectForKey:@"income" defaultValue:@"0"];
    self.expenditure       = [dic objectForKey:@"expenditure" defaultValue:@"0"];
    
    NSArray *dictArray = [dic objectForKey:@"items" defaultValue:[NSArray array]];
    NSMutableArray *objectTrendArray = [NSMutableArray array];
    if ([dictArray isKindOfClass:[NSArray class]]) {
        
        for (NSDictionary *dict in dictArray) {
            WLTradeRecordObject *object = [WLTradeRecordObject mj_objectWithKeyValues:dict];
            object.tradeID = [dict objectForKey:@"id"];
            [objectTrendArray addObject:object];
        }
        self.items = [objectTrendArray copy];
    }
    
    return self;
}
@end
