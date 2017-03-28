//
//  WL_Mine_Setting_SetNewPassword_ViewController.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  设置新密码控制器

#import "WL_Mine_Setting_SetNewPassword_ViewController.h"
#import "WL_Mine_Setting_SetNewPassword_View.h"

#import "WL_Mine_Setting_ValidationSucceed_ViewController.h"

@interface WL_Mine_Setting_SetNewPassword_ViewController ()

/** 新密码输入框中输入的密码 */
@property(nonatomic, copy)NSString *password;

/** 重复密码输入框中输入的密码 */
@property(nonatomic, copy)NSString *rePassword;

/** 弹出框 */
@property(nonatomic, strong)WL_TipAlert_View *alert;

/** 设置新密码View */
@property(nonatomic, weak)WL_Mine_Setting_SetNewPassword_View *setNewPassowrdView;
@end

@implementation WL_Mine_Setting_SetNewPassword_ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.setNewPassowrdView.succeedButton.userInteractionEnabled = NO;
    self.setNewPassowrdView.succeedButton.alpha = 0.5;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置控制器Nav
    [self setupNavToSettingNewPassword];
    
    //设置内容
    [self setupConrtentToSettingNewPassword];
    //注册弹框
    [self creatTipAlertViewToRegister];
    
}

#pragma mark - 注册弹框
- (void)creatTipAlertViewToRegister
{
    self.alert = [WL_TipAlert_View sharedAlert];
    
}

#pragma mark - 设置控制器Nav
- (void)setupNavToSettingNewPassword
{
    self.title = @"设置密码";
}

#pragma mark - 设置内容
- (void)setupConrtentToSettingNewPassword
{
    //初始化内容View
    WL_Mine_Setting_SetNewPassword_View *setNewPassowrdView = [[WL_Mine_Setting_SetNewPassword_View alloc] init];
    //添加到父控件
    [self.view addSubview:setNewPassowrdView];
    //添加约束
    [setNewPassowrdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    //设置检测方法
    //检测新密码输入框的文字
    [setNewPassowrdView.passwordTextField addTarget:self action:@selector(newPasswordInput:) forControlEvents:UIControlEventEditingChanged];
    //检测重复新密码输入框的文字
    [setNewPassowrdView.reNewPassowrdTextField addTarget:self action:@selector(reNewPasswordInput:) forControlEvents:UIControlEventEditingChanged];
    //检测完成按钮的点击
    [setNewPassowrdView.succeedButton addTarget:self action:@selector(succeedButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.setNewPassowrdView = setNewPassowrdView;

}


#pragma mark - 检测新密码输入框文字
- (void)newPasswordInput:(UITextField *)textField
{
    self.password = textField.text;
    //判断完成按钮是否可以点击
    [self confirmFinishClick];
}

#pragma mark - 检测重复新密码输入框的文字
- (void)reNewPasswordInput:(UITextField *)textField
{
    self.rePassword = textField.text;
    //判断完成按钮是否可以点击
    [self confirmFinishClick];
}

#pragma mark - 判断完成按钮是否可点击
- (void)confirmFinishClick
{
    //如果不是都有值,下一页按钮不可点
    if (self.password == nil || self.rePassword == nil || self.password.length == 0 || self.rePassword.length == 0)
    {
        self.setNewPassowrdView.succeedButton.userInteractionEnabled = NO;
        self.setNewPassowrdView.succeedButton.alpha = 0.5;
    }
    else
    {
        self.setNewPassowrdView.succeedButton.userInteractionEnabled = YES;
        self.setNewPassowrdView.succeedButton.alpha = 1.0;
    }
    
}

#pragma mark - 检测完成按钮的点击
- (void)succeedButtonClick
{
    //如果密码输入框没有输入密码
    if (self.password == nil || self.password.length == 0)
    {
        [self.alert createTip:@"密码不能为空"];
        return;
    }
    //如果密码输入框输入的密码不符合位数规则
    if (self.password.length < 6 || self.password.length > 20)
    {
        [self.alert createTip:@"请输入6-20位密码"];
        return;
    }
    //如果密码输入框输入的密码包含空格
    if ([self.password rangeOfString:@" "].location != NSNotFound)
    {
        [self.alert createTip:@"密码中不能包含空格"];
        return;
    }
    //如果确认密码输入框没有输入密码
    if (self.rePassword == nil || self.rePassword.length == 0)
    {
        [self.alert createTip:@"请输入确认密码"];
        return;
    }
    //如果两次输入的密码不一致
    if (![self.rePassword isEqualToString: self.password])
    {
        [self.alert createTip:@"两次输入密码不一致,请检查后重新输入"];
        return;
    }
    
    //发送网络请求设置新密码
    [self sendRequestToSettingNewPassword];
    
   
}

#pragma mark - 发送网络请求设置新密码
- (void)sendRequestToSettingNewPassword
{
    //网络请求Url
    NSString *urlStr = ChangeNewPassowrdUrl;
    
    //网络请求参数
    //获取用户手机号码
    NSString *phoneNum = [WLUserTools getUserMobile];
    //获取用户原有密码
    NSString *oldPassword = [WLUserTools getUserPassword];
    //对原有密码进行加密
    NSString *encryptStr = [MyRSA encryptString:oldPassword publicKey:RSAKey];
    //对新密码进行加密
    NSString *newPassword = [MyRSA encryptString:self.password publicKey:RSAKey];
    //RSA加密
    NSDictionary *params = @{
                             @"user_mobile" : phoneNum,
                             @"user_password" : encryptStr,
                             @"new_password" : newPassword
                             };
    
    //显示菊花
    [self showHud];
    
    //请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    manager.requestSerializer.timeoutInterval = 30;
    //发送网络请求
    [manager POST:urlStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"result"] intValue] != 1)
        {
            //隐藏菊花
            [self hidHud];
            //弹出提示文字
            [self.alert createTip:[NSString stringWithFormat:@"%@", responseObject[@"msg"]]];
            
            return;
        }
        //隐藏菊花
        [self hidHud];
        //将新设置的密码保存到本地
        [WLUserTools saveUserPassword:self.password];
        //跳转修改成功控制器
        WL_Mine_Setting_ValidationSucceed_ViewController *changeSucceed = [[WL_Mine_Setting_ValidationSucceed_ViewController alloc] init];
        //修改密码状态
        changeSucceed.succeedStatus = WL_ChangePassword;
        [self.navigationController pushViewController:changeSucceed animated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败后弹框提示错误信息
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

@end
