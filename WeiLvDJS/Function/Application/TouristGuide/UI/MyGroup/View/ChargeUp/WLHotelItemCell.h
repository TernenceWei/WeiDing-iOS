//
//  WLHotelItemCell.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLTouristGroupHeader.h"

@interface WLHotelItemCell : UITableViewCell
+ (WLHotelItemCell *)cellWithTableView:(UITableView*)tableView type:(TouristItemType)type indexPath:(NSIndexPath *)indexPath;
@end
