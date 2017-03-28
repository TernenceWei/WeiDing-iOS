//
//  WL_Deposit_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Deposit_ViewController.h"
#import "WL_Mine_UserInfoModel.h"
#import "WL_BankCard_Model.h"
#import "WL_DepositSucess_ViewController.h"
#import "WLNetworkAccountHandler.h"
#import "TPPasswordTextView.h"
#import "WLPaymentCodeView.h"
#import "WLPasswordAccessoryView.h"
#import "NSDictionary+DefaultValue.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface WL_Deposit_ViewController ()<UIAlertViewDelegate>
{
    UITextField *depositTextfield;
    dispatch_group_t group;
}
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UITextField *bottomField;
@property (nonatomic, strong) UIView *blackView;
@property (nonatomic, strong) WLPasswordAccessoryView *accessoryView;
@property (nonatomic, strong) NSDictionary *dataDict;

@end

@implementation WL_Deposit_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BgViewColor;
    self.titleItem.title =@"提现";
    
    WS(weakSelf);
    group=dispatch_group_create();
    dispatch_queue_t queue=dispatch_get_global_queue(0, 0);
    [weakSelf showHud];
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        [weakSelf initBankData];
    });

    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        [weakSelf hidHud];
        [weakSelf initUI];
    
    });
    
}

-(void)initUI
{
    UIView *backGroundView =[[UIView alloc]initWithFrame:CGRectMake(ScaleW(15),65 + ScaleH(15), ScreenWidth - ScaleW(30), ScaleH(240))];
    backGroundView.backgroundColor =[UIColor whiteColor];
    backGroundView.layer.cornerRadius = 6;
    backGroundView.layer.masksToBounds = YES;
    [self.view addSubview:backGroundView];
    
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.frame = CGRectMake(ScaleW(18), ScaleH(10), 50, 50);
    iconView.image = [UIImage imageNamed:@"农业银行.png"];
    iconView.backgroundColor = Color1;
    iconView.layer.cornerRadius = 25;
    iconView.layer.masksToBounds = YES;
    [backGroundView addSubview:iconView];
    
    UILabel *bankNameLabel = [UILabel labelWithText:@"中国建设银行" textColor:Color2 fontSize:15];
    bankNameLabel.frame = CGRectMake(CGRectGetMaxX(iconView.frame) + ScaleW(8), ScaleH(10), ScreenWidth, ScaleH(20));
    [backGroundView addSubview:bankNameLabel];

    UILabel *bankNoticeLabel = [UILabel labelWithText:@"尾号6266储蓄卡" textColor:Color3 fontSize:14];
    bankNoticeLabel.frame = CGRectMake(CGRectGetMaxX(iconView.frame) + ScaleW(8), CGRectGetMaxY(bankNameLabel.frame) + 2, ScreenWidth, ScaleH(20));
    [backGroundView addSubview:bankNoticeLabel];
    
    UILabel *depositNoticeLabel = [UILabel labelWithText:@"输入提现金额" textColor:Color3 fontSize:15];
    depositNoticeLabel.frame = CGRectMake(ScaleW(18), ScaleH((65 + 20)), ScreenWidth, ScaleH(30));
    [backGroundView addSubview:depositNoticeLabel];
    
    depositTextfield = [[UITextField alloc]initWithFrame:CGRectMake(depositNoticeLabel.left, CGRectGetMaxY(depositNoticeLabel.frame) + ScaleH(0), backGroundView.width, ScaleH(60))];
    depositTextfield.placeholder = @"请输入提现金额";
    depositTextfield.font =WLFontSize(18);
    depositTextfield.keyboardType = UIKeyboardTypeDecimalPad;
    [depositTextfield addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [backGroundView addSubview:depositTextfield];


    UILabel *remainLabel = [UILabel labelWithText:@"可提现金额0.00" textColor:Color3 fontSize:14];
    remainLabel.frame = CGRectMake(ScaleW(18), ScaleH(175), ScreenWidth, ScaleH(65));
    [backGroundView addSubview:remainLabel];
    
    UILabel *line1  = [WLTools allocLabel:@"" font:nil textColor:nil frame:CGRectMake(0, ScaleH(65),backGroundView.width, 1) textAlignment:NSTextAlignmentLeft];
    line1.backgroundColor = bordColor;
    [backGroundView addSubview:line1];
    
    UILabel *line2 = [WLTools allocLabel:@"" font:nil textColor:nil frame:CGRectMake(ScaleW(18), ScaleH(175),backGroundView.width, 1) textAlignment:NSTextAlignmentLeft];
    line2.backgroundColor = bordColor;
    [backGroundView addSubview:line2];
    
    NSDate *currentDate = [NSDate date];
    NSTimeInterval  oneDay = 24*60*60*5;
    NSDate *date = [currentDate initWithTimeIntervalSinceNow: oneDay];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd "];
    NSString *dateString = [dateFormatter stringFromDate:date];

    UILabel *dateLabel = [UILabel labelWithText:[NSString stringWithFormat:@"预计到账时间%@",dateString] textColor:Color3 fontSize:14];
    dateLabel.frame = CGRectMake(0, backGroundView.bottom + ScaleH(20), ScreenWidth, 30);
    dateLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:dateLabel];

    
    UIButton *confirmButton =[[UIButton alloc]initWithFrame:CGRectMake((ScreenWidth - ScaleW(250)) / 2, dateLabel.bottom + ScaleH(15), ScaleW(250), 45)];
    [confirmButton setBackgroundColor:WLColor(140, 157, 244, 1)];
    [confirmButton setTitle:@"确认提现" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    confirmButton.layer.cornerRadius = 22.5;
    confirmButton.layer.masksToBounds = YES;
    [confirmButton setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateDisabled];
    [confirmButton setBackgroundImage:[UIImage imageWithColor:Color1] forState:UIControlStateNormal];
    [confirmButton setTitleColor:HEXCOLOR(0xeaeaea) forState:UIControlStateDisabled];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmButton.layer.borderWidth = 1.0;
    confirmButton.layer.borderColor = HEXCOLOR(0xeaeaea).CGColor;
    confirmButton.enabled = NO;
    [self.view addSubview:confirmButton];
    self.confirmButton = confirmButton;
    
    WS(weakSelf);
    WLPasswordAccessoryView *accessView = [[WLPasswordAccessoryView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 180)
                                                                              backAction:^{
                                                                                  
                                                                                  [weakSelf finishInputPassword];
                                                                              }
                                                                            finishAction:^(NSString *password) {
                                                                               
                                                                                [weakSelf finishInputPassword];
                                                                                [weakSelf depositRequestWith:password];
                                                                            }];
    self.accessoryView = accessView;
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, 100, 40)];
    textField .font =WLFontSize(14);
    textField .textColor = BlackColor;
    textField.hidden = YES;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.keyboardType = UIKeyboardTypeNumberPad;
    [textField addTarget:self action:@selector(passwordFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    textField.inputAccessoryView = accessView;
    [self.view addSubview:textField];
    self.bottomField = textField;
    
    if (self.dataDict == nil) {
        return;
    }
    NSString *bankName = [self.dataDict objectForKey:@"bank_name" defaultValue:@"农业银行"];
//    NSString *logo = [self.dataDict objectForKey:@"bank_logo" defaultValue:[NSString stringWithFormat:@"%@.png",bankName]];
    NSString *bankNo = [self.dataDict objectForKey:@"bank_number" defaultValue:@"123456789"];
    NSString *balance = [self.dataDict objectForKey:@"balance" defaultValue:@"100"];
    
    iconView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",bankName]];
    bankNameLabel.text = bankName;
    bankNoticeLabel.text = bankNo;
    remainLabel.text = [NSString stringWithFormat:@"可提现金额%@",balance];
    
    
}

#pragma mark private method
- (void)finishInputPassword{
    
    [self.bottomField resignFirstResponder];
    [self.accessoryView removeInput];
    self.bottomField.text = nil;
    [UIView animateWithDuration:0.5 animations:^{
        
        self.blackView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        if (finished) {
            [self.blackView removeFromSuperview];
            self.blackView = nil;
        }
    }];
    
}

-(void)confirmButtonClick
{
    if (depositTextfield.text.length==0) {
        [[WL_TipAlert_View sharedAlert]createTip:@"请输入提现金额"];
        return;
    }
    [self.view endEditing:YES];

    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self.navigationController.view addSubview:bgView];
    self.blackView = bgView;
    
    [self.bottomField becomeFirstResponder];

}

#pragma mark network
//获取绑定的银行卡
-(void)initBankData
{
    WS(weakSelf);
    [WLNetworkAccountHandler requestDepositingBankCardInfoWithDataBlock:^(WLResponseType responseType, id data, NSString *message) {
        dispatch_group_leave(group);
        if (responseType == WLResponseTypeSuccess) {
            weakSelf.dataDict = data;
        }else{
            weakSelf.dataDict = nil;
            [[WL_TipAlert_View sharedAlert] createTip:message];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        }
        
        
    }];
}

//提现
-(void)depositRequestWith:(NSString *)pass
{
    NSString *depositMoney =[NSString stringWithFormat:@"%0.2f",[depositTextfield.text floatValue]];
//    NSString *pay_password = [MyRSA encryptString:pass publicKey:RSAKey];
    NSString *balance = [self.dataDict objectForKey:@"balance" defaultValue:@"0"];
    NSString *bankNo = [self.dataDict objectForKey:@"bank_id" defaultValue:@"0"];
    WS(weakSelf);
    [self showHud];
    [WLNetworkAccountHandler depositWithPaymentCode:pass
                                             amount:depositMoney
                                            balance:balance
                                           bankCard:bankNo
                                          dataBlock:^(WLResponseType responseType, id data, NSString *message) {
                                              
                                              [weakSelf hidHud];
                                                  
                                              if (responseType == WLResponseTypeSuccess) {
                                                  
                                                  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提现成功" message:@"相关款项将在3个工作日内到账" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                                  alertView.delegate = self;
                                                  [alertView show];
                                              }else{
                                                  [[WL_TipAlert_View sharedAlert]createTip:message];
                                              }
                                                  
                                              
        
    }];
}

#pragma mark UITextFieldDelegate
- (void)passwordFieldTextChange:(UITextField *)textField{
    
    [self.accessoryView inputPasswordWithPasswordString:textField.text];
}

-(void)textChange:(UITextField *)textField
{
    if (depositTextfield.text.length>=1&&[[depositTextfield.text substringToIndex:1] isEqualToString:@"."]) {
        depositTextfield.text = @"";
    }
    if (depositTextfield.text.length>=1&&[[depositTextfield.text substringToIndex:1] isEqualToString:@"0"]) {
        if ([depositTextfield.text intValue]>=1) {
            depositTextfield.text =[NSString stringWithFormat:@"%d",[depositTextfield.text intValue]];
        }else if ([depositTextfield.text isEqualToString:@"00"]){
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
    self.confirmButton.enabled = (depositTextfield.text.length != 0 && [depositTextfield.text floatValue] >= 0.001);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
