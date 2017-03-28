//
//  WL_Mine_Setting_SetNewPassword_View.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Mine_Setting_SetNewPassword_View.h"

@implementation WL_Mine_Setting_SetNewPassword_View

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置子控件
        [self setupChildViewToSetNewPassword];
        //设置背景色
        self.backgroundColor = BgViewColor;
    }
    return self;
}

#pragma mark - 设置子控件
- (void)setupChildViewToSetNewPassword
{
    //1.输入内容的底部View
    UIView *contentView = [[UIView alloc] init];
    //添加到父控件
    [self addSubview:contentView];
    //设置属性
    contentView.backgroundColor = WLColor(255, 255, 255, 1);
    //添加约束
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top).offset(50);
        make.height.equalTo(@101);
    }];
    
    //1.1 新密码输入标题
    UILabel *newPasswordLable = [[UILabel alloc] init];
    //添加到父视图
    [contentView addSubview:newPasswordLable];
    //设置属性
    newPasswordLable.text = @"输入新密码";
    newPasswordLable.textColor = WLColor(47, 47, 47, 1);
    newPasswordLable.textAlignment = NSTextAlignmentLeft;
    newPasswordLable.font = WLFontSize(14);
    //添加约束
    [newPasswordLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(15);
        make.top.equalTo(contentView.mas_top);
        make.height.equalTo(@50);
        make.width.equalTo(@80);
    }];
    
    //1.2新密码输入框
    UITextField *passwordTextField = [[UITextField alloc] init];
    //添加到父控件上
    [contentView addSubview:passwordTextField];
    //设置属性
    passwordTextField.placeholder = @"请输入6-20位密码";
   //密文输入
    passwordTextField.secureTextEntry = YES;
    //大删除按钮
    passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [passwordTextField setValue:WLColor(156, 160, 176, 1) forKeyPath:@"_placeholderLabel.textColor"];
    passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //添加约束
    [passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(newPasswordLable.mas_right);
        make.height.equalTo(newPasswordLable.mas_height);
        make.centerY.equalTo(newPasswordLable.mas_centerY);
        make.right.equalTo(self.mas_right);
    }];
    self.passwordTextField = passwordTextField;
    
    //1.3中间分隔线
    UIView *lineView = [[UIView alloc] init];
    //添加到父控件
    [contentView addSubview:lineView];
    //设置属性
    lineView.backgroundColor = [WLTools stringToColor:@"#f1f1f1"];

    //添加约束
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left);
        make.right.equalTo(contentView.mas_right);
        make.top.equalTo(contentView.mas_top).offset(50);
        make.height.equalTo(@1);
    }];
    
    
    //1.4重复输入密码Lable
    UILabel *reNewPasswordLable = [[UILabel alloc] init];
    //添加到父视图
    [contentView addSubview:reNewPasswordLable];
    //设置属性
    reNewPasswordLable.text = @"确认新密码";
    reNewPasswordLable.textColor = WLColor(47, 47, 47, 1);
    reNewPasswordLable.textAlignment = NSTextAlignmentLeft;
    reNewPasswordLable.font = WLFontSize(14);
    //添加约束
    [reNewPasswordLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(15);
        make.top.equalTo(lineView.mas_bottom);
        make.height.equalTo(@50);
        make.width.equalTo(@80);
    }];
    
    //1.5输入新密码textField
    UITextField *reNewPassowrdTextField = [[UITextField alloc] init];
    //添加到父控件上
    [contentView addSubview:reNewPassowrdTextField];
    //设置属性
    reNewPassowrdTextField.placeholder = @"请再次输入密码";
    [reNewPassowrdTextField setValue:WLColor(156, 160, 176, 1) forKeyPath:@"_placeholderLabel.textColor"];
    //密文输入
    reNewPassowrdTextField.secureTextEntry = YES;
    //大删除按钮
    reNewPassowrdTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    //添加约束
    [reNewPassowrdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(reNewPasswordLable.mas_right);
        make.height.equalTo(reNewPasswordLable.mas_height);
        make.centerY.equalTo(reNewPasswordLable.mas_centerY);
        make.right.equalTo(self.mas_right);
    }];
    self.reNewPassowrdTextField = reNewPassowrdTextField;

    
    //2.底部完成按钮
    UIButton *succeedButton = [[UIButton alloc] init];
    [self addSubview:succeedButton];
    //设置属性
    succeedButton.layer.cornerRadius = 5.0f;
    succeedButton.layer.masksToBounds = YES;
    [succeedButton setTitle:@"完成" forState:UIControlStateNormal];
    [succeedButton setTitleColor:WLColor(255, 255, 255, 1) forState:UIControlStateNormal];
    [succeedButton setBackgroundColor:[WLTools stringToColor:@"#879efb"]];
    succeedButton.titleLabel.font = WLFontSize(18);
    
    //添加约束
    [succeedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(13);
        make.right.equalTo(self.mas_right).offset(-13);
        make.top.equalTo(contentView.mas_bottom).offset(20);
        make.height.equalTo(@45);
    }];
    self.succeedButton = succeedButton;
    
}

@end
