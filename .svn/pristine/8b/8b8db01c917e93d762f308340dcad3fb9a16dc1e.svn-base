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

#import "WL_Mine_RechargeViewController_Cell.h"

#import "WL_DepositSucess_ViewController.h"


//产品中心
#define ProductBaseHost      @"http://112.126.68.22:"
#define ProductBasePort      @"8070"
#define ProductBaseServer    ProductBaseHost ProductBasePort

/* 微信支付->回调地址>接口地址 */
#define WL_WxPay_Back_URL    [NSString stringWithFormat:@"%@/pay/weixinpay/backUrl",ProductBaseServer]

@interface WL_Mine_RechargeViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

{
    UIView *view;
    
    UITextField *rechargeField;
    
    NSIndexPath *selectIndex;
    
    NSIndexPath *lastIndex;
    
    payRequsestHandler *req;
    
    WL_Network_Model *AlipayModel;
}

@property(nonatomic,strong)UITableView *tableView;


@property(nonatomic,strong)NSArray *imageArray;

@property(nonatomic,strong)NSArray *titleArray;

@end

@implementation WL_Mine_RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"充值";
    self.view.backgroundColor = BgViewColor;
    
    [self initData];
    [self initUI];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(AlipayNotify:) name:ORDER_PAY_ALIPAY object:nil];
    
    lastIndex = [NSIndexPath indexPathForRow:0 inSection:0];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    WlLog(@"123");
}

-(void)initData
{
    self.titleArray =[NSArray arrayWithObjects:@"支付宝支付",@"微信支付", nil];
    
    self.imageArray =[NSArray arrayWithObjects:@"recharge_zhifubao_icon",@"recharge_weixinPay_icon", nil];
}
-(void)initUI
{
    self.tableView =[[UITableView alloc]init];
    
    [self.tableView setFrame:CGRectMake(0, 0, ScreenWidth, self.titleArray.count*50)];
    
    self.tableView.delegate=self;
    
    self.tableView.dataSource =self;
    
    self.tableView.showsHorizontalScrollIndicator =NO;
    self.tableView.showsVerticalScrollIndicator =NO;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    self.tableView.scrollEnabled=NO;
    
    [self.view addSubview:self.tableView];
    
    view =[[UIView alloc]initWithFrame:CGRectMake(0, ViewBelow(self.tableView)+10, ScreenWidth, 50)];
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
    
    [confirmButton setBackgroundColor:WLColor(140, 157, 244, 1)];
    
    [confirmButton setTitle:@"确认充值" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    confirmButton.layer.cornerRadius = 3.0;
    [self.view addSubview:confirmButton];

    
}

- (void)rechargeFieldChange
{
    
    
    if (rechargeField.text.length>=1&&[[rechargeField.text substringToIndex:1] isEqualToString:@"."]) {
        
        rechargeField.text = @"";
        
    }
    if (rechargeField.text.length>=1&&[[rechargeField.text substringToIndex:1] isEqualToString:@"0"]) {
        
        if ([rechargeField.text intValue]>=1) {
            
            rechargeField.text =[NSString stringWithFormat:@"%d",[rechargeField.text intValue]];
            
        }else if ([rechargeField.text isEqualToString:@"00"])
        {
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
}

- (void)confirmButtonClick
{
    
    
    [rechargeField resignFirstResponder];
   
    if (selectIndex==nil) {
        
        [[WL_TipAlert_View sharedAlert]createTip:@"请选择充值类型"];
       
        return;
        
    }
    
    
    if (rechargeField.text.length==0) {
        
        [[WL_TipAlert_View sharedAlert]createTip:@"请输入充值金额"];
        
        return;
    }
    
    if ([rechargeField.text floatValue]==0.0) {
        [[WL_TipAlert_View sharedAlert]createTip:@"充值金额不能为0"];
        return;
    }

    if (selectIndex.row == 0)
    {
        
        [self order_alipay_request];
        
    }else if (selectIndex.row ==1)
    {
        
        [self order_wxpay_request];
    }
    
    
}

-(void)order_alipay_request
{
    
    NSString *amount = [NSString stringWithFormat:@"%0.2f",[rechargeField.text floatValue]];
    
    NSString *userId = [WLUserTools getUserId];
    
    NSString *passWord =[WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:passWord publicKey:RSAKey];
    
    NSString *subject = @"充值";
    
    NSString *body = @"支付宝充值";
    
    NSDictionary *prama = @{@"user_id":userId,@"user_password":encryptStr,@"total_fee":amount,@"subject":subject,@"body":body};
    
    [self showHud];
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager]requestWithURL:AlipayPayRsaUrl RequestType:RequestTypePost Parameters:prama Success:^(id responseObject) {
       
        [weakSelf hidHud];
        
        AlipayModel=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([AlipayModel.result isEqualToString:@"1"]) {
            
            
            [weakSelf travel_order_alipay];
            
        }
        
        
        WlLog(@"%@",responseObject);
        
    } Failure:^(NSError *error) {
       
        
    }];
    
    
}

#pragma mark - 选择微信支付 立即支付 事件

-(void)order_wxpay_request
{
    [self travel_order_wxpay];
}

#pragma mark - 选择 支付宝支付 立即支付 事件
-(void)travel_order_alipay
{
    WlLog(@"您选择的是支付宝支付类型");
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    
    NSString *appScheme = @"weilvdjs";
    
    NSString *orderString  = AlipayModel.data[@"alipay_config"];

    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic)
         {
           
             
    }];
    
}


-(void)AlipayNotify:(NSNotification *)notification

{
    
    NSDictionary *resultDic =[notification object];
    
    WlLog(@"支付结果__________%@",resultDic);
    NSString *errorCode = [resultDic objectForKey:@"resultStatus"];
    NSString *resultMsg = [resultDic objectForKey:@"memo"];
    if ([errorCode intValue] == 9000)
    {
        [self toNextSuccess];//成功有专门的成功弹出页面 ，所以不用[alert show];
        
    }
    else if ([errorCode intValue] == 8000)
    {
        resultMsg = @"正在处理中";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付结果"
                                                        message:resultMsg
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([errorCode intValue] == 4000)
    {
        resultMsg = @"订单支付失败";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付结果"
                                                        message:resultMsg
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([errorCode intValue] == 6001)
    {
        resultMsg = @"用户中途取消";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付结果"
                                                        message:resultMsg
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([errorCode intValue] == 6002)
    {
        resultMsg = @"网络连接出错";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付结果"
                                                        message:resultMsg
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        resultMsg = @"支付失败";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付结果"
                                                        message:resultMsg
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
    

    
}
#pragma mark - 选择 微信支付 立即支付 事件
-(void)travel_order_wxpay
{
    WlLog(@"您选择的是微信支付类型");
    //判断iPhone客户端是否安装微信APP，如果没有则使用支付宝支付
    if (![WXApi isWXAppInstalled])
    {
       // [self travel_order_alipay];
    }
    else
    {
        [self WX_PayOrder];
    }
    
}
#pragma mark - 微信支付 方法
-(void)WX_PayOrder
{
    
    //WeiXinID
    req = [[payRequsestHandler alloc]init];
    [req init:WeiXinID mch_id:WXPartnerId];
    [req setKey:WXPartnerKey];
    NSMutableDictionary *dict = [self sendPay];
    if(dict == nil)
    {
        //错误提示
        NSString *debug = [req getDebugifo];
        [self showAlert:@"支付失败!"];
        WlLog(@"%@\n\n",debug);
    }
    else
    {
        WlLog(@"%@\n\n",[req getDebugifo]);
        NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
        
        PayReq* request             = [[PayReq alloc] init];
        request.openID              = [dict objectForKey:@"appid"];
        request.partnerId           = [dict objectForKey:@"partnerid"];
        request.prepayId            = [dict objectForKey:@"prepayid"];
        request.nonceStr            = [dict objectForKey:@"noncestr"];
        request.timeStamp           = stamp.intValue;
        request.package             = [dict objectForKey:@"package"];
        request.sign                = [dict objectForKey:@"sign"];
        [WXApi sendReq:request];
    }
}

#pragma mark - 微信支付 配置参数
- ( NSMutableDictionary *)sendPay
{
    srand( (unsigned)time(0) );
    NSString *noncestr  = [NSString stringWithFormat:@"%d", rand()];
    NSMutableDictionary *packageParams = [NSMutableDictionary dictionary];
    NSString *money =[NSString stringWithFormat:@"%0.2f",0.01*100];
    
    NSString *body =@"充值";
    //    if (body.length >32)
    //    {
    //        body = [body substringToIndex:32];
    //    }
    NSString *totalFee = [NSString stringWithFormat:@"%d",[money intValue]];
    [packageParams setObject: WeiXinID             forKey:@"appid"];       //开放平台appid
    [packageParams setObject: WXPartnerId             forKey:@"mch_id"];      //商户号
    [packageParams setObject: @"APP-001"        forKey:@"device_info"]; //支付设备号或门店号
    [packageParams setObject: noncestr          forKey:@"nonce_str"];   //随机串
    [packageParams setObject: @"APP"            forKey:@"trade_type"];  //支付类型，固定为APP
    [packageParams setObject: body       forKey:@"body"];        //订单描述，展示给用户
    //[packageParams setObject:WL_WxPay_Back_URL forKey :@"notify_url"];  //支付结果异步通知
    
    [packageParams setObject: @"10254555444" forKey:@"out_trade_no"];//商户订单号
    
    
    [packageParams setObject: @"127.0.0.1"    forKey:@"spbill_create_ip"];//发器支付的机器ip
    [packageParams setObject: totalFee       forKey:@"total_fee"];       //订单金额，单位为分
    
    NSString *prePayid;
    prePayid = [req sendPrepay:packageParams];
    
    if ( prePayid != nil)
    {
        NSString    *package, *time_stamp, *nonce_str;
        time_stamp  = [self genTimeStamp];
        nonce_str	= [WLTools md5:time_stamp];
        package         = @"Sign=WXPay";
        
        NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
        [signParams setObject: WeiXinID        forKey:@"appid"];
        [signParams setObject: nonce_str    forKey:@"noncestr"];
        [signParams setObject: package      forKey:@"package"];
        [signParams setObject: WXPartnerId        forKey:@"partnerid"];
        [signParams setObject: time_stamp   forKey:@"timestamp"];
        [signParams setObject: prePayid     forKey:@"prepayid"];
        NSString *sign  = [req createMd5Sign:signParams];
        
        [signParams setObject: sign         forKey:@"sign"];
        return signParams;
        
    }
    return nil;
}

#pragma mark - 获取时间戳
- (NSString *)genTimeStamp
{
    return [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
}

#pragma mark - 微信支付 支付成功后 触发通知函数
- (void)updateOrderPayResult:(NSNotification *)notification
{
    [self toNextSuccess];
}
#pragma mark - 支付宝 支付成功 跳转 页面
- (void)toNextSuccess
{
    
    NSString *userId = [WLUserTools getUserId];
    
    NSString *passWord =[WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:passWord publicKey:RSAKey];
    
    NSString *out_trade_no = AlipayModel.data[@"out_trade_no"];
    
    NSDictionary *parameters = @{@"user_id":userId,@"user_password":encryptStr,@"out_trade_no":out_trade_no};
    
    
    [[WLHttpManager shareManager]requestWithURL:AlipayPayUpdateRechargeFUrl  RequestType:RequestTypePost Parameters:parameters Success:^(id responseObject) {
        
        WlLog(@"%@",responseObject);
        
        if ([responseObject[@"result"]integerValue]==1) {
            
           
            WL_DepositSucess_ViewController *VC =[[WL_DepositSucess_ViewController alloc]init];
            
            VC.string1 = @"充值成功";
            VC.string2 =@"";
            
            [self.navigationController pushViewController:VC animated:YES];
            
            
        }else
        {
            [[WL_TipAlert_View sharedAlert]createTip:responseObject[@"msg"]];
        }
        
        WlLog(@"%@",responseObject[@"msg"]);
    } Failure:^(NSError *error) {
        WlLog(@"%@",error);
    }];
    
    
}






- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.titleArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return 50;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID =@"cellID";
    WL_Mine_RechargeViewController_Cell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell==nil) {
        cell =[[WL_Mine_RechargeViewController_Cell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
    }
    
    cell.leftImage.image =[UIImage imageNamed:self.imageArray[indexPath.row]];
    
    cell.typeLabel.text = self.titleArray[indexPath.row];
    
    
    if (indexPath.row==lastIndex.row) {
        
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        imageView.image=[UIImage imageNamed:@"RechargeSelect"];//把图片置空
        cell.accessoryView=imageView;
        
        lastIndex=indexPath;
        selectIndex=indexPath;
    }else{
        
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        imageView.image=[UIImage imageNamed:@"RechargeUnSelect"];//把图片置空
        cell.accessoryView=imageView;
        
    }
    
    if (indexPath.row==self.titleArray.count-1) {
        
        cell.line.hidden=YES;
        
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (lastIndex.row==indexPath.row) {
        WL_Mine_RechargeViewController_Cell * cell=(WL_Mine_RechargeViewController_Cell *)[tableView cellForRowAtIndexPath:lastIndex];
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        imageView.image=[UIImage imageNamed:@"RechargeUnSelect"];//把图片置空
        cell.accessoryView=imageView;
        lastIndex=[NSIndexPath indexPathForRow:10000 inSection:0];//把index置为一个不可能相等的数
        selectIndex=nil;
    }else{
        WL_Mine_RechargeViewController_Cell * cell2=(WL_Mine_RechargeViewController_Cell *)[tableView cellForRowAtIndexPath:lastIndex];
        UIImageView *imageView2=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        imageView2.image=[UIImage imageNamed:@"RechargeUnSelect"];//把图片置空
        cell2.accessoryView=imageView2;
        
        WL_Mine_RechargeViewController_Cell * cell=(WL_Mine_RechargeViewController_Cell *)[tableView cellForRowAtIndexPath:indexPath];
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        imageView.image=[UIImage imageNamed:@"RechargeSelect"];
        cell.accessoryView=imageView;
        lastIndex=indexPath;
        selectIndex=indexPath;
        
    }
    
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
    
    
}
- (void)showAlert:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示信息" message:msg delegate:nil  cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [alter show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
