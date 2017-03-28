//
//  WLMyIncomeListInfo.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLOrderListInfo.h"

@interface WLMyIncomeDateInfo : NSObject
@property (nonatomic, copy)   NSString *month;//月份
@property (nonatomic, copy)   NSString *income;//收入


- (instancetype)initWithDict:(NSDictionary*)dict;
@end

@interface WLMyIncomeListInfo : NSObject
@property (nonatomic, strong)   NSArray *orderList;//订单列表，WLOrderListInfo
@property (nonatomic, strong)   NSArray *incomeList;//按月统计的收入，WLMyIncomeDateInfo


- (instancetype)initWithDict:(NSDictionary*)dict hasDate:(BOOL)hasDate;
@end
