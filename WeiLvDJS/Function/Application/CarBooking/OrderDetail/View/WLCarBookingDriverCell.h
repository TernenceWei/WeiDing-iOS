//
//  WLCarBookingDriverCell.h
//  WeiLvDJS
//
//  Created by ternence on 2017/2/10.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLCarBookingDriverObject.h"

@interface WLCarBookingDriverCell : UITableViewCell

+ (WLCarBookingDriverCell *)cellWithTableView:(UITableView*)tableView
                                 selectAction:(void (^)())selectAction;

//@property (nonatomic, strong) WLCarBookingDriverObject *object;
-(void)setCellViewPath:(NSIndexPath *)path object:(WLCarBookingDriverObject *)DriverObject;

@end
