//
//  WL_Application_Driver_OrderDetailCell3.h
//  WeiLvDJS
//
//  Created by whw on 16/12/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WL_Application_Driver_OrderDetailCell3 : UITableViewCell
/**< 数据源 */
@property (nonatomic, strong) NSArray *dataArray;
+ (instancetype)cellForTableView:(UITableView *)tableView;
@end