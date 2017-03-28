//
//  AppManager.h
//  WeiLvDJS
//
//  Created by ternence on 16/12/9.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

typedef NS_ENUM(NSUInteger, WLPaymentCode) {
    WLPaymentCodeSuccess    = 1,    /**< 成功    */
    WLPaymentCodeCancel     = 2,    /**< 取消    */
    WLPaymentCodeFailure    = 3,    /**< 失败    */
    WLPaymentCodeProcessed  = 4,    /**< 处理中    */
    
};

@interface AppManager : NSObject

+ (instancetype)sharedInstance;

/**
 处理微信充值和支付的回调
 */
- (void)handelWeixinPaymentResultWithResp:(BaseResp *)resp;

/**
 处理支付宝充值和支付的回调
 */
- (void)handelAliPayResultWithUrl:(NSURL *)url;

/**
 支付的返回点击
 */
- (void)handelAliPayResultAndWeixinPaymentResultWithUrl;

/**
 版本更新
 */
- (void)checkVersionUpdate;


/**
 程序在前台收到通知
 */
- (void)remoteNotificationWillPresent:(NSDictionary *)userInfo;


/**
 程序在后台，点击通知
 */
- (void)remoteNotificationDidSelected:(NSDictionary *)userInfo;

- (UIViewController *)getCurrentViewController;


/**
 设置为正式环境
 */
- (void)setDistributionMode;

//是否为正式环境
- (BOOL)isDistributionMode;

/**
 发起请求获取省市区列表
 */
- (void)requestCityList;


/**
 读取省市区列表
 */
- (void)getCityListWithResultBlock:(void(^)(NSArray *cityArray))resultBlock;


/**
 注册极光推送标签和别名
 */
- (void)registerJPushTagsAndAlias;


/**
 停止极光推送
 */
- (void)stopJPushService;

/**
初始化bugly
 */
- (void)setBugly;
@end
