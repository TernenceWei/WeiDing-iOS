//
//  WLIncomeStatisInfo.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLIncomeStatisInfo.h"
#import "NSDictionary+DefaultValue.h"

@implementation WLIncomeCompanyInfo
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.companyName        = [dict objectForKey:@"name" defaultValue:@"0"];
    self.percent            = [dict objectForKey:@"percent" defaultValue:@"0"];
    self.income             = [dict objectForKey:@"amount" defaultValue:@"0"];
    
    return self;
}


@end

@implementation WLIncomeMonthInfo
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.month             = [dict objectForKey:@"month" defaultValue:@"0"];
    self.income            = [dict objectForKey:@"income_amount" defaultValue:@"0"];
    return self;
}


@end

@implementation WLIncomeStatisInfo
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.totalIncome        = [dict objectForKey:@"income_amount" defaultValue:@"0"];
    self.year        = [dict objectForKey:@"year" defaultValue:@"0"];
    
    NSArray *array1 = [dict objectForKey:@"company" defaultValue:@"0"];
    if ([array1 isKindOfClass:[NSArray class]]) {
        NSMutableArray *companyArray= [NSMutableArray array];
        for (NSDictionary *dict in array1) {
            WLIncomeCompanyInfo *info = [[WLIncomeCompanyInfo alloc] initWithDict:dict];
            [companyArray addObject:info];
            
        }
        self.companyList = [companyArray copy];
    }
    
    NSArray *array2 = [dict objectForKey:@"bill" defaultValue:@"0"];
    NSMutableArray *billArray= [NSMutableArray array];
    for (NSDictionary *dict in array2) {
        WLIncomeMonthInfo *info = [[WLIncomeMonthInfo alloc] initWithDict:dict];
        [billArray addObject:info];
        
    }
    self.billList = [billArray copy];
    return self;
}
@end
