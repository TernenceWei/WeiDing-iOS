//
//  WL_Application_Driver_OrderDetail_ViewController.h
//  WeiLvDJS
//
//  Created by whw on 16/12/25.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseViewController.h"
#import "WL_Application_Driver_OrderDetailBottomView.h"
#import "WLDriverOrderObject.h"
@interface WL_Application_Driver_OrderDetail_ViewController : WL_BaseViewController
/**< 订单状态 */
@property (nonatomic, assign) WLOrderDetailStatus orderDetailStatus;
/**< 配置组头的数据源 */
@property (nonatomic, strong) NSArray *orderDetailSectionArray;
/**< 订单详情的数据源 */
@property (nonatomic, strong) WLDriverOrderObject *orderDetailData;

@end
