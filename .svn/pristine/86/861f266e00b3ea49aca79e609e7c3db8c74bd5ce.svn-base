//
//  WL_Login_ViewController.m
//  WeiLvDJS
//
//  Created by zhaoxiao on 16/8/30.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Login_ViewController.h"
//导入注册控制器
#import "WL_Register_ViewController.h"
#import "RSA.h"

#import "WL_UserInfo_Model.h"

#import "WL_TabBarController.h"

//导入登录View
#import "WL_Login_View.h"

@interface WL_Login_ViewController ()<UITextFieldDelegate,UIActionSheetDelegate>

@property(nonatomic, weak)WL_Login_View *loginView;

@property(nonatomic, strong)WL_UserInfo_Model *userInfo;

@property(nonatomic, strong)WL_TipAlert_View *alert;

@property(nonatomic ,assign)CGFloat scacle;

@end

@implementation WL_Login_ViewController

- (void)viewWillAppear:(BOOL)animated
{
    //[super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNavigationLeftImg:@""];
    //设置登录UI界面
    [self setupLoginUI];
    
    //注册弹框
    [self creatTipAlertView];
}


#pragma mark - 注册弹框
- (void)creatTipAlertView
{
    self.alert = [WL_TipAlert_View sharedAlert];
}

#pragma mark - 登录界面设置UI布局
- (void)setupLoginUI
{
    //登录界面Nav标题
    self.title = @"登录";

    //初始化登录页面的View
    WL_Login_View *loginView = [[WL_Login_View alloc] init];
   //将登录界面添加到登录控制器的View上
    [self.view addSubview:loginView];
    //添加约束
    [loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(35);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    self.loginView = loginView;
    //获取默认用户基本信息
    //[self getDefaultUser];

    //登录按钮被点击
    [loginView.loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //忘记密码按钮被点击
    [loginView.forgetPasswordButton addTarget:self action:@selector(forgetPasswordButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //环境切换按钮被点击
    [loginView.ChangeEnvironmentButton addTarget:self action:@selector(ChangeEnvironmentButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //新用户注册按钮被点击
    [loginView.registerButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //短信验证码按钮被点击
    [loginView.VerificationCodeButton addTarget:self action:@selector(VerificationCodeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //设置输入框的代理为登录控制器
    loginView.phoneNumField.delegate = self;
    loginView.passwordField.delegate = self;
    
    //为输入框添加通知
    [loginView.phoneNumField addTarget:self action:@selector(textfieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textfieldDidChange:(UITextField *)textField
{
    //self.loginView.logoImageView.image = [UIImage imageNamed:@"DJS_Logo"];
    self.loginView.logoImageView.hidden = YES;
    self.loginView.noUserlogoImageView.hidden = NO;
    self.loginView.noUserlogoImageView.image = [UIImage imageNamed:@"logo_denglu"];
}

#pragma mark - 获取默认用户信息
- (void)getDefaultUser
{
    //获取用户头像
    NSString *userPhoto = [WLUserTools getUserPhoto];
    //获取用户电话号码/账号
    NSString *userMobile = [WLUserTools getUserMobile];
   //本地没有存储用户的电话
    if ([userMobile isEqualToString:@""])
    {
        //self.loginView.logoImageView.image = [UIImage imageNamed:@"DJS_Logo"];
        self.loginView.logoImageView.hidden = YES;
        self.loginView.noUserlogoImageView.hidden = NO;
        self.loginView.noUserlogoImageView.image = [UIImage imageNamed:@"logo_denglu"];
        
        self.loginView.phoneNumField.text = @"";
    }
    else    //本地存储的有用户的电话 那么一定有用户的头像
    {
        self.loginView.logoImageView.hidden = NO;
        self.loginView.noUserlogoImageView.hidden = YES;
        
        self.loginView.phoneNumField.text = userMobile;
        NSURL *url = [NSURL URLWithString:userPhoto];
        [self.loginView.logoImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"about_logo60x60"]];
    }
}

//输入框的代理方法
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
//    [self.loginView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top).offset(-120);
//    }];
//    [self.view setNeedsUpdateConstraints];
//    [self.view updateConstraintsIfNeeded];
//    //更新LoginView的约束
//    [UIView animateWithDuration:0.3 animations:^{
//        [self.view layoutIfNeeded];
//    }];
    return YES;
}



//点击控制器的View调用方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //键盘退出
    [self resignFirstResponderTextField];
}

//键盘退出方法
- (void)resignFirstResponderTextField
{
    //textField失去第一响应者
    [self.loginView.phoneNumField resignFirstResponder];
    [self.loginView.passwordField resignFirstResponder];
    [self.loginView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(35);
    }];
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    //更新LoginView的约束
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}


#pragma mark - 登录按钮点击方法
- (void)loginButtonClick
{
    //键盘退出
    [self resignFirstResponderTextField];
    
    //判断账号是否为空
    if (self.loginView.phoneNumField.text.length == 0 || self.loginView.phoneNumField.text == nil)
    {
        [self.alert createTip:@"手机号码不能为空"];
        return;
    }
    //判断账号是否符合格式
    
//    if (![RegexTools isMobileNumber:self.loginView.phoneNumField.text])
//    {
//        [self.alert createTip:@"请输入正确的手机号码"];
//        return;
//    }
    //判断密码是否为空
    if (self.loginView.passwordField.text.length == 0 || self.loginView.passwordField.text == nil)
    {
        [self.alert createTip:@"请输入密码"];
        return;
    }
    //判断密码是否符合输入格式
    if (self.loginView.passwordField.text.length < 6 || self.loginView.passwordField.text.length > 20)
    {
        [self.alert createTip:@"请输入正确的密码"];
        return;
    }
    //发送登录请求
    [self sendRequestToLogin];

}

#pragma mark - 忘记密码按钮点击方法
- (void)forgetPasswordButtonClick
{
    WL_Register_ViewController *registerVc = [[WL_Register_ViewController alloc] init];
    //修改密码
    registerVc.verificationStatus = WL_Recovery;
    [self.navigationController pushViewController:registerVc animated:YES];
}

#pragma mark - 新用户注册按钮点击方法
- (void)registerButtonClick
{
    WL_Register_ViewController *registerVc = [[WL_Register_ViewController alloc] init];
    //注册会员
    registerVc.verificationStatus = WL_Register;
    [self.navigationController pushViewController:registerVc animated:YES];
}

#pragma mark - 验证码登录按钮点击方法
- (void)VerificationCodeButtonClick
{
    WL_Register_ViewController *registerVc = [[WL_Register_ViewController alloc] init];
    //短信登录
    registerVc.verificationStatus = WL_WithdrawDeposits;
    [self.navigationController pushViewController:registerVc animated:YES];
}

#pragma mark - 环境切换按钮点击方法
- (void)ChangeEnvironmentButtonClick
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"环境选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"开发环境",@"测试环境",@"预发环境",@"线上环境", nil];
    [actionSheet showInView:self.view];
}

#pragma mark----选择图片或者照相机
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0://开发
        {
            [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"ConfigurationCode"];

            break;
        }
            
        case 1://测试
        {
            [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"ConfigurationCode"];

        }
            break;
        case 2://预发
        {
            [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"ConfigurationCode"];
            
        }
            break;
        case 3://正式
        {
            [[NSUserDefaults standardUserDefaults] setInteger:100 forKey:@"ConfigurationCode"];

        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 发送登录请求
- (void)sendRequestToLogin
{
    //显示菊花
    [self showHud];
    
    [[WLNetworkLoginHandler sharedInstance] loginWithUserName:self.loginView.phoneNumField.text password:self.loginView.passwordField.text isSMSLogin:NO result:^(BOOL success, BOOL result, NSString *token, NSString *message) {
        
        //隐藏菊花
        [self hidHud];
        
        if (success) {
            if (result) {
                [self.alert createTip:@"登录成功"];
                //将用户token保存到本地
                [WLUserTools saveAccessToken:token];
                
                [WLUserTools saveUserMobile:self.loginView.phoneNumField.text];
                
                //主线程设置TabBar为窗口的根控制器
                dispatch_async(dispatch_get_main_queue(), ^{
                    WL_TabBarController *tabBar = [[WL_TabBarController alloc] init];
                    [ShareApplicationDelegate window].rootViewController = tabBar;
                });
            }
            else
            {
                [self.alert createTip:@"账户名或密码错误"];
            }
        }
        else
        {
            [self.alert createTip:message];
        }
        
    }];
}

#pragma mark - 保存用户基本信息到沙盒
- (void)achiveUserInfo
{
    //保存默认信息
    //用户密码
    [WLUserTools saveUserPassword:self.loginView.passwordField.text];
    //保存服务器返回的登录信息
    [WLUserTools saveUserWithUserInfo:self.userInfo];
    
}
//当控制器销毁时,移除弹框控件
- (void)dealloc
{
    [self.alert removeFromSuperview];
}

@end
