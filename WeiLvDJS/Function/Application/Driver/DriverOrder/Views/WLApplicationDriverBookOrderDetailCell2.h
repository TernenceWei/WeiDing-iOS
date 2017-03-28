//
//  WLApplicationDriverBookOrderDetailCell2.h
//  WeiLvDJS
//
//  Created by whw on 17/2/27.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLApplicationDriverBookOrderDetailCell2 : UITableViewCell
/**< 数据源 */
@property (nonatomic, strong) NSArray *dataArray;
+ (instancetype)cellForTableView:(UITableView *)tableView;
@end
