//
//  WLDriverBillListObject.h
//  WeiLvDJS
//
//  Created by ternence on 2016/12/28.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLDriverBillItemObject : NSObject
@property (nonatomic, copy)   NSString *orderID;//订单id
@property (nonatomic, copy)   NSString *start_at;//出发时间
@property (nonatomic, copy)   NSString *end_at;//到达时间
@property (nonatomic, copy)   NSString *order_price;//派单价
@property (nonatomic, copy)   NSString *trip_end_at;//行程结束时间
@property (nonatomic, copy)   NSString *no_pay;//待支付
@property (nonatomic, copy)   NSString *pay;//已支付
@property (nonatomic, copy)   NSString *pay_at;//结算时间
@property (nonatomic, copy)   NSString *actual_pay;//实际支付

@property (nonatomic, assign)   NSInteger order_type;//
@property (nonatomic, copy)   NSString *driver_price;//
@property (nonatomic, copy)   NSString *dispatch_price;//

@property (nonatomic, copy)   NSString *no_confirm;//
@property (nonatomic, copy)   NSString *is_local;//

- (instancetype)initWithDict:(NSDictionary *)dict;
@end

@interface WLDriverBillListObject : NSObject

@property (nonatomic, copy)   NSString *pay;//累计
@property (nonatomic, copy)   NSString *no_pay;//待支付
@property (nonatomic, copy)   NSString *date;//时间
@property (nonatomic, copy)   NSString *year;
@property (nonatomic, copy)   NSString *month;
@property (nonatomic, strong) NSArray *items;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
