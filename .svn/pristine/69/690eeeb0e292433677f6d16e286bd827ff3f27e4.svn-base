//
//  WL_ Replacement_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Replacement_ViewController.h"
#import "WL_SetSucess_ViewController.h"

@interface WL_Replacement_ViewController ()<UITextFieldDelegate>
{
    UITextField *passWord;
    
    
    UITextField *secondTextField;
}

@end

@implementation WL_Replacement_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.view.backgroundColor = BgViewColor;
    
    self.navigationItem.title =@"重置支付密码";
    
    [self initUI];

}

-(void)initUI
{
    
    UIView *backGroundView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,90)];
    backGroundView.backgroundColor =[UIColor whiteColor];
    
    [self.view addSubview:backGroundView];
    
    UILabel *payWord =[WLTools allocLabel:@"支付密码" font:WLFontSize(14) textColor:BlackColor frame:CGRectMake(10, 0, 80, 45) textAlignment:NSTextAlignmentLeft];
    
    [backGroundView addSubview:payWord];
    
    
    passWord = [[UITextField alloc]initWithFrame:CGRectMake(ViewRight(payWord), 0, ScreenWidth-100-10, 45)];
    
    passWord.font =WLFontSize(14);
    
    passWord.textColor = BlackColor;
    
    passWord.delegate =self;
    
    passWord.placeholder =@"请输入6位数字";
    
    passWord.secureTextEntry =YES;
    
    passWord.clearButtonMode =UITextFieldViewModeWhileEditing;
    
    [passWord addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    
    [backGroundView addSubview:passWord];
    
    
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, ScreenWidth-10, 0.5)];
    line1.backgroundColor =bordColor;
    
    [backGroundView addSubview:line1];
    
    
    UILabel *secondWord =[WLTools allocLabel:@"确认密码" font:WLFontSize(14) textColor:BlackColor frame:CGRectMake(ViewX(payWord), ViewBelow(payWord), ViewWidth(payWord), 45) textAlignment:NSTextAlignmentLeft];
    
    [backGroundView addSubview:secondWord];
    
    secondTextField =[[UITextField alloc]initWithFrame:CGRectMake(ViewX(passWord), ViewBelow(passWord), ViewWidth(passWord), 45)];
    
    secondTextField.font= WLFontSize(14);
    
    secondTextField.textColor =BlackColor;
    
    secondTextField.delegate =self;
    
    secondTextField.secureTextEntry =YES;
    
    [secondTextField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    
    secondTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [backGroundView addSubview:secondTextField];

    UIButton *confirmButton =[[UIButton alloc]initWithFrame:CGRectMake(45, ViewBelow(backGroundView)+45, ScreenWidth-90, 45)];
    
    [confirmButton setBackgroundColor:WLColor(140, 157, 244, 1)];
    
    [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    confirmButton.layer.cornerRadius = 3.0;
    
    [self.view addSubview:confirmButton];

    
}

-(void)textChange:(UITextField *)textField
{
    
    if (textField == passWord) {
        
        if (passWord.text.length>=6) {
            
            passWord.text = [passWord.text substringToIndex:6];
            
        }
    }
    
    
    if (textField ==secondTextField) {
        
        
        if (secondTextField.text.length>=6) {
            
            secondTextField.text = [secondTextField.text substringToIndex:6];
        }
        
    }
}

-(void)confirmButtonClick
{
    
    if (passWord.text.length==0) {
        
        [[WL_TipAlert_View sharedAlert]createTip:@"请输入支付密码"];
        
        return ;
    }
    
    
    if (![RegexTools isPassWordNumber:passWord.text]) {
        
        [[WL_TipAlert_View sharedAlert]createTip:@"请输入由英文和数字组合的6位密码"];
        
        return ;
    }
    
    if (secondTextField.text.length==0) {
        
        [[WL_TipAlert_View sharedAlert]createTip:@"请输入确认密码"];
        
        return;
        
    }
    if (![RegexTools isPassWordNumber:secondTextField.text]) {
        [[WL_TipAlert_View sharedAlert]createTip:@"请输入由英文和数字组合的6位密码"];
        
        return ;
    }
    
    if (![secondTextField.text isEqualToString:passWord.text]) {
        
        [[WL_TipAlert_View sharedAlert]createTip:@"两次输入的密码不一致"];
        
        return;
        
    }
  
    
    NSString *user_id = [WLUserTools getUserId];
    
    NSString *user_passWord =[WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:user_passWord publicKey:RSAKey];
    
    NSString *payWord = secondTextField.text;
    
    
    NSString *encryptPayWord = [MyRSA encryptString:payWord publicKey:RSAKey];
    
    NSDictionary *para = @{@"user_id":user_id,@"user_password":encryptStr,@"PayPassword":encryptPayWord,@"type":@"2"};
    
    
    [[WLHttpManager shareManager]requestWithURL:MinePayPassWordUrl RequestType:RequestTypePost Parameters:para Success:^(id responseObject) {
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        
        
        if ([network_Model.result isEqualToString:@"1"]) {
            
            WL_SetSucess_ViewController *VC =[[WL_SetSucess_ViewController alloc]init];
            
            VC.tip = @"恭喜你,重置支付密码成功!";
            
            VC.titleSting =@"重置支付密码";
            
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
