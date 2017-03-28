//
//  WLCurrentGroupCell2.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLTouristGroupHeader.h"
@interface WLCurrentGroupCell2 : UITableViewCell
+ (WLCurrentGroupCell2 *)cellWithTableView:(UITableView*)tableView
                                      type:(TouristItemType)type
                                 dataArray:(NSArray *)dataArray;

- (void)setLeftBtnClickAction:(void(^)(NSString *phoneNO))leftBlock
          rightBtnClickAction:(void(^)(id object))rightBlock
           sectionClickAction:(void(^)(id object))sectionBlock;

@property (nonatomic, assign) BOOL canChargeup;
@end
