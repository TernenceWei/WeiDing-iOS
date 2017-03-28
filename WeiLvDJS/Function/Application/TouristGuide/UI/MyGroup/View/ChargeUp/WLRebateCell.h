//
//  WLRebateCell.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/27.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLTouristGroupHeader.h"
#import "WLChargeUpShopObject.h"

@interface WLRebateCell : UITableViewCell
+ (WLRebateCell *)cellWithTableView:(UITableView *)tableView
                         roleObject:(WLChargeUpRoleObject *)roleObject;
- (void)setTotalReturnPrice:(NSString *)returnprice;
@end
