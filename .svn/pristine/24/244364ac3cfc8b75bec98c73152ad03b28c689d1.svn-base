//
//  WLTradeRecordDetailObject.m
//  WeiLvDJS
//
//  Created by ternence on 2017/1/4.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLTradeRecordDetailObject.h"
#import "NSDictionary+DefaultValue.h"

@implementation WLTradeRecordDetailObject
- (instancetype)initWithDict:(NSDictionary *)dic tradeType:(WLTradeRecordType)type
{
    self = [super init];
    if (type == WLTradeRecordTypeRecharge) {

        self.logo              = nil;
        self.title             = [dic objectForKey:@"receipt_account" defaultValue:@"0"];
        self.subTitle          = nil;
        self.money             = [dic objectForKey:@"amount" defaultValue:@"0"];
        self.status            = [dic objectForKey:@"status" defaultValue:@"0"];
        
        NSString *channel      = [dic objectForKey:@"pay_channel" defaultValue:@"0"];
        if (channel.integerValue == 1) {
            self.title = @"支付宝充值";
        }else{
            self.title = @"微信充值";
        }
        
        NSString *remark = [dic objectForKey:@"memo" defaultValue:@"0"];
        if ([remark isEqualToString:@"app微信充值"]){
            self.placeholderImage = @"payment_weixin";
        }else{
            self.placeholderImage = @"payment_alipay";
            
        }
        NSString *type = @"充值";
        NSString *time = [dic objectForKey:@"pay_at" defaultValue:@"0"];
        time = [WLUITool timeStringWithTimeInterval:time.integerValue formatter:@"yyyy-MM-dd HH:mm:ss"];
        NSString *orderNO = [dic objectForKey:@"order_no" defaultValue:@"0"];
        NSString *businessNO = [dic objectForKey:@"channel_order_no" defaultValue:@"0"];
        self.bottomArray = [@[@"交易类型",type,@"交易时间",time, @"订单号", orderNO, @"商户订单", businessNO] mutableCopy];
        
    }else if (type == WLTradeRecordTypeDeposit){
        
        self.logo              = [dic objectForKey:@"bank_logo" defaultValue:@"0"];
        self.title             = [dic objectForKey:@"bank_name" defaultValue:@"0"];
        self.subTitle          = [dic objectForKey:@"bank_number" defaultValue:@"0"];
        self.money             = [dic objectForKey:@"amount" defaultValue:@"0"];
        self.status            = [dic objectForKey:@"audit_status" defaultValue:@"0"];
        
        NSString *type = @"提现";
        NSString *time = [dic objectForKey:@"request_at" defaultValue:@"0"];
        time = [WLUITool timeStringWithTimeInterval:time.integerValue formatter:@"yyyy-MM-dd HH:mm:ss"];
        NSString *orderNO = [dic objectForKey:@"order_no" defaultValue:@"0"];
        NSString *businessNO = [dic objectForKey:@"channel_order_no" defaultValue:@"0"];
        NSString *predictTime = [dic objectForKey:@"predict_expire_date" defaultValue:@"0"];
        predictTime = [WLUITool timeStringWithTimeInterval:predictTime.integerValue formatter:@"yyyy-MM-dd HH:mm:ss"];
        self.bottomArray = [@[@"交易类型",type,@"提现时间",time,@"预计到账时间",predictTime, @"订单号", orderNO, @"商户单号", businessNO] mutableCopy];
        self.placeholderImage = self.title;
        
    }else if (type == WLTradeRecordTypeMemberShipMoney){

        self.logo              = [dic objectForKey:@"logonail_path" defaultValue:@"0"];
        self.title             = [dic objectForKey:@"company_name" defaultValue:@"0"];
        self.subTitle          = nil;
        self.money             = [dic objectForKey:@"amount" defaultValue:@"0"];
        self.status            = [dic objectForKey:@"trade_status" defaultValue:@"0"];
        
        NSString *type = @"团费结算";
        NSString *time = [dic objectForKey:@"created_at" defaultValue:@"0"];
        time = [WLUITool timeStringWithTimeInterval:time.integerValue formatter:@"yyyy-MM-dd HH:mm:ss"];
        NSString *orderNO = [dic objectForKey:@"order_no" defaultValue:@"0"];
        self.bottomArray = [@[@"交易类型",type,@"交易时间",time, @"订单号", orderNO] mutableCopy];
        
    }else if (type == WLTradeRecordTypeDriverOrderPay){
 
        NSString *baseUrl = [dic objectForKey:@"logo_base_url" defaultValue:@"0"];

        self.logo              = [NSString stringWithFormat:@"%@/%@",baseUrl,[dic objectForKey:@"logonail_path" defaultValue:@"0"]];
        self.title             = [dic objectForKey:@"company_name" defaultValue:@"0"];
        self.subTitle          = nil;
        self.money             = [dic objectForKey:@"amount" defaultValue:@"0"];
        self.status            = [dic objectForKey:@"trade_status" defaultValue:@"0"];
        
        NSString *type = @"司机订单支付";
        NSString *time = [dic objectForKey:@"created_at" defaultValue:@"0"];
        time = [WLUITool timeStringWithTimeInterval:time.integerValue formatter:@"yyyy-MM-dd HH:mm:ss"];
        NSString *orderNO = [dic objectForKey:@"order_no" defaultValue:@"0"];
        self.bottomArray = [@[@"交易类型",type,@"交易时间",time, @"订单号", orderNO] mutableCopy];
        
    }else if (type == WLTradeRecordTypeGrabOrderPay || type == WLTradeRecordTypeCarBookingOrderPay){

        self.logo              = [dic objectForKey:@"company_logo" defaultValue:@"0"];
        self.title             = [dic objectForKey:@"company_name" defaultValue:@"0"];
        self.subTitle          = [dic objectForKey:@"callcar_user" defaultValue:@"0"];
        self.money             = [dic objectForKey:@"amount" defaultValue:@"0"];
        self.status            = [dic objectForKey:@"trade_status" defaultValue:@"0"];
        
        NSString *typeString = @"车费结算";
        NSString *time = [dic objectForKey:@"created_at" defaultValue:@"0"];
        time = [WLUITool timeStringWithTimeInterval:time.integerValue formatter:@"yyyy-MM-dd HH:mm"];
        NSString *orderNO = [dic objectForKey:@"order_no" defaultValue:@"0"];
        NSString *frozenTime = [dic objectForKey:@"updated_at" defaultValue:@"0"];
        frozenTime = [WLUITool timeStringWithTimeInterval:frozenTime.integerValue formatter:@"yyyy-MM-dd"];
        if (type == WLTradeRecordTypeCarBookingOrderPay) {//叫车单支付
            self.money             = [NSString stringWithFormat:@"-%@",self.money];
            self.bottomArray = [@[@"交易类型",typeString,@"付款时间",time, @"订单号", orderNO] mutableCopy];
        }else{
            if (self.status.integerValue == 5) {
                self.bottomArray = [@[@"交易类型",typeString,@"到账时间",time, @"订单号", orderNO] mutableCopy];
            }else{
                self.bottomArray = [@[@"交易类型",typeString,@"到账时间",time, @"订单号", orderNO, @"解冻时间", frozenTime] mutableCopy];
            }
        }
        
    }

    return self;
}
@end
