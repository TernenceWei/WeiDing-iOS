//
//  WL_Register_ViewController.m
//  WeiLvDJS
//
//  Created by zhaoxiao on 16/8/30.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Register_ViewController.h"

#import "WL_TabBarController.h"

//引入注册页面View
#import "WL_Register_View.h"

//引入设置密码控制器
#import "WL_SettingPassword_ViewController.h"

#import "WLEndUserLicenseViewController.h"

@interface WL_Register_ViewController ()

{
    dispatch_source_t _timer ;
}

/** 注册View */
@property(nonatomic, weak)WL_Register_View *registerView;

/** 验证码间隔事件 */
@property(nonatomic, assign) NSInteger min_time_span;

///** 电话号码输入框中输入的电话号码 */
//@property(nonatomic ,copy)NSString *phoneNum;
//
///** 验证码输入框中输入的验证码 */
//@property(nonatomic ,copy)NSString *captcha;
/** 弹出框 */
@property(nonatomic, strong)WL_TipAlert_View *alert;


@end

@implementation WL_Register_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置注册页面UI
    [self setupRegisterUI];
    
    self.titleItem.title = self.title;
    
    self.registerView.nextButton.userInteractionEnabled = NO;
    self.registerView.nextButton.alpha = 0.5;
    
    //注册弹框
    [self creatTipAlertViewToRegister];
    
}

#pragma mark - 注册弹框
- (void)creatTipAlertViewToRegister
{
    self.alert = [WL_TipAlert_View sharedAlert];
    
}

#pragma mark - 设置注册页面UI
- (void)setupRegisterUI
{
    WL_Register_View *registerView = [[WL_Register_View alloc] init];
    [self.view addSubview:registerView];
    [registerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(@65);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    self.registerView = registerView;
    //验证码输入框
    [registerView.captchaField addTarget:self action:@selector(captchaFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
    [registerView.phoneNumField addTarget:self action:@selector(phoneNumFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
        
    //点击了发送验证码请求
    [registerView.achieveCaptchaButton addTarget:self action:@selector(achieveCaptchaButtonClick) forControlEvents:UIControlEventTouchUpInside];

    if (_verificationStatus == WL_Register) {
        self.title = @"注册";
        [registerView setupLoginButton:@"register"];
    }
    else if (_verificationStatus == WL_ResetPassword)
    {
        self.title = @"修改密码";
        [registerView setupLoginButton:@"resetpassword"];
    }
    else if (_verificationStatus == WL_Recovery)
    {
        self.title = @"重置密码";
        [registerView setupLoginButton:@"resetpassword"];
    }
    else if (_verificationStatus == WL_WithdrawDeposits)
    {
        self.title = @"验证码登录";
        [registerView setupLoginButton:@"WL_WithdrawDeposits"];
    }
    else if (_verificationStatus == WL_ChangePhoneNum)
    {
        self.title = @"验证原手机号";
        [registerView setupLoginButton:@"WL_ChangePhoneNum"];
    }
    
    self.registerView.phoneNumField.text = [WLUserTools getUserMobile];
    //点击了下一页的按钮
    [registerView.nextButton addTarget:self action:@selector(settingPassword) forControlEvents:UIControlEventTouchUpInside];
    [registerView.looktButton addTarget:self action:@selector(lookButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

//检测验证码输入框文字
- (void)captchaFieldTextChanged:(UITextField *)textField
{
    
    [self monitorTextFieldTextChange];
}

//检测手机号码输入框文字
- (void)phoneNumFieldTextChanged:(UITextField *)textField
{
    
    //判断下一页按钮是否可点
    [self monitorTextFieldTextChange];
}

//判断输入框和验证码输入框是否都有值
- (void)monitorTextFieldTextChange
{
    //如果不是都有值,下一页按钮不可点
    if (self.registerView.captchaField == nil || self.registerView.phoneNumField == nil || self.registerView.captchaField.text.length == 0 || self.registerView.phoneNumField.text.length == 0)
    {
        self.registerView.nextButton.userInteractionEnabled = NO;
        self.registerView.nextButton.alpha = 0.5;
    }
    else
    {
        self.registerView.nextButton.userInteractionEnabled = YES;
        self.registerView.nextButton.alpha = 1.0;
    }
}

#pragma 点击下一页按钮
- (void)settingPassword
{
    if (_verificationStatus == WL_WithdrawDeposits) {
        //校验验证码是否正确---验证码登录
        [self sendRequestToRegister];
    }
    else if (_verificationStatus == WL_Register) {
        //注册
        [self RegisterRegister];
    }
    else if (_verificationStatus == WL_Recovery)
    {
        // 忘记密码
        [self ChangePassWordNet];
    }
    else if (_verificationStatus == WL_ChangePhoneNum)
    {
        // 修改手机号
        [self changePhone];
    }
    else if (_verificationStatus == WL_ResetPassword)
    {
        // 修改密码
        [self ChangePassWordNet];
    }
}

#pragma mark - 发送验证码按钮点击事件
- (void)achieveCaptchaButtonClick
{
    //如果输入的是11位号码并且不包含空格
    if (self.registerView.phoneNumField.text.length == 0) {
        [self.alert createTip:@"手机号码不能为空!"];
        return;
    }
    
    
    if (self.registerView.phoneNumField.text.length != 11 || [self.registerView.phoneNumField.text rangeOfString:@" "].location != NSNotFound)
    {
        [self.alert createTip:@"请输入正确的手机号码"];
        return;
        
    }
    //发送获取验证码请求
    [self sendRequestToCaptcha];
    
}

#pragma mark - 发送获取验证码网络请求
- (void)sendRequestToCaptcha
{
    //电话号码参数 user_mobile
    NSString *phoneNum = self.registerView.phoneNumField.text;
    //验证码类型（没有在用了）
    NSString *code_type = [NSString stringWithFormat:@"%zd", self.verificationStatus];
    
    //显示菊花
    [self showHud];
    
    [WLNetworkManager sendRequestToCaptchaWithPhoneNO:phoneNum codeType:code_type result:^(BOOL success, BOOL result, NSString *message, NSInteger minTimespan) {
        if (success) {
            if (result) {
                [self.alert createTip:[NSString stringWithFormat:@"验证码已发送"]];
                self.min_time_span = minTimespan;
                //发送验证码按钮不可变
                self.registerView.achieveCaptchaButton.enabled = NO;
                [self.registerView.achieveCaptchaButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                self.registerView.achieveCaptchaButton.backgroundColor = [UIColor whiteColor];
                self.registerView.achieveCaptchaButton.layer.borderColor = [WLTools stringToColor:@"#e4e4e4"].CGColor;
                //获取动态密码倒计时
                [self achieveCaptchaStartTime];
            }
            else
            {
                [self.alert createTip:[NSString stringWithFormat:@"%@", message]];
            }
        }
        else
        {
            [self.alert createTip:message];
        }
        
        //隐藏菊花
        [self hidHud];
    }];
}

/**
 开启获取验证码定时器
 */
#pragma mark - 开启获取验证码定时器
- (void)achieveCaptchaStartTime
{
     __block NSInteger timeout = self.min_time_span; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                self.registerView.achieveCaptchaButton.backgroundColor=[UIColor clearColor];
                
                [self.registerView.achieveCaptchaButton setTitle:@"重新发送" forState:UIControlStateNormal];
                
                [self.registerView.achieveCaptchaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.registerView.achieveCaptchaButton.backgroundColor = [WLTools stringToColor:@"#00cc99"];
                
                self.registerView.achieveCaptchaButton.titleLabel.font=WLFontSize(13);
                
                self.registerView.achieveCaptchaButton.enabled = YES;
                self.registerView.achieveCaptchaButton.backgroundColor = [WLTools stringToColor:@"#00cc99"];
                self.registerView.achieveCaptchaButton.layer.borderColor = [WLTools stringToColor:@"#00cc99"].CGColor;
                
            });
        }
        else
        {
            // int minutes = timeout / 60;
            int seconds = timeout % 61;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                //DLog(@"____%@",strTime);
                [self.registerView.achieveCaptchaButton setTitle:[NSString stringWithFormat:@"%@秒",strTime] forState:UIControlStateNormal];
                [self.registerView.achieveCaptchaButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                //self.registerView.achieveCaptchaButton.titleLabel.textColor = [WLTools stringToColor:@"#00cc99"];
                self.registerView.achieveCaptchaButton.titleLabel.font=WLFontSize(13);
                self.registerView.achieveCaptchaButton.enabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

/** 验证码登录 */
#pragma mark - 校验验证码是否正确
- (void)sendRequestToRegister
{
    //显示菊花
    [self showHud];
    
    [[WLNetworkLoginHandler sharedInstance] loginWithUserName:self.registerView.phoneNumField.text password:self.registerView.captchaField.text isSMSLogin:YES result:^(BOOL success, BOOL result, NSString *token, NSString *message) {
        
        if (success) {
            if (result) {
                [self.alert createTip:@"登录成功"]; // 验证码登录

                //将用户token保存到本地
                [WLUserTools saveAccessToken:token];
                [WLUserTools saveUserMobile:self.registerView.phoneNumField.text];
                
                //主线程设置TabBar为窗口的根控制器
                dispatch_async(dispatch_get_main_queue(), ^{
                    WL_TabBarController *tabBar = [[WL_TabBarController alloc] init];
                    [ShareApplicationDelegate window].rootViewController = tabBar;
                });
            }
            else
            {
                [self.alert createTip:@"验证码错误"];
            }
        }
        else
        {
            [self.alert createTip:@"登录失败,请检查您的网络"];
        }
        
        //隐藏菊花
        [self hidHud];
        
    }];
}

/** 忘记密码==修改密码 */
- (void)ChangePassWordNet
{
    if (![self.registerView.againPassWordField.text isEqual:self.registerView.passWordField.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"两次密码不一致，请重新输入！！" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert show];
        return;
    }
    //显示菊花
    [self showHud];
    BOOL isfoget;
    if (_verificationStatus == WL_Recovery)
    {
        // 忘记密码
        isfoget = YES;
    }
    else if (_verificationStatus == WL_ResetPassword)
    {
        // 修改密码
        isfoget = NO;
    }
    
    [[WLNetworkLoginHandler sharedInstance] changePassWord:self.registerView.phoneNumField.text password:self.registerView.againPassWordField.text isSMSLogin:self.registerView.captchaField.text isForget:isfoget  result:^(BOOL success, BOOL result, NSString *message) {
        if (success) {
            if (result) {
                [self.alert createTip:@"密码修改成功"];
                if (_verificationStatus == WL_Recovery)
                {
                    // 忘记密码
                    [self.navigationController popViewControllerAnimated:NO];
                }
                else if (_verificationStatus == WL_ResetPassword)
                {
                    // 修改密码
                    //主线程设置TabBar为窗口的根控制器
                    dispatch_async(dispatch_get_main_queue(), ^{
                        WL_TabBarController *tabBar = [[WL_TabBarController alloc] init];
                        [ShareApplicationDelegate window].rootViewController = tabBar;
                    });
                }
            }
            else
            {
                [self.alert createTip:@"验证码错误"];
            }
        }
        else
        {
            [self.alert createTip:message];
        }
        
        //隐藏菊花
        [self hidHud];
    }];
}

// 注册
- (void)RegisterRegister
{
    //显示菊花
    [self showHud];
    
    [[WLNetworkLoginHandler sharedInstance] RegisterRegisterWithPhone:self.registerView.phoneNumField.text password:self.registerView.passWordField.text isSMSLogin:self.registerView.captchaField.text result:^(BOOL success, BOOL result,NSString *token, NSString *message) {
        if (success) {
            if (result) {
                [self.alert createTip:@"注册成功"];
                
                //将用户token保存到本地
                [WLUserTools saveAccessToken:token];
                [WLUserTools saveUserMobile:self.registerView.phoneNumField.text];
                
                //主线程设置TabBar为窗口的根控制器
                dispatch_async(dispatch_get_main_queue(), ^{
                    WL_TabBarController *tabBar = [[WL_TabBarController alloc] init];
                    [ShareApplicationDelegate window].rootViewController = tabBar;
                });
            }
            else
            {
                [self.alert createTip:@"验证码错误"];
            }
        }
        else
        {
            if ([token isEqual:@"400"]) {
                [self.alert createTip:message];
            }
            else
            {
                [self.alert createTip:message];
            }
        }
        
        //隐藏菊花
        [self hidHud];
    }];
}

// 修改原手机号
- (void)changePhone
{
    //显示菊花
    [self showHud];
    [[WLNetworkLoginHandler sharedInstance] ChangePhoneWithUserName:self.registerView.phoneNumField.text password:self.registerView.captchaField.text isNew:NO result:^(BOOL success, BOOL result, NSString *message) {
        if (success) {
            WL_SettingPassword_ViewController *settingPassword = [[WL_SettingPassword_ViewController alloc] init];
            settingPassword.verificationStatus = WL_ChangePhoneNum;
            [self.navigationController pushViewController:settingPassword animated:YES];
        }
        else
        {
            [self.alert createTip:message];
        }
        //隐藏菊花
        [self hidHud];
    }];
}

//当控制器销毁时,移除弹框控件
- (void)dealloc
{
    [self.alert removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //textField失去第一响应者
    [self.registerView.phoneNumField resignFirstResponder];
    [self.registerView.captchaField resignFirstResponder];
}

- (void)lookButtonClick
{
    WLEndUserLicenseViewController * nextVC = [[WLEndUserLicenseViewController alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}


@end
