//
//  WL_Mine_Setting_Account_ChangePassword_ViewController.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/12.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  修改密码控制器

#import "WL_Mine_Setting_Account_ChangePassword_ViewController.h"

#import "WL_Register_View.h"

#import "WL_Mine_Setting_SetNewPassword_ViewController.h"

@interface WL_Mine_Setting_Account_ChangePassword_ViewController ()

{
    dispatch_source_t _timer ;
}

@property(nonatomic, weak)WL_Register_View *verificationView;

/** 验证码间隔事件 */
@property(nonatomic, assign)int min_time_span;

/** 电话号码输入框中输入的电话号码 */
@property(nonatomic ,copy)NSString *phoneNum;

/** 验证码输入框中输入的验证码 */
@property(nonatomic ,copy)NSString *captcha;
/** 弹出框 */
@property(nonatomic, strong)WL_TipAlert_View *alert;

@end

@implementation WL_Mine_Setting_Account_ChangePassword_ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.verificationView.nextButton.userInteractionEnabled = NO;
    self.verificationView.nextButton.alpha = 0.5;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.设置Nav内容
    [self setupNavToChangePassword];
    //2.设置界面内容
    [self setupContentToChangePassword];
    //注册弹框
    [self creatTipAlertViewToRegister];
    
}

#pragma mark - 注册弹框
- (void)creatTipAlertViewToRegister
{
    self.alert = [WL_TipAlert_View sharedAlert];
    
}

#pragma mark - 设置界面内容
- (void)setupContentToChangePassword
{
    //内容View
    WL_Register_View *verificationView = [[WL_Register_View alloc] init];
    //添加到父控件
    [self.view addSubview:verificationView];
    //设置属性
    verificationView.backgroundColor = BgViewColor;
    //添加约束
    [verificationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.view.mas_top);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    self.verificationView = verificationView;
    
//    //将手机号码输入框与验证码输入框输入键盘改为数字键盘
//    verificationView.phoneNumField.keyboardType = UIKeyboardTypeNumberPad;
//    verificationView.captchaField.keyboardType = UIKeyboardTypeNumberPad;
    
    //验证码输入框
    [verificationView.captchaField addTarget:self action:@selector(captchaFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
    [verificationView.phoneNumField addTarget:self action:@selector(phoneNumFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
    //点击了下一页的按钮
    [verificationView.nextButton addTarget:self action:@selector(settingPassword) forControlEvents:UIControlEventTouchUpInside];
    
    //点击了发送验证码请求
    [verificationView.achieveCaptchaButton addTarget:self action:@selector(achieveCaptchaButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
  
}


//检测验证码输入框文字
- (void)captchaFieldTextChanged:(UITextField *)textField
{
    
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
        self.verificationView.nextButton.userInteractionEnabled = NO;
        self.verificationView.nextButton.alpha = 0.5;
    }
    else
    {
        self.verificationView.nextButton.userInteractionEnabled = YES;
        self.verificationView.nextButton.alpha = 1.0;
    }
}

#pragma 点击下一页按钮
- (void)settingPassword
{
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
    //发送验证码请求Url
    NSString *urlStr = CaptchaUrl;
    //电话号码参数 user_mobile
    NSString *phoneNum = self.verificationView.phoneNumField.text;
    //验证码类型
    int code_type = 2;
    
    //登录请求参数
    NSDictionary *params = @{
                             @"user_mobile" : phoneNum,
                             @"code_type" : @(code_type)
                             };
    //显示菊花
    [self showHud];
    
    //请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    manager.requestSerializer.timeoutInterval = 30;
    [manager POST:urlStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    }
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         if ([responseObject[@"result"] intValue] == 1)
         {
             
             [self.alert createTip:[NSString stringWithFormat:@"%@", responseObject[@"msg"]]];
             self.min_time_span = [responseObject[@"min_time_span"] intValue];
             //发送验证码按钮不可变
             self.verificationView.achieveCaptchaButton.enabled = NO;
             //获取动态密码倒计时
             [self achieveCaptchaStartTime];
             
             
         }
         else
         {
             [self.alert createTip:[NSString stringWithFormat:@"%@", responseObject[@"msg"]]];
         }
         //隐藏菊花
         [self hidHud];
         
     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         //隐藏菊花
         [self hidHud];
         //弹出框提示错误信息
         if (error.code == -1009) {
             [self.alert createTip:@"登录失败,请检查您的网络"];
         }
         else
         {
             [self.alert createTip:@"登录失败,请稍后再试"];
         }
     }];
    
}

/**
 开启获取验证码定时器
 */
#pragma mark - 开启获取验证码定时器
- (void)achieveCaptchaStartTime
{
    __block int timeout = self.min_time_span; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                self.verificationView.achieveCaptchaButton.backgroundColor=[UIColor clearColor];
                
                [self.verificationView.achieveCaptchaButton setTitle:@"重新发送" forState:UIControlStateNormal];
                
                [self.verificationView.achieveCaptchaButton setTitleColor:WLColor(92, 179, 228, 1) forState:UIControlStateNormal];
                self.verificationView.achieveCaptchaButton.backgroundColor = [UIColor whiteColor];
                
                self.verificationView.achieveCaptchaButton.titleLabel.font= WLFontSize(13);
                
                self.verificationView.achieveCaptchaButton.enabled = YES;
                
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
                [self.verificationView.achieveCaptchaButton setTitle:[NSString stringWithFormat:@"%@秒",strTime] forState:UIControlStateNormal];
                [self.verificationView.achieveCaptchaButton setTitleColor:WLColor(92, 179, 228, 1) forState:UIControlStateNormal];
                self.verificationView.achieveCaptchaButton.titleLabel.textColor = [UIColor whiteColor];
                self.verificationView.achieveCaptchaButton.titleLabel.font=WLFontSize(13);
                self.verificationView.achieveCaptchaButton.enabled = NO;
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
    //2.校验网络请求URL
    NSString *urlStr = CheckVerifyUrl;
    
    //验证码类型
    int code_type = 2;
    
    NSDictionary *params = @{
                             @"user_mobile" : self.verificationView.phoneNumField.text,
                             @"verify_code" : self.verificationView.captchaField.text,
                             @"code_type" : @(code_type)
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 30;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    //显示菊花
    [self showHud];
    [manager POST:urlStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    }
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         //如果返回结果为1,那么验证成功
         if ([responseObject[@"result"] intValue] != 1)
         {
             //隐藏菊花
             [self hidHud];
             [self.alert createTip:[NSString stringWithFormat:@"%@", responseObject[@"msg"]]];
             return;
         }
         
         
         WL_Mine_Setting_SetNewPassword_ViewController *setNewPasswordVc = [[WL_Mine_Setting_SetNewPassword_ViewController alloc] init];
         setNewPasswordVc.view.backgroundColor = BgViewColor;
         [self.navigationController pushViewController:setNewPasswordVc animated:YES];
         
         
         
         
         //隐藏菊花
         [self hidHud];
     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         //隐藏菊花
         [self hidHud];
//         [self.alert createTip:[NSString stringWithFormat:@"%@", error]];
         if (error.code == -1009) {
             [self.alert createTip:@"登录失败,请检查您的网络"];
         }
         else
         {
             [self.alert createTip:@"登录失败,请稍后再试"];
         }
     }];
    
}


#pragma mark - 设置Nav内容
- (void)setupNavToChangePassword
{
    self.title = @"输入手机号";
}

//当控制器销毁时,移除弹框控件
- (void)dealloc
{
    [self.alert removeFromSuperview];
}



@end
