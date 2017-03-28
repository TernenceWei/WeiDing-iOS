//
//  WL_Register_ViewController.h
//  WeiLvDJS
//
//  Created by zhaoxiao on 16/8/30.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//
typedef NS_ENUM(NSInteger, WLVerificationStatus){
    /** 注册 */
    WL_Register = 0,
    /** 密码找回 */
    WL_Recovery = 1,
    /** 重置密码 */
    WL_ResetPassword = 2,
    /** 修改手机 */
    WL_ChangePhoneNum = 3,
    /** 发送新手机验证 */
    WL_ValidationNewPhone = 4,
    /** 验证码登录*/
    WL_WithdrawDeposits = 5
};

#import "WL_BaseViewController.h"



@interface WL_Register_ViewController : WLBaseNavigationController

/** 验证码所验证的状态 */
@property(nonatomic, assign)WLVerificationStatus verificationStatus;



@end
