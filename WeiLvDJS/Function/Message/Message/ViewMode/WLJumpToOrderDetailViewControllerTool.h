//
//  WLJumpToOrderDetailViewControllerTool.h
//  WeiLvDJS
//
//  Created by whw on 17/2/8.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WL_Application_Driver_OrderDetailBottomView.h"
#import "WL_Application_Driver_OrderDetail_ViewController.h"
#import "WLApplicationDriverBookOrderCell.h"
#import "WLApplicationDriverBookOrderDetailViewController.h"
#define KJumpTool [WLJumpToOrderDetailViewControllerTool sharedJumpToolInstance]
@interface WLJumpToOrderDetailViewControllerTool : NSObject
+ (instancetype)sharedJumpToolInstance;
//跳转到司机派单 订单详情的页面
- (void)jumpToDriveOrderDetailViewControllerWithOrderID:(NSString *)orderID andNaVC:(UINavigationController *)navigationController;
/**< 跳转到司机 竞价详情页面 */
- (void)jumpToDriveBookOrderDetailViewControllerWithOrderID:(NSString *)orderID andNaVC:(UINavigationController *)navigationController;
/**< 获取派单状态的订单类型 */
- (WLOrderDetailStatus)getSendOrderStatusWithModel:(WLDriverOrderObject*)orderModel;
/**< 获取竞价状态的订单类型 */
- (WLBookOrderStatus)getBookOrderStatusWithModel:(WLDriverOrderObject*)orderModel;

@end
