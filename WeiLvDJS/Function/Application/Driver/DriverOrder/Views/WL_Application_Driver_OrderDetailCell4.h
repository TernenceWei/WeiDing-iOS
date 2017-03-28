//
//  WL_Application_Driver_OrderDetailCell4.h
//  WeiLvDJS
//
//  Created by whw on 16/12/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WL_Application_Driver_OrderDetailCell4 : UITableViewCell
/**< 备注 */
@property (nonatomic, weak) UILabel *commentLabel;

+ (instancetype)cellForTableView:(UITableView *)tableView;
@end
