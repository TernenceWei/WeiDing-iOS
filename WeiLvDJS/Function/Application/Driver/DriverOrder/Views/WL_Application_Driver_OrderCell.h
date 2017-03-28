//
//  WL_Application_Driver_OrderCell.h
//  WeiLvDJS
//
//  Created by whw on 16/12/20.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLDriverOrderObject.h"
/**< 订单状态 */
typedef NS_ENUM(NSInteger, WLOrderStatus){
    /** 待接单状态 */
    WL_WaitOrderStatus         = 1,
    /**< 已接单 */
    WL_AcceptOrderStatus       = 2,
    /** 失效订单状态 */
    WL_FailureOrderStatus      = 3,
    /** 已接单状态出发 */
    WL_AcceptOrderStatusStart  = 21,
    /** 已接单状态行程中 */
    WL_AcceptOrderStatusTravel = 22,
    /** 已接单状态结束 */
    WL_AcceptOrderStatusEnd    = 23,
    /**< 已拒绝 */
    WL_FailureOrderStatusRefused = 24,
    /**< 已取消 */
    WL_FailureOrderStatusCanceled = 25,
    /**< 失效超时 */
    WL_FailureOrderStatusOverTime = 26,
};
@interface WL_Application_Driver_OrderCell : UITableViewCell
/**< 订单的状态 */
@property(nonatomic, assign)WLOrderStatus orderStatus;
/**< 拒单按钮 */
@property (nonatomic, weak) UIButton *refuseButton;
/**< 接单按钮 */
@property (nonatomic, weak) UIButton *acceptButton;
/**< 订单模型 */
@property (nonatomic, strong) WLDriverOrderObject *orderModel;
/** 出发日期Label */
@property(nonatomic, weak)UILabel *departureTimeLabel;
/** 出发城市Label */
@property(nonatomic, weak)UILabel *fromCityLabel;
@end


