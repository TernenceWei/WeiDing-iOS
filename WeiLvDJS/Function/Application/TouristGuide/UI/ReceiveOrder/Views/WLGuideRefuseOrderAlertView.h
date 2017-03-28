//
//  WLGuideRefuseOrderAlertView.h
//  WeiLvDJS
//
//  Created by whw on 16/11/1.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLGuideRefuseOrderAlertView : UIView

/** 内容TableView */
@property(nonatomic, weak)UITableView *refuseReasonTableView;
/** 取消按钮 */
@property(nonatomic, weak) UIButton *cancleButton;
/** 确认拒绝按钮 */
@property(nonatomic, weak) UIButton *refuseButton;

@end
