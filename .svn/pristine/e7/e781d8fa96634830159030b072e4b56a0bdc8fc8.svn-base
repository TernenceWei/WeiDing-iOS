//
//  WL_SettingPassword_View.m
//  WeiLvDJS
//
//  Created by zhaoxiao on 16/9/1.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_SettingPassword_View.h"

@interface WL_SettingPassword_View ()

@property(nonatomic, weak)UIView *inputView;

@end

@implementation WL_SettingPassword_View

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置注册页面子控件
        [self setupChildViewToSettingPassword];
        self.backgroundColor = [WLTools stringToColor:@"#f6f6f7"];
    }
    return self;
}

#pragma mark - 设置密码页面子控件
- (void)setupChildViewToSettingPassword
{
    [self setupTopViewToSettingPassword];
    
    [self setupInputFieldToSettingPassword];
    
    [self setupLoginButton];
}

- (void)setupTopViewToSettingPassword
{
    UILabel *titleLable = [[UILabel alloc] init];
    [self addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(17);
        make.top.equalTo(self.mas_top).offset(15);
        make.right.equalTo(self.mas_right);
        
    }];
    titleLable.numberOfLines = 0;
    
    titleLable.text = @"设置密码后,你可以用手机号和密码登录电脑版和手机版。";
    titleLable.font = WLFontSize(16);
    titleLable.textColor = [WLTools stringToColor:@"#5f5f5f"];
    titleLable.textAlignment = NSTextAlignmentLeft;
    
    
    UILabel *phoneLable = [[UILabel alloc] init];
    [self addSubview:phoneLable];
    [phoneLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLable.mas_left);
        make.top.equalTo(titleLable.mas_bottom).offset(7);
        make.height.equalTo(@45);
        make.width.equalTo(@56);
        
    }];
    phoneLable.text = @"手机号码";
    phoneLable.textAlignment = NSTextAlignmentLeft;
    phoneLable.font = WLFontSize(14);
    [phoneLable sizeToFit];
    
    UILabel *phoneNumLable = [[UILabel alloc] init];
    [self addSubview:phoneNumLable];
    [phoneNumLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneLable.mas_right).offset(40);
        make.top.equalTo(phoneLable.mas_top);
        make.height.equalTo(@45);
        
    }];
    phoneNumLable.text = @"18807520315";
    phoneNumLable.textColor = [WLTools stringToColor:@"#5f5f5f"];
    phoneNumLable.textAlignment = NSTextAlignmentLeft;
    phoneNumLable.font = WLFontSize(14);
    self.phoneNumLable = phoneNumLable;
    
}

#pragma mark - 设置中间输入框
- (void)setupInputFieldToSettingPassword
{
    //中间输入框的底层View
    UIView *inputView = [[UIView alloc] init];
    [self addSubview:inputView];
    
    [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneNumLable.mas_bottom);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(@92);
        make.centerX.equalTo(self.mas_centerX);
    }];
    self.inputView = inputView;
    inputView.backgroundColor = [UIColor whiteColor];
    
    //密码标题
    UILabel *passwordLable = [[UILabel alloc] init];
    
    [inputView addSubview:passwordLable];
    [passwordLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(inputView.mas_left).offset(17);
        make.top.equalTo(inputView.mas_top);
        make.height.equalTo(@45);
    }];
    passwordLable.text = @"密码";
    passwordLable.font = WLFontSize(14);
    
    //密码输入框
    UITextField *passwordField = [[UITextField alloc] init];
    //将密码输入框添加到View上
    [inputView addSubview:passwordField];
    passwordField.backgroundColor = [UIColor whiteColor];
    //添加约束
    [passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(inputView.mas_top);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@45);
        make.left.equalTo(self.phoneNumLable.mas_left);
    }];
    passwordField.placeholder = @"请输入6-20位密码";
    passwordField.font = WLFontSize(14);
    //密文输入
    passwordField.secureTextEntry = YES;
    passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordField = passwordField;
    //间隔
    UIView *lineView = [[UIView alloc] init];
    [inputView addSubview:lineView];
    lineView.backgroundColor = [WLTools stringToColor:@"#f1f2f6"];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(inputView.mas_centerY);
        make.height.equalTo(@1);
        make.width.equalTo(inputView.mas_width);
        make.centerX.equalTo(inputView.mas_centerX);
    }];
    
    
    //重复密码标题
    UILabel *rePasswordLable = [[UILabel alloc] init];
    
    [inputView addSubview:rePasswordLable];
    [rePasswordLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passwordLable.mas_left);
        make.top.equalTo(lineView.mas_bottom);
        make.height.equalTo(@45);
    }];
    rePasswordLable.text = @"确认密码";
    rePasswordLable.font = WLFontSize(14);

    //重置密码输入框
    UITextField *rePasswordField = [[UITextField alloc] init];
    //将重置密码输入框添加到View上
    [inputView addSubview:rePasswordField];
    rePasswordField.backgroundColor = [UIColor whiteColor];
    //添加约束
    [rePasswordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rePasswordLable.mas_top);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@45);
        make.left.equalTo(passwordField.mas_left);
    }];
    rePasswordField.placeholder = @"请再次输入密码";
    rePasswordField.font = WLFontSize(14);
    //密文输入
    rePasswordField.secureTextEntry = YES;
    rePasswordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.rePasswordField = rePasswordField;
}

#pragma mark - 底部登录按钮以下
- (void)setupLoginButton
{
    //登录按钮
    UIButton *inputButton = [[UIButton alloc] init];
    [self addSubview:inputButton];
    inputButton.layer.cornerRadius = 5.0;
    inputButton.layer.masksToBounds = YES;
    [inputButton setTitle:@"进入微叮" forState:UIControlStateNormal];
    inputButton.titleLabel.font = WLFontSize(17);
    [inputButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inputView.mas_bottom).offset(20);
        make.left.equalTo(self.mas_left).offset(13);
        make.height.equalTo(@45);
        make.right.equalTo(self.mas_right).offset(-13);
    }];
    self.inputButton = inputButton;
    inputButton.backgroundColor = [WLTools stringToColor:@"#879efb"];
}





@end
