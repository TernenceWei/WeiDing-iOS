//
//  WLRechargeViewController.m
//  WeiLvDJS
//
//  Created by ternence on 2017/1/17.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLRechargeViewController.h"
#import "WLRechargeCell.h"
#import "WLNetworkAccountHandler.h"
#import "AppManager.h"


@interface WLRechargeViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIAlertViewDelegate>
{
    UITextField *rechargeField;
    WL_Network_Model *alipayModel;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *confirmButton;

@end

@implementation WLRechargeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.titleItem.title =@"充值";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paymentFinishAction:) name:PaymentNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [rechargeField becomeFirstResponder];
}

- (void)setMode:(WLPaymentMode)mode
{
    _mode = mode;
    [self initUI];
    [self.tableView reloadData];
}

- (void)paymentFinishAction:(NSNotification *)notification
{
    NSDictionary *dict = notification.userInfo;
    NSUInteger code = [[dict objectForKey:@"code"] integerValue];
    
    
    NSString *message = @"支付成功";
    if (code == WLPaymentCodeSuccess){
        
        message = @"支付成功";
    }else if (code == WLPaymentCodeProcessed){
        
        message = @"正在处理中";
    }else if (code == WLPaymentCodeFailure){
        
        message = @"订单支付失败";
    }else if (code == WLPaymentCodeCancel){
        
        message = @"用户中途取消";
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付结果"
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"确认"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    [self.navigationController popViewControllerAnimated:YES];

}


-(void)initUI
{
    self.view.backgroundColor = BgViewColor;
    
    self.tableView = [[UITableView alloc] init];
    [self.tableView setFrame:CGRectMake(0, 65, ScreenWidth, 180)];
    self.tableView.delegate=self;
    self.tableView.dataSource =self;
    self.tableView.showsHorizontalScrollIndicator =NO;
    self.tableView.showsVerticalScrollIndicator =NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled=NO;
    [self.view addSubview:self.tableView];
    
    
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, ViewBelow(self.tableView) + 10, ScreenWidth, 50)];
    view.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:view];
    
    UILabel *rechargeLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 50)];
    rechargeLabel.font =WLFontSize(14);
    rechargeLabel.text =@"充值金额";
    rechargeLabel.textColor =[WLTools stringToColor:@"#2f2f2f"];
    [view addSubview:rechargeLabel];
    
    rechargeField =[[UITextField alloc]initWithFrame:CGRectMake(ViewRight(rechargeLabel)+40, 0, ScreenWidth -140, 50)];
    rechargeField.placeholder=@"请输入充值金额";
    rechargeField.font =WLFontSize(14);
    rechargeField.delegate =self;
    rechargeField.clearButtonMode = UITextFieldViewModeWhileEditing;
    rechargeField.returnKeyType = UIReturnKeyDone;
    rechargeField.keyboardType = UIKeyboardTypeDecimalPad;
    rechargeField.textColor = [WLTools stringToColor:@"#2f2f2f"];
    [rechargeField addTarget:self action:@selector(rechargeFieldChange) forControlEvents:UIControlEventEditingChanged];
    [view addSubview:rechargeField];
    
    UIButton *confirmButton =[[UIButton alloc]initWithFrame:CGRectMake(45, ViewBelow(view)+45, ScreenWidth-90, 45)];
    [confirmButton setTitle:@"确认充值" forState:UIControlStateNormal];
    [confirmButton setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateDisabled];
    [confirmButton setBackgroundImage:[UIImage imageWithColor:Color1] forState:UIControlStateNormal];
    [confirmButton setTitleColor:HEXCOLOR(0xeaeaea) forState:UIControlStateDisabled];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmButton.layer.cornerRadius = 22.5;
    confirmButton.layer.masksToBounds = YES;
    confirmButton.layer.borderWidth = 1.0;
    confirmButton.layer.borderColor = HEXCOLOR(0xeaeaea).CGColor;
    confirmButton.enabled = NO;
    [confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmButton];
    self.confirmButton = confirmButton;
}

#pragma mark 按钮点击事件
- (void)rechargeFieldChange
{
    if (rechargeField.text.length>=1&&[[rechargeField.text substringToIndex:1] isEqualToString:@"."]) {
        rechargeField.text = @"";
    }
    if (rechargeField.text.length>=1&&[[rechargeField.text substringToIndex:1] isEqualToString:@"0"]) {
        
        if ([rechargeField.text intValue]>=1) {
            rechargeField.text =[NSString stringWithFormat:@"%d",[rechargeField.text intValue]];
        }else if ([rechargeField.text isEqualToString:@"00"]){
            rechargeField.text =[NSString stringWithFormat:@"%d",[rechargeField.text intValue]];
        }
        
    }
    
    if ([rechargeField.text rangeOfString:@"."].location!=NSNotFound) {
        
        NSInteger index =[rechargeField.text rangeOfString:@"."].location;
        NSString *str=[rechargeField.text substringFromIndex:index+1];
        if (rechargeField.text.length>index+1) {
            NSString *originString = [rechargeField.text substringWithRange:NSMakeRange(index+1, 1)];
            if ([originString isEqualToString:@"."]) {
                rechargeField.text = [rechargeField.text substringToIndex:index+1];
            }
        }
        if (str.length>=2) {
            rechargeField.text= [rechargeField.text substringToIndex:index+3];
        }
    }
    if (rechargeField.text.length>12) {
        rechargeField.text=[rechargeField.text substringToIndex:12];
    }
    
    self.confirmButton.enabled = (rechargeField.text.length != 0 && [rechargeField.text floatValue] >= 0.001);
    
}

- (void)confirmButtonClick
{
    [rechargeField resignFirstResponder];
    if (rechargeField.text.length==0) {
        [[WL_TipAlert_View sharedAlert]createTip:@"请输入充值金额"];
        return;
    }
    if ([rechargeField.text floatValue]==0.0) {
        [[WL_TipAlert_View sharedAlert]createTip:@"充值金额不能为0"];
        return;
    }
    [self requestAlipayOrder];
}

#pragma mark 支付宝支付
-(void)requestAlipayOrder
{
    //先提交给后台，由后台向支付宝请求支付订单
    NSString *amount = [NSString stringWithFormat:@"%0.2f",[rechargeField.text floatValue]];
    NSString *body = @"支付宝充值";
    
    if (self.mode == WLPaymentModeWeixin) {
        amount = [NSString stringWithFormat:@"%0.2f",[rechargeField.text floatValue] * 100];
        body = @"微信充值";
    }
    
    [WLNetworkAccountHandler requestPaymentOrderWithPaymentMode:self.mode
                                                          money:amount
                                                        content:body
                                                      dataBlock:^(WLResponseType responseType, id data, NSString *message) {
                                                          
                                                          if (responseType == WLResponseTypeSuccess) {
                                                              
                                                              [WLNetworkAccountHandler rechargeWithPaymentMode:self.mode orderParams:data operationBlock:^(WLResponseType responseType, BOOL result, NSString *message) {
                                                                  
                                                              }];
                                                              
                                                          }else{
                                                              
                                                          }
                                                      }];
    
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLRechargeCell *cell =[WLRechargeCell cellWithTableView:tableView];
    cell.mode = self.mode;
    return cell;
}

#pragma mark private method
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
