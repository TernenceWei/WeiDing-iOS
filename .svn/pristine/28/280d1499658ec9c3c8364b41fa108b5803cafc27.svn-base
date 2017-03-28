//
//  WL_ChangePassWord_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/14.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_ChangePassWord_ViewController.h"
#import "WL_SetSucess_ViewController.h"
#import "WL_Register_View.h"
#import "WLUserTools.h"
#import "WL_SetPayPassWord_ViewController.h"
#import "WLNetworkAccountHandler.h"

@interface WL_ChangePassWord_ViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UITextField *phoneNOField;
@property (nonatomic, strong) UITextField *codeField;
@property (nonatomic, strong) UITextField *IDCardField;
@property (nonatomic, strong) UIButton *codeBtn;
@end

@implementation WL_ChangePassWord_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI
{
    self.titleItem.title = @"修改支付密码";
    
    CGFloat height = ScaleH(50);
    UILabel * PhoneLabel = [WLTools allocLabel:@"+86" font:[UIFont WLFontOfSize:15.0] textColor:[UIColor lightGrayColor] frame:CGRectMake(ScaleW(32), ScaleH((15)) + 64, ScaleW(35), height) textAlignment:NSTextAlignmentCenter];
    [self.view addSubview:PhoneLabel];
    
    //手机号码输入框
    UITextField *phoneNumField = [[UITextField alloc] initWithFrame:CGRectMake(PhoneLabel.right + ScaleW(25), PhoneLabel.top + ScaleH(5), ScreenWidth - ScaleW(90), ScaleH(40))];
    phoneNumField.placeholder = @"请输入手机号码";
    phoneNumField.font = WLFontSize(15);
    phoneNumField.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneNumField.keyboardType = UIKeyboardTypeNumberPad;
    phoneNumField.text = [WLUserTools getUserMobile];
    [phoneNumField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:phoneNumField];
    self.phoneNOField = phoneNumField;
    
    //间隔
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(ScaleW(80), ScaleH(20) + 64, 1, height - ScaleH(5))];
    lineView.backgroundColor = bordColor;
    [self.view addSubview:lineView];

    //验证码输入框
    UITextField *captchaField = [[UITextField alloc] initWithFrame:CGRectMake(ScaleW(32), PhoneLabel.bottom + ScaleH(5), ScaleW(150), ScaleH(40))];
    captchaField.placeholder = @"请输入验证码";
    captchaField.font = WLFontSize(15);
    captchaField.clearButtonMode = UITextFieldViewModeWhileEditing;
    captchaField.keyboardType = UIKeyboardTypeNumberPad;
    [captchaField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:captchaField];
    self.codeField = captchaField;
    
    
    //获取验证码Button
    UIButton *achieveCaptchaButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - ScaleW(132), PhoneLabel.bottom + ScaleH(9), ScaleW(100), ScaleH(32))];
    achieveCaptchaButton.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    [achieveCaptchaButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [achieveCaptchaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [achieveCaptchaButton setBackgroundColor:[WLTools stringToColor:@"#00cc99"]];
    [achieveCaptchaButton.titleLabel setFont:WLFontSize(14)];
    achieveCaptchaButton.layer.cornerRadius = 15;
    achieveCaptchaButton.layer.masksToBounds = YES;
    [achieveCaptchaButton addTarget:self action:@selector(verificationCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:achieveCaptchaButton];
    self.codeBtn = achieveCaptchaButton;
    
    //身份证输入框
    UITextField *idCardField = [[UITextField alloc] initWithFrame:CGRectMake(ScaleW(32), ScaleH(115) + 64, ScaleW(250), height)];
    idCardField.placeholder = @"请输入身份证号码";
    idCardField.font = WLFontSize(15);
    idCardField.clearButtonMode = UITextFieldViewModeWhileEditing;
    idCardField.keyboardType = UIKeyboardTypeNumberPad;
    [idCardField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:idCardField];
    self.IDCardField = idCardField;
    
    for (int i = 0; i < 3; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(ScaleW(32), 64 + ScaleH(15) + height * (i + 1), ScreenWidth - ScaleW(64), 1)];
        lineView.backgroundColor = bordColor;
        [self.view addSubview:lineView];
    }

    
    self.nextButton =[[UIButton alloc]initWithFrame:CGRectMake((ScreenWidth - ScaleW(250)) / 2, idCardField.bottom+ ScaleH(90), ScaleW(250), ScaleH(45))];
    [self.nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    self.nextButton.layer.cornerRadius = ScaleH(22.5);
    self.nextButton.layer.masksToBounds = YES;
    [self.nextButton setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateDisabled];
    [self.nextButton setBackgroundImage:[UIImage imageWithColor:Color1] forState:UIControlStateNormal];
    [self.nextButton setTitleColor:HEXCOLOR(0xeaeaea) forState:UIControlStateDisabled];
    [self.nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.nextButton.layer.borderWidth = 1.0;
    self.nextButton.layer.borderColor = HEXCOLOR(0xeaeaea).CGColor;
    self.nextButton.enabled = NO;
    [self.nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextButton];
    
}

- (void)textChange
{    
    self.nextButton.enabled = (_phoneNOField.text.length != 0 && _codeField.text.length != 0 && _IDCardField.text.length != 0);
}

-(void)nextButtonClick
{
    //判断身份证号是否正确
//    NSString *idCard = [WLUserTools getIdCard];
//    if (![self.IDCardField.text isEqualToString:idCard]) {
//        [[WL_TipAlert_View sharedAlert] createTip:@"身份证号码不正确"];
//        return;
//    }
    [WLNetworkAccountHandler resetPaymentCodeWithMobile:self.phoneNOField.text
                                                   code:self.codeField.text
                                                 iDCard:self.IDCardField.text
                                         operationBlock:^(WLResponseType responseType, BOOL result, NSString *message) {
                                             
                                             if (result) {
                                                 WL_SetPayPassWord_ViewController *passwordVC = [[WL_SetPayPassWord_ViewController alloc] init];
                                                 [self.navigationController pushViewController:passwordVC animated:YES];
                                             }else{
                                                 if ([message isEqualToString:@""] || message == nil) {
                                                     return ;
                                                 }
                                                [[WL_TipAlert_View sharedAlert] createTip:message];
                                             }
                                         }];
    
}

#pragma mark - 获取验证码
- (void)verificationCodeBtnClick
{
    if (self.phoneNOField.text.length != 11) {
        [[WL_TipAlert_View sharedAlert] createTip:@"手机号码格式不正确"];
        return;
    }
    NSString *phoneNO = [WLUserTools getUserMobile];
    if (![phoneNO isEqualToString:self.phoneNOField.text]) {
        [[WL_TipAlert_View sharedAlert] createTip:@"该手机号不正确"];
        return;
    }
    WS(weakSelf);
    [[WLNetworkLoginHandler sharedInstance] sendRequestToCaptchaWithPhoneNO:self.phoneNOField.text
                                                                   codeType:@"1"
                                                                     result:^(BOOL success, BOOL result, NSString *message, NSInteger minTimespan) {
                                                                         if (success) {
                                                                             if (result) {
                                                                                 [[WL_TipAlert_View sharedAlert] createTip:@"短信验证码已发送"];
                                                                                 [weakSelf startTimeWithTimeOut:minTimespan];
                                                                             }else{
                                                                                 [[WL_TipAlert_View sharedAlert]createTip:message];
                                                                             }
                                                                         }else{
                                                                             [[WL_TipAlert_View sharedAlert]createTip:@"验证码获取失败"];
                                                                         }
                                                                     }];

}

-(void)startTimeWithTimeOut:(NSInteger)timeout1
{
    __block NSInteger timeout=timeout1; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.codeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
                self.codeBtn.userInteractionEnabled = YES;
            });
        }else{
            long seconds = timeout % timeout1;
            NSString *strTime;
            if (timeout==timeout1){
                strTime=[NSString stringWithFormat:@"%ld", (long)timeout1];
            }else{
                strTime = [NSString stringWithFormat:@"%02ld", seconds];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.codeBtn setTitle:[NSString stringWithFormat:@"倒计时%@秒",strTime] forState:UIControlStateNormal];
                self.codeBtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);

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
