//
//  WLApplicationDriverBookOrderDetailBottomView.h
//  WeiLvDJS
//
//  Created by whw on 17/1/20.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLApplicationDriverBookOrderCell.h"
@interface WLApplicationDriverBookOrderDetailBottomView : UIView
/**< 订单模型 */
@property (nonatomic, strong) WLDriverOrderObject *orderModel;
/**< 抢单按钮 */
@property (nonatomic, weak) UIButton *bookButton;
/**< 抢单状态 */
@property (nonatomic, assign) WLBookOrderStatus bookStatus;
/**< 倒计时回调 */
@property (nonatomic, copy) void(^timeEndCallBack)();
@end
