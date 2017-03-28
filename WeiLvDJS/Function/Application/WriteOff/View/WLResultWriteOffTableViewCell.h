//
//  WLResultWriteOffTableViewCell.h
//  WeiLvDJS
//
//  Created by hsliang on 2017/1/5.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLWriteOffObject.h"

@interface WLResultWriteOffTableViewCell : UITableViewCell

+ (WLResultWriteOffTableViewCell *)cellCreateTableView:(UITableView *)tableView;

- (void)setCellModel:(WLWriteOffObject *)model;

@end
