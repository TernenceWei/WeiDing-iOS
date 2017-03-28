//
//  WLHotelOrderInfo.h
//  WeiLvDJS
//
//  Created by ternence on 16/11/15.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLTouristGroupHeader.h"

@interface WLHotelOrderInfo : NSObject
@property (nonatomic, copy)   NSString *checkCount;//计调数量
@property (nonatomic, copy)   NSString *checkPrice;//计调价格
@property (nonatomic, copy)   NSString *checkPriceCount;//计调总金额
@property (nonatomic, copy)   NSString *checkerID;//计调ID
@property (nonatomic, copy)   NSString *dispatchStatus;//计调ID

@property (nonatomic, copy)   NSString *checkoutDate;//离店日期

@property (nonatomic, copy)   NSString *checkListID;//订单id
@property (nonatomic, copy)   NSString *djCompany;//地接社公司
@property (nonatomic, copy)   NSString *djCompanyPhone;//地接社电话
@property (nonatomic, copy)   NSString *expiryDate;//派单的失效日期
@property (nonatomic, copy)   NSString *forcastPrice;//报价金额
@property (nonatomic, copy)   NSString *forcastCount;//报价数量
@property (nonatomic, copy)   NSString *forcastPriceCount;//报价总金额
@property (nonatomic, copy)   NSString *groupNO;//团号
@property (nonatomic, copy)   NSString *orderNO;//订单号
@property (nonatomic, assign) BOOL isBidding;//是否为竞价单
@property (nonatomic, assign) BOOL isSplitSend;//是否允许拆单，由派单者确定
@property (nonatomic, assign) NSInteger isSplitAccept;//是否允许拆单,由竞价者确定
@property (nonatomic, copy)   NSString *priceListName;//栏目名称
@property (nonatomic, copy)   NSString *sendOrderDate;//派单日期
@property (nonatomic, copy)   NSString *whichDate;//入住日期
@property (nonatomic, copy)   NSString *dispatchExpiryDate;//报价有效期
@property (nonatomic, copy)   NSString *realName;//计调联系人
@property (nonatomic, copy)   NSString *userMobile;//计调联系电话

@property (nonatomic, assign) BOOL rz_status; //// 是否入住
@property (nonatomic, assign) NSInteger type_status;//0未确认（未接单） 1超时 2竞价失败 3订单被取消 4拒绝接单 5取消报价 6已确认（已接单）

@property (nonatomic, assign) NSUInteger status;//
@property (nonatomic, copy)   NSString *jdCompany;//
@property (nonatomic, copy)   NSString *jdCompanyPhone;//
@property (nonatomic, copy)   NSString *gCompanyID;//
@property (nonatomic, copy)   NSString *resourceCompanyID;//
@property (nonatomic, copy)   NSString *isOpen;//


- (instancetype)initWithDict:(NSDictionary*)dict;
@end
