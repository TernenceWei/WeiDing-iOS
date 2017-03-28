//
//  WL_Mine_Setting_Account_ChangePhone_ViewController.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/12.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  修改手机号码控制器

#import "WL_Mine_Setting_Account_ChangePhone_ViewController.h"

#import "WL_Mine_Setting_Account_ChangePhone_Content_View.h"

#import "WL_Mine_Setting_ValidationOldPassword_ViewController.h"

@interface WL_Mine_Setting_Account_ChangePhone_ViewController ()

@property(nonatomic, weak)WL_Mine_Setting_Account_ChangePhone_Content_View *contentView;

@end

@implementation WL_Mine_Setting_Account_ChangePhone_ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.contentView.phoneNumLable.text = [WLUserTools getUserMobile];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置Nav
    [self setupNavToChangePhone];
    
    //设置内容
    [self setupContentToChangePhone];
}

#pragma mark - 设置更改手机号码的Nav
- (void)setupNavToChangePhone
{
    self.title = @"更换手机号";
}

#pragma mark - 设置更改手机号码的内容
- (void)setupContentToChangePhone
{
    self.view.backgroundColor = BgViewColor;
    WL_Mine_Setting_Account_ChangePhone_Content_View *contentView = [[WL_Mine_Setting_Account_ChangePhone_Content_View alloc] init];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    self.contentView = contentView;
    [contentView.changePhoneButton addTarget:self action:@selector(changePhoneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 点击修改手机号码按钮方法
- (void)changePhoneButtonClick
{
    WL_Mine_Setting_ValidationOldPassword_ViewController *validationOldPasswordVc = [[WL_Mine_Setting_ValidationOldPassword_ViewController alloc] init];
    [self.navigationController pushViewController:validationOldPasswordVc animated:YES];
}



@end
