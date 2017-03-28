//
//  WLCarBookingRemarkCell.h
//  WeiLvDJS
//
//  Created by ternence on 2017/2/23.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLCarBookingRemarkCell : UITableViewCell

+ (WLCarBookingRemarkCell *)cellWithTableView:(UITableView*)tableView
                                  clickAction:(void(^)(NSUInteger index))clickAction
                                placeHoldText:(NSString *)placeHoldText;

- (void)setRemark:(NSString *)remark;
@end
