//
//  WL_Mine_Setting_SetNewPassword_View.h
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseView.h"

@interface WL_Mine_Setting_SetNewPassword_View : WL_BaseView

/** 新密码输入框 */
@property(nonatomic, weak)UITextField *passwordTextField;

/** 重复输入密码输入框 */
@property(nonatomic, weak)UITextField *reNewPassowrdTextField;

/** 底部完成按钮 */

@property(nonatomic, weak)UIButton *succeedButton;


@end
