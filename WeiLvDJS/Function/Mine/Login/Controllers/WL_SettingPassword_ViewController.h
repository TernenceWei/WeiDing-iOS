//
//  WL_SettingPassword_ViewController.h
//  WeiLvDJS
//
//  Created by zhaoxiao on 16/9/1.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseViewController.h"
#import "WL_Register_ViewController.h"
@interface WL_SettingPassword_ViewController : WLBaseNavigationController

/** 验证码所验证的状态 */
@property(nonatomic, assign)WLVerificationStatus verificationStatus;
@end
