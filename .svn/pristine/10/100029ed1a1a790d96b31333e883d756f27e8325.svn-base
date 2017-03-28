//
//  WLCurrentGroupItemCell.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/14.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLTouristGroupHeader.h"


@interface WLCurrentGroupItemCell : UITableViewCell
+ (WLCurrentGroupItemCell *)cellWithTableView:(UITableView*)tableView;

- (void)setLeftBtnClickAction:(void(^)())leftBlock
          rightBtnClickAction:(void(^)())rightBlock;

- (void)setDataArray:(NSArray *)dataArray;
@property (nonatomic, assign) GroupItemCellType type;
@property (nonatomic, assign) BOOL canChargeup;
@end
