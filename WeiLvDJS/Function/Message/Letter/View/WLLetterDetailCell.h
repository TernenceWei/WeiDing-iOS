//
//  WLLetterDetailCell.h
//  WeiLvDJS
//
//  Created by ternence on 16/12/12.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WL_PrivateDetail_Model.h"

@interface WLLetterDetailCell : UITableViewCell
+ (WLLetterDetailCell *)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) WL_PrivateDetail_Model *detailModel;
@end
