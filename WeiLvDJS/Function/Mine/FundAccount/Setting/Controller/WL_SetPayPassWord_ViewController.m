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
#import "WLNetworkAccountHandler.h"
#import "WLPaymentCodeView.h"
#import "WL_FundAccount_ViewController.h"

@interface WL_SetPayPassWord_ViewController ()<UIAlertViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) WLPaymentCodeView *codeView;
@property (nonatomic, strong) NSString *firstPassword;
@property (nonatomic, strong) UIButton *confirmButton;

@end

@implementation WL_SetPayPassWord_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.codeView beginToInput];
}


-(void)initUI
{
    self.titleItem.title = @"设置支付密码";

    self.titleLabel = [WLTools allocLabel:@"设置6位数的支付密码" font:WLFontSize(15) textColor:Color2 frame:CGRectMake(0, ScaleH(80) + 64, ScreenWidth, 45) textAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.titleLabel];
    
    WS(weakSelf);
    self.codeView = [[WLPaymentCodeView alloc] initWithFrame:CGRectMake(0, self.titleLabel.bottom + ScaleH(30), ScreenWidth, ScaleH(50))
                                                             passwordBlock:^(NSString *password, BOOL isFirstInput) {
                                                                 
                                                                 [weakSelf passwordInputComplete:password firstInput:isFirstInput];
                                                                 
        
    }];
    [self.view addSubview:self.codeView];
    
    
 
    self.confirmButton =[[UIButton alloc]initWithFrame:CGRectMake((ScreenWidth - ScaleW(250)) / 2, self.codeView.bottom+ ScaleH(100), ScaleW(250), ScaleH(45))];
    [self.confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    self.confirmButton.layer.cornerRadius = ScaleH(22.5);
    self.confirmButton.layer.masksToBounds = YES;
    [self.confirmButton setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateDisabled];
    [self.confirmButton setBackgroundImage:[UIImage imageWithColor:Color1] forState:UIControlStateNormal];
    [self.confirmButton setTitleColor:HEXCOLOR(0xeaeaea) forState:UIControlStateDisabled];
    [self.confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.confirmButton.layer.borderWidth = 1.0;
    self.confirmButton.layer.borderColor = HEXCOLOR(0xeaeaea).CGColor;
    self.confirmButton.enabled = NO;
    [self.confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.confirmButton];

}

- (void)passwordInputComplete:(NSString *)password firstInput:(BOOL)isFirstInput
{
    WlLog(@"第%d次： %@",isFirstInput?1:2, password);
    if (isFirstInput) {//第一次输入
        self.firstPassword = password;
        [self.codeView clearInputWithResetFlag:NO];
        self.titleLabel.text = @"请再次输入支付密码";
        
    }else{//第二次输入
        if ([password isEqualToString:self.firstPassword]) {//两次密码相同
            WlLog(@"两次密码相同");
            self.confirmButton.enabled = YES;
        }else{
            WlLog(@"两次密码不相同");
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"两次输入的密码不一致"
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"知道了", nil];
            [alertView show];
            
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.firstPassword = nil;
    [self.codeView clearInputWithResetFlag:YES];
    self.titleLabel.text = @"设置6位数的支付密码";
}

-(void)confirmButtonClick
{
    [self.view endEditing:YES];
    [self showHud];
    WS(weakSelf);
    [WLNetworkAccountHandler setPaymentCodeWithPassword:self.firstPassword operationBlock:^(WLResponseType responseType, BOOL result, NSString *message) {
        [weakSelf hidHud];
        if (responseType == WLResponseTypeSuccess) {
            if (result) {
                [[WL_TipAlert_View sharedAlert] createTip:@"密码设置成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    for (UIViewController *vc in weakSelf.navigationController.viewControllers) {
                        if ([vc isKindOfClass:[WL_FundAccount_ViewController class]]) {
                            [weakSelf.navigationController popToViewController:vc animated:YES];
                        }
                    }
                });
            }
            [[WL_TipAlert_View sharedAlert] createTip:message];
        }
        
        
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
}

- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
