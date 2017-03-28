//
//  WLBiddingListCell.h
//  WeiLvDJS
//
//  Created by hsliang on 2016/11/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLHotelOrderInfo.h"

@interface WLBiddingListCell : UITableViewCell

+ (WLBiddingListCell *)cellCreateTableView:(UITableView *)tableView;

- (void)wCClickAction:(void(^)(NSInteger wCNO))action;
- (void)iPhoneAction:(void(^)(NSInteger iPhoneNO))action;

- (void)closeVSopenClickAction:(void(^)(NSString *isopen))action;

- (void)qXBtnClickAction:(void(^)(NSString * xQID))action;

- (void)setCellModel:(WLHotelOrderInfo *)modelInfo Nstatus:(HotelListStatus)SNstatus;

@end
