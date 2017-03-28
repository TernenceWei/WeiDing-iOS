//
//  WL_SetPayPassWord_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_SetPayPassWord_ViewController.h"

#import "RegexTools.h"

#import "WL_SetSucess_ViewController.h"

@interface WL_SetPayPassWord_ViewController ()<UITextFieldDelegate>
{
    UITextField *passWord;
    
    UITextField *secondTextField;
    
    UITextField *codeTextField;
}

@property(nonatomic,strong)UIButton *codeButton;

@end

@implementation WL_SetPayPassWord_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =BgViewColor;
    
    self.navigationItem.title =@"设置支付密码";
    
    [self initUI];
}

-(void)initUI
{
    
    UIView *backGroundView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 135)];
    backGroundView.backgroundColor =[UIColor whiteColor];
    
    [self.view addSubview:backGroundView];
    
    UILabel *payWord =[WLTools allocLabel:@"支付密码" font:WLFontSize(14) textColor:BlackColor frame:CGRectMake(10, 0, 100, 45) textAlignment:NSTextAlignmentLeft];
    
    [backGroundView addSubview:payWord];
    
    
    passWord = [[UITextField alloc]initWithFrame:CGRectMake(ViewRight(payWord), 0, ScreenWidth-100-10, 45)];
    
    passWord.font =WLFontSize(14);
    
    passWord.textColor = BlackColor;
    
    passWord.delegate =self;
    
    passWord.placeholder =@"请输入6位字符";
    
    passWord.clearButtonMode =UITextFieldViewModeWhileEditing;
    
    [backGroundView addSubview:passWord];
    
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, ScreenWidth-10, 0.5)];
    line1.backgroundColor =bordColor;
    
    [backGroundView addSubview:line1];
    
    
    UILabel *secondWord =[WLTools allocLabel:@"确认密码" font:WLFontSize(14) textColor:BlackColor frame:CGRectMake(ViewX(payWord), ViewBelow(payWord), ViewWidth(payWord), 45) textAlignment:NSTextAlignmentLeft];
    
    [backGroundView addSubview:secondWord];
    
    secondTextField =[[UITextField alloc]initWithFrame:CGRectMake(ViewX(passWord), ViewBelow(passWord), ViewWidth(passWord), 45)];
    
    secondTextField.font= WLFontSize(14);
    
    secondTextField.textColor =BlackColor;
    
    secondTextField.placeholder = @"确认密码";
    
    secondTextField.delegate =self;
    
    secondTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [backGroundView addSubview:secondTextField];
    
    
    UILabel *line2 =[[UILabel alloc]initWithFrame:CGRectMake(10, ViewBelow(secondWord), ScreenWidth-10, 0.5)];
    
    line2.backgroundColor = bordColor;
    
    [backGroundView addSubview:line2];
    
    
    UILabel *codeLabel =[WLTools allocLabel:@"短信验证码" font:WLFontSize(14) textColor:BlackColor frame:CGRectMake(10, ViewBelow(secondWord), 100, 45) textAlignment:NSTextAlignmentLeft];
    [backGroundView addSubview:codeLabel];
    
    codeTextField =[[UITextField alloc]initWithFrame:CGRectMake(ViewX(passWord), ViewBelow(secondWord), ScreenWidth-130-10-100, 45)];
    
    codeTextField.font =WLFontSize(14);
    
    codeTextField.delegate = self;
    
    codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    
    [backGroundView addSubview:codeTextField];
    

    self.codeButton =[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-70-10, ViewBelow(secondWord), 70, 45)];
    
    [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    self.codeButton.titleLabel.font =WLFontSize(14);
    
    [self.codeButton setTitleColor:WLColor(73, 119, 231, 1) forState:UIControlStateNormal];
    
    [self.codeButton addTarget:self action:@selector(codeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [backGroundView addSubview:self.codeButton];
    
    UIButton *confirmButton =[[UIButton alloc]initWithFrame:CGRectMake(45, ViewBelow(backGroundView)+45, ScreenWidth-90, 45)];
    
    [confirmButton setBackgroundColor:WLColor(140, 157, 244, 1)];
    
    [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    confirmButton.layer.cornerRadius = 3.0;
    [self.view addSubview:confirmButton];

}

#pragma mark --  确认按钮

-(void)confirmButtonClick

{
   
    if (codeTextField.text.length==0) {
        
        [[WL_TipAlert_View sharedAlert]createTip:@"请输入验证码"];
        
    }
    
    NSString *user_id = [WLUserTools getUserId];
    
    NSString *user_passWord =[WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:user_passWord publicKey:RSAKey];
    
    NSString *payWord = secondTextField.text;
    
    
    NSString *encryptPayWord = [MyRSA encryptString:payWord publicKey:RSAKey];
    
    NSDictionary *para = @{@"user_id":user_id,@"user_password":encryptStr,@"PayPassword":encryptPayWord,@"type":@"1",@"code":codeTextField.text};
    
    
    [[WLHttpManager shareManager]requestWithURL:MinePayPassWordUrl RequestType:RequestTypePost Parameters:para Success:^(id responseObject) {
       
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        WlLog(@"%@",network_Model);
        
        if ([network_Model.result isEqualToString:@"1"]) {
            
            WL_SetSucess_ViewController *VC =[[WL_SetSucess_ViewController alloc]init];
            
            VC.tip = @"恭喜你,支付密码设置成功!";
           
            VC.titleSting =@"设置支付密码";
            
            VC.type =@"1";
            
            [self.navigationController pushViewController:VC animated:YES];
            
        }else
        {
            [[WL_TipAlert_View sharedAlert]createTip:network_Model.msg];
        }
        
        
        
    } Failure:^(NSError *error) {
        
        [[WL_TipAlert_View sharedAlert]createTip:@"设置失败"];
    }];
}
-(void)codeButtonClick
{
   
    
    if (passWord.text.length==0) {
        [[WL_TipAlert_View sharedAlert]createTip:@"请输入支付密码"];
        
        return ;
    }
    
    
    if (![RegexTools isPassWordNumber:passWord.text]) {
        
        [[WL_TipAlert_View sharedAlert]createTip:@"请输入由英文或数字组合的6位密码"];
        
        return ;
    }
    
    if (secondTextField.text.length==0) {
        
       [[WL_TipAlert_View sharedAlert]createTip:@"请输入确认密码"];
        
        return;
        
    }
    if (![RegexTools isPassWordNumber:secondTextField.text]) {
         [[WL_TipAlert_View sharedAlert]createTip:@"请输入由英文或数字组合的6位密码"];
        
        return ;
    }
    
    if (![secondTextField.text isEqualToString:passWord.text]) {
       
        [[WL_TipAlert_View sharedAlert]createTip:@"两次输入的密码不一致"];
        
        return;
        
    }
    
    [self sendRequestToCaptcha];
}

#pragma mark - 发送获取验证码网络请求
- (void)sendRequestToCaptcha
{
    //发送验证码请求Url
    NSString *urlStr = CaptchaUrl;
    //电话号码参数 user_mobile
    NSString *phoneNum = [WLUserTools getUserMobile];
    //验证码类型,设置支付密码 传11
    NSString *code_type = @"11";
    
    //登录请求参数
    NSDictionary *params = @{
                             @"user_mobile" : phoneNum,
                             @"code_type" : code_type
                             };
    //显示菊花
  
    
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
                [self.codeButton setTitle:[NSString stringWithFormat:@"获取验证码%@",strTime] forState:UIControlStateNormal];

                self.codeButton.width = 120;
                
                self.codeButton.x= ScreenWidth-110-10;
                
                self.self.codeButton.userInteractionEnabled = NO;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
}

#pragma mark --- textField

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if ([string isEqualToString:@""])  //按删除键车可以改变
    {
        return YES;
    }
    if (textField ==passWord) {
    
        if (passWord.text.length>=6) {
            
            return NO;
        }
    }
    
    if (textField==secondTextField) {
       
        if (secondTextField.text.length >=6) {
            
            return NO;
        }
        
    }
    
    if (textField == codeTextField) {
      
        if (codeTextField.text.length >=6) {
            return NO;
        }
    }
    

    return YES;
    
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
