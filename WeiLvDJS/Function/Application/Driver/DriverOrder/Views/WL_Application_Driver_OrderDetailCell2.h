//
//  WL_Application_Driver_OrderDetailCell2.h
//  WeiLvDJS
//
//  Created by whw on 16/12/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WL_Application_Driver_OrderDetailCell2 : UITableViewCell
/**< 提示图片 */
@property (nonatomic, copy) void(^paidTipImageViewTapHandBlack)();
/**< 是否已结清 */
@property (nonatomic, assign) BOOL isFinished;
/**< 数据源 */
@property (nonatomic, strong) NSArray *dataArray;
/**< cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

+ (instancetype)cellForTableView:(UITableView *)tableView;

@end
