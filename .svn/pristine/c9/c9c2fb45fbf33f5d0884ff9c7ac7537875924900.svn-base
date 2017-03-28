//
//  WLCarBookingChooseDriverController.m
//  WeiLvDJS
//
//  Created by ternence on 2017/2/9.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLCarBookingChooseDriverController.h"
#import "WLNetworkCarBookingHandler.h"
#import "WLCarBookingDetailViewMode.h"
#import "WLCarBookingOrderDetailObject.h"
#import "WLCarBookingDetailView.h"
#import "WLCarBookingDriverCell.h"
#import "WLCarBookingDriverObject.h"
#import "WLNetworkAccountHandler.h"
#import "WLCarBookingAddCostController.h"
#import "WLCarBookingOrderDetailController.h"
#import "WLAffirmDriverViewController.h"
#import "WLApplicationImageBrowserViewController.h"

@interface WLCarBookingChooseDriverController ()<UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *remainLabel;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger remainTime;
@property (nonatomic, strong) WLCarBookingOrderDetailObject *object;
@property (nonatomic, strong) WLCarBookingDetailView *detailView;
@property (nonatomic, strong) WLCarBookingDriverObject *selectedDriver;

@end

@implementation WLCarBookingChooseDriverController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupHeaderView];
    [self setupUI];
    [self refresh];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countTime) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSMutableArray *array = [self.navigationController.viewControllers mutableCopy];
    if (array.count >= 2) {
        UIViewController *vc = array[array.count - 2];
        if ([vc isKindOfClass:[WLCarBookingAddCostController class]]) {
            [array removeObject:vc];
            [self.navigationController setViewControllers: array animated:NO];
        }
    }
    [self loadData];
}

- (void)dealloc
{
    [_timer invalidate];
}

- (void)setupNavigationBar
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"取消订单" style:UIBarButtonItemStyleDone target:self action:@selector(rightButtonClick:)];
    self.navigationItem.rightBarButtonItem = item;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont WLFontOfSize:14];
    attrs[NSForegroundColorAttributeName] = [WLTools stringToColor:@"#b6b6b6"];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    
}

- (void)setupHeaderView
{
    UIView *payView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(40))];
    payView.backgroundColor = [WLTools stringToColor:@"#d1f5ec"];
    [self.view addSubview:payView];

//    UILabel *bottomLabel = [UILabel labelWithText:@"点击查看订单信息，选择司机剩余时间00:00" textColor:[WLTools stringToColor:@"#666666"] fontSize:14];
//    bottomLabel.frame = CGRectMake(0, 0, ScreenWidth, ScaleH(40));
//    bottomLabel.textAlignment = NSTextAlignmentCenter;
//    [payView addSubview:bottomLabel];
//    self.remainLabel = bottomLabel;
    self.remainLabel = [UILabel labelWithText:@"点击查看订单信息，选择司机剩余时间00:00" textColor:[WLTools stringToColor:@"#666666"] fontSize:14];
    self.remainLabel.frame = CGRectMake(0, 0, ScreenWidth, ScaleH(40));
    self.remainLabel.textAlignment = NSTextAlignmentCenter;
    [payView addSubview:self.remainLabel];

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(orderDetailButtonClick)];
    [payView addGestureRecognizer:tapGesture];
}

- (void)setupUI
{
    self.title = @"待选择司机";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, ScaleH(40), ScreenWidth, ScreenHeight - 64 - ScaleH(40))];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.layer.cornerRadius = 4;
    self.tableView.layer.masksToBounds = YES;
    [self.view addSubview:self.tableView];
}

-(void)refresh{
    //注册下拉刷新
    //WS(weakSelf);
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        _thisPage = 1;
        [self loadData];
    }];
    _tableView.mj_header = header;
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
    
    
//    MJRefreshAutoNormalFooter *footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
////        _thisPage ++;
//        [self loadData];
//        
//    }];
//    _tableView.mj_footer = footer;
//    [footer setTitle:@"松开刷新" forState:MJRefreshStatePulling];
//    [footer setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
    
}

- (void)setOrderID:(NSString *)orderID
{
    _orderID = orderID;
    //[self loadData];
}

#pragma mark network
- (void)loadData{
    
    WS(weakSelf);
    [self showHud];
    [WLNetworkCarBookingHandler requestOrderDetailWithOrderID:self.orderID dataBlock:^(WLResponseType responseType, id data, NSString *message) {
        [self hidHud];
        if (responseType == WLResponseTypeSuccess) {
            
            weakSelf.object = data;
            [weakSelf beginToCountTime];
            [weakSelf.tableView reloadData];
            
            if ([weakSelf.object.pay_status isEqual:@"1"] || ![weakSelf.object.reception_status isEqual:@"0"]) {
                [weakSelf NavigationLeftEvent];
            }
            
        }else{
            [[WL_TipAlert_View sharedAlert] createTip:message];
            
        }
//        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
    }];
    
}

- (void)rightButtonClick:(UIBarButtonItem *)item
{

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:@"是否确认取消订单"
                                                   delegate:self
                                          cancelButtonTitle:@"是"
                                          otherButtonTitles:@"否", nil];
    alert.tag = 1001;
    [alert show];
    

}


- (void)selectDriverWithObject:(WLCarBookingDriverObject *)object
{
    [WLNetworkCarBookingHandler requestPaymentOrderWithPaymentMode:WLPaymentModeAlipayOrder
                                                           orderID:self.orderID
                                                          driverID:object.sj_driver_id
                                                         dataBlock:^(WLResponseType responseType, id data, NSString *message) {
                                                             if (responseType == WLResponseTypeSuccess) {
                                                                 
                                                                 [WLNetworkAccountHandler rechargeWithPaymentMode:WLPaymentModeAlipayOrder orderParams:data operationBlock:^(WLResponseType responseType, BOOL result, NSString *message) {
                                                                     
                                                                 }];
                                                             }else{
                                                                 [[WL_TipAlert_View sharedAlert] createTip:message];
                                                             }
                                                         }];

}

- (void)selectPaymode
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"支付宝支付", nil];
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self selectDriverWithObject:self.selectedDriver];
    }
}


- (void)beginToCountTime
{
    NSTimeInterval nowtimeStamp= [[NSDate date] timeIntervalSince1970];
    int timeout = [self.object.choice_expiry_at integerValue] - nowtimeStamp;
    
    self.remainTime = (timeout < 0)?0:timeout;
}

- (void)countTime
{
    self.remainLabel.text = [NSString stringWithFormat:@"单击查看订单信息，选择司机剩余时间%02ld:%02ld",self.remainTime/60,self.remainTime % 60];
    
    if (self.remainTime > 0) {
        self.remainTime --;
    }
    else
    {
        if (self.remainTime < 0) {
            [_timer invalidate];
        }
    }
}

- (void)orderDetailButtonClick{
    
    if (!self.detailView) {
        WLCarBookingDetailView *detailView = [[WLCarBookingDetailView alloc] initWithiSchoose:YES Object:self.object];
        [detailView lookImgAction:^{
            [self lookImgArr:NO];
        }];
        [self.view addSubview:detailView];
        self.detailView = detailView;
    }
    [self.detailView show];
    
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.object.invalid_order_bid_list.count == 0) {
        return 1;
    }
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.object.order_bid_list.count;
    }
    else if (section == 1)
    {
        return self.object.invalid_order_bid_list.count;
    }
    else
    {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1 && self.object.invalid_order_bid_list.count != 0) {
        UIView * Headview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(30))];
        Headview.backgroundColor = [WLTools stringToColor:@"#f8f8f8"];
        UILabel * IsAlreadySelectedLabel = [UILabel labelWithText:@"以下报价已被别的用户选择" textColor:[WLTools stringToColor:@"#929292"] fontSize:13.0];
        IsAlreadySelectedLabel.frame = CGRectMake(ScaleW(20), 0, Headview.frame.size.width, Headview.frame.size.height);
        IsAlreadySelectedLabel.textAlignment = NSTextAlignmentLeft;
        [Headview addSubview:IsAlreadySelectedLabel];
        return Headview;
    }
    return nil;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WS(weakSelf);
    WLCarBookingDriverObject *object = [[WLCarBookingDriverObject alloc] init];
    if (indexPath.section == 0) {
        object = self.object.order_bid_list[indexPath.row];
    }
    else if (indexPath.section == 1)
    {
        object = self.object.invalid_order_bid_list[indexPath.row];
    }
    WLCarBookingDriverCell *cell = [WLCarBookingDriverCell cellWithTableView:tableView
                                                                selectAction:^{
                                                                    
                                                                    weakSelf.selectedDriver = weakSelf.object.order_bid_list[indexPath.row];
                                                                    [weakSelf selectPaymode];
                                                                    
                                                                }];
    [cell setCellViewPath:indexPath object:object];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        WLCarBookingDriverObject *oobject = _object.order_bid_list[indexPath.row];
        WLAffirmDriverViewController * nextVC = [[WLAffirmDriverViewController alloc] init];
        nextVC.orderID = _orderID;
        nextVC.driverobject = oobject;
        nextVC.remainTime = _remainTime;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}


#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleH(85);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return ScaleH(30);
    }
    return 0;
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1001) {
        if (buttonIndex == 1) {
            // 取消
        }
        if (buttonIndex == 0) {
            [WLNetworkCarBookingHandler cancelOrderWithOrderID:self.object.orderID dataBlock:^(WLResponseType responseType, id data, NSString *message) {
                
                if (responseType == WLResponseTypeSuccess) {
                    [[WL_TipAlert_View sharedAlert] createTip:message];
                }
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
    }
}

@end
