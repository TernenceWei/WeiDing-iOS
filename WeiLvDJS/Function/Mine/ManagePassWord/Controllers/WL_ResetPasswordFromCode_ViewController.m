//
//  WL_ResetPasswordFromCode_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/19.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_ResetPasswordFromCode_ViewController.h"

#import "WL_Replacement_ViewController.h"

#import "WL_MangerWord_ViewController.h"

#import "WL_SetPayPassWord_ViewController.h"

@interface WL_ResetPasswordFromCode_ViewController ()<UITextFieldDelegate>

{
    UITextField *codeTextField;
    
    UITextField *passwordTextField;
}

@property(nonatomic,strong)UIButton *codeButton;


@end

@implementation WL_ResetPasswordFromCode_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor =BgViewColor;
    
    self.navigationItem .title =@"重置支付密码";
    
    [self createUI];
}


-(void)createUI
{
    UIView *backGroundView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 90)];
    backGroundView.backgroundColor =[UIColor whiteColor];
    
    [self.view addSubview:backGroundView];
    
    UILabel *codeLabel =[WLTools allocLabel:@"短信验证码" font:WLFontSize(14) textColor:BlackColor frame:CGRectMake(10, 0, 100, 45) textAlignment:NSTextAlignmentLeft];
    [backGroundView addSubview:codeLabel];
    
    codeTextField =[[UITextField alloc]initWithFrame:CGRectMake(ViewRight(codeLabel), 0, ScreenWidth-120-10-100, 45)];
    
    codeTextField.font =WLFontSize(14);
    
    codeTextField.delegate = self;
    
    codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    
    [backGroundView addSubview:codeTextField];
    
    UILabel *line =[[UILabel alloc]initWithFrame:CGRectMake(10, ViewBelow(codeLabel), ScreenWidth-10, 0.5)];
    line.backgroundColor = bordColor;
    
    [backGroundView addSubview:line];
    
    
    self.codeButton =[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-70-10, 0, 70, 45)];
    
    [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    self.codeButton.titleLabel.font =WLFontSize(14);
    
    [self.codeButton setTitleColor:WLColor(73, 119, 231, 1) forState:UIControlStateNormal];
    
    [self.codeButton addTarget:self action:@selector(codeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [backGroundView addSubview:self.codeButton];
    
    UILabel *identityLabel =[WLTools allocLabel:@"登录密码" font:WLFontSize(14) textColor:BlackColor frame:CGRectMake(10,ViewBelow(codeLabel), 100, 45) textAlignment:NSTextAlignmentLeft];
    [backGroundView addSubview:identityLabel];
    
    
    passwordTextField =[[UITextField alloc]initWithFrame:CGRectMake(ViewX(codeTextField), ViewBelow(codeLabel), ScreenWidth-100-10, 45)];
    
    passwordTextField.font =WLFontSize(14);
    
    passwordTextField.delegate = self;
    
    passwordTextField.placeholder =@"请输入登录密码";
    
    passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    passwordTextField.secureTextEntry = YES;
    
    [passwordTextField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    
    [backGroundView addSubview:passwordTextField];
    
    UIButton *confirmButton =[[UIButton alloc]initWithFrame:CGRectMake(45, ViewBelow(backGroundView)+45, ScreenWidth-90, 45)];
    
    [confirmButton setBackgroundColor:WLColor(140, 157, 244, 1)];
    
    [confirmButton setTitle:@"下一步" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    confirmButton.layer.cornerRadius = 3.0;
    [self.view addSubview:confirmButton];
    
    
}

-(void)codeButtonClick
{
    
    [self sendRequestToCaptcha];
    
}

- (void)sendRequestToCaptcha
{
    //发送验证码请求Url
    NSString *urlStr = CaptchaUrl;
    //电话号码参数 user_mobile
    NSString *phoneNum = [WLUserTools getUserMobile];
    //验证码类型,重置支付密码 传12
    NSString *code_type = @"12";
    
    //登录请求参数
    NSDictionary *params = @{
                             @"user_mobile" : phoneNum,
                             @"code_type" : code_type
                             };
 
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager]requestWithURL: urlStr RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([network_Model.result isEqualToString:@"1"]) {
            
            [weakSelf startTime];
            
        }else
        {
            [[WL_TipAlert_View sharedAlert]createTip:network_Model.msg];
        }
        
       
        
    } Failure:^(NSError *error) {
        
        
      
        
        [[WL_TipAlert_View sharedAlert]createTip:@"验证码获取失败"];
        
    }];
    
    
}

#pragma mark-验证码计时
-(void)startTime
{
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.codeButton setTitle:@"重新获取" forState:UIControlStateNormal];
                
                self.codeButton.x = ScreenWidth-60-10;
                self.codeButton.width = 60;
                
                self.codeButton.userInteractionEnabled = YES;
            });
        }
        else
        {
            
            int seconds = timeout % 60;
            
            NSString *strTime;
            
            if (timeout==60)
            {
                
                strTime=[NSString stringWithFormat:@"%d", 60];
                
            }
            else
            {
                
                strTime = [NSString stringWithFormat:@"%02d", seconds];
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.codeButton setTitle:[NSString stringWithFormat:@"获取验证码(%@秒)",strTime] forState:UIControlStateNormal];
                
                self.codeButton.width = 120;
                
                self.codeButton.x= ScreenWidth-110-10;
                
                self.self.codeButton.userInteractionEnabled = NO;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
}



-(void)confirmButtonClick
{
    [self.view endEditing:YES];
    
    if (codeTextField.text.length==0) {
        
        [[WL_TipAlert_View sharedAlert]createTip:@"请输入验证码"];
        return;
    }
    
    if (passwordTextField.text.length==0) {
        
        [[WL_TipAlert_View sharedAlert]createTip:@"请输入登录密码"];
        
        return;
    }
    
    
    [self goNext];
}

-(void)goNext
{
    
    NSString *user_id =[WLUserTools getUserId];
    
    NSString *user_password =[WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:user_password publicKey:RSAKey];
    
    
    NSDictionary *dict =@{@"user_id":user_id,@"user_password":encryptStr,@"password":encryptStr,@"type":@"2",@"code":codeTextField.text};
    
    
    WS(weakSelf);
    
    [self showHud];
    
    [[WLHttpManager shareManager]requestWithURL:ForgetPayPassUrl RequestType:RequestTypePost Parameters:dict Success:^(id responseObject) {
        
        
        
        [weakSelf hidHud];
        
        WL_Network_Model *net_model =[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([net_model.result isEqualToString:@"1"]) {
            
            WL_Replacement_ViewController *VC =[[WL_Replacement_ViewController alloc]init];
            
            [self.navigationController pushViewController:VC animated:YES];
            
        }else
            
        {
            [[WL_TipAlert_View sharedAlert]createTip:net_model.msg];
        }
        
        
    } Failure:^(NSError *error) {
        
        [weakSelf hidHud];
        
        
        if (error.code ==-1009)
        {
            
            [[WL_TipAlert_View sharedAlert]createTip:@"似乎已断开与互联网的连接"];
            
        }else
        {
            [[WL_TipAlert_View sharedAlert]createTip:@"服务器错误,请稍后重试"];
        }

        
    }];
    
    
}




-(void)textChange:(UITextField *)textField
{
    
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
