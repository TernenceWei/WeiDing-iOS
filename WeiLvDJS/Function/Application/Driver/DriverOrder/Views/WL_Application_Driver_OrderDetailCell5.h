//
//  WL_Application_Driver_OrderDetailCell5.h
//  WeiLvDJS
//
//  Created by whw on 16/12/27.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WL_Application_Driver_OrderDetailBottomView.h"
#import "WLDriverOrderObject.h"
@interface WL_Application_Driver_OrderDetailCell5 : UITableViewCell

/**< 订单状态 */
@property (nonatomic, assign) WLOrderDetailStatus orderDetailStatus;
/**< 订单详情的数据源 */
@property (nonatomic, strong) WLDriverOrderObject *cellData;

+ (instancetype)cellForTableView:(UITableView *)tableView;
@end
