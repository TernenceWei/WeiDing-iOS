//
//  WLRechargeCell.h
//  WeiLvDJS
//
//  Created by ternence on 16/12/15.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLNetworkAccountHandler.h"

@interface WLRechargeCell : UITableViewCell

+ (WLRechargeCell *)cellWithTableView:(UITableView*)tableView;
@property (nonatomic, assign) WLPaymentMode mode;

@end
