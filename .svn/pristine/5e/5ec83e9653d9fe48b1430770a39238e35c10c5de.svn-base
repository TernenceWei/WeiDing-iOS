//
//  WL_Mine_personInfo_Authentication_ViewController.m
//  WeiLvDJS
//
//  Created by liuxin on 16/9/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Mine_personInfo_Authentication_ViewController.h"
#import "WL_MangerWord_ViewController.h"
#import "WL_SetPayPassWord_ViewController.h"
#import "WLNetworkAccountHandler.h"

@interface WL_Mine_personInfo_Authentication_ViewController ()<UITextFieldDelegate>

@property(nonatomic,strong)UITextField *nameInput;
@property(nonatomic,strong)UITextField *IDnumberInput;
@property(nonatomic,strong)UILabel *sussedLabel;
@property (nonatomic, strong) UIButton *registerBtn;
@property (nonatomic, strong) UILabel *noticeLabel;

@end

@implementation WL_Mine_personInfo_Authentication_ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.titleItem.title = @"实名认证";
    [self creatStartView];
    [self loadData];
}


#pragma mark-----开始实名认证的界面
-(void)creatStartView
{
    CGFloat height = ScaleH(50);
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(0, ScaleH(15) + 64, ScreenWidth, height*2);
    [self.view addSubview:view];
    
    //真实姓名
    UILabel *labelName = [[UILabel alloc] init];
    labelName.frame = CGRectMake(ScaleW(20), 0, 100, ScaleH(50));
    labelName.textAlignment = NSTextAlignmentLeft;
    labelName.textColor = Color2;
    labelName.font =WLFontSize(16);
    labelName.text = @"真实姓名";
    [view addSubview:labelName];
    
    //身份证号
    UILabel *IdNumber = [[UILabel alloc] init];
    IdNumber.frame = CGRectMake(ScaleW(20), ScaleH(50), 100, ScaleH(50));
    IdNumber.textAlignment = NSTextAlignmentLeft;
    IdNumber.textColor = Color2;
    IdNumber.font = WLFontSize(16);
    IdNumber.text = @"身份证号";
    [view addSubview:IdNumber];
    
    //横线
    for (int i = 0; i < 2; i++) {
        UILabel *line = [[UILabel alloc] init];
        line.frame = CGRectMake(ScaleW(20), height * (i + 1)-0.5, ScreenWidth-ScaleW(20), 0.5);
        line.backgroundColor = Color4;
        [view addSubview:line];
    }
    
    //姓名输入框
    _nameInput = [[UITextField alloc] init];
    _nameInput.frame = CGRectMake(ScaleW(120), 5, ScreenWidth-ScaleW(120), height - 10);
    _nameInput.placeholder = @"请输入您的真实姓名";
    _nameInput.delegate= self;
    [_nameInput addTarget:self action:@selector(modifyConfirmBtnStatus) forControlEvents:UIControlEventEditingChanged];
    _nameInput.clearButtonMode = UITextFieldViewModeAlways;
    _nameInput.font = WLFontSize(14);
    _nameInput.textColor =BlackColor;
    _nameInput.backgroundColor = [UIColor whiteColor];
    [view addSubview:_nameInput];
    
    //身份证号码输入框
    _IDnumberInput = [[UITextField alloc] init];
    _IDnumberInput.frame = CGRectMake(ScaleW(120),height + 5, ScreenWidth-ScaleW(120),height - 10);
    _IDnumberInput.placeholder = @"请输入您的身份证号码";
    _IDnumberInput.delegate = self;
    [_IDnumberInput addTarget:self action:@selector(modifyConfirmBtnStatus) forControlEvents:UIControlEventEditingChanged];
    _IDnumberInput.clearButtonMode = UITextFieldViewModeAlways;
    _IDnumberInput.font = WLFontSize(14);
    _IDnumberInput.textColor = BlackColor;
    _IDnumberInput.backgroundColor = [UIColor whiteColor];
    [view addSubview:_IDnumberInput];
    
    UILabel *noticeLabel = [UILabel labelWithText:@"请认真填写，若3次都认证失败，则需联系客服处理。" textColor:Color3 fontSize:12];
    CGSize noticeSize = [WLUITool sizeWithString:noticeLabel.text font:noticeLabel.font constrainedToSize:CGSizeMake(ScreenWidth - ScaleW(44), MAXFLOAT)];
    noticeLabel.frame = CGRectMake(ScaleW(22), view.bottom + ScaleH(15), ScreenWidth - ScaleW(44), noticeSize.height);
    [self.view addSubview:noticeLabel];
    self.noticeLabel = noticeLabel;
    
    //认证按钮
    UIButton *btnStart = [UIButton buttonWithType:UIButtonTypeSystem];
    btnStart.frame = CGRectMake((ScreenWidth - ScaleW(250)) / 2, noticeLabel.bottom + ScaleH(40), ScaleW(250), ScaleH(40));
    [btnStart addTarget:self action:@selector(startBtn:) forControlEvents:UIControlEventTouchUpInside];
    btnStart.tag = 201;
    [btnStart setTitle:@"立即认证" forState:UIControlStateNormal];
    [btnStart setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateDisabled];
    [btnStart setBackgroundImage:[UIImage imageWithColor:Color1] forState:UIControlStateNormal];
    [btnStart setTitleColor:HEXCOLOR(0xeaeaea) forState:UIControlStateDisabled];
    [btnStart setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnStart.layer.cornerRadius = ScaleH(20);
    btnStart.layer.masksToBounds = YES;
    btnStart.layer.borderWidth = 1.0;
    btnStart.layer.borderColor = HEXCOLOR(0xeaeaea).CGColor;
    btnStart.enabled = NO;
    [self.view addSubview:btnStart];
    self.registerBtn = btnStart;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyBorod)];
    [self.view addGestureRecognizer:tap];
}

- (void)modifyConfirmBtnStatus
{

    self.registerBtn.enabled = (_nameInput.text.length != 0 && _IDnumberInput.text.length != 0);

}

- (void)loadData
{
    WS(weakSelf);
    [WLNetworkAccountHandler checkRealNameAuthenticationCountWithOperationBlock:^(WLResponseType responseType, BOOL result, NSString *message) {
        if (responseType && result) {//超过三次
            weakSelf.noticeLabel.text = @"您已进行过3次实名认证，请联系客服处理！";
            weakSelf.registerBtn.enabled = NO;
        }
        
    }];
}

#pragma mark----点击认证按钮
-(void)startBtn:(UIButton *)btn
{
    if (_nameInput.text.length==0) {
        [[WL_TipAlert_View sharedAlert] createTip:@"请输入姓名"];
        return;
    }
    if (_IDnumberInput.text.length == 0){
        [[WL_TipAlert_View sharedAlert] createTip:@"请输入身份证号"];
        return;
    }
    if (![RegexTools validateIDCardNumber:_IDnumberInput.text]){
        [[WL_TipAlert_View sharedAlert] createTip:@"身份证号输入有误"];
        return;
    }
    //输入合法后的界面
    [self VerificationToServer];
}

//开始认证
-(void)VerificationToServer
{
    [self.nameInput resignFirstResponder];
    [self.IDnumberInput resignFirstResponder];
    __weak typeof(self)weakSelf = self;
    [self showHud];
    [WLNetworkAccountHandler authenticateRealNameWithName:_nameInput.text
                                                   IDCard:_IDnumberInput.text
                                           operationBlock:^(WLResponseType responseType, BOOL result, NSString *message) {
                                               
                                               [weakSelf hidHud];
                                               if (responseType == WLResponseTypeSuccess && result) {
                                                   [[WL_TipAlert_View sharedAlert] createTip:@"实名认证成功"];
                                                   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                       [weakSelf.navigationController popViewControllerAnimated:YES];
                                                   });
                                                   
                                                   
                                               }else{
                                                   [[WL_TipAlert_View sharedAlert] createTip:message];
                                               }
                                               
                                           }];

    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(void)hiddenKeyBorod
{
    [_IDnumberInput resignFirstResponder];
    [_nameInput resignFirstResponder];
}

- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
