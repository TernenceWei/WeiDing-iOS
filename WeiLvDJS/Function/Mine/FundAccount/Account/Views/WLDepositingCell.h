//
//  WLDepositingCell.h
//  WeiLvDJS
//
//  Created by ternence on 2016/12/18.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLDepositListObject.h"

@interface WLDepositingCell : UITableViewCell

+ (WLDepositingCell *)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) WLDepositListObject *object;

@end
