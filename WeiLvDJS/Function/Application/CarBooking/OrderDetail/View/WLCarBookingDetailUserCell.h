//
//  WLCarBookingDetailUserCell.h
//  WeiLvDJS
//
//  Created by ternence on 2017/1/20.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLCarBookingOrderDetailObject.h"

@interface WLCarBookingDetailUserCell : UITableViewCell

+ (WLCarBookingDetailUserCell *)cellWithTableView:(UITableView*)tableView
                                    paymentAction:(void(^)())paymentAction;

@property (nonatomic, strong) WLCarBookingOrderDetailObject *object;

@end
