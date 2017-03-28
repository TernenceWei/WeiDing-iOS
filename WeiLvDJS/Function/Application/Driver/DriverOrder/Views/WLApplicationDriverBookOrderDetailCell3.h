//
//  WLApplicationDriverBookOrderDetailCell3.h
//  WeiLvDJS
//
//  Created by whw on 17/1/21.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLApplicationDriverBookOrderCell.h"
@interface WLApplicationDriverBookOrderDetailCell3 : UITableViewCell
/**< 数据源 */
@property (nonatomic, strong) NSArray *dataArray;
/**< 订单状态 */
@property (nonatomic, assign) WLBookOrderStatus bookStatus;

+ (instancetype)cellForTableView:(UITableView *)tableView;
@end
