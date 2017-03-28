//
//  WL_Mine_RechargeViewController.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Mine_RechargeViewController.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "WXApiObject.h"
#import "payRequsestHandler.h"
#import "WLRechargeCell.h"
#import "WL_DepositSucess_ViewController.h"
#import "WLNetworkAccountHandler.h"

//产品中心
#define ProductBaseHost      @"http://112.126.68.22:"
#define ProductBasePort      @"8070"
#define ProductBaseServer    ProductBaseHost ProductBasePort

/* 微信支付->回调地址>接口地址 */
#define WL_WxPay_Back_URL    [NSString stringWithFormat:@"%@/pay/weixinpay/backUrl",ProductBaseServer]

@interface WL_Mine_RechargeViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITextField *rechargeField;
    WL_Network_Model *alipayModel;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *confirmButton;

@end

@implementation WL_Mine_RechargeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(alipayNotify:) name:ORDER_PAY_ALIPAY object:nil];
}

- (void)setMode:(WLPaymentMode)mode
{
    _mode = mode;
//    if (mode == WLPaymentModeWeixin) {
//        self.titleItem.title = @"微信充值";
//    }else{
//        self.titleItem.title = @"支付宝充值";
//    }
    [self initUI];
    [self.tableView reloadData];
}


-(void)initUI
{
    self.titleItem.title =@"充值";
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

//支付完成之后的消息通知
-(void)alipayNotify:(NSNotification *)notification
{
    NSDictionary *resultDic = [notification object];
    
    NSString *errorCode = [resultDic objectForKey:@"resultStatus"];
    NSString *resultMsg = [resultDic objectForKey:@"memo"];
    if ([errorCode intValue] == 9000){
        
        resultMsg = @"支付成功";
    }else{
        if ([errorCode intValue] == 8000){
            
            resultMsg = @"正在处理中";
        }else if ([errorCode intValue] == 4000){
            
            resultMsg = @"订单支付失败";
        }else if ([errorCode intValue] == 6001){
            
            resultMsg = @"用户中途取消";
        }else if ([errorCode intValue] == 6002){
            
            resultMsg = @"网络连接出错";
        }else{
            resultMsg = @"支付失败";
        }
        
    }
    [self showAlertViewWithMessage:resultMsg];
}

- (void)showAlertViewWithMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付结果"
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"确认"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

////更新支付宝支付结果
//- (void)updateAlipayStatus
//{
//    WS(weakSelf);
//    NSString *out_trade_no = alipayModel.data[@"out_trade_no"];
//    [WLNetworkAccountHandler updateAlipayStatusWithTradeNumber:out_trade_no
//                                                operationBlock:^(WLResponseType responseType, BOOL result, NSString *message) {
//                                                    
//                                                    if (responseType == WLResponseTypeSuccess) {
//
//                                                        [[WL_TipAlert_View sharedAlert] createTip:@"充值成功"];
//                                                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                                                            [weakSelf.navigationController popViewControllerAnimated:YES];
//                                                        });
//                                                    }else{
//                                                        
//                                                        [[WL_TipAlert_View sharedAlert]createTip:message];
//                                                    }
//                                                }];
//}

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

////#pragma mark - 微信支付 方法
//-(void)WX_PayOrder
//{
//    
//    //WeiXinID
//    req = [[payRequsestHandler alloc]init];
//    [req init:WeiXinID mch_id:WXPartnerId];
//    [req setKey:WXPartnerKey];
//    NSMutableDictionary *dict = [self sendPay];
//    if(dict == nil)
//    {
//        //错误提示
//        NSString *debug = [req getDebugifo];
//        [self showAlert:@"支付失败!"];
//        WlLog(@"%@\n\n",debug);
//    }else{
//        WlLog(@"%@\n\n",[req getDebugifo]);
//        NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
//        
//        PayReq* request             = [[PayReq alloc] init];
//        request.openID              = [dict objectForKey:@"appid"];
//        request.partnerId           = [dict objectForKey:@"partnerid"];
//        request.prepayId            = [dict objectForKey:@"prepayid"];
//        request.nonceStr            = [dict objectForKey:@"noncestr"];
//        request.timeStamp           = stamp.intValue;
//        request.package             = [dict objectForKey:@"package"];
//        request.sign                = [dict objectForKey:@"sign"];
//        [WXApi sendReq:request];
//    }
//}

//#pragma mark - 微信支付 配置参数
//- ( NSMutableDictionary *)sendPay
//{
//    srand( (unsigned)time(0) );
//    NSString *noncestr  = [NSString stringWithFormat:@"%d", rand()];
//    NSMutableDictionary *packageParams = [NSMutableDictionary dictionary];
//    NSString *money =[NSString stringWithFormat:@"%0.2f",0.01*100];
//    
//    NSString *body =@"充值";
//    //    if (body.length >32)
//    //    {
//    //        body = [body substringToIndex:32];
//    //    }
//    NSString *totalFee = [NSString stringWithFormat:@"%d",[money intValue]];
//    [packageParams setObject: WeiXinID             forKey:@"appid"];       //开放平台appid
//    [packageParams setObject: WXPartnerId             forKey:@"mch_id"];      //商户号
//    [packageParams setObject: @"APP-001"        forKey:@"device_info"]; //支付设备号或门店号
//    [packageParams setObject: noncestr          forKey:@"nonce_str"];   //随机串
//    [packageParams setObject: @"APP"            forKey:@"trade_type"];  //支付类型，固定为APP
//    [packageParams setObject: body       forKey:@"body"];        //订单描述，展示给用户
//    //[packageParams setObject:WL_WxPay_Back_URL forKey :@"notify_url"];  //支付结果异步通知
//    
//    [packageParams setObject: @"10254555444" forKey:@"out_trade_no"];//商户订单号
//    
//    
//    [packageParams setObject: @"127.0.0.1"    forKey:@"spbill_create_ip"];//发器支付的机器ip
//    [packageParams setObject: totalFee       forKey:@"total_fee"];       //订单金额，单位为分
//    
//    NSString *prePayid;
//    prePayid = [req sendPrepay:packageParams];
//    
//    if ( prePayid != nil)
//    {
//        NSString    *package, *time_stamp, *nonce_str;
//        time_stamp  = [self genTimeStamp];
//        nonce_str	= [WLTools md5:time_stamp];
//        package         = @"Sign=WXPay";
//        
//        NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
//        [signParams setObject: WeiXinID        forKey:@"appid"];
//        [signParams setObject: nonce_str    forKey:@"noncestr"];
//        [signParams setObject: package      forKey:@"package"];
//        [signParams setObject: WXPartnerId        forKey:@"partnerid"];
//        [signParams setObject: time_stamp   forKey:@"timestamp"];
//        [signParams setObject: prePayid     forKey:@"prepayid"];
//        NSString *sign  = [req createMd5Sign:signParams];
//        
//        [signParams setObject: sign         forKey:@"sign"];
//        return signParams;
//        
//    }
//    return nil;
//}
//
@end
