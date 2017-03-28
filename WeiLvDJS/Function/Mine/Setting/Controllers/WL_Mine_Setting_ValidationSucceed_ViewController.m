//
//  WL_Mine_Setting_ValidationSucceed_ViewController.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  验证成功页面

#import "WL_Mine_Setting_ValidationSucceed_ViewController.h"
#import "WL_Mine_Setting_ValidationSucceed_View.h"

#import "WL_Mine_Setting_Account_ViewController.h"


@interface WL_Mine_Setting_ValidationSucceed_ViewController ()

@end

@implementation WL_Mine_Setting_ValidationSucceed_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏信息
    [self stupNavToValidationSucceed];
    
    //设置内容
    [self setupContentToValidationSucceed];
}

#pragma mark - 设置导航栏信息
- (void)stupNavToValidationSucceed
{
    self.title = @"验证完成";
}

#pragma mark - 设置内容
- (void)setupContentToValidationSucceed
{
    WL_Mine_Setting_ValidationSucceed_View *validationSucceedView = [[WL_Mine_Setting_ValidationSucceed_View alloc] init];
    [self.view addSubview:validationSucceedView];
    [validationSucceedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.view.mas_top);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    //为确定按钮添加点击方法
    [validationSucceedView.sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 确定按钮点击方法
- (void)sureButtonClick
{
    
    for (UIViewController *controller in self.navigationController.viewControllers)
    {
        if ([controller isKindOfClass:[WL_Mine_Setting_Account_ViewController class]])
        {
            WL_Mine_Setting_Account_ViewController *settingAccountVc =(WL_Mine_Setting_Account_ViewController *)controller;
            [self.navigationController popToViewController:settingAccountVc animated:YES];
        }
    }
}


@end
