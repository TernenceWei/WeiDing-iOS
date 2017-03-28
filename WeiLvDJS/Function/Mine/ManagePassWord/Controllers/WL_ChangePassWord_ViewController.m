//
//  WL_ChangePassWord_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/14.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_ChangePassWord_ViewController.h"

#import "WL_SetSucess_ViewController.h"
@interface WL_ChangePassWord_ViewController ()<UITextFieldDelegate>

{
    UITextField *originpassWord;
    
    UITextField *newTextField;
    
    UITextField *sureTextField;
}

@property(nonatomic,strong)UIButton *codeButton;

@end

@implementation WL_ChangePassWord_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = BgViewColor;
    
    self.navigationItem .title =@"修改支付密码";
    
    [self initUI];
}


-(void)initUI
{
    
    UIView *backGroundView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 135)];
    backGroundView.backgroundColor =[UIColor whiteColor];
    
    [self.view addSubview:backGroundView];
    
    UILabel *payWord =[WLTools allocLabel:@"原支付密码" font:WLFontSize(14) textColor:BlackColor frame:CGRectMake(10, 0, 100, 45) textAlignment:NSTextAlignmentLeft];
    
    [backGroundView addSubview:payWord];
    
    
    originpassWord = [[UITextField alloc]initWithFrame:CGRectMake(ViewRight(payWord), 0, ScreenWidth-100-10, 45)];
    
    originpassWord.font =WLFontSize(14);
    
    originpassWord.textColor = BlackColor;
    
    originpassWord.delegate =self;
    
    originpassWord.secureTextEntry = YES;

    originpassWord.clearButtonMode =UITextFieldViewModeWhileEditing;
    
    [originpassWord addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    
    [backGroundView addSubview:originpassWord];
    
    
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, ScreenWidth-10, 0.5)];
    line1.backgroundColor =bordColor;
    
    [backGroundView addSubview:line1];
    
    
    UILabel *secondWord =[WLTools allocLabel:@"新支付密码" font:WLFontSize(14) textColor:BlackColor frame:CGRectMake(ViewX(payWord), ViewBelow(payWord), ViewWidth(payWord), 45) textAlignment:NSTextAlignmentLeft];
    
    [backGroundView addSubview:secondWord];
    
    newTextField =[[UITextField alloc]initWithFrame:CGRectMake(ViewX(originpassWord), ViewBelow(originpassWord), ViewWidth(originpassWord), 45)];
    
    newTextField.font= WLFontSize(14);
    
    newTextField.textColor =BlackColor;
    
    newTextField.delegate =self;
    
    newTextField.secureTextEntry =YES;
    
    newTextField.placeholder =@"请输入6位字符";
    
    [newTextField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    
    newTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [backGroundView addSubview:newTextField];
    
    
    UILabel *line2 =[[UILabel alloc]initWithFrame:CGRectMake(10, ViewBelow(secondWord), ScreenWidth-10, 0.5)];
    
    line2.backgroundColor = bordColor;
    
    [backGroundView addSubview:line2];
    
    
    UILabel *codeLabel =[WLTools allocLabel:@"确认密码" font:WLFontSize(14) textColor:BlackColor frame:CGRectMake(10, ViewBelow(secondWord), 100, 45) textAlignment:NSTextAlignmentLeft];
    [backGroundView addSubview:codeLabel];
    
    sureTextField =[[UITextField alloc]initWithFrame:CGRectMake(ViewX(originpassWord), ViewBelow(secondWord), ScreenWidth-100-10, 45)];
    
    sureTextField.font =WLFontSize(14);
    
    sureTextField.delegate = self;
    
    sureTextField.secureTextEntry =YES;
    
    sureTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [sureTextField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    
    [backGroundView addSubview:sureTextField];
    

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
    
    if (textField == originpassWord) {
        
        if (originpassWord.text.length>=6) {
            
            originpassWord.text = [originpassWord.text substringToIndex:6];
            
        }
    }
    
    
    if (textField ==newTextField) {
        
        
        if (newTextField.text.length>=6) {
            
            newTextField.text = [newTextField.text substringToIndex:6];
        }
        
    }
    
    if (textField==sureTextField) {
        
        if (sureTextField.text.length>=6) {
            
            sureTextField.text =[sureTextField.text substringToIndex:6];
            
        }
    }
    
}


-(void)confirmButtonClick
{
    if (originpassWord.text.length==0) {
       
        [[WL_TipAlert_View sharedAlert]createTip:@"请输入原支付密码"];
        
        return ;
    }
    
    
    if (![RegexTools isPassWordNumber:originpassWord.text]) {
        
        [[WL_TipAlert_View sharedAlert]createTip:@"请输入由英文和数字组合的6位密码"];
        
        return ;
    }
    
    if (newTextField.text.length==0) {
        
        [[WL_TipAlert_View sharedAlert]createTip:@"请输入新的支付密码"];
        
        return;
        
    }
    if (![RegexTools isPassWordNumber:newTextField.text]) {
        
        [[WL_TipAlert_View sharedAlert]createTip:@"请输入由英文和数字组合的6位密码"];
        
        return ;
    }

    
    [self changePassWord];
}

-(void)changePassWord
{
    
    NSString *user_id = [WLUserTools getUserId];
    
    NSString *user_passWord =[WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:user_passWord publicKey:RSAKey];
    
    NSString *oldPassword = originpassWord.text;
    
    NSString *oldEncryptStr =[MyRSA encryptString:oldPassword publicKey:RSAKey];
    
    NSString *newPassWord = sureTextField.text;
    
    NSString *newEncryptStr =[MyRSA encryptString:newPassWord publicKey:RSAKey];
    
    NSDictionary *dic =@{@"user_id":user_id,@"user_password":encryptStr,@"newPayPassword":newEncryptStr,@"oldPassword":oldEncryptStr};
    
    [[WLHttpManager shareManager]requestWithURL:EditPassWordUrl RequestType:RequestTypePost Parameters:dic Success:^(id responseObject) {
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([network_Model.result isEqualToString:@"1"]) {
            
            WL_SetSucess_ViewController *VC =[[WL_SetSucess_ViewController alloc]init];
            
            VC.tip = @"恭喜你,支付密码修改成功!";
            
            VC.titleSting =@"修改支付密码";
            
            VC.type =@"2";
            
            [self.navigationController pushViewController:VC animated:YES];
            
        }else
        {
            [[WL_TipAlert_View sharedAlert]createTip:network_Model.msg];
        }
        

        
        
    } Failure:^(NSError *error) {
        
        [[WL_TipAlert_View sharedAlert]createTip:@"修改支付密码失败"];
        
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
