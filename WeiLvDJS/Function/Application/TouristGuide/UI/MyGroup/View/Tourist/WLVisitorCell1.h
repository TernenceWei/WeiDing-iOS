//
//  WLVisitorCell1.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLVisitorDetailInfo.h"

@interface WLVisitorCell1 : UITableViewCell
+ (WLVisitorCell1 *)cellWithTableView:(UITableView*)tableView;
@property (nonatomic, strong) WLVisitorDetailInfo *detailInfo;
@end
