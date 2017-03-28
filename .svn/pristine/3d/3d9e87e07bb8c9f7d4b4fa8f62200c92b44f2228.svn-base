//
//  WL_Deposit_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Deposit_ViewController.h"

#import "WL_PasswordView.h"

#import "WL_DepositList_ViewController.h"

#import "WL_Mine_UserInfoModel.h"

#import "WL_BankCard_Model.h"

#import "WL_DepositSucess_ViewController.h"
@interface WL_Deposit_ViewController ()

{
    UITextField *depositTextfield;
    
    WL_PasswordView *password;
    
    WL_BankCard_Model *bankCardModel;
    
    
    dispatch_group_t group;
}

@property(nonatomic,strong)WL_Mine_UserInfoModel *userInfoModel;

@end

@implementation WL_Deposit_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BgViewColor;
    
    self.navigationItem.title =@"账户提现";
    
    UIButton *depositRecord =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 65, 20)];
    
    depositRecord.titleLabel.font =WLFontSize(16);
    
    [depositRecord setTitle:@"提现记录" forState:UIControlStateNormal];
    
    
    [depositRecord addTarget:self action:@selector(depositRecordClick) forControlEvents:UIControlEventTouchUpInside];
    
    [depositRecord setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:depositRecord];
    
    WS(weakSelf);
    
    group=dispatch_group_create();
    
    dispatch_queue_t queue=dispatch_get_global_queue(0, 0);
    
    
    [weakSelf showHud];
    
    dispatch_group_enter(group);
    
    dispatch_async(queue, ^{
       
        
        [weakSelf loadAccountData];
    });
    
    dispatch_group_enter(group);
    
    dispatch_async(queue, ^{
       
        [weakSelf initBankData];
    });
    
    
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        [weakSelf hidHud];
    
        
        [weakSelf initUI];
    
    });

    
    
}

-(void)loadAccountData
{
    
    NSString *userId = [WLUserTools getUserId];
    
    NSString *passWord =[WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:passWord publicKey:RSAKey];
    
    NSDictionary *dict =@{@"user_id":userId,@"user_password":encryptStr};
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager]requestWithURL:MinePersonCenterHomeUrl RequestType:RequestTypePost Parameters:dict Success:^(id responseObject) {
        
        dispatch_group_leave(group);
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([network_Model.result intValue]==1) {
        
        weakSelf.userInfoModel = [WL_Mine_UserInfoModel mj_objectWithKeyValues:network_Model.data];
      }
        
        
       
        
        WlLog(@"%@",responseObject);
        
    } Failure:^(NSError *error) {
        
        dispatch_group_leave(group);
        
    }];
    
}

-(void)initBankData
{
    
    NSString *userId = [WLUserTools getUserId];
    
    NSString *passWord =[WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:passWord publicKey:RSAKey];
    
    NSDictionary *dict =@{@"user_id":userId,@"user_password":encryptStr};
    
    
    [[WLHttpManager shareManager]requestWithURL:GetBankCardListUrl RequestType:RequestTypePost Parameters:dict Success:^(id responseObject) {
        
        dispatch_group_leave(group);
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        WlLog(@"%@",network_Model);
        
        if ([network_Model.result isEqualToString:@"1"]) {
            
            bankCardModel = [WL_BankCard_Model mj_objectWithKeyValues:network_Model.data[0]];
            
            
        }else
        {
            [[WL_TipAlert_View sharedAlert]createTip:network_Model.msg];
        }
        
       
        
    } Failure:^(NSError *error) {
        
        WlLog(@"%@",error);
        
        dispatch_group_leave(group);
        
    }];
    
    
}


-(void)initUI
{
    UIView *backGroundView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 135)];
    
    backGroundView.backgroundColor =[UIColor whiteColor];
    
    [self.view addSubview:backGroundView];
    
    UILabel *availableBalance =[WLTools allocLabel:@"可用余额" font:WLFontSize(14) textColor:BlackColor frame:CGRectMake(10, 0, 100, 45) textAlignment:NSTextAlignmentLeft];
    
    [backGroundView addSubview:availableBalance];
    
    NSString *leave_Amount =[NSString stringWithFormat:@"¥%0.2f",[self.userInfoModel.leave_amount floatValue]];
    
    UILabel *availableBalanceNum =[WLTools allocLabel:leave_Amount font:WLFontSize(14) textColor:BlackColor frame:CGRectMake(ViewRight(availableBalance), 0, 150, 45) textAlignment:NSTextAlignmentLeft];
    
    [backGroundView addSubview:availableBalanceNum];
    
    UILabel *line1  = [WLTools allocLabel:@"" font:nil textColor:nil frame:CGRectMake(10, ViewBelow(availableBalance)  , ScreenWidth-10, 0.5) textAlignment:NSTextAlignmentLeft];
    
    line1.backgroundColor =bordColor;
    
    [backGroundView addSubview:line1];
    
    
    UILabel *bankCard =[WLTools allocLabel:@"提现银行卡" font:WLFontSize(14) textColor:BlackColor frame:CGRectMake(10, ViewBelow(line1), 100, 45) textAlignment:NSTextAlignmentLeft];
    
    [backGroundView addSubview:bankCard];
    
    NSString *bankNumber =[bankCardModel.bank_number stringByReplacingCharactersInRange:NSMakeRange(0, bankCardModel.bank_number.length-4) withString:@"****"];
  
    NSString *string =[NSString stringWithFormat:@"%@(%@)",bankCardModel.bank_name,bankNumber];
    
    UILabel *bankCardDetail =[WLTools allocLabel:string font:WLFontSize(14) textColor:BlackColor frame:CGRectMake(ViewRight(bankCard), ViewBelow(line1), ScreenWidth-100, 45) textAlignment:NSTextAlignmentLeft];
    
    [backGroundView addSubview:bankCardDetail];
    
    
    UILabel *line2 = [WLTools allocLabel:@"" font:nil textColor:nil frame:CGRectMake(10, ViewBelow(bankCard),ScreenWidth-10, 0.5) textAlignment:NSTextAlignmentLeft];

    line2.backgroundColor =bordColor;
    
    [backGroundView addSubview:line2];
    
    UILabel *depositBalance =[WLTools allocLabel:@"提现金额" font:WLFontSize(14) textColor:BlackColor frame:CGRectMake(10, ViewBelow(line2), 100, 45) textAlignment:NSTextAlignmentLeft];
    
    [backGroundView addSubview:depositBalance];
    
    depositTextfield =[[UITextField alloc]initWithFrame:CGRectMake(ViewRight(depositBalance), ViewBelow(line2), ScreenWidth-100-70, 45)];
    
    depositTextfield.placeholder = @"请输入提现金额";
    
    depositTextfield.font =WLFontSize(14);
    
    depositTextfield.keyboardType = UIKeyboardTypeDecimalPad;
    
    [depositTextfield addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    
    [backGroundView addSubview:depositTextfield];
    
    
    UIButton *allDepositButton =[WLTools allocButton:@"全部提现" textColor:WLColor(73, 119, 231, 1) nom_bg:nil hei_bg:nil frame:CGRectMake(ScreenWidth-10-60, ViewBelow(line2), 60, 45)];
    
    
    [allDepositButton addTarget:self action:@selector(allDepositButton) forControlEvents:UIControlEventTouchUpInside];
    
    allDepositButton.titleLabel.font =WLFontSize(14);
    
    [backGroundView addSubview:allDepositButton];
    
    UIButton *confirmButton =[[UIButton alloc]initWithFrame:CGRectMake(45, ViewBelow(backGroundView)+45, ScreenWidth-90, 45)];
    
    [confirmButton setBackgroundColor:WLColor(140, 157, 244, 1)];
    
    [confirmButton setTitle:@"确认提现" forState:UIControlStateNormal];
    
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    confirmButton.layer.cornerRadius = 3.0;
    
    [self.view addSubview:confirmButton];
    
    
    
}


#pragma mark --- 全部提现按钮 点击

-(void)allDepositButton

{
    
    NSString *leave_Amount =[NSString stringWithFormat:@"%0.2f",[self.userInfoModel.leave_amount floatValue]];
    
    depositTextfield.text  = leave_Amount;
    
}

-(void)depositRecordClick
{
    
    WL_DepositList_ViewController *VC =[[WL_DepositList_ViewController alloc]init];
    
    [self.navigationController pushViewController:VC animated:YES];
    
}

-(void)confirmButtonClick
{
    
    
    if (depositTextfield.text.length==0) {
        
        [[WL_TipAlert_View sharedAlert]createTip:@"请输入提现金额"];
        
        return;
    }

    
    [self.view endEditing:YES];
    
    
    password =[[WL_PasswordView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    
    WS(weakSelf);
    
    password.removeKeyboard = ^(NSString *pass){
        
        WlLog(@"%@",pass);
        
        [weakSelf depositRequestWith:pass];
        
    };
    
    [[UIApplication sharedApplication].keyWindow addSubview:password];
    
}

-(void)depositRequestWith:(NSString *)pass
{
    
    NSString *user_id = [WLUserTools getUserId];
    
    NSString *user_PassWord= [WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:user_PassWord publicKey:RSAKey];
    
    NSString *depositMoney =[NSString stringWithFormat:@"%0.2f",[depositTextfield.text floatValue]];
    
    NSString *pay_password = [MyRSA encryptString:pass publicKey:RSAKey];
    

    NSDictionary *dict = @{@"user_id":user_id,@"user_password":encryptStr,@"bank_card_id":bankCardModel.bank_card_id,@"money":depositMoney,@"pay_password":pay_password};
    
    WS(weakSelf);
   
    [weakSelf showHud];
    
    [[WLHttpManager shareManager]requestWithURL:AccountWithdrawalUrl RequestType:RequestTypePost Parameters:dict Success:^(id responseObject) {
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([network_Model.result isEqualToString:@"1"]) {
            
            WL_DepositSucess_ViewController *VC =[[WL_DepositSucess_ViewController alloc]init];
            
            VC.string1 = @"提现申请提交成功";
            
            VC.string2 = @"预计1～2个工作日到账";
            [self.navigationController pushViewController:VC animated:YES];
            
        }else
        {
           
            [[WL_TipAlert_View sharedAlert]createTip:network_Model.msg];
        }
        
        [weakSelf hidHud];
        
    } Failure:^(NSError *error) {
        
        [weakSelf hidHud];
        
        [[WL_TipAlert_View sharedAlert]createTip:@"您的网络不给力,请稍后再试"];
        
    }];
}


-(void)textChange:(UITextField *)textField
{
    
    if (depositTextfield.text.length>=1&&[[depositTextfield.text substringToIndex:1] isEqualToString:@"."]) {
        
        depositTextfield.text = @"";
        
    }
    if (depositTextfield.text.length>=1&&[[depositTextfield.text substringToIndex:1] isEqualToString:@"0"]) {
        
        if ([depositTextfield.text intValue]>=1) {
            
            depositTextfield.text =[NSString stringWithFormat:@"%d",[depositTextfield.text intValue]];
            
        }else if ([depositTextfield.text isEqualToString:@"00"])
        {
            depositTextfield.text =[NSString stringWithFormat:@"%d",[depositTextfield.text intValue]];
        }
        
    }
    
    if ([depositTextfield.text rangeOfString:@"."].location!=NSNotFound) {
        
        NSInteger index =[depositTextfield.text rangeOfString:@"."].location;
        
        NSString *str=[depositTextfield.text substringFromIndex:index+1];
        
        
        if (depositTextfield.text.length>index+1) {
            
            NSString *originString = [depositTextfield.text substringWithRange:NSMakeRange(index+1, 1)];
            
            if ([originString isEqualToString:@"."]) {
                
                depositTextfield.text = [depositTextfield.text substringToIndex:index+1];
            }
            
            
        }
        
        if (str.length>=2) {
            
            depositTextfield.text= [depositTextfield.text substringToIndex:index+3];
            
        }
        
    }
    
    if (depositTextfield.text.length>12) {
        
        depositTextfield.text=[depositTextfield.text substringToIndex:12];
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
   
    [super didReceiveMemoryWarning];
   
    
}



@end
