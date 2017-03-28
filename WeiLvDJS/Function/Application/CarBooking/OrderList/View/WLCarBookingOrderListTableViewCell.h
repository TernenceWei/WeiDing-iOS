//
//  WLCarBookingOrderListTableViewCell.h
//  WeiLvDJS
//
//  Created by hsliang on 2017/1/19.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLCarBookingOrderListObject.h"

@interface WLCarBookingOrderListTableViewCell : UITableViewCell

+ (WLCarBookingOrderListTableViewCell *)cellcreateTableView:(UITableView *)tableView;

- (void)setCellModel:(WLCarBookingOrderListObject *)model status:(NSInteger)status;

@end
