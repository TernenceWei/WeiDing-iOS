//
//  WL_Mine_Setting_ValidationSucceed_ViewController.h
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  验证成功页面

#import "WL_BaseViewController.h"

typedef NS_ENUM(NSInteger, WLSucceedStatus){
    /** 修改手机号码陈宫 */
    WL_ChangePhoneNum = 0,
    /** 修改登录密码 */
    WL_ChangePassword = 1
};


@interface WL_Mine_Setting_ValidationSucceed_ViewController : WL_BaseViewController


/** 控制器跳转的状态 */
@property(nonatomic, assign)WLSucceedStatus succeedStatus;

@end
