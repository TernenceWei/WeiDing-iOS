//
//  WL_Login_View.m
//  WeiLvDJS
//
//  Created by zhaoxiao on 16/8/31.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Login_View.h"

@interface WL_Login_View ()



//中间输入框底层的View
@property (nonatomic, weak) UIView *inputView;


@end

@implementation WL_Login_View

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置子控件
        [self setupChildView];
        //设置背景颜色
        self.backgroundColor = [UIColor whiteColor];//[WLTools stringToColor:@"#f7f7f8"];
    }
    return self;
}

#pragma mark - 设置子控件
- (void)setupChildView
{
   //上边Logo的View
    [self setupTopImageView];
    //中间输入框
    [self setupInputField];
    //底部控件
    [self setupLoginButton];
}

#pragma mark - 设置上边的Logo的View
- (void)setupTopImageView
{
    //初始化
    UIImageView *logoImageView = [[UIImageView alloc] init];
    //添加到父控件view上
    [self addSubview:logoImageView];
    
    //添加约束
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(35 * AUTO_IPHONE6_HEIGHT_667);
        make.height.equalTo(@(88 * AUTO_IPHONE6_HEIGHT_667));
        make.width.equalTo(@(88 * AUTO_IPHONE6_HEIGHT_667));
    }];
    //设置LogoImageView的图层为圆形
    logoImageView.layer.cornerRadius = (44.0 * AUTO_IPHONE6_HEIGHT_667);
    //超出图层部分剪切
    logoImageView.layer.masksToBounds = YES;
    //设置Logo背景颜色
//    logoImageView.backgroundColor = [WLTools stringToColor:@"#4977e7"];
    
   
    self.logoImageView = logoImageView;
    
    //----------------
    
    //初始化
    UIImageView *noUserlogoImageView = [[UIImageView alloc] init];
    [noUserlogoImageView setImage:[UIImage imageNamed:@"logo_denglu"]];
    //添加到父控件view上
    [self addSubview:noUserlogoImageView];
    
    noUserlogoImageView.frame = CGRectMake((ScreenWidth /2 ) - ScaleW(70), ScaleH(35), ScaleW(140), ScaleH(100));
    
    self.noUserlogoImageView = noUserlogoImageView;

}

#pragma mark - 中间输入框
- (void)setupInputField
{
//中间输入框的底层View
    UIView *inputView = [[UIView alloc] init];
    [self addSubview:inputView];
    [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImageView.mas_bottom).offset(55);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(@101);
        make.centerX.equalTo(self.mas_centerX);
    }];
    self.inputView = inputView;
    inputView.backgroundColor = [UIColor whiteColor];
    
//间隔线
    UIView *lineViewtop = [[UIView alloc] init];
    [inputView addSubview:lineViewtop];
    
    lineViewtop.backgroundColor = [WLTools stringToColor:@"#e4e4e4"];
    [lineViewtop mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.centerY.equalTo(@0);
        make.top.equalTo(@0);
        make.height.equalTo(@0.5);
        make.width.equalTo(inputView.mas_width);
        make.centerX.equalTo(inputView.mas_centerX);
    }];
    
    UIButton * PhoneNOBtn = [WLTools allocButton:nil textColor:nil nom_bg:[UIImage imageNamed:@""] hei_bg:[UIImage imageNamed:@""] frame:CGRectMake(ScaleW(58), ScaleH(15), ScaleW(22), ScaleH(22))];
    [PhoneNOBtn setImage:[UIImage imageNamed:@"user"] forState:UIControlStateNormal];
    [inputView addSubview:PhoneNOBtn];
    
//手机号码输入框
    UITextField *phoneNumField = [[UITextField alloc] init];
    //将手机号码输入框添加到View上
    [inputView addSubview:phoneNumField];
    phoneNumField.backgroundColor = [UIColor whiteColor];
    //添加约束
    [phoneNumField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineViewtop.mas_top).offset(1);
        make.width.equalTo(self.mas_width).offset(-90);
        make.height.equalTo(@50);
        make.left.equalTo(PhoneNOBtn.mas_right).offset(10);
    }];
    self.phoneNumField = phoneNumField;
    phoneNumField.placeholder = @"请输入手机号码";
    phoneNumField.keyboardType = UIKeyboardTypeNumberPad;//UIKeyboardTypePhonePad;
    phoneNumField.font = WLFontSize(16);
    phoneNumField.clearButtonMode = UITextFieldViewModeWhileEditing;
//间隔
    UIView *lineView = [[UIView alloc] init];
    [inputView addSubview:lineView];
    lineView.backgroundColor = [WLTools stringToColor:@"#e4e4e4"];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneNumField.mas_bottom);
        make.height.equalTo(@0.5);
        make.width.equalTo(inputView.mas_width);
        make.centerX.equalTo(inputView.mas_centerX);
    }];
    
    //UIButton * PSBtn = [WLTools allocButton:nil textColor:nil nom_bg:[UIImage imageNamed:@""] hei_bg:[UIImage imageNamed:@""] frame:CGRectMake(PhoneNOBtn.frame.origin.x, PhoneNOBtn.frame.origin.y + PhoneNOBtn.frame.size.height + 30, ScaleW(22), ScaleH(22))];
    UIButton * PSBtn = [[UIButton alloc] init];
    if (IsiPhone4||IsiPhone5) {
        PSBtn.frame = CGRectMake(PhoneNOBtn.frame.origin.x, PhoneNOBtn.frame.origin.y + PhoneNOBtn.frame.size.height + ScaleH(45), ScaleW(22), ScaleH(22));
    }
    else
    {
        PSBtn.frame = CGRectMake(PhoneNOBtn.frame.origin.x, PhoneNOBtn.frame.origin.y + PhoneNOBtn.frame.size.height + ScaleH(30), ScaleW(22), ScaleH(22));
    }
    
    [PSBtn setImage:[UIImage imageNamed:@"password"] forState:UIControlStateNormal];
    [inputView addSubview:PSBtn];
    
//登录密码输入框
    UITextField *passwordField = [[UITextField alloc] init];
    //将手机号码输入框添加到View上
    [self addSubview:passwordField];
    passwordField.backgroundColor = [UIColor whiteColor];
    passwordField.keyboardType = UIKeyboardTypeDefault;
    //添加约束
    [passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneNumField.mas_bottom).offset(3);
        make.width.equalTo(self.mas_width).offset(-170);
        make.height.equalTo(@50);
        make.left.equalTo(PSBtn.mas_right).offset(10);
    }];
    self.passwordField = passwordField;
    passwordField.secureTextEntry = YES;
    passwordField.placeholder = @"请输入登录密码";
    passwordField.font = WLFontSize(16);
    passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
//间隔
    UIView *lineViewbottom = [[UIView alloc] init];
    [self addSubview:lineViewbottom];
    lineViewbottom.backgroundColor = [WLTools stringToColor:@"#e4e4e4"];
    [lineViewbottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(inputView.mas_bottom).offset(1);
        make.height.equalTo(@0.5);
        make.width.equalTo(inputView.mas_width);
        make.centerX.equalTo(inputView.mas_centerX);
    }];
    
//忘记密码Button
    UIButton *forgetPasswordButton = [[UIButton alloc] init];
    [self addSubview:forgetPasswordButton];
    [forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passwordField.mas_right);
        make.top.equalTo(passwordField.mas_top).offset(11);
        //make.height.equalTo(@(20 * AUTO_IPHONE6_HEIGHT_667));
        //make.width.equalTo(@(100 * AUTO_IPHONE6_WIDTH_375));
    }];
    
    self.forgetPasswordButton = forgetPasswordButton;
    [forgetPasswordButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetPasswordButton setTitleColor:[WLTools stringToColor:@"#00cc99"] forState:UIControlStateNormal];
    [forgetPasswordButton.titleLabel setFont:WLFontSize(14)];
}

#pragma mark - 底部登录按钮以下
- (void)setupLoginButton
{
    //登录按钮
    UIButton *loginButton = [[UIButton alloc] init];
    [self addSubview:loginButton];
    loginButton.layer.cornerRadius = 23;
    loginButton.layer.masksToBounds = YES;
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    loginButton.titleLabel.font = WLFontSize(17);
    
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inputView.mas_bottom).offset(25 * AUTO_IPHONE6_HEIGHT_667);
        
        make.left.equalTo(self.mas_left).offset(50);
        make.height.equalTo(@45);
        make.right.equalTo(self.mas_right).offset(-50);
    }];
    self.loginButton = loginButton;
    loginButton.backgroundColor = [WLTools stringToColor:@"#00cc99"];
    
    //新用户注册Button
    UIButton *registerButton = [[UIButton alloc] init];
    [self addSubview:registerButton];
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(loginButton.mas_right);
        make.top.equalTo(loginButton.mas_bottom).offset(7);
        //make.height.equalTo(@(20 * AUTO_IPHONE6_HEIGHT_667));
        //make.width.equalTo(@(120 * AUTO_IPHONE6_WIDTH_375));
    }];
    self.registerButton = registerButton;
    [registerButton setTitle:@"新用户注册" forState:UIControlStateNormal];
    [registerButton setTitleColor:[WLTools stringToColor:@"#333333"] forState:UIControlStateNormal];
    [registerButton.titleLabel setFont:WLFontSize(14)];
    
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - ScaleH(200), [UIScreen mainScreen].bounds.size.width, ScaleH(200))];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];
    
    UILabel * bottonleftline = [WLTools allocLabel:nil font:nil textColor:nil frame:CGRectMake(ScaleW(20), ScaleH(10), ([UIScreen mainScreen].bounds.size.width - ScaleW(80)) / 3, ScaleH(0.5)) textAlignment:NSTextAlignmentCenter];
    bottonleftline.backgroundColor = [WLTools stringToColor:@"#e4e4e4"];
    [bottomView addSubview:bottonleftline];
    
    UILabel * bottonOtherLoginLabel = [WLTools allocLabel:@"其他方式登录" font:[UIFont WLFontOfSize:12.0] textColor:[WLTools stringToColor:@"#333333"] frame:CGRectMake(bottonleftline.frame.origin.x + bottonleftline.frame.size.width + ScaleW(20), ScaleH(5), bottonleftline.frame.size.width, ScaleH(10)) textAlignment:NSTextAlignmentCenter];
    [bottomView addSubview:bottonOtherLoginLabel];
    
    
    UILabel * bottonrightline = [WLTools allocLabel:nil font:nil textColor:nil frame:CGRectMake(bottonOtherLoginLabel.frame.origin.x + bottonOtherLoginLabel.frame.size.width + ScaleW(20), bottonleftline.frame.origin.y, bottonleftline.frame.size.width, bottonleftline.frame.size.height) textAlignment:NSTextAlignmentCenter];
    bottonrightline.backgroundColor = [WLTools stringToColor:@"#e4e4e4"];
    [bottomView addSubview:bottonrightline];
    
    _VerificationCodeButton = [WLTools allocButton:nil textColor:nil nom_bg:[UIImage imageNamed:@""] hei_bg:[UIImage imageNamed:@""] frame:CGRectMake((bottonOtherLoginLabel.frame.origin.x + bottonOtherLoginLabel.frame.size.width / 2) - ScaleW(26), bottonOtherLoginLabel.frame.origin.y + bottonOtherLoginLabel.frame.size.height + ScaleH(20), ScaleW(52), ScaleH(52))];
    [_VerificationCodeButton setImage:[UIImage imageNamed:@"Verificationcode"] forState:UIControlStateNormal];
    [bottomView addSubview:_VerificationCodeButton];
    
    UILabel * bottonOtherLoginLabel2 = [WLTools allocLabel:@"短信验证码登录" font:[UIFont WLFontOfSize:14.0] textColor:[WLTools stringToColor:@"#929292"] frame:CGRectMake(bottonOtherLoginLabel.frame.origin.x - ScaleW(20), _VerificationCodeButton.frame.origin.y + _VerificationCodeButton.frame.size.height + ScaleH(20), bottonOtherLoginLabel.frame.size.width + ScaleW(40), bottonOtherLoginLabel.frame.size.height) textAlignment:NSTextAlignmentCenter];
    [bottomView addSubview:bottonOtherLoginLabel2];

    _ChangeEnvironmentButton = [[UIButton alloc] initWithFrame:CGRectMake(ScaleW(10), ScaleH(20), ScaleW(100), ScaleH(20))];
    [_ChangeEnvironmentButton setTitle:@"环境切换" forState:UIControlStateNormal];
    _ChangeEnvironmentButton.titleLabel.font = [UIFont WLFontOfSize:14.0];
    [_ChangeEnvironmentButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self addSubview:_ChangeEnvironmentButton];
    
    
    
    
}

@end
