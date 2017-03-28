//
//  WLDriverBillStatisticsObject.h
//  WeiLvDJS
//
//  Created by ternence on 2016/12/28.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLDriverBillStatisticsProportionObject : NSObject
@property (nonatomic, copy)   NSString *percent;
@property (nonatomic, copy)   NSString *price;
@property (nonatomic, copy)   NSString *company_name;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end

@interface WLDriverBillStatisticsTrendObject : NSObject
@property (nonatomic, copy)   NSString *year;
@property (nonatomic, copy)   NSString *price;
@property (nonatomic, copy)   NSString *month;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end

@interface WLDriverBillStatisticsObject : NSObject
@property (nonatomic, copy)   NSString *year;
@property (nonatomic, copy)   NSString *totalPrice;
@property (nonatomic, strong) NSArray *proportionArray;
@property (nonatomic, strong) NSArray *trendArray;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
