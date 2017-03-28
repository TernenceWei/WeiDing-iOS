//
//  WLApplicationDriverBookOrderCell.h
//  WeiLvDJS
//
//  Created by whw on 17/1/19.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLDriverOrderObject.h"
/**<抢单 订单状态 */
typedef NS_ENUM(NSInteger, WLBookOrderStatus){
    WLWaitOrderStatus = 300,                 /** 待报价状态 */
    WLUnpaidStatus,                          /**< 已报价 待客户确认*/
    WLOrderStatusStart,                      /**已支付 待出发 */
    WLOrderStatusTravel,                     /** 已支付 行程中 */
    WLOrderStatusSettlement,                 /** 待结算*/
    WLOrderStatusFinish,                     /**< 已结清 */
    WLFailureOrderStatusOverTime,            /** 失效订单状态 报价超时*/
    WLFailureOrderStatusQuoted,              /**< 失效订单状态 已竞价 失败 */
    WLFailureOrderStatusUnquoted,            /**< 失效订单状态 未竞价 失败 */
    WLFailureOrderStatusQuotedCanceled,      /**< 失效订单状态 已竞价 被取消 */
    WLFailureOrderStatusUnquotedCanceled,    /**< 失效订单状态 未竞价 被取消 */
};
@interface WLApplicationDriverBookOrderCell : UITableViewCell
/**< 订单模型 */
@property (nonatomic, strong) WLDriverOrderObject *orderModel;
/**< 抢单按钮 */
@property (nonatomic, weak) UIButton *bookButton;
/**< 抢单状态 */
@property (nonatomic, assign) WLBookOrderStatus bookStatus;

/**< 倒计时回调 */
@property (nonatomic, copy) void(^timeEndCallBack)();
@end
