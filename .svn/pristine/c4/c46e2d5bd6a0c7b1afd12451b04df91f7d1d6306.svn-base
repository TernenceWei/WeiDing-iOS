//
//  WLWaitingListCell.h
//  WeiLvDJS
//
//  Created by hsliang on 2016/11/15.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLHotelOrderInfo.h"

@interface WLWaitingListCell : UITableViewCell

/** 数据模型 */
@property (nonatomic, strong) WLHotelOrderInfo * modelInfo;

+ (WLWaitingListCell *)cellCreateTableView:(UITableView *)tableView;

- (void)wCClickAction:(void(^)(NSInteger wCNO))action;
- (void)iPhoneAction:(void(^)(NSInteger iPhoneNO))action;

- (void)sureBtnClickAction:(void(^)(WLHotelOrderInfo *StrrCIDM))action;
- (void)RefusedBtnClickAction:(void(^)(NSString *Strr))action;

- (void)ChooseDateClickAction:(void(^)())action;

//- (void)setCellModel:(WLHotelOrderInfo *)modelInfo;

@end
