//
//  WL_MyBalance_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/18.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_MyBalance_ViewController.h"
#import "WLRechargeViewController.h"
#import "WL_Deposit_ViewController.h"
#import "WL_Network_Model.h"
#import "WL_BindBankCards_ViewController.h"
#import "WL_Mine_personInfo_Authentication_ViewController.h"
#import "WL_SetPayPassWord_ViewController.h"
#import "WL_Mine_UserInfoModel.h"
#import "WLPaymentChooseView.h"

#define RealNameAlertTag 1000
#define BindBankAlertTag 1001
#define PasswordAlertTag 1002

@interface WL_MyBalance_ViewController ()<UIAlertViewDelegate>

@property (nonatomic, assign) BOOL hadRealName;
@property (nonatomic, assign) BOOL hadBindCard;
@property (nonatomic, assign) BOOL hadPaymentCode;
@property (nonatomic, strong) WLPaymentChooseView *chooseView;
@property (nonatomic, strong) UILabel *moneyLabel;

@end

@implementation WL_MyBalance_ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)setObject:(WLFundAccountObject *)object
{
    _object = object;
    self.hadRealName = object.is_validated.boolValue;
    self.hadBindCard = object.bankcard_status.boolValue;
    self.hadPaymentCode = object.is_set_paypwd.boolValue;
    [self initUI];
}

-(void)initUI
{
    self.view.backgroundColor = BgViewColor;
    self.titleItem.title =@"余额";
    
    UIImageView *topImage =[UIImageView new];
    topImage.image =[UIImage imageNamed:@"accountYuE"];
    [self.view addSubview:topImage];
    NSInteger top = ScaleH(130);
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(top);
    }];
    
    UILabel *moneyLabel =[UILabel new];
    moneyLabel.textColor = WLColor(47, 47, 47, 1);
    moneyLabel.font = WLFontSize(25);
    moneyLabel.text = [NSString stringWithFormat:@"¥%0.2f",[self.object.balance floatValue]];
    moneyLabel.textAlignment =NSTextAlignmentCenter;
    [self.view addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(topImage.mas_bottom).mas_offset(40);
        
    }];
    self.moneyLabel = moneyLabel;
    
    UIButton *rechargeButton =[UIButton new];
    [rechargeButton setBackgroundColor:WLColor(82, 119, 224, 1)];
    [rechargeButton setTitle:@"充值" forState:UIControlStateNormal];
    [rechargeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rechargeButton setBackgroundImage:[UIImage imageWithColor:Color1] forState:UIControlStateNormal];
    [rechargeButton addTarget:self action:@selector(rechargeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    rechargeButton.layer.cornerRadius = 22.5;
    rechargeButton.layer.masksToBounds = YES;
    [self.view addSubview:rechargeButton];
    NSInteger distance = ScaleH(50);
    [rechargeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(moneyLabel.mas_bottom).offset(distance);
        make.size.mas_equalTo(CGSizeMake(275, 45));
        make.centerX.mas_equalTo(self.view);
        
    }];
   
    UIButton *depositButton =[UIButton new];
    [depositButton setTitle:@"提现" forState:UIControlStateNormal];
    [depositButton setTitleColor:Color1 forState:UIControlStateNormal];
    [depositButton addTarget:self action:@selector(depositButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [depositButton setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    depositButton.layer.borderWidth = 0.5;
    depositButton.layer.borderColor = Color1.CGColor;
    depositButton.layer.cornerRadius = 22.5;
    depositButton.layer.masksToBounds = YES;
    [self.view addSubview:depositButton];
    [depositButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(rechargeButton.mas_bottom).offset(15);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(275, 45));
        
    }];
    
}

- (void)setupChooseView
{
    WS(weakSelf);
    self.chooseView = [[WLPaymentChooseView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)
                                                                     clickAction:^(NSUInteger index) {
                                                                         
                                                                         [weakSelf removeChooseView];
                                                                         WLRechargeViewController *VC =[[WLRechargeViewController alloc] init];
                                                                         VC.mode = index;
                                                                         [weakSelf.navigationController pushViewController:VC animated:YES];
                                       
                                                                    }
                                                                    cancelAction:^{
                                                                        [weakSelf removeChooseView];
                                          
                                      }];
    [self.navigationController.view addSubview:self.chooseView];
}

- (void)removeChooseView
{
    [self.chooseView removeFromSuperview];
    self.chooseView = nil;
}


#pragma mark 按钮点击事件
//充值按钮点击事件
-(void)rechargeButtonClick
{
    //检查是否实名认证
    if (self.hadRealName) {//已认证
        
        [self setupChooseView];
        
    }else{//未认证
        
        [self showAlertViewWithMessage:@"请先完成实名认证" tag:RealNameAlertTag];
        
    }
}

//提现按钮点击事件
-(void)depositButtonClick
{
    //判断是否绑定了银行卡
    if (self.hadBindCard) {//绑定了银行卡
        
        //判断是否设置了支付密码
        if (self.hadPaymentCode) {//设置了支付密码
            
            WL_Deposit_ViewController *VC =[[WL_Deposit_ViewController alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else{//去设置支付密码
            
           [self showAlertViewWithMessage:@"请先设置支付密码" tag:PasswordAlertTag];
        }
        
    }else{//去绑卡
        if (!self.hadRealName) {
            [self showAlertViewWithMessage:@"请先完成实名认证" tag:RealNameAlertTag];
        }else{
            [self showAlertViewWithMessage:@"请先绑定银行卡" tag:BindBankAlertTag];
        }
        
    }
    
}

#pragma mark private method
- (void)showAlertViewWithMessage:(NSString *)message tag:(NSUInteger)tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"否"
                                              otherButtonTitles:@"是", nil];
    alertView.tag = tag;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if (alertView.tag == RealNameAlertTag) {//去实名认证
            
            WL_Mine_personInfo_Authentication_ViewController *VC =[[WL_Mine_personInfo_Authentication_ViewController alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if (alertView.tag == BindBankAlertTag){//去绑卡
            
            WL_BindBankCards_ViewController *VC =[[WL_BindBankCards_ViewController alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if (alertView.tag == PasswordAlertTag){//去设置支付密码
            
            WL_SetPayPassWord_ViewController *VC =[[WL_SetPayPassWord_ViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
    }
}

- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loadData
{
    WS(weakSelf);
    [WLNetworkAccountHandler requestFundAccountWithResultBlock:^(WLResponseType responseType, id data, NSString *message) {
        
        if (responseType == WLResponseTypeSuccess) {
            WLFundAccountObject *object = (WLFundAccountObject *)data;
            
            weakSelf.hadRealName = object.is_validated.boolValue;
            weakSelf.hadBindCard = object.bankcard_status.boolValue;
            weakSelf.hadPaymentCode = object.is_set_paypwd.boolValue;
            weakSelf.moneyLabel.text = [NSString stringWithFormat:@"¥%@",object.balance];

        }else{
            [[WL_TipAlert_View sharedAlert] createTip:message];
        }
    }];
    
}

@end
