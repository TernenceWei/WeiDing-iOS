//
//  WL_Register_View.m
//  WeiLvDJS
//
//  Created by zhaoxiao on 16/9/1.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Register_View.h"

@interface WL_Register_View ()
/** 中间输入框底层的View */
@property (nonatomic, weak) UIView *inputView;

@end

@implementation WL_Register_View

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置注册页面子控件
        [self setupChildViewToRegister];
        self.backgroundColor = [UIColor whiteColor];//[WLTools stringToColor:@"#f6f6f7"];
    }
    return self;
}

#pragma mark - 设置注册页面子控件
- (void)setupChildViewToRegister
{
    
    //[self setupTopViewToRegister];
    
    [self setupInputFieldToRegister];
    
    //[self setupLoginButton];
    
    
}

- (void)setupTopViewToRegister
{
    UILabel *titleLable = [[UILabel alloc] init];
    [self addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.top.equalTo(self.mas_top);
        make.height.equalTo(@45);
    }];
    titleLable.text = @"我们将发送短信验证码到您的手机号码";
    titleLable.font = WLFontSize(15);
    titleLable.textColor = [WLTools stringToColor:@"#5f5f5f"];
    titleLable.textAlignment = NSTextAlignmentLeft;
    self.titleLable = titleLable;
    
}

- (void)setupInputFieldToRegister
{
    //中间输入框的底层View
    UIView *inputView = [[UIView alloc] init];
    inputView.backgroundColor = [UIColor whiteColor];
    [self addSubview:inputView];
    
    [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(@92);
        make.centerX.equalTo(self.mas_centerX);
    }];
    self.inputView = inputView;
    
    UILabel * PhoneLabel = [WLTools allocLabel:@"+86" font:[UIFont WLFontOfSize:15.0] textColor:[UIColor lightGrayColor] frame:CGRectMake(ScaleW(32), ScaleH(15), ScaleW(35), ScaleH(20)) textAlignment:NSTextAlignmentCenter];
    [inputView addSubview:PhoneLabel];
    
//手机号码输入框
    UITextField *phoneNumField = [[UITextField alloc] init];
    //将手机号码输入框添加到View上
    [inputView addSubview:phoneNumField];
    phoneNumField.backgroundColor = [UIColor whiteColor];
    //添加约束
    [phoneNumField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(inputView.mas_top);
        make.width.equalTo(self.mas_width).offset(-90);
        make.height.equalTo(@50);
        make.left.equalTo(PhoneLabel.mas_right).offset(10);
    }];
    self.phoneNumField = phoneNumField;
    phoneNumField.placeholder = @"请输入手机号码";
    phoneNumField.font = WLFontSize(15);
    phoneNumField.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneNumField.keyboardType = UIKeyboardTypeNumberPad;
    
//间隔
    UIView *lineView = [[UIView alloc] init];
    [inputView addSubview:lineView];
    lineView.backgroundColor = [WLTools stringToColor:@"#e4e4e4"];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneNumField.mas_bottom);
        make.height.equalTo(@1);
        make.width.equalTo(inputView.mas_width);
        make.centerX.equalTo(inputView.mas_centerX);
    }];
    
//验证码输入框
    UITextField *captchaField = [[UITextField alloc] init];
    //将手机号码输入框添加到View上
    [self addSubview:captchaField];
    captchaField.backgroundColor = [UIColor whiteColor];
    //添加约束
    [captchaField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneNumField.mas_bottom).offset(1);
        make.width.equalTo(self.mas_width).offset(-158);
        make.height.equalTo(@46);
        make.left.equalTo(PhoneLabel.mas_left);
    }];
    self.captchaField = captchaField;
    captchaField.placeholder = @"请输入验证码";
    captchaField.font = WLFontSize(15);
    captchaField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    captchaField.keyboardType = UIKeyboardTypeNumberPad;
//获取验证码Button
    UIButton *achieveCaptchaButton = [[UIButton alloc] init];
    [self addSubview:achieveCaptchaButton];
    achieveCaptchaButton.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    [achieveCaptchaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(captchaField.mas_right);
        make.top.equalTo(captchaField.mas_top).offset(7);
        make.height.equalTo(@30);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
    
    self.achieveCaptchaButton = achieveCaptchaButton;
    [achieveCaptchaButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [achieveCaptchaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [achieveCaptchaButton setBackgroundColor:[WLTools stringToColor:@"#00cc99"]];
    achieveCaptchaButton.layer.borderColor = [WLTools stringToColor:@"#00cc99"].CGColor;
    achieveCaptchaButton.layer.borderWidth = 1;
    [achieveCaptchaButton.titleLabel setFont:WLFontSize(16)];
    
    achieveCaptchaButton.layer.cornerRadius = 15;
    achieveCaptchaButton.layer.masksToBounds = YES;

    
//间隔线
    UIView *lineView2 = [[UIView alloc] init];
    [inputView addSubview:lineView2];
    lineView2.backgroundColor = [WLTools stringToColor:@"#e4e4e4"];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(captchaField.mas_bottom);
        make.height.equalTo(@1);
        make.width.equalTo(inputView.mas_width);
        make.centerX.equalTo(inputView.mas_centerX);
    }];
}

#pragma mark - 底部登录按钮以下
- (void)setupLoginButton:(NSString *)Str
{
    //下一页按钮
    UIButton *nextButton = [[UIButton alloc] init];
    [self addSubview:nextButton];
    nextButton.layer.cornerRadius = 23;
    nextButton.layer.masksToBounds = YES;
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    nextButton.titleLabel.font = WLFontSize(17);
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inputView.mas_bottom).offset(40);
        make.left.equalTo(self.mas_left).offset(70);
        make.height.equalTo(@45);
        make.right.equalTo(self.mas_right).offset(-70);
    }];
    self.nextButton = nextButton;
    nextButton.backgroundColor = [WLTools stringToColor:@"#00cc99"];
    
    if ([Str isEqualToString:@"WL_WithdrawDeposits"]) {
        [nextButton setTitle:@"登录" forState:UIControlStateNormal];
    }
    
    if ([Str isEqualToString:@"register"]) {
        
        UIView * psView = [[UIView alloc] init];
        if (IsiPhone4||IsiPhone5) {
            psView.frame = CGRectMake(0, ScaleH(115), [UIScreen mainScreen].bounds.size.width, ScaleH(50));
        }
        else
        {
            psView.frame = CGRectMake(0, ScaleH(92), [UIScreen mainScreen].bounds.size.width, ScaleH(50));
        }
        [self addSubview:psView];
        
        [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(psView.mas_bottom).offset(40);
            make.left.equalTo(self.mas_left).offset(70);
            make.height.equalTo(@45);
            make.right.equalTo(self.mas_right).offset(-70);
        }];
        
        _passWordField = [[UITextField alloc] init];
        if (IsiPhone4||IsiPhone5) {
            _passWordField.frame = CGRectMake(ScaleW(32), 0, psView.frame.size.width - ScaleW(50), ScaleH(50));
        }
        else
        {
            _passWordField.frame = CGRectMake(ScaleW(32), ScaleH(5), psView.frame.size.width - ScaleW(50), ScaleH(50));
        }
        _passWordField.placeholder = @"请输入登录密码";
        _passWordField.font = WLFontSize(15);
        _passWordField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [psView addSubview:_passWordField];
        
        //间隔线
        UIView *PSlineView = [[UIView alloc] init];
        [psView addSubview:PSlineView];
        PSlineView.backgroundColor = [WLTools stringToColor:@"#e4e4e4"];
        [PSlineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(psView.mas_bottom);
            make.height.equalTo(@1);
            make.width.equalTo(psView.mas_width);
            make.centerX.equalTo(psView.mas_centerX);
        }];
        
        [self isLoginView];
    }
    
    if ([Str isEqualToString:@"resetpassword"]) {
        UIView * psView = [[UIView alloc] init];
        if (IsiPhone4||IsiPhone5) {
            psView.frame = CGRectMake(0, ScaleH(115), [UIScreen mainScreen].bounds.size.width, ScaleH(100));
        }
        else
        {
            psView.frame = CGRectMake(0, ScaleH(92), [UIScreen mainScreen].bounds.size.width, ScaleH(100));
        }
        [self addSubview:psView];
        
        [nextButton setTitle:@"确认" forState:UIControlStateNormal];
        [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(psView.mas_bottom).offset(40);
            make.left.equalTo(self.mas_left).offset(70);
            make.height.equalTo(@45);
            make.right.equalTo(self.mas_right).offset(-70);
        }];
        
        _passWordField = [[UITextField alloc] init];
        if (IsiPhone4||IsiPhone5) {
            _passWordField.frame = CGRectMake(ScaleW(32), 0, psView.frame.size.width - ScaleW(50), ScaleH(50));
        }
        else
        {
            _passWordField.frame = CGRectMake(ScaleW(32), ScaleH(5), psView.frame.size.width - ScaleW(50), ScaleH(50));
        }
        _passWordField.placeholder = @"请输入登录密码";
        _passWordField.font = WLFontSize(15);
        _passWordField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [psView addSubview:_passWordField];
        
        //间隔线
        UIView *PSlineView = [[UIView alloc] init];
        [psView addSubview:PSlineView];
        PSlineView.backgroundColor = [WLTools stringToColor:@"#e4e4e4"];
        [PSlineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_passWordField.mas_bottom);
            make.height.equalTo(@1);
            make.width.equalTo(psView.mas_width);
            make.centerX.equalTo(psView.mas_centerX);
        }];
        
        _againPassWordField = [[UITextField alloc] initWithFrame:CGRectMake(ScaleW(32), _passWordField.frame.origin.y + _passWordField.frame.size.height + ScaleH(1), psView.frame.size.width - ScaleW(50), ScaleH(50))];
        _againPassWordField.placeholder = @"确认您的新密码";
        _againPassWordField.font = WLFontSize(15);
        _againPassWordField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [psView addSubview:_againPassWordField];
        
        //间隔线
        UIView *PSlineView2 = [[UIView alloc] init];
        [psView addSubview:PSlineView2];
        PSlineView2.backgroundColor = [WLTools stringToColor:@"#e4e4e4"];
        [PSlineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(psView.mas_bottom);
            make.height.equalTo(@1);
            make.width.equalTo(psView.mas_width);
            make.centerX.equalTo(psView.mas_centerX);
        }];
    }
    
    if ([Str isEqualToString:@"WL_ChangePhoneNum"]) {
        [nextButton setTitle:@"确定" forState:UIControlStateNormal];
    }
}

- (void)isLoginView
{
    // 底部协议视图
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - ScaleH(150), [UIScreen mainScreen].bounds.size.width, ScaleH(150))];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];
    
    _agreeButton = [WLTools allocButton:nil textColor:nil nom_bg:[UIImage imageNamed:@"zhucegouxuankuang"] hei_bg:[UIImage imageNamed:@"zhucegouxuankuang"] frame:CGRectMake(([UIScreen mainScreen].bounds.size.width / 2)  - ScaleW(120), ScaleH(20), ScaleW(20), ScaleH(20))];
    //_agreeButton.backgroundColor = [UIColor redColor];
    [bottomView addSubview:_agreeButton];
    
    UILabel * agreeLabel = [WLTools allocLabel:@"我已阅读并同意" font:[UIFont WLFontOfSize:12.0] textColor:[WLTools stringToColor:@"#333333"] frame:CGRectMake(_agreeButton.frame.origin.x + _agreeButton.frame.size.width, _agreeButton.frame.origin.y, ScaleW(105), ScaleH(20)) textAlignment:NSTextAlignmentCenter];
    [bottomView addSubview:agreeLabel];
    
    _looktButton = [WLTools allocButton:@"《微叮用户使用协议》" textColor:[WLTools stringToColor:@"#00cc99"] nom_bg:nil hei_bg:nil frame:CGRectMake(agreeLabel.frame.origin.x + agreeLabel.frame.size.width, _agreeButton.frame.origin.y, ScaleW(145), ScaleH(20))];
    _looktButton.titleLabel.font = [UIFont WLFontOfSize:12.0];
    [bottomView addSubview:_looktButton];
}

@end
