//
//  WLMyIncomeListInfo.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLMyIncomeListInfo.h"
#import "NSDictionary+DefaultValue.h"

@implementation WLMyIncomeDateInfo
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.month         = [dict objectForKey:@"years_month" defaultValue:@"0"];
    self.income        = [dict objectForKey:@"month_rebate" defaultValue:@"0"];
    
    return self;
}


@end

@implementation WLMyIncomeListInfo
- (instancetype)initWithDict:(NSDictionary *)dict hasDate:(BOOL)hasDate
{
    self = [super init];
    
    NSMutableArray *dictArray = [NSMutableArray array];
    if (hasDate) {//上个月的收入
        dictArray = [dict objectForKey:@"select_month_groupList" defaultValue:[NSMutableArray array]];
        
    }else{//本月收入
        dictArray = [dict objectForKey:@"now_month_groupList" defaultValue:[NSMutableArray array]];
        
        NSArray *monthArray = [dict objectForKey:@"every_month_avg" defaultValue:[NSArray array]];
        NSMutableArray *objectArray1 = [NSMutableArray array];
        for (NSDictionary *dict in monthArray) {
            WLMyIncomeDateInfo *info = [[WLMyIncomeDateInfo alloc] initWithDict:dict];
            [objectArray1 addObject:info];
        }
        self.incomeList = [objectArray1 copy];
        
    }
    
    NSMutableArray *objectArray = [NSMutableArray array];
    if (![dictArray isKindOfClass:[NSString class]]) {
        for (NSDictionary *dict in dictArray) {
            WLOrderListInfo *info = [[WLOrderListInfo alloc] initWithDict:dict];
            [objectArray addObject:info];
        }
        self.orderList = [objectArray copy];
    }
    
    
    return self;
}
@end
