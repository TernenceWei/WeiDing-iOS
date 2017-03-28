//
//  WLApplicationDriverBookOrderDetailCell6.h
//  WeiLvDJS
//
//  Created by whw on 17/2/27.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLApplicationDriverBookOrderCell.h"
@interface WLApplicationDriverBookOrderDetailCell6 : UITableViewCell
/**< 订单状态 */
@property (nonatomic, assign) WLBookOrderStatus bookStatus;
/**< 订单详情的数据源 */
@property (nonatomic, strong) WLDriverOrderObject *orderModel;
+ (instancetype)cellForTableView:(UITableView *)tableView;
@end