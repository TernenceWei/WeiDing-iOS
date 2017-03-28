//
//  WL_Application_Driver_Order_Rush_AlertView.h
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/23.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseView.h"

@interface WL_Application_Driver_Order_Rush_AlertView : WL_BaseView
/** 提示信息Lable */
@property(nonatomic, weak) UILabel *promptMessageLable;
/** 取消按钮 */
@property(nonatomic, weak) UIButton *cancleButton;
/** 接单按钮 */
@property(nonatomic, weak) UIButton *rushButton;

/** 提示标题Lable */
@property(nonatomic, weak) UILabel *promptLable;
/** 提示内容底部的View */
@property(nonatomic, weak) UIView *bottomView;
/** 分隔线 */
@property(nonatomic, weak) UIView *lineView;
@end
