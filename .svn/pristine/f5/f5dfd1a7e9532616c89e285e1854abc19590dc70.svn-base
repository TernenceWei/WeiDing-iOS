//
//  WLCarBookingDetailOrderCell.h
//  WeiLvDJS
//
//  Created by ternence on 2017/1/20.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLCarBookingOrderDetailObject.h"

@interface WLCarBookingDetailOrderCell : UITableViewCell
@property (nonatomic, assign) BOOL iSChooseVC;

+ (WLCarBookingDetailOrderCell *)cellWithTableView:(UITableView*)tableView
                                            isFold:(BOOL)isFold
                                        foldAction:(void(^)(BOOL isFold))foldAction;

@property (nonatomic, strong) WLCarBookingOrderDetailObject *object;
- (void)lookImgClickAction:(void(^)())action;

@end
