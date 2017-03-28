//
//  WL_Mine_Setting_ValidationOldPassword_ViewController.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/12.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  验证原密码控制器

#import "WL_Mine_Setting_ValidationOldPassword_ViewController.h"

#import "WL_Mine_Setting_ValidationOldPassword_View.h"

#import "WL_Mine_Setting_ChangePhoneNum_ViewController.h"

#import "WL_Mine_Setting_ValidationSucceed_ViewController.h"

@interface WL_Mine_Setting_ValidationOldPassword_ViewController ()<UITextFieldDelegate>

/** 用户输入的原密码 */
@property(nonatomic, copy)NSString *oldPassword;

@property(nonatomic, weak)WL_Mine_Setting_ValidationOldPassword_View *validationOldPasswordView;

@property(nonatomic, strong)WL_TipAlert_View *alert;

@end

@implementation WL_Mine_Setting_ValidationOldPassword_ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    //设置Nav
    [self setupNavToValidationOldPassword];
    //设置内容
    [self setupContentViewToValidationOldPassword];
    //注册弹框
    [self creatTipAlertView];
    
}

#pragma mark - 注册弹框
- (void)creatTipAlertView
{
    self.alert = [WL_TipAlert_View sharedAlert];
    
}

#pragma mark - 设置验证原密码的Nav
- (void)setupNavToValidationOldPassword
{
    self.title = @"验证原密码";
}

#pragma mark - 设置验证原密码的内容 View
- (void)setupContentViewToValidationOldPassword
{
    self.view.backgroundColor = BgViewColor;
    WL_Mine_Setting_ValidationOldPassword_View *validationOldPasswordView = [[WL_Mine_Setting_ValidationOldPassword_View alloc] init];
    [self.view addSubview:validationOldPasswordView];
    [validationOldPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    //接收用户输入的密码
    validationOldPasswordView.oldPasswordField.delegate = self;
    validationOldPasswordView.oldPasswordField.text = self.oldPassword;
    [validationOldPasswordView.oldPasswordField addTarget:self action:@selector(oldPasswordDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    //添加按钮点击事件
    [validationOldPasswordView.nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.validationOldPasswordView = validationOldPasswordView;
    
}

#pragma mark - 检测原密码输入框输入文字的变化
- (void)oldPasswordDidChanged:(UITextField *)textField
{
    self.oldPassword = textField.text;
    //判断原密码输入框中输入的密码是否为6 - 20位
    if (textField.text.length >= 6)
    {
        self.validationOldPasswordView.nextButton.userInteractionEnabled = YES;
        self.validationOldPasswordView.nextButton.alpha = 1.0f;
    }
    else
    {
        self.validationOldPasswordView.nextButton.userInteractionEnabled = NO;
        self.validationOldPasswordView.nextButton.alpha = 0.5f;
    }

    
}

#pragma mark - 添加按钮点击事件方法
- (void)nextButtonClick
{
    //发送请求,验证密码是否正确
    [self sendRequestToVerificationOldPassword];
    
}

#pragma mark - 点击控制器View调用方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //键盘退出
    [self resignFirstResponderTextField];
}

//键盘退出方法
- (void)resignFirstResponderTextField
{
    //textField失去第一响应者
    [ self.validationOldPasswordView.oldPasswordField resignFirstResponder];

 
}

#pragma mark - 发送请求验证原密码是否正确
- (void)sendRequestToVerificationOldPassword
{
    //请求地址
    NSString *urlStr = VerificationOldPasswordUrl;
    
    //请求参数
    //进行RSA加密后的密码字符串
    NSString *userPassword = [MyRSA encryptString:self.oldPassword publicKey:RSAKey];
    NSString *oldPassword = userPassword;
    NSString *phoneNum = [WLUserTools getUserMobile];
    //登录参数
    NSDictionary *params = @{
                             @"user_mobile" : phoneNum,
                             @"user_password" : userPassword,
                             @"oldPassword" : oldPassword
                             };
    //请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    manager.requestSerializer.timeoutInterval = 30;
    //显示登录菊花
    [self showHud];
    
    [manager POST:urlStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        if ([responseObject[@"result"] intValue] == 1)
        {
            //验证成功
            //验证成功,弹框成功信息
            [self.alert createTip:[NSString stringWithFormat:@"验证成功"]];
            //跳转修改手机号码控制器
            WL_Mine_Setting_ChangePhoneNum_ViewController *changePhoneNumVc = [[WL_Mine_Setting_ChangePhoneNum_ViewController alloc] init];
            changePhoneNumVc.title = @"输入新号码";
            changePhoneNumVc.view.backgroundColor = BgViewColor;
            [self.navigationController pushViewController:changePhoneNumVc animated:YES];

            
        }
        else
        {
            //验证失败,弹框失败信息
            [self.alert createTip:[NSString stringWithFormat:@"%@", responseObject[@"msg"]]];
        }
        
        [self hidHud];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        [self hidHud];
//        [self.alert createTip:[NSString stringWithFormat:@"%@", error]];
        if (error.code == -1009) {
            [self.alert createTip:@"登录失败,请检查您的网络"];
        }
        else
        {
            [self.alert createTip:@"登录失败,请稍后再试"];
        }
    }];
  
}

- (void)dealloc
{
    [self.alert removeFromSuperview];
}




@end
