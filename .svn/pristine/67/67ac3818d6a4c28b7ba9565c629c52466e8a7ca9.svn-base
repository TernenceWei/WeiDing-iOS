//
//  WL_MyBalance_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/18.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_MyBalance_ViewController.h"

#import "WL_Mine_RechargeViewController.h"

#import "WL_Deposit_ViewController.h"


#import "WL_Network_Model.h"

#import "WL_BindBankCards_ViewController.h"

#import "WL_Mine_personInfo_Authentication_ViewController.h"

#import "WL_SetPayPassWord_ViewController.h"

#import "WL_Mine_UserInfoModel.h"

@interface WL_MyBalance_ViewController ()

@property(nonatomic,strong)WL_Mine_UserInfoModel *userInfoModel;

@end

@implementation WL_MyBalance_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BgViewColor;
    
    self.navigationItem.title =@"余额";

    [self loadAccountData];
}



-(void)loadAccountData
{

    [self showHud];
    
    NSString *userId = [WLUserTools getUserId];
    
    NSString *passWord =[WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:passWord publicKey:RSAKey];
    
    NSDictionary *dict =@{@"user_id":userId,@"user_password":encryptStr};
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager]requestWithURL:MinePersonCenterHomeUrl RequestType:RequestTypePost Parameters:dict Success:^(id responseObject) {
        
       
        
     WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([network_Model.result intValue]==1) {
            
        weakSelf.userInfoModel = [WL_Mine_UserInfoModel mj_objectWithKeyValues:network_Model.data];
        }
        
        
        [weakSelf hidHud];
        
        [weakSelf initUI];
        
        WlLog(@"%@",responseObject);
        
    } Failure:^(NSError *error) {
        
        
        if (error.code ==-1009)
        {
            
            [[WL_TipAlert_View sharedAlert]createTip:@"似乎已断开与互联网的连接"];
            
        }else
        {
            [[WL_TipAlert_View sharedAlert]createTip:@"服务器错误,请稍后重试"];
        }


    }];
    
}


-(void)initUI
{
    
    UIImageView *topImage =[UIImageView new];
    
    topImage.image =[UIImage imageNamed:@"MineBalance"];
    
    [self.view addSubview:topImage];
    
    NSInteger top =0;
    
    if (IsiPhone4) {
        
        top = 50;
    }else if(IsiPhone5)
    {
        top =110;
        
    }else if (IsiPhone6)
    {
        top = 130;
        
    }else if (IsiPhone6P)
    {
        top = 150;
    }
    
    
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.centerX.mas_equalTo(self.view);
        
        make.top.mas_equalTo(top);
        
        
    }];
    
    UILabel *moneyLabel =[UILabel new];
    
    moneyLabel.textColor = WLColor(47, 47, 47, 1);
    
    moneyLabel.font = WLFontSize(25);
    
    moneyLabel.text = [NSString stringWithFormat:@"¥%0.2f",[self.userInfoModel.leave_amount floatValue]];
    
    moneyLabel.textAlignment =NSTextAlignmentCenter;
    
    [self.view addSubview:moneyLabel];
    
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.centerX.mas_equalTo(self.view);
        
        make.top.mas_equalTo(topImage.mas_bottom).mas_offset(30);
        
    }];
    
    UIButton *rechargeButton =[UIButton new];
    
    [rechargeButton setBackgroundColor:WLColor(82, 119, 224, 1)];
    
    [rechargeButton setTitle:@"充值" forState:UIControlStateNormal];
    
    [rechargeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [rechargeButton addTarget:self action:@selector(rechargeButton) forControlEvents:UIControlEventTouchUpInside];
    
    rechargeButton.layer.cornerRadius = 3.0;
    
    [self.view addSubview:rechargeButton];
    
    NSInteger distance=0;
   
    if (IsiPhone4||IsiPhone5) {
       
        distance =52;
    }else
    {
        distance = 72;
    }
    
    [rechargeButton mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.top.mas_equalTo(moneyLabel.mas_bottom).offset(distance);
        
        make.size.mas_equalTo(CGSizeMake(275, 45));
        
        make.centerX.mas_equalTo(self.view);
        
    }];
    
   
    UIButton *depositButton =[UIButton new];
    
    [depositButton setTitle:@"提现" forState:UIControlStateNormal];
    
    [depositButton setTitleColor:[WLTools stringToColor:@"#879ffa"] forState:UIControlStateNormal];
    
    depositButton.layer.cornerRadius =3.0;
    
    depositButton.layer.borderWidth =1.0;
    
    [depositButton addTarget:self action:@selector(depositButton) forControlEvents:UIControlEventTouchUpInside];
    
    depositButton.layer.borderColor = [WLTools stringToColor:@"#879ffa"].CGColor;
    
    [self.view addSubview:depositButton];
    
    [depositButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(rechargeButton.mas_bottom).offset(15);
        
        make.centerX.mas_equalTo(self.view);
        
        make.size.mas_equalTo(CGSizeMake(275, 45));
        
    }];
    
}

#pragma mark -- 重置按钮
-(void)rechargeButton
{
    
    //检查是否 实名认证 －－检查是否设置支付密码
    [self checkRealName];
}

-(void)checkRealName
{
    
    NSString *user_id = [WLUserTools getUserId];
    
    NSString *user_PassWord= [WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:user_PassWord publicKey:RSAKey];
    
    NSDictionary *dict = @{@"user_id":user_id,@"user_password":encryptStr};
    
    WS(weakSelf);
    
    [weakSelf showHud];
    
    [[WLHttpManager shareManager]requestWithURL:CheckRealNameUrl RequestType:RequestTypePost Parameters:dict Success:^(id responseObject) {
        
      WL_Network_Model *model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([model.result isEqualToString:@"1"])
        {
            
            [self checkPayPasswordAboutBankCard];
            
        }else
        {
            
            [weakSelf hidHud];
            
            //跳转去实名认证
            WL_Mine_personInfo_Authentication_ViewController *VC =[[WL_Mine_personInfo_Authentication_ViewController alloc]init];
            
            
            [self.navigationController pushViewController:VC animated:YES];
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

#pragma  mark ---检查是否设置了支付密码，跳转银行卡之前的验证
-(void)checkPayPasswordAboutBankCard
{
    NSString *user_id = [WLUserTools getUserId];
    
    NSString *user_PassWord= [WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:user_PassWord publicKey:RSAKey];
    
    NSDictionary *dict = @{@"user_id":user_id,@"user_password":encryptStr};
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager]requestWithURL:CheckPassWordUrl RequestType:RequestTypePost Parameters:dict Success:^(id responseObject) {
        
        WL_Network_Model *model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([model.result isEqualToString:@"1"])
        {
            
        
             WL_Mine_RechargeViewController *VC =[[WL_Mine_RechargeViewController alloc]init];
            
            
             [self.navigationController pushViewController:VC animated:YES];
            
        }else
        {
            
            WL_SetPayPassWord_ViewController *VC =[[WL_SetPayPassWord_ViewController alloc]init];
            
            [self.navigationController pushViewController:VC animated:YES];
            
            
        }
        
        [weakSelf hidHud];
        
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

#pragma  mark ---提现点击按钮
-(void)depositButton
{
    
    //判断是否绑定了银行卡，如果没绑定 先绑定银行卡
    [self checkBindBankCard];
    
}

#pragma mark ----  检查是否绑定了银行卡
-(void)checkBindBankCard
{
    
    NSString *user_id = [WLUserTools getUserId];
    
    NSString *user_PassWord= [WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:user_PassWord publicKey:RSAKey];
    
    NSDictionary *dict = @{@"user_id":user_id,@"user_password":encryptStr};
    
    WS(weakSelf);
    
    
    [[WLHttpManager shareManager]requestWithURL:CheckBindBankUrl RequestType:RequestTypePost Parameters:dict Success:^(id responseObject) {
        
      WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([network_Model.result isEqualToString:@"1"]) {
            
            if ([network_Model.data[@"is_bind"] integerValue]==1)
            {
                
                WL_Deposit_ViewController *VC =[[WL_Deposit_ViewController alloc]init];
                
                [self.navigationController pushViewController:VC animated:YES];
                
            }else
            {
                
                [[WL_TipAlert_View sharedAlert]createTip:network_Model.msg];
                
            }
            
            
        }else
        {
            
            [[WL_TipAlert_View sharedAlert]createTip:network_Model.msg];
        }
        
        [weakSelf hidHud];
        
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


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
   
}

@end
