//
//  WLGuideWaitOrderTableViewCell.h
//  WeiLvDJS
//
//  Created by whw on 16/10/20.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLOrderListInfo, WLGuideWaitOrderTableViewCell;

@protocol WLGuideWaitOrderTableViewCellDelegate <NSObject>

- (void)denyOrder:(WLOrderListInfo *)orderInfoID;

- (void)acceptOrder:(WLGuideWaitOrderTableViewCell *)cell orderInfo:(WLOrderListInfo *)orderInfo;

@end

@interface WLGuideWaitOrderTableViewCell : UITableViewCell

@property(nonatomic, weak) id<WLGuideWaitOrderTableViewCellDelegate> delegate;

@property(nonatomic, strong)WLOrderListInfo *orderInfo;

//订单ID
@property(nonatomic,copy)NSString *orderID;
//groupID
@property(nonatomic,copy)NSString *groupListID;

@end
