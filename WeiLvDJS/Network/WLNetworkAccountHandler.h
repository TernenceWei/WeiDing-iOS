//
//  WLNetworkAccountHandler.h
//  WeiLvDJS
//
//  Created by ternence on 16/12/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLNetworkTool.h"

typedef NS_ENUM (NSUInteger, WLDepositingStatus){
    WLDepositingStatusUnShenhe             = 1,        //待审核
    WLDepositingStatusUnFukuan             = 2,        //待付款
    WLDepositingStatusTixianSuccess        = 3,        //提现成功
    WLDepositingStatusTixianRefuse         = 4,        //提现拒绝
    WLDepositingStatusDefault              = 0,        //全部
};

typedef NS_ENUM (NSUInteger, WLTradeRecordType){
    WLTradeRecordTypeRecharge             = 1,        //充值
    WLTradeRecordTypeDeposit              = 2,        //提现
    WLTradeRecordTypeSpareMoney           = 5,        //备用金
    WLTradeRecordTypeMemberShipMoney      = 6,        //团费
    WLTradeRecordTypeOrderPay             = 7,        //订单支付
    WLTradeRecordTypeStoreOrderPay        = 8,        //店铺订单支付
    WLTradeRecordTypeStoreOrderBack       = 9,        //店铺订单退款
    WLTradeRecordTypeStaffPay             = 10,        //员工提成
    WLTradeRecordTypeDriverOrderPay       = 11,        //司机订单支付
    WLTradeRecordTypeGrabOrderPay         = 12,        //抢单到账金额
    WLTradeRecordTypeCarBookingOrderPay   = 14,        //叫车单支付
};

typedef NS_ENUM (NSUInteger, WLPaymentMode){
    WLPaymentModeAlipay             = 1,        //支付宝充值,资金账户
    WLPaymentModeWeixin             = 2,        //微信充值，资金账户
    WLPaymentModeAlipayOrder        = 3,        //支付宝支付，叫车
    WLPaymentModeWeixinOrder        = 4,        //微信支付，叫车
};


@interface WLNetworkAccountHandler : NSObject

/**
 获取资金账户信息
 */
+ (void)requestFundAccountWithResultBlock:(CompletionDataBlock)dataBlock;

/**
 获取冻结金额
 */
+ (void)requestFrozenAccountWithResultBlock:(void(^)(WLResponseType responseType, NSString *frozenCount, NSString *depositCount, NSString *carFrozenCount, NSString *message))dataBlock;

/**
 获取冻结表
 @param dataBlock
 */
+ (void)requestFrozenListWithResultBlock:(CompletionDataBlock)dataBlock;

/**
 获取提现列表

 @param status WLDepositingStatus
 @param dataBlock
 */
+ (void)requestDepositingListWithDepositingStatus:(WLDepositingStatus)status
                                      resultBlock:(CompletionDataBlock)dataBlock;


/**
 获取交易列表
 */
+ (void)requestTradeRecordListWithResultBlock:(CompletionDataBlock)dataBlock;


/**
 筛选交易列表

 @param tradeType tradeType
 */
+ (void)requestTradeRecordListWithTradeType:(WLTradeRecordType)tradeType resultBlock:(CompletionDataBlock)dataBlock;


/**
 获取交易详情

 @param tradeType tradeType
 @param tradeID tradeID
 @param dataBlock
 */
+ (void)requestTradeRecordDetailWithTradeType:(WLTradeRecordType)tradeType tradeID:(NSString *)tradeID resultBlock:(CompletionDataBlock)dataBlock;

/**
 实名认证
 
 @param name 真实姓名
 @param IDCard 身份证号
 @param operationBlock 操作是否成功
 */
+ (void)authenticateRealNameWithName:(NSString *)name
                              IDCard:(NSString *)IDCard
                      operationBlock:(OperationBlock)operationBlock;


/**
 绑定银行卡
 
 @param bankOwner 持卡人
 @param bankName 银行名称
 @param branchBankName 支行名称
 @param bankCard 卡号
 @param operationBlock 操作是否成功
 */
+ (void)bindBankCardWithBankName:(NSString *)bankName
                   branchBankName:(NSString *)branchBankName
                        bankCard:(NSString *)bankCard
                          cityID:(NSString *)cityID
                   operationBlock:(OperationBlock)operationBlock;


/**
 获取绑定的银行卡信息
 */
+ (void)requestBankListWithResultBlock:(CompletionDataBlock)dataBlock;

/**
 获取绑定的银行卡信息
 */
+ (void)requestBindBankInfoWithResultBlock:(CompletionDataBlock)dataBlock;


/**
设置支付密码
*/
+ (void)setPaymentCodeWithPassword:(NSString *)password
                    operationBlock:(OperationBlock)operationBlock;


/**
 重置支付密码

 @param mobile 手机号
 @param code 验证码
 @param idCard 身份证号
 @param operationBlock
 */
+ (void)resetPaymentCodeWithMobile:(NSString *)mobile
                              code:(NSString *)code
                            iDCard:(NSString *)idCard
                    operationBlock:(OperationBlock)operationBlock;


/**
 检测实名认证次数
 */
+ (void)checkRealNameAuthenticationCountWithOperationBlock:(OperationBlock)operationBlock;

/**
 生成支付订单

 @param mode 支付方式
 @param money 充值金额
 @param content 内容
 @param dataBlock
 */
+ (void)requestPaymentOrderWithPaymentMode:(WLPaymentMode)mode
                                     money:(NSString *)money
                                   content:(NSString *)content
                                 dataBlock:(CompletionDataBlock)dataBlock;


/**
 调起客户端支付

 @param mode 支付方式
 @param orderParams 订单签名
 @param operationBlock 
 */
+ (void)rechargeWithPaymentMode:(WLPaymentMode)mode
                    orderParams:(id)orderParams
                 operationBlock:(OperationBlock)operationBlock;



/**
 获取提现的银行卡信息
 */
+ (void)requestDepositingBankCardInfoWithDataBlock:(CompletionDataBlock)dataBlock;

/**
 提现
 
 @param paymentCode 支付密码
 @param amount 金额
 @param bankCard 银行卡号
 @param dataBlock
 */
+ (void)depositWithPaymentCode:(NSString *)paymentCode
                        amount:(NSString *)amount
                       balance:(NSString *)balance
                      bankCard:(NSString *)bankCard
                     dataBlock:(CompletionDataBlock)dataBlock;


/**
 获取省市区城市列表
 */
+ (void)requestCityListWithDataBlock:(CompletionDataBlock)dataBlock;




///**
// 更新支付宝支付状态
//
// @param tradeNumber 交易号码
// @param operationBlock 
// */
//+ (void)updateAlipayStatusWithTradeNumber:(NSString *)tradeNumber
//                           operationBlock:(OperationBlock)operationBlock;





@end
