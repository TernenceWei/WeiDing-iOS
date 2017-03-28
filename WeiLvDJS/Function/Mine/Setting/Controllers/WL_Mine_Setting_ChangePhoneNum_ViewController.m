//
//  WL_Mine_Setting_ChangePhoneNum_ViewController.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Mine_Setting_ChangePhoneNum_ViewController.h"
/** 导入验证成功页面 */
#import "WL_Mine_Setting_ValidationSucceed_ViewController.h"

#import "WL_Register_View.h"

@interface WL_Mine_Setting_ChangePhoneNum_ViewController ()
{
    dispatch_source_t _timer ;
}


/** 验证码间隔事件 */
@property(nonatomic, assign)int min_time_span;

/** 弹出框 */
@property(nonatomic, strong)WL_TipAlert_View *alert;

/** 电话号码输入框中输入的电话号码 */
@property(nonatomic ,copy)NSString *phoneNum;

/** 验证码输入框中输入的验证码 */
@property(nonatomic ,copy)NSString *captcha;

/** 修改手机号的内容View */
@property(nonatomic ,weak)WL_Register_View *changePhoneView;



@end

@implementation WL_Mine_Setting_ChangePhoneNum_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置内容
    [self setupContentViewToChangePhoneNum];
    //注册弹框
    [self creatTipAlertViewToRegister];
    
}

#pragma mark - 注册弹框
- (void)creatTipAlertViewToRegister
{
    self.alert = [WL_TipAlert_View sharedAlert];
    
}


#pragma mark - 设置修改手机号码内容
- (void)setupContentViewToChangePhoneNum
{
    //获取验证码View
    WL_Register_View *changePhoneView = [[WL_Register_View alloc] init];
    //设置背景颜色
    changePhoneView.backgroundColor = BgViewColor;
    //添加到父控件
    [self.view addSubview:changePhoneView];
    //添加获取验证码View的约束
    [changePhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    //设置子控件的属性
    changePhoneView.titleLable.hidden = YES;
    [changePhoneView.inputView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(changePhoneView.mas_top).offset(15);
    }];
    //修改完成按钮的文字
    [changePhoneView.nextButton setTitle:@"完成" forState:UIControlStateNormal];
    changePhoneView.nextButton.userInteractionEnabled = NO;
    changePhoneView.nextButton.alpha = 0.5f;
    //修改手机号码输入框的placeholder文字
    changePhoneView.phoneNumField.placeholder = @"请输入新的手机号";
    
//    //将手机号码输入框与验证码输入框输入键盘改为数字键盘
//    changePhoneView.phoneNumField.keyboardType = UIKeyboardTypeNumberPad;
//    changePhoneView.captchaField.keyboardType = UIKeyboardTypeNumberPad;
    
    //为号码输入框添加监听
    [changePhoneView.phoneNumField addTarget:self action:@selector(phoneNumberChanged:) forControlEvents:UIControlEventEditingChanged];
    //为验证码输入框添加监听
    [changePhoneView.captchaField addTarget:self action:@selector(captchaNumChanged:) forControlEvents:UIControlEventEditingChanged];
    self.changePhoneView = changePhoneView;
    
    //为完成按钮添加点击方法
    [changePhoneView.nextButton addTarget:self action:@selector(finishClick) forControlEvents:UIControlEventTouchUpInside];
    //为获取验证码添加点击事件
    [changePhoneView.achieveCaptchaButton addTarget:self action:@selector(achieveCaptchaClick) forControlEvents:UIControlEventTouchUpInside];
    
  
}

#pragma mark - 获取验证码按钮点击方法
- (void)achieveCaptchaClick
{
    //如果输入的是11位号码并且不包含空格
    if (self.phoneNum.length == 0 || self.phoneNum == nil) {
        [self.alert createTip:@"手机号码不能为空!"];
        return;
    }
    
    
    if (![RegexTools isMobileNumber:self.phoneNum])
    {
        [self.alert createTip:@"请输入正确的手机号码"];
        return;
        
    }
    //发送获取验证码请求
    [self sendRequestToCaptcha];
    
}

#pragma mark - 发送获取验证码请求
- (void)sendRequestToCaptcha
{
    //请求Url
    NSString *urlStr = CaptchaUrl;
    //参数
    NSDictionary *params = @{
                             @"user_mobile" : self.phoneNum,
                             @"code_type" : @"3"
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
            //弹框提示信息
            [self.alert createTip:[NSString stringWithFormat:@"%@", responseObject[@"msg"]]];
            
            return;
        }
        
        //弹框提示信息
        [self.alert createTip:[NSString stringWithFormat:@"%@", responseObject[@"msg"]]];
        self.min_time_span = [responseObject[@"min_time_span"] intValue];
        //发送验证码按钮不可变
        self.changePhoneView.achieveCaptchaButton.enabled = NO;
        //获取动态密码倒计时
        [self achieveCaptchaStartTime];
        
        //隐藏菊花
        [self hidHud];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //隐藏菊花
        [self hidHud];
        //弹框提示信息
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



#pragma mark - 监听电话号码输入框的输入文字
- (void)phoneNumberChanged:(UITextField *)textField
{
    self.phoneNum = textField.text;
    //判断完成按钮是否可以点击
    [self confirmFinishClick];
}

#pragma mark - 监听验证码输入框的输入文字
- (void)captchaNumChanged:(UITextField *)textField
{
    self.captcha = textField.text;
    //判断完成按钮是否可以点击
    [self confirmFinishClick];
    
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
                self.changePhoneView.achieveCaptchaButton.backgroundColor=[UIColor clearColor];
                
                [self.changePhoneView.achieveCaptchaButton setTitle:@"重新发送" forState:UIControlStateNormal];
                
                [self.changePhoneView.achieveCaptchaButton setTitleColor:WLColor(92, 179, 228, 1) forState:UIControlStateNormal];
                self.changePhoneView.achieveCaptchaButton.backgroundColor = [UIColor whiteColor];
                
                self.changePhoneView.achieveCaptchaButton.titleLabel.font=WLFontSize(13);
                
                self.changePhoneView.achieveCaptchaButton.enabled = YES;
                
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
                [self.changePhoneView.achieveCaptchaButton setTitle:[NSString stringWithFormat:@"%@秒",strTime] forState:UIControlStateNormal];
                [self.changePhoneView.achieveCaptchaButton setTitleColor:WLColor(92, 179, 228, 1) forState:UIControlStateNormal];
                self.changePhoneView.achieveCaptchaButton.titleLabel.textColor = [UIColor whiteColor];
                self.changePhoneView.achieveCaptchaButton.titleLabel.font=WLFontSize(13);
                self.changePhoneView.achieveCaptchaButton.enabled = NO;
            });
            timeout--;
        }
    });
    
    dispatch_resume(_timer);
    
}

#pragma mark - 确认完成按钮是否可以点击
- (void)confirmFinishClick
{
    //如果不是都有值,下一页按钮不可点
    if (self.captcha == nil || self.phoneNum == nil || self.captcha.length == 0 || self.phoneNum.length == 0)
    {
        self.changePhoneView.nextButton.userInteractionEnabled = NO;
        self.changePhoneView.nextButton.alpha = 0.5;
    }
    else
    {
        self.changePhoneView.nextButton.userInteractionEnabled = YES;
        self.changePhoneView.nextButton.alpha = 1.0;
    }

}

#pragma mark - 完成按钮点击事件方法
- (void)finishClick
{
    //重新绑定手机号网络请求 Url
    NSString *urlStr = ChangeNewPhoneUrl;
    //从沙盒获取原手机号码
    NSString *oldPhone = [WLUserTools getUserMobile];
    //从沙盒获取密码
    NSString *userPassword = [WLUserTools getUserPassword];
    //对密码进行RSA加密
    NSString *passwordStr = [MyRSA encryptString:userPassword publicKey:RSAKey];
    //请求参数
    NSDictionary *params = @{
                             @"user_mobile" : oldPhone,
                             @"new_mobile" : self.phoneNum,
                             @"sms_verify_code" : self.captcha,
                             @"user_password" : passwordStr
                             };
    
    //请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    manager.requestSerializer.timeoutInterval = 30;
    //显示登录菊花
    [self showHud];

    //发送验证请求
    [manager POST:urlStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"result"] intValue] != 1)
        {
            //隐藏菊花
            [self hidHud];
            //弹框提示信息
            [self.alert createTip:[NSString stringWithFormat:@"%@", responseObject[@"msg"]]];
            
            return;

        }
        //弹框提示信息
        [self.alert createTip:@"更换成功"];
        //修改手机号成功,跳转成功页面
        WL_Mine_Setting_ValidationSucceed_ViewController *validationSuccessedVc = [[WL_Mine_Setting_ValidationSucceed_ViewController alloc] init];
        //修改手机号码状态
        validationSuccessedVc.succeedStatus = WL_ChangePhoneNum;
        [self.navigationController pushViewController:validationSuccessedVc animated:YES];
        //更新本地保存的手机号码
        [WLUserTools saveUserMobile:self.phoneNum];
        
        //隐藏菊花
        [self hidHud];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //隐藏菊花
        [self hidHud];
    }];
    
    
}

- (void)dealloc
{
    [self.alert removeFromSuperview];
}



@end
