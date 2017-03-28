//
//  WLHotelBillDetailInfo.h
//  WeiLvDJS
//
//  Created by ternence on 16/11/16.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLHotelBillDetailItemInfo : NSObject
@property (nonatomic, copy)   NSString *paymentTerm;//账期时间
@property (nonatomic, copy)   NSString *checkPrice;//计调金额
@property (nonatomic, copy)   NSString *pricelistName;//
@property (nonatomic, copy)   NSString *checkCount;//计调数量
@property (nonatomic, copy)   NSString *payDate;//结算时间
@property (nonatomic, copy)   NSString *actualPrice;//实际金额
@property (nonatomic, copy)   NSString *actualCountPrice;//实际总金额
@property (nonatomic, assign) NSUInteger settlementMode;//结算方式，1现付，2挂账
@property (nonatomic, copy)   NSString *orderNO;//
@property (nonatomic, copy)   NSString *checkCountPrice;//计调总金额
@property (nonatomic, copy)   NSString *actualCount;//实际数量
- (instancetype)initWithDict:(NSDictionary *)dict;
@end

@interface WLHotelBillDetailInfo : NSObject
@property (nonatomic, copy)   NSString *companyName;//地接社名称
@property (nonatomic, copy)   NSString *groupNO;//
@property (nonatomic, copy)   NSString *whichDate;//入住日期
@property (nonatomic, copy)   NSString *realName;//计调名称
@property (nonatomic, copy)   NSString *userMobile;//手机
@property (nonatomic, copy)   NSString *checkoutDate;//离店日期
@property (nonatomic, copy)   NSString *checkPayPrice;//计调合计
@property (nonatomic, copy)   NSString *actualPayPrice;//实际合计
@property (nonatomic, strong) NSArray *itemList;//
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
