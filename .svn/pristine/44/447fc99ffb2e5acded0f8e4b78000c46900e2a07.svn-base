//
//  WLCarBookingPriceCell.h
//  WeiLvDJS
//
//  Created by ternence on 2017/1/19.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLCarBookingPriceCell : UITableViewCell

+ (WLCarBookingPriceCell *)cellWithTableView:(UITableView*)tableView
                                 clickAction:(void(^)())clickAction
                              placeHoldArray:(NSArray *)placeHoldArray;

- (void)setSeatCount:(NSUInteger)count;

- (void)resetSeatCount;

@property (nonatomic, copy) void(^onFinishInput)(NSString *seatCount);

@end
