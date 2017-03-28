//
//  WL_Mine_Setting_ValidationOldPassword_View.h
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/12.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseView.h"

@interface WL_Mine_Setting_ValidationOldPassword_View : WL_BaseView

/** 下一步按钮 */
@property(nonatomic, weak)UIButton *nextButton;

/** 原密码输入框 */
@property(nonatomic, weak)UITextField *oldPasswordField;

@end
