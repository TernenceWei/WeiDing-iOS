//
//  WL_SettingPassword_ViewController.m
//  WeiLvDJS
//
//  Created by zhaoxiao on 16/9/1.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_SettingPassword_ViewController.h"

#import "WL_TabBarController.h"

//引入注册页面View
#import "WL_Register_View.h"
#import "WL_Login_ViewController.h"

@interface WL_SettingPassword_ViewController ()
{
    dispatch_source_t _timer ;
}

/** 注册View */
@property(nonatomic, weak)WL_Register_View *registerView;

/** 验证码间隔事件 */
@property(nonatomic, assign) NSInteger min_time_span;

/** 电话号码输入框中输入的电话号码 */
@property(nonatomic ,copy)NSString *phoneNum;

/** 验证码输入框中输入的验证码 */
@property(nonatomic ,copy)NSString *captcha;
/** 弹出框 */
@property(nonatomic, strong)WL_TipAlert_View *alert;

@end

@implementation WL_SettingPassword_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //设置注册页面UI
    [self setupRegisterUI];
    
    self.titleItem.title =self.title;
    
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
        make.top.equalTo(@64);
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
        self.title = @"设置新手机号";
        [registerView setupLoginButton:@"WL_ChangePhoneNum"];
    }
    
    //点击了下一页的按钮
    [registerView.nextButton addTarget:self action:@selector(settingPassword) forControlEvents:UIControlEventTouchUpInside];
}

//检测验证码输入框文字
- (void)captchaFieldTextChanged:(UITextField *)textField
{
    WlLog(@"%@", textField.text);
    self.captcha = textField.text;
    [self monitorTextFieldTextChange];
}

//检测手机号码输入框文字
- (void)phoneNumFieldTextChanged:(UITextField *)textField
{
    WlLog(@"phoneNumFieldTextChanged %@", textField.text);
    self.phoneNum = textField.text;
    //判断下一页按钮是否可点
    [self monitorTextFieldTextChange];
}

//判断输入框和验证码输入框是否都有值
- (void)monitorTextFieldTextChange
{
    //如果不是都有值,下一页按钮不可点
    if (self.captcha == nil || self.phoneNum == nil || self.captcha.length == 0 || self.phoneNum.length == 0)
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
//    WL_SettingPassword_ViewController *settingPassword = [[WL_SettingPassword_ViewController alloc] init];
//    [self.navigationController pushViewController:settingPassword animated:YES];
    //校验验证码是否正确
    [self sendRequestToRegister];
    
}

#pragma mark - 发送验证码按钮点击事件
- (void)achieveCaptchaButtonClick
{
    //如果输入的是11位号码并且不包含空格
    if (self.phoneNum.length == 0 || self.phoneNum == nil) {
        [self.alert createTip:@"手机号码不能为空!"];
        return;
    }
    
    
    if (self.phoneNum.length != 11 || [self.phoneNum rangeOfString:@" "].location != NSNotFound)
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
    //验证码类型
    NSString *code_type = @"0";//[NSString stringWithFormat:@"%zd", self.verificationStatus];
    
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
                
                self.registerView.achieveCaptchaButton.titleLabel.font=WLFontSize(13);
                self.registerView.achieveCaptchaButton.enabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

/** 校验验证码是否正确 */
#pragma mark - 校验验证码是否正确
- (void)sendRequestToRegister
{
    [[WLNetworkLoginHandler sharedInstance] ChangePhoneWithUserName:self.registerView.phoneNumField.text password:self.registerView.captchaField.text isNew:YES result:^(BOOL success, BOOL result, NSString *message) {
        if (success) {
            
            [WLKeychainTool deleteKeychainValue:@"user_mobile"];
            [WLKeychainTool deleteKeychainValue:@"access_token"];
            
            [WLKeychainTool deleteKeychainValue:@"CompanyID"];
            
            [WLUserTools saveUserMobile:self.registerView.phoneNumField.text];
            
            [self.alert createTip:@"手机号修改成功"];
            
            WL_Login_ViewController *loginVC = [[WL_Login_ViewController alloc] init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }
        else
        {
            [self.alert createTip:message];
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //textField失去第一响应者
    [self.registerView.phoneNumField resignFirstResponder];
    [self.registerView.captchaField resignFirstResponder];
}

//当控制器销毁时,移除弹框控件
- (void)dealloc
{
    [self.alert removeFromSuperview];
}

@end
