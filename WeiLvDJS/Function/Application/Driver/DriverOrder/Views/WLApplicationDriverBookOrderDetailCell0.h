//
//  WLApplicationDriverBookOrderDetailCell0.h
//  WeiLvDJS
//
//  Created by whw on 17/1/21.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLApplicationDriverBookOrderDetailCell0 : UITableViewCell
/**< 数据源 */
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, copy) void(^tripButtonCallBack)(NSArray *urlArray);
+ (instancetype)cellForTableView:(UITableView *)tableView;
@end
