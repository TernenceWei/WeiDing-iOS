//
//  AppDelegate.h
//  WeiLvDJS
//
//  Created by jyc on 16/8/25.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate,WXApiDelegate,UIAlertViewDelegate,BMKGeneralDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
/*
上线流程
1.iTunes创建新版本
2.AppDelegate打开正式环境开关
3.隐藏环境切换按钮
4.不能提前出发和结束判断打开
5.修改version和build号
6.打包，使用applicationloader上传
7.更新版本介绍，截屏，核对测试账号
8.保存，提交审核
*/
