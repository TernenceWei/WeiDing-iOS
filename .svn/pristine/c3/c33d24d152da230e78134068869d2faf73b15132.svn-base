//
//  WLCarBookingOrderDetailController.m
//  WeiLvDJS
//
//  Created by ternence on 2017/1/20.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLCarBookingOrderDetailController.h"
#import "WLCarBookingDetailOrderCell.h"
#import "WLCarBookingDetailUserCell.h"
#import "WLCarBookingDetailPaymentCell.h"
#import "WLNetworkCarBookingHandler.h"
#import "WLCarBookingOrderDetailObject.h"
#import "WLCarBookingCostDetailViewController.h"
#import "WLCarBookingDetailViewMode.h"
#import "WLNetworkAccountHandler.h"
#import "WLCarBookingChooseDriverController.h"
#import "WLCarBookingOrderListViewController.h"
#import "WLCarBookingDriverObject.h"
#import "WLApplicationImageBrowserViewController.h"
#import "AppManager.h"
#import "WLAffirmDriverViewController.h"
#import "WL_TabBarController.h"
#import "WLCarBookingAddCostController.h"
#import "WLCarBookingViewController.h"
#import "WL_ApplicationViewController.h"

@interface WLCarBookingOrderDetailController ()<UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WLCarBookingOrderDetailObject *object;
@property (nonatomic, assign) BOOL isFold;
@property (nonatomic, strong) UILabel *remainLabel;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSTimeInterval remainTime;
@property (nonatomic, strong) UIButton * ToPayBtn;
@property (nonatomic, assign) BOOL ishiddenDriver;

@end

@implementation WLCarBookingOrderDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishPayment:) name:PaymentNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (_iSAffirm) {
        NSMutableArray *array = [self.navigationController.viewControllers mutableCopy];
        if (array.count >= 2) {
            UIViewController *vc = array[array.count - 2];
            
            if ([vc isKindOfClass:[WLAffirmDriverViewController class]]) {
                
                UIViewController *vc2 = array[array.count - 3];
                if ([vc2 isKindOfClass:[WLCarBookingChooseDriverController class]]) {
                    [array removeObject:vc];
                    [array removeObject:vc2];
                    [self.navigationController setViewControllers: array animated:NO];
                    
                }
            }
        }
    }
    
    if (_iSAddCost) {
        NSMutableArray *array = [self.navigationController.viewControllers mutableCopy];
        if (array.count >= 2) {
            UIViewController *vc = array[array.count - 2];
            
            if ([vc isKindOfClass:[WLCarBookingAddCostController class]]) {
                
                [array removeObject:vc];
                [self.navigationController setViewControllers: array animated:NO];
            }
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:PaymentNotification object:nil];
}

- (void)setupNavigationBar
{
    NSString *title = @"司机已接单";
    _ishiddenDriver = NO;
    if (self.object.reception_status.integerValue == 0) {//待接单
        title = @"待接单";
    }else if (self.object.reception_status.integerValue == 1){//已接单
        
        if (self.object.trip_status.integerValue == 0) {
            title = @"待出行";
        }else if (self.object.trip_status.integerValue == 1) {
            title = @"正在行程中";
        }else if (self.object.trip_status.integerValue == 2) {
            title = @"已完成";
        }
        
        
    }else if (self.object.reception_status.integerValue == 4){//已取消
        title = @"订单取消";
        _ishiddenDriver = YES;
    }else if (self.object.reception_status.integerValue == 6){//无司机应答
        title = @"无司机应答";
        _ishiddenDriver = YES;
    }else if (self.object.reception_status.integerValue == 7){//选择超时
        title = @"选择超时";
        _ishiddenDriver = YES;
    }

    self.title = title;
    
    NSString *rightTitle = @"呼叫客服";
    if (self.object.reception_status.integerValue == 0) {
        rightTitle = @"取消订单";
    }
    if (self.object.trip_status.integerValue == 0) {
        rightTitle = @"呼叫客服";
    }
    if (self.object.reception_status.integerValue == 4 || self.object.reception_status.integerValue == 6|| self.object.reception_status.integerValue == 7) {
        rightTitle = nil;
    }
    if (rightTitle) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:rightTitle style:UIBarButtonItemStyleDone target:self action:@selector(rightButtonClick:)];
        self.navigationItem.rightBarButtonItem = item;
        
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSFontAttributeName] = [UIFont WLFontOfSize:14];
        attrs[NSForegroundColorAttributeName] = Color1;
        [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    }
}

- (void)setupUI
{
    self.isFold = YES;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = BgViewColor;
    self.tableView.layer.cornerRadius = 4;
    self.tableView.layer.masksToBounds = YES;
    [self.view addSubview:self.tableView];

    _ToPayBtn = [[UIButton alloc] initWithFrame:CGRectZero];
}

- (void)setOrderID:(NSString *)orderID
{
    _orderID = orderID;
    [self loadData];
}

- (void)loadData{
    
    WS(weakSelf);
    [self showHud];
    [WLNetworkCarBookingHandler requestOrderDetailWithOrderID:self.orderID dataBlock:^(WLResponseType responseType, id data, NSString *message) {
        [self hidHud];
        if (responseType == WLResponseTypeSuccess) {
            
            weakSelf.object = data;
            [weakSelf setupNavigationBar];
            [self showPay];
            
            [weakSelf.tableView reloadData];
            
        }else{
            [[WL_TipAlert_View sharedAlert] createTip:message];
        }
        
    }];
}

- (void)rightButtonClick:(UIBarButtonItem *)item
{
    NSString *title = item.title;
    WS(weakSelf);
    if ([title isEqualToString:@"取消订单"]) {
        [WLNetworkCarBookingHandler cancelOrderWithOrderID:self.orderID dataBlock:^(WLResponseType responseType, id data, NSString *message) {
            if (responseType == WLResponseTypeSuccess) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [[WL_TipAlert_View sharedAlert] createTip:message];
            }
        }];
    }else{
        if (self.object.service_phone.length == 0) {
            [[WL_TipAlert_View sharedAlert] createTip:@"暂时没有客服电话可以拨打"];
        }
        NSString *telPhoneStr = [NSString stringWithFormat:@"tel:%@", self.object.service_phone];
        if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:telPhoneStr]])
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telPhoneStr]];
        }
    }
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WS(weakSelf);
    if (indexPath.section == 0) {
        
        WLCarBookingDetailOrderCell *cell = [WLCarBookingDetailOrderCell cellWithTableView:tableView isFold:self.isFold foldAction:^(BOOL isFold) {
            weakSelf.isFold = !weakSelf.isFold;
            [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
            
        }];
        [cell lookImgClickAction:^{

            [self lookImgArr:NO];
        }];
        cell.object = self.object;
        return cell;
        
    }else if (indexPath.section == 1){
        
        WLCarBookingDetailUserCell *cell = [WLCarBookingDetailUserCell cellWithTableView:tableView paymentAction:^{
            
            [self lookImgArr:YES];
            
        }];
        cell.object = self.object;
        return cell;
        
    }else if (indexPath.section == 2){
        
        WLCarBookingDriverObject *oobject = [[WLCarBookingDriverObject alloc] init];
        if (_object.order_bid_list.count != 0) {
            oobject = _object.order_bid_list[indexPath.row];
        }

        WLCarBookingDetailPaymentCell *cell = [WLCarBookingDetailPaymentCell cellWithTableView:tableView clickAction:^{
            
            WLCarBookingCostDetailViewController *costVC = [[WLCarBookingCostDetailViewController alloc] init];
            costVC.object = oobject;
            [weakSelf.navigationController pushViewController:costVC animated:YES];
        }];
        cell.object = self.object;
        return cell;
        
    }
    return nil;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return [WLCarBookingDetailViewMode getOrderCellHeightWithObject:self.object isFold:self.isFold];
        
    }else if (indexPath.section == 1){
        
//        if (self.object.reception_status.integerValue == 1) {
//            return  ScaleH(45) * 3;
//        }
//        if (self.object.reception_status.integerValue == 4 || self.object.reception_status.integerValue == 6 || self.object.reception_status.integerValue == 7) {
//            return 0;
//        }
        if (_ishiddenDriver) {
            return 0;
        }
        return ScaleH(45) * 3;
    }
    return [WLCarBookingDetailViewMode getPaymentCellHeight:self.object];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section != 0) {
        UIView *view = [[UIView alloc] init];
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    if (section == 1) {
        if (self.object.reception_status.integerValue == 1) {
            return  ScaleH(15);
        }
        if (self.object.reception_status.integerValue == 4 || self.object.reception_status.integerValue == 6 || self.object.reception_status.integerValue == 7) {
            return ScaleH(0);
        }
    }
    return ScaleH(15);
}

- (void)showPay
{
    if ((self.object.pay_status.integerValue == 0) && self.object.reception_status.integerValue == 1) {
        
        _ToPayBtn.hidden = NO;
        _ToPayBtn.backgroundColor = [WLTools stringToColor:@"#00cc99"];
        [_ToPayBtn setTitle:@"去付款" forState:UIControlStateNormal];
        [_ToPayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _ToPayBtn.titleLabel.font = [UIFont WLFontOfSize:13.0];
        [_ToPayBtn addTarget:self action:@selector(selectDriverWithObject) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_ToPayBtn];
        
        if (IsiPhone5||IsiPhone4)
        {
            _tableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 134);
            _ToPayBtn.frame = CGRectMake(ScaleW(12), ScreenHeight - ScaleH(124), ScreenWidth - ScaleW(24), ScaleH(40));
            _ToPayBtn.layer.cornerRadius = 18.0;
        }
        else
        {
            _tableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 124);
            _ToPayBtn.frame = CGRectMake(ScaleW(12), ScreenHeight - ScaleH(114), ScreenWidth - ScaleW(24), ScaleH(40));
            _ToPayBtn.layer.cornerRadius = 20.0;
        }
    }
    else if ((self.object.reception_status.integerValue == 4) || (self.object.reception_status.integerValue == 6) || (self.object.reception_status.integerValue == 7))
    {
        _ToPayBtn.hidden = NO;
        _ToPayBtn.backgroundColor = [UIColor whiteColor];
        [_ToPayBtn setTitle:@"再来一单" forState:UIControlStateNormal];
        [_ToPayBtn setTitleColor:[WLTools stringToColor:@"#00cc99"] forState:UIControlStateNormal];
        _ToPayBtn.titleLabel.font = [UIFont WLFontOfSize:16.0];
        [_ToPayBtn addTarget:self action:@selector(oneMoreAgain) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_ToPayBtn];
        
        if (IsiPhone5||IsiPhone4)
        {
            _tableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 134);
            _ToPayBtn.frame = CGRectMake(0, ScreenHeight - ScaleH(124), ScreenWidth, ScaleH(44));
            //_ToPayBtn.layer.cornerRadius = 18.0;
        }
        else
        {
            _tableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 124);
            _ToPayBtn.frame = CGRectMake(0, ScreenHeight - ScaleH(114), ScreenWidth, ScaleH(44));
            //_ToPayBtn.layer.cornerRadius = 20.0;
        }
    }
    else
    {
        _tableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64);
        _ToPayBtn.hidden = YES;
    }
}

/***去付款点击事件**/
- (void)selectDriverWithObject
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择支付方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"支付宝支付",@"微信支付", nil];
    [sheet showInView:self.view];
}

/***订单取消、选择超时、无司机应答，，再来一单点击事件**/
- (void)oneMoreAgain
{
//    NSArray *temp = self.navigationController.viewControllers;
//    WL_ApplicationViewController *applicationVC = [temp firstObject];
//    [self.navigationController popToRootViewControllerAnimated:NO];
    
    
    WLCarBookingViewController *bookVC = [[WLCarBookingViewController alloc] init];
    bookVC.fillObject = self.object;
    bookVC.companyID = self.object.from_company_id;
    [self.navigationController pushViewController:bookVC animated:YES];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self payType:WLPaymentModeAlipayOrder];
    }
    if (buttonIndex == 1) {

        [self payType:WLPaymentModeWeixinOrder];
    }
}

- (void)payType:(WLPaymentMode)Type
{
        WLCarBookingDriverObject *oobject = _object.order_bid_list[0];
    
        [WLNetworkCarBookingHandler requestPaymentOrderWithPaymentMode:Type
                                                               orderID:self.orderID
                                                              driverID:oobject.sj_driver_id
                                                             dataBlock:^(WLResponseType responseType, id data, NSString *message) {
                                                                 if (responseType == WLResponseTypeSuccess) {
    
                                                                     [WLNetworkAccountHandler rechargeWithPaymentMode:Type orderParams:data operationBlock:^(WLResponseType responseType, BOOL result, NSString *message) {
    
                                                                     }];
                                                                 }else{
                                                                     [[WL_TipAlert_View sharedAlert] createTip:message];
                                                                 }
                                                             }];
}

- (void)lookImgArr:(BOOL)iSCarImg
{
    if (iSCarImg) {
        WLCarBookingDriverObject *oobject = [[WLCarBookingDriverObject alloc] init];
        
        if (_object.order_bid_list.count != 0) {
            oobject = _object.order_bid_list[0];
            
            WLApplicationImageBrowserViewController *imageBrowserVC = [[WLApplicationImageBrowserViewController alloc]init];
            imageBrowserVC.imagesArray = [NSArray arrayWithArray:oobject.car_image];
            
            [self.navigationController pushViewController:imageBrowserVC animated:YES];
        }
        else
        {
            UIAlertView * noDataAlertView = [[UIAlertView alloc] initWithTitle:@"暂无车辆图片数据" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
            [noDataAlertView show];
        }
    }
    else
    {
        if (_object.trip_image.count != 0) {

            WLApplicationImageBrowserViewController *imageBrowserVC = [[WLApplicationImageBrowserViewController alloc]init];
            imageBrowserVC.imagesArray = [NSArray arrayWithArray:_object.trip_image];
            
            [self.navigationController pushViewController:imageBrowserVC animated:YES];
        }
        else
        {
            UIAlertView * noDataAlertView = [[UIAlertView alloc] initWithTitle:@"暂无行程图片数据" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
            [noDataAlertView show];
        }
    }
}

//- (void)NavigationLeftEvent
//{
//    for (UIViewController *controller in self.navigationController.viewControllers) {
//        if ([controller isKindOfClass:[WLCarBookingOrderListViewController class]]) {
//            
//            [self.navigationController popToViewController:controller animated:YES];
//            
//        }
//        else
//        {
//        }
//    }
//}

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

        [self loadData];
        
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
}

- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
}

@end
