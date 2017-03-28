//
//  WLBillDetailInfo.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/14.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLTouristGroupHeader.h"

@interface WLBillFailMessageInfo : NSObject
@property (nonatomic, copy)   NSString *itemName;
@property (nonatomic, copy)   NSString *itemType;
@property (nonatomic, copy)   NSString *message;

- (instancetype)initWithDict:(NSDictionary*)dict;
@end

@interface WLBillCarInfo : NSObject
@property (nonatomic, copy)   NSString *orderID;
@property (nonatomic, copy)   NSString *date;//日期
@property (nonatomic, copy)   NSString *companyName;//公司名称
@property (nonatomic, copy)   NSString *actualSpend;//实际消费
@property (nonatomic, copy)   NSString *actualPay;//实际现付
@property (nonatomic, copy)   NSString *payAmount;//现付总金额

- (instancetype)initWithDict:(NSDictionary*)dict;
@end

@interface WLBillHotelInfo : NSObject
@property (nonatomic, copy)   NSString *checkListID;
@property (nonatomic, copy)   NSString *itemType;
@property (nonatomic, copy)   NSString *date;//日期
@property (nonatomic, copy)   NSString *companyName;//公司名称
@property (nonatomic, assign) PaymentMode payMode;//支付方式
@property (nonatomic, copy)   NSString *actualSpend;//实际消费
@property (nonatomic, copy)   NSString *payAmount;//现付总金额

- (instancetype)initWithDict:(NSDictionary*)dict;
@end

@interface WLBillShoppingInfo : NSObject
@property (nonatomic, copy)   NSString *checkListID;
@property (nonatomic, copy)   NSString *resourceID;
@property (nonatomic, copy)   NSString *itemType;
@property (nonatomic, copy)   NSString *guideID;
@property (nonatomic, copy)   NSString *date;//日期
@property (nonatomic, copy)   NSString *companyName;//公司名称
@property (nonatomic, copy)   NSString *actualSpend;//实际消费,加点项目为结余
@property (nonatomic, copy)   NSString *rate;//返点
@property (nonatomic, copy)   NSString *cashBack;//应返现
@property (nonatomic, copy)   NSString *payAmount;//返现总金额
- (instancetype)initWithDict:(NSDictionary*)dict shopping:(BOOL)shopping;
@end



@interface WLBillDetailInfo : NSObject
@property (nonatomic, copy)   NSString *imprestShouKuan;//备用金收款
@property (nonatomic, copy)   NSString *imprestXianFu;//备用金现付
@property (nonatomic, copy)   NSString *imprestChaoE;//备用金超额
@property (nonatomic, copy)   NSString *shopSpend;//购物店消费
@property (nonatomic, copy)   NSString *shopRebate;//购物店返点
@property (nonatomic, copy)   NSString *shopBack;//购物店返现
@property (nonatomic, copy)   NSString *additionalTotal;//加点总结余
@property (nonatomic, copy)   NSString *additionalPerson;//加点个人结余
@property (nonatomic, copy)   NSString *additionalBack;//加点个人返现
@property (nonatomic, copy)   NSString *serviceFree;//导服费
@property (nonatomic, copy)   NSString *settle;//剩余待结算

@property (nonatomic, strong) NSArray *hotelList;
@property (nonatomic, strong) NSArray *mealList;
@property (nonatomic, strong) NSArray *carList;
@property (nonatomic, strong) NSArray *playList;
@property (nonatomic, strong) NSArray *shoppingList;
@property (nonatomic, strong) NSArray *additionalList;

@property (nonatomic, strong) NSArray *failMessage;//审核失败原因
@property (nonatomic, copy)   NSString *failDate;//审核失败时间
@property (nonatomic, copy)   NSString *additionalRebate;//加点返点
@property (nonatomic, assign) GroupStatus status;//状态
@property (nonatomic, copy)   NSString *companyName;
@property (nonatomic, copy)   NSString *groupNO;
- (instancetype)initWithDict:(NSDictionary*)dict;
@end
