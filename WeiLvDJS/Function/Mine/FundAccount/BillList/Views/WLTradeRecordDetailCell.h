//
//  WLTradeRecordDetailCell.h
//  WeiLvDJS
//
//  Created by ternence on 2016/12/20.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLTradeRecordDetailObject.h"

@interface WLTradeRecordDetailCell : UITableViewCell

+ (WLTradeRecordDetailCell *)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) WLTradeRecordDetailObject *detailObject;

@end
