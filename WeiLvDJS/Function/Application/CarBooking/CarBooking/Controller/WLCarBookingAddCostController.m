//
//  WLCarBookingAddCostController.m
//  WeiLvDJS
//
//  Created by ternence on 2017/1/20.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLCarBookingAddCostController.h"
#import "WLCarBookingOrderListViewController.h"
#import "WLCarBookingAddCostView.h"
#import "WLNetworkCarBookingHandler.h"
#import "WLCarBookingDetailViewMode.h"
#import "WLCarBookingOrderDetailObject.h"
#import "WLCarBookingOrderDetailObject.h"
#import "WLCarBookingChooseDriverController.h"
#import "AppManager.h"
#import "WLCarBookingOrderDetailController.h"

@interface WLCarBookingAddCostController ()<UIAlertViewDelegate>

@property (nonatomic, strong) WLCarBookingAddCostView *costView;
@property (nonatomic, strong) UIButton *timeBtn;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSTimer *refreshTimer;
@property (nonatomic, strong) UILabel * waitingTimeLabel;
@property (nonatomic, strong) NSString * iSStopM;
@property (nonatomic, strong) NSString * iSStopS;

@end

@implementation WLCarBookingAddCostController

- (void)viewDidLoad {
    
    [super viewDidLoad];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    if (!self.object.fromList) {
        NSMutableArray *array = [self.navigationController.viewControllers mutableCopy];
        WLCarBookingOrderListViewController *listVC = [[WLCarBookingOrderListViewController alloc] init];
        listVC.companyID = self.object.companyID;
        [array replaceObjectAtIndex:array.count - 2 withObject:listVC];
        [self.navigationController setViewControllers: array animated:NO];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
    [self.refreshTimer invalidate];
    self.refreshTimer = nil;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}

- (void)setObject:(WLBookingCarResultObject *)object
{
    _object = object;
    [self setupUI];
}

//- (void)setupNavigationBar
//{
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"取消订单" style:UIBarButtonItemStyleDone target:self action:@selector(cancelBtnClick)];
//    self.navigationItem.rightBarButtonItem = item;
//    
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName] = [UIFont WLFontOfSize:15];
//    attrs[NSForegroundColorAttributeName] = Color1;
//    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
//}

- (void)setupUI{
    
    self.titleItem.title = @"待司机应答";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *timeString = [WLCarBookingDetailViewMode dateTimeDifferenceWithBeginDate:[NSDate dateWithTimeIntervalSince1970:self.object.nowTime.integerValue]];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countTime) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];

    UIImageView * backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [backImg setImage:[UIImage imageNamed:@"yingdaImg"]];
    [self.view addSubview:backImg];
    
    UIView * navView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, 44)];
    [backImg addSubview:navView];
    
    backImg.userInteractionEnabled = YES;
    UIButton * leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScaleW(10), ScaleH(5), ScaleW(30), ScaleH(30))];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:leftBtn];
    
    UIImageView * leftImg = [[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(5), 0, ScaleW(15), ScaleH(30))];
    [leftImg setImage:[UIImage imageNamed:@"returnImg"]];
    [leftBtn addSubview:leftImg];
    
    UILabel * navTitle = [[UILabel alloc] initWithFrame:CGRectMake((navView.frame.size.width / 2) - ScaleW(50), ScaleH(10), ScaleW(100), ScaleH(20))];
    navTitle.text = @"待司机应答";
    navTitle.textColor = [UIColor whiteColor];
    navTitle.textAlignment = NSTextAlignmentCenter;
    navTitle.font = [UIFont WLFontOfSize:16.0];
    [navView addSubview:navTitle];
    
    UIButton * rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(navView.frame.size.width - ScaleW(80), ScaleH(13), ScaleW(70), ScaleH(17))];
    [rightBtn setTitle:[NSString stringWithFormat:@"取消订单"] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.titleLabel.font = [UIFont WLFontOfSize:12.0];
    [navView addSubview:rightBtn];
    
    UILabel *noticeLabel = [UILabel labelWithText:@"点击左上角返回，离开本页面，您可在订单管理中看到该订单状态，并进行订单操作" textColor:Color3 fontSize:12.0];
    noticeLabel.frame = CGRectMake(ScaleW(12), navView.frame.origin.y + navView.frame.size.height + ScaleH(10), ScreenWidth - ScaleW(24), ScaleH(40));
    noticeLabel.textAlignment = NSTextAlignmentLeft;
    noticeLabel.numberOfLines = 0;
    noticeLabel.textColor = [UIColor whiteColor];
    [backImg addSubview:noticeLabel];
    
    UIImageView * yuanImg = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth / 2) - ScaleW(150), noticeLabel.frame.origin.y + noticeLabel.frame.size.height + ScaleH(50), ScaleW(300), ScaleH(300))];
    [yuanImg setImage:[UIImage imageNamed:@"yingdayuanImg"]];
    [backImg addSubview:yuanImg];
    
    UILabel * waitingLabel = [[UILabel alloc] initWithFrame:CGRectMake((yuanImg.frame.size.width / 2) - ScaleW(30), ScaleH(100), ScaleW(60), ScaleH(15))];
    waitingLabel.text = @"已等候";
    waitingLabel.textColor = [UIColor whiteColor];
    waitingLabel.textAlignment = NSTextAlignmentCenter;
    waitingLabel.font = [UIFont WLFontOfSize:14.0];
    [yuanImg addSubview:waitingLabel];
    
    _waitingTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake((yuanImg.frame.size.width / 2) - ScaleW(100), waitingLabel.frame.origin.y + waitingLabel.frame.size.height + ScaleH(15), ScaleW(200), ScaleH(40))];
    _waitingTimeLabel.text = [NSString stringWithFormat:@"%@",timeString];//@"05:38";
    _waitingTimeLabel.textColor = [UIColor whiteColor];
    _waitingTimeLabel.textAlignment = NSTextAlignmentCenter;
    _waitingTimeLabel.font = [UIFont WLFontOfSize:40.0];
    [yuanImg addSubview:_waitingTimeLabel];
    
    UIButton *howdriverBtn = [[UIButton alloc] initWithFrame:CGRectMake((ScreenWidth / 2) - ScaleW(130), yuanImg.frame.origin.y + yuanImg.frame.size.height + ScaleH(80), ScaleW(260), ScaleH(40))];
    howdriverBtn.userInteractionEnabled = NO;
    [howdriverBtn setTitle:[NSString stringWithFormat:@"已为您通知到%@名司机",self.object.driverCount] forState:UIControlStateNormal];
    [howdriverBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    howdriverBtn.titleLabel.font = [UIFont WLFontOfSize:14];
    [howdriverBtn setBackgroundImage:[UIImage imageNamed:@"yingdahowdriverImg"] forState:UIControlStateNormal];
    [backImg addSubview:howdriverBtn];
}

- (void)leftBtnClick
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)countTime{
    NSString *timeString = [WLCarBookingDetailViewMode dateTimeDifferenceWithBeginDate:[NSDate dateWithTimeIntervalSince1970:self.object.nowTime.integerValue]];
    _waitingTimeLabel.text = [NSString stringWithFormat:@"%@",timeString];
    
    _iSStopM = [timeString substringToIndex:2];
    _iSStopS = [timeString substringFromIndex:3];

    if ([_iSStopM integerValue] == 59 && [_iSStopS integerValue] == 59) {
        [self NavigationLeftEvent];
    }
}

- (void)cancelBtnClick
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:@"是否确认取消订单"
                                                   delegate:self
                                          cancelButtonTitle:@"是"
                                          otherButtonTitles:@"再等等", nil];
    [alert show];
}

#pragma mark network
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {

        [WLNetworkCarBookingHandler cancelOrderWithOrderID:self.object.orderID dataBlock:^(WLResponseType responseType, id data, NSString *message) {
            
            if (responseType == WLResponseTypeSuccess) {
                [[WL_TipAlert_View sharedAlert] createTip:message];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
}



- (void)dealloc
{
}

//- (void)refreshOrderPrice
//{
//    WS(weakSelf);
//    [WLNetworkCarBookingHandler requestOrderDetailWithOrderID:self.object.orderID dataBlock:^(WLResponseType responseType, id data, NSString *message) {
//        if (responseType == WLResponseTypeSuccess) {
//            WLCarBookingOrderDetailObject *detailObject = (WLCarBookingOrderDetailObject *)data;
////            weakSelf.costLabel.text = [NSString stringWithFormat:@"¥%@",detailObject.order_price];
//            weakSelf.object.orderPice = detailObject.order_price;
//
//        }
//    }];
//}


//- (void)addCostBtnClick
//{
//    WS(weakSelf);
//    WLCarBookingAddCostView *costView = [[WLCarBookingAddCostView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) originPrice:self.object.orderPice finishAction:^(BOOL cancel, NSString *newPrice) {
//
//        [weakSelf removeCostView];
//        if (!cancel) {
//
//            [WLNetworkCarBookingHandler requestOrderDetailWithOrderID:self.object.orderID dataBlock:^(WLResponseType responseType, id data, NSString *message) {
//                if (responseType == WLResponseTypeSuccess) {
//                    WLCarBookingOrderDetailObject *object = data;
//                    if (object.reception_status.integerValue == 0) {//待接单
//                        [WLNetworkCarBookingHandler addCostWithOrderID:self.object.orderID price:newPrice companyID:self.object.companyID operationBlock:^(WLResponseType responseType, BOOL result, NSString *message) {
//
//                            [[WL_TipAlert_View sharedAlert] createTip:message];
//                            if (responseType == WLResponseTypeSuccess) {
//                                [weakSelf refreshOrderPrice];
//
//                            }
//
//                        }];
//                    }else{
//
//                        NSString *noticeMessage = @"司机接单后不能加价";
//                        if (object.reception_status.integerValue == 4) {
//                            noticeMessage = @"该订单已取消";
//                        }
//                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                            [weakSelf.navigationController popViewControllerAnimated:YES];
//                        });
//
//                    }
//                }else{
//                    [[WL_TipAlert_View sharedAlert] createTip:message];
//                }
//            }];
//
//
//        }
//
//    }];
//    [self.navigationController.view addSubview:costView];
//    self.costView = costView;
//}
//
//- (void)removeCostView
//{
//    [self.costView removeFromSuperview];
//    self.costView = nil;
//
//}


//    UILabel *costLabel = [UILabel labelWithText:[NSString stringWithFormat:@"¥%@",self.object.orderPice] textColor:Color2 fontSize:28];
//    costLabel.frame = CGRectMake(0, ScaleH(50), ScreenWidth, ScaleH(40));
//    costLabel.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:costLabel];
//    self.costLabel = costLabel;

//    UIButton *actionBtn = [[UIButton alloc] initWithFrame:CGRectMake((ScreenWidth - ScaleW(140)) / 2, costLabel.bottom + ScaleH(20), ScaleW(140), ScaleH(40))];
//    [actionBtn setTitle:@"我要加价" forState:UIControlStateNormal];
//    [actionBtn setTitleColor:Color1 forState:UIControlStateNormal];
//    actionBtn.titleLabel.font = [UIFont WLFontOfSize:20];
//    [actionBtn setBackgroundImage:[UIImage imageNamed:@"carBooking_buttonBg"] forState:UIControlStateNormal];
//    [actionBtn addTarget:self action:@selector(addCostBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:actionBtn];

//    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(ScaleW(12), ScaleH(180), ScreenWidth - ScaleW(24), 1)];
//    line.backgroundColor = bordColor;
//    [self.view addSubview:line];
@end
