//
//  WLCarBookingTimeCell.h
//  WeiLvDJS
//
//  Created by ternence on 2017/1/19.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLCarBookingTimeCell : UITableViewCell

+ (WLCarBookingTimeCell *)cellWithTableView:(UITableView*)tableView
                                clickAction:(void(^)(NSUInteger index))clickAction;

- (void)setTime:(NSString *)time index:(NSUInteger)index;

@end
