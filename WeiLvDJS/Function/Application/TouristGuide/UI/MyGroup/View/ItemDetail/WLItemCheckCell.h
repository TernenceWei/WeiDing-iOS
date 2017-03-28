//
//  WLItemCheckCell.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/31.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLItemDetailHotelObject.h"
#import "WLTouristGroupHeader.h"

@interface WLItemCheckCell : UITableViewCell
+ (WLItemCheckCell *)cellWithTableView:(UITableView*)tableView
                              itemType:(TouristItemType)itemType
                                object:(WLItemDetailHotelObject *)object;
@end
