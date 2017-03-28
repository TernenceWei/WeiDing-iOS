//
//  WLHotelBillDetailDateCell.h
//  WeiLvDJS
//
//  Created by ternence on 16/11/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLHotelBillDetailInfo.h"

@interface WLHotelBillDetailDateCell : UITableViewCell
+ (WLHotelBillDetailDateCell *)cellWithTableView:(UITableView*)tableView;
@property (nonatomic, strong) WLHotelBillDetailInfo *detailInfo;
@end
