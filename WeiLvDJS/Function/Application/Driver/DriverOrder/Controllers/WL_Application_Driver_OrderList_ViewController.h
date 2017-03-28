//
//  WL_Application_Driver_OrderList_ViewController.h
//  WeiLvDJS
//
//  Created by whw on 16/12/20.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseViewController.h"
#import "WL_Application_Driver_OrderCell.h"
@interface WL_Application_Driver_OrderList_ViewController : WL_BaseViewController
/** 订单列表所处的状态 */
@property(nonatomic, assign)WLOrderStatus orderStatus;
/**< 公司的id */
@property(nonatomic, copy) NSString *company_id;
//司机认证状态
@property(nonatomic,assign)WLDriverStatus driverStatus;
//车辆认证状态
@property(nonatomic,assign)WLCarStatus carStaus;
@end
