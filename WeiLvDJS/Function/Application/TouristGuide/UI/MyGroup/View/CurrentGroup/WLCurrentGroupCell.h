//
//  WLCurrentGroupCell.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/14.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLCurrentGroupInfo.h"
#import "WLTouristGroupHeader.h"

@interface WLCurrentGroupCell : UITableViewCell
+ (WLCurrentGroupCell *)cellWithTableView:(UITableView*)tableView
                                 gropInfo:(WLCurrentGroupInfo *)groupInfo
                              isFoldArray:(NSArray *)isFoldArray;

- (void)setLeftBtnClickAction:(void(^)(NSString *phoneNO))leftBlock
          rightBtnClickAction:(void(^)(TouristItemType itemType, id object))rightBlock
           sectionClickAction:(void(^)(TouristItemType itemType, id object))sectionBlock
             arrowClickAction:(void(^)(NSUInteger section, BOOL isFold))foldAction;

@property (nonatomic, strong) WLCurrentGroupInfo *groupInfo;
@property (nonatomic, assign) BOOL canChargeup;
@end
