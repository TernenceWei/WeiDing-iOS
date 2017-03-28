//
//  WL_Application_Driver_Bill_TableHeaderView.h
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseView.h"

@interface WL_Application_Driver_Bill_TableHeaderView : WL_BaseView
/** 账单月份Lable */
@property(nonatomic, weak) UILabel *titleLable;
/** 账单未结清总金额Lable */
@property(nonatomic, weak) UILabel *balanceLable;
/** 指示器Button */
@property(nonatomic, weak) UIButton *indicatorButton;
/** 添加剩余金额TitleLable */
@property(nonatomic, weak) UILabel *balanceTitleLable;
/** 底部分隔线 */
@property(nonatomic, weak) UIView *lineView;
@end
