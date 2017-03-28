//
//  WL_Application_Driver_OrderDetailBottomView.h
//  WeiLvDJS
//
//  Created by whw on 16/12/25.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WL_Application_Driver_Order_Tour_Button.h"
#import "WLDriverOrderObject.h"
/**< 订单状态 */
typedef NS_ENUM(NSInteger, WLOrderDetailStatus){
    /** 待接单状态 */
    WLOrderDetailWait = 200,
    /**< 待出发 */
    WLOrderDetailStart,
    /**< 行程中 */
    WLOrderDetailTravel,
    /**< 结算中 */
    WLOrderDetailSettlement,
    /**< 已结算 */
    WLOrderDetailFinished,
    /**< 已取消 */
    WLOrderDetailCancel,
    /**< 已拒绝 */
    WLOrderDetailRefuse,
    /**< 超时 */
    WLOrderDetailOverTime,
};
@interface WL_Application_Driver_OrderDetailBottomView : UIView

/**< 拒单按钮 */
@property (nonatomic, weak) UIButton *refuseButton;
/**< 接单按钮 */
@property (nonatomic, weak) UIButton *acceptButton;
/**< 订单状态 */
@property (nonatomic, assign) WLOrderDetailStatus orderDetailStatus;
/**< 失效时间 */
@property (nonatomic, copy) NSString *expiry_at;
/**<数据源 */
@property (nonatomic, strong) WLDriverOrderObject *orderDetailData;
/**< 倒计时回调 */
@property (nonatomic, copy) void(^timeEndCallBack)();
@end
