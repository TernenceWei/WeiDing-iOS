//
//  WLAffirmDriverViewController.m
//  WeiLvDJS
//
//  Created by hsliang on 2017/2/27.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLAffirmDriverViewController.h"
#import "WLAffirmDriverTableViewCell.h"
#import "WLNetworkCarBookingHandler.h"
#import "WLNetworkAccountHandler.h"
#import "WLCarBookingOrderDetailController.h"
#import "WLApplicationImageBrowserViewController.h"
#import "AppManager.h"

@interface WLAffirmDriverViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) UITableView * affirmTable;
@property (nonatomic, strong) UIButton * rightBottomBtn;
@property (nonatomic, strong) NSString * runTimeStr;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) WLCarBookingOrderDetailObject *object;

@end

@implementation WLAffirmDriverViewController

- (void)viewDidDisappear:(BOOL)animated
{

    [super viewDidDisappear:animated];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:PaymentNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"确认选择";
    
    [self createUI];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countTime) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishPayment:) name:PaymentNotification object:nil];
}

- (void)createUI
{
    _affirmTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - ScaleH(64))];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _affirmTable.delegate = self;
    _affirmTable.dataSource = self;
    _affirmTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    //_affirmTable.showsVerticalScrollIndicator = NO;
    _affirmTable.scrollEnabled = NO;
    _affirmTable.backgroundColor = BgViewColor;
    [self.view addSubview:_affirmTable];
    
    CGFloat originY = 0.0;
    if (IsiPhone5||IsiPhone4) {
        originY = ScreenHeight - ScaleH(124);
    }
    else
    {
        originY = ScreenHeight - ScaleH(114);
    }
    
    UIButton * leftBottomBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, originY, ScreenWidth / 2, ScaleH(50))];
    leftBottomBtn.backgroundColor = [UIColor whiteColor];
    [leftBottomBtn setTitle:[NSString stringWithFormat:@"待付款￥%@",_driverobject.bid_price] forState:UIControlStateNormal];
    [leftBottomBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:leftBottomBtn];
    
    _rightBottomBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth / 2, leftBottomBtn.frame.origin.y, ScreenWidth / 2, ScaleH(50))];
    _rightBottomBtn.backgroundColor = [WLTools stringToColor:@"#00cc99"];
    [_rightBottomBtn setTitle:[NSString stringWithFormat:@"确认选Ta(%@)",[NSString stringWithFormat:@"%02ld:%02ld",self.remainTime/60,self.remainTime % 60]] forState:UIControlStateNormal];
    [_rightBottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_rightBottomBtn addTarget:self action:@selector(rightBottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_rightBottomBtn];
}

- (void)countTime
{
    _runTimeStr = [NSString stringWithFormat:@"%02ld:%02ld",self.remainTime/60,self.remainTime % 60];

    [_rightBottomBtn setTitle:[NSString stringWithFormat:@"确认选Ta(%@)",_runTimeStr] forState:UIControlStateNormal];
    
    if (self.remainTime > 0) {
        self.remainTime --;
    }
    else
    {
        self.remainTime = 0;
        _runTimeStr = @"00:00";
        [_timer invalidate];
    }
}

- (void)rightBottomBtnClick
{
    [self selectDriverWithObject];
}

- (void)selectDriverWithObject
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择支付方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"稍后再付款",@"支付宝支付",@"微信支付", nil];
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self chooseDriver];
    }
    if (buttonIndex == 1) {
        [self selectDriverWithObject:_driverobject payType:WLPaymentModeAlipayOrder];
    }
    if (buttonIndex == 2) {
        [self selectDriverWithObject:_driverobject payType:WLPaymentModeWeixinOrder];
    }
}

- (void)chooseDriver
{
    //显示隐藏的菊花
    [self showHud];
    [WLNetworkCarBookingHandler doChooseDriverWithOrderID:_orderID driverID:_driverobject.sj_driver_id Block:^(WLResponseType responseType, NSInteger status, NSString *message) {
        //隐藏菊花
        [self hidHud];
        if (responseType == WLResponseTypeSuccess) {
            WLCarBookingOrderDetailController *detailVC = [[WLCarBookingOrderDetailController alloc] init];
            detailVC.orderID = _orderID;
            detailVC.iSAffirm = YES;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
        else
        {
            [[WL_TipAlert_View sharedAlert] createTip:message];
        }
        if (status == 422) {
            [NSThread currentThread];
            UIAlertView * noDataAlertView = [[UIAlertView alloc] initWithTitle:message message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
            noDataAlertView.tag = 199008;
            [noDataAlertView show];
        }
    }];
}

- (void)selectDriverWithObject:(WLCarBookingDriverObject *)object payType:(WLPaymentMode)Type
{
    [WLNetworkCarBookingHandler requestPaymentOrderWithPaymentMode:Type
                                                           orderID:self.orderID
                                                          driverID:object.sj_driver_id
                                                         dataBlock:^(WLResponseType responseType, id data, NSString *message) {
                                                             if (responseType == WLResponseTypeSuccess) {
                                                                 
                                                                 [WLNetworkAccountHandler rechargeWithPaymentMode:Type orderParams:data operationBlock:^(WLResponseType responseType, BOOL result, NSString *message) {
                                                                     
                                                                 }];
                                                             }else{
                                                                 [[WL_TipAlert_View sharedAlert] createTip:message];
                                                             }
                                                         }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        WLAffirmDriverTableViewCell * cell = [WLAffirmDriverTableViewCell cellWithTableView:tableView];
        
        [cell setCellDatadriverobject:_driverobject];
        
        return cell;
    }
    if (indexPath.section == 1) {
        UITableViewCell *cell = [_affirmTable dequeueReusableCellWithIdentifier:@"listCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"listCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;//选中不变颜色
        
        NSString *carmode = @"大巴车";
        if (_driverobject.car_model.integerValue == 2) {
            carmode = @"商务车";
        }else if (_driverobject.car_model.integerValue == 4) {
            carmode = @"小轿车";
        }
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@座%@",_driverobject.car_seat_amount,carmode];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ 已用%@年 %@",_driverobject.car_brand,_driverobject.age_limit,_driverobject.car_number];

        
        UIImageView * arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - ScaleW(20), cell.textLabel.frame.origin.y + ScaleH(18), ScaleW(10), ScaleH(20))];
        [arrowImg setImage:[UIImage imageNamed:@"arrow"]];
        [cell addSubview:arrowImg];
        
        return cell;
    }

    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 0) {

        if (_driverobject.car_image.count != 0) {
            
            WLApplicationImageBrowserViewController *imageBrowserVC = [[WLApplicationImageBrowserViewController alloc]init];
            imageBrowserVC.imagesArray = [NSArray arrayWithArray:_driverobject.car_image];
            
            [self.navigationController pushViewController:imageBrowserVC animated:YES];
        }
        else
        {
            UIAlertView * noDataAlertView = [[UIAlertView alloc] initWithTitle:@"暂无车辆图片数据" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
            [noDataAlertView show];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return ScaleH(10);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return ScaleH(0.1);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return ScaleH(150);
    }
    if (indexPath.section == 1) {
        return ScaleH(60);
    }
    
    return 0;
}

#pragma mark alipay
- (void)finishPayment:(NSNotification *)notification
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
    alert.tag = code;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == WLPaymentCodeSuccess) {

        WLCarBookingOrderDetailController *detailVC = [[WLCarBookingOrderDetailController alloc] init];
        detailVC.orderID = self.orderID;
        detailVC.iSAffirm = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
        
        
    }else if (alertView.tag == 1001){
        if (buttonIndex == 0) {
            WS(weakSelf);
            [WLNetworkCarBookingHandler cancelOrderWithOrderID:self.orderID dataBlock:^(WLResponseType responseType, id data, NSString *message) {
                
                if (responseType == WLResponseTypeSuccess) {
                    [[WL_TipAlert_View sharedAlert] createTip:@"取消订单成功"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    });
                }else{
                    [[WL_TipAlert_View sharedAlert] createTip:message];
                }
            }];
        }
    }
    
    if (alertView.tag == 199008) {
        
        [self NavigationLeftEvent];
    }
}

- (void)dealloc
{
    [_timer invalidate];
}

#pragma mark network
- (void)loadData{

    WS(weakSelf);
    [self showHud];
    [WLNetworkCarBookingHandler requestOrderDetailWithOrderID:self.orderID dataBlock:^(WLResponseType responseType, id data, NSString *message) {
        [self hidHud];
        if (responseType == WLResponseTypeSuccess) {
            
            weakSelf.object = data;
            if ([weakSelf.object.pay_status isEqual:@"1"]) {
                WLCarBookingOrderDetailController *detailVC = [[WLCarBookingOrderDetailController alloc] init];
                detailVC.orderID = self.orderID;
                detailVC.iSAffirm = YES;
                [self.navigationController pushViewController:detailVC animated:YES];
            }
            
        }else{
            [[WL_TipAlert_View sharedAlert] createTip:message];
            
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
