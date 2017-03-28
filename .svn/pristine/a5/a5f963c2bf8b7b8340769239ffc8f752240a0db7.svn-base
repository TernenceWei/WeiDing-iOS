//
//  WLIncomeStatisInfo.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLIncomeCompanyInfo : NSObject
@property (nonatomic, copy)   NSString *companyName;//旅行社名称
@property (nonatomic, copy)   NSString *percent;//比例
@property (nonatomic, copy)   NSString *income;//收入

- (instancetype)initWithDict:(NSDictionary*)dict;
@end

@interface WLIncomeMonthInfo : NSObject
@property (nonatomic, copy)   NSString *month;//月份
@property (nonatomic, copy)   NSString *income;//收入

- (instancetype)initWithDict:(NSDictionary*)dict;
@end

@interface WLIncomeStatisInfo : NSObject
@property (nonatomic, copy)   NSString *totalIncome;//总收入
@property (nonatomic, copy)   NSString *year;//年份
@property (nonatomic, strong) NSArray *companyList;//旅行社统计
@property (nonatomic, strong) NSArray *billList;//按月统计

- (instancetype)initWithDict:(NSDictionary*)dict;
@end
