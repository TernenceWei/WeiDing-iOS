//
//  WL_Application_Driver_Order_WaitOrderDetail_ViewController.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_Order_WaitOrderDetail_ViewController.h"
#import "WL_Application_Driver_Order_WaitOrderDetail_Cell.h"
#import "WL_Application_Driver_OrderDetail_Model.h"
#import "WL_Application_Driver_OrderDetail_Guide_Model.h"
#import "WL_Application_Driver_OrderDetail_Dispatcher_Model.h"
#import "WL_Application_Driver_OrderDetail_PayRecord_Model.h"

#import "WL_Application_Driver_Order_OrderDetail_TopView.h"
#import "WL_Application_Driver_Order_OrderDetail_BottomView.h"
#import "WL_Application_Driver_Order_OrderDetail_NavTitleView.h"
#import "WL_Application_Driver_Order_Rush_AlertView.h"

#import "WL_Application_Driver_RefuseOrder_AlertView.h"

#import "WL_Application_Driver_Order_RefuseOrder_Cell.h"

@interface WL_Application_Driver_Order_WaitOrderDetail_ViewController ()<UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>
{
    dispatch_source_t _timer ;
}

@property(nonatomic, strong)UITextView *reasonTextView;
@property(nonatomic, strong)WL_TipAlert_View *alert;

@property(nonatomic, strong)WL_Application_Driver_OrderDetail_Model *orderDetailModel;
@property(nonatomic, strong)UILabel *placeholderLable;
@property(nonatomic, assign)float differentSec;

@property(nonatomic, weak)WL_Application_Driver_Order_OrderDetail_NavTitleView *navTitleView;

@property(nonatomic, weak)WL_Application_Driver_Order_Rush_AlertView *rushOrderAlertView;


//TableView的头视图
@property(nonatomic, weak)WL_Application_Driver_Order_OrderDetail_TopView *orderDetailTopView;
/** 拒绝订单弹框 */
@property(nonatomic, weak)WL_Application_Driver_RefuseOrder_AlertView *refuseOrderAlertView;
//TableView的尾视图
@property(nonatomic, weak)WL_Application_Driver_Order_OrderDetail_BottomView *orderDetailBottomView;
/** 拒绝原因数组 */
@property(nonatomic, strong) NSArray *refuseReasons;
/** 拒绝原因参数数组 */
@property(nonatomic, strong) NSMutableArray *refuseReasonArr;
//设置订单详情TableView
@property(nonatomic, weak) UITableView *orderDetailTableView;
//设置拒绝订单原因的TableView
@property(nonatomic, weak) UITableView *refuseReasonTableView;
/** 导游模型 */
@property(nonatomic, strong) WL_Application_Driver_OrderDetail_Guide_Model *guideModel;
/** 计调模型 */
@property(nonatomic, strong) WL_Application_Driver_OrderDetail_Dispatcher_Model *dispatcherModel;

/** 无网络View */
@property(nonatomic, strong) WL_NoData_View *noDataView;

//拒单按钮
@property(nonatomic, weak)UIButton *refuseButton;

//抢单按钮
@property(nonatomic, weak)UIButton *rushButton;


@end

@implementation WL_Application_Driver_Order_WaitOrderDetail_ViewController

#pragma mark - lazy
- (NSMutableArray *)refuseReasonArr
{
    if (!_refuseReasonArr) {
        _refuseReasonArr = [NSMutableArray array];
    }
    return _refuseReasonArr;
}
- (WL_NoData_View *)noDataView
{
    if (_noDataView == nil) {
        
        WS(weakSelf);
        
        _noDataView = [[WL_NoData_View alloc] initWithFrame:self.view.frame andRefreshBlock:^{
            [weakSelf sendRequestToOrderDetail];
            
        }];
        
        _noDataView.hidden = YES;
    }
    
    return _noDataView;
}

#pragma makr - 设置无数据提示的显示、隐藏及类型
- (void)hideNoData:(BOOL)hidden andType:(WLNetworkType)type {
    
    self.noDataView.hidden = hidden;
    
    if (!hidden) {
        
        self.noDataView.type = type;
        
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];


    self.view.backgroundColor = BgViewColor;
    
    //设置Nav内容
    [self setupContentToNav];
    //设置内容
    [self setupOrderDetailToContent];
    //发送网络请求请求订单数据
    [self sendRequestToOrderDetail];
    //注册弹框
    [self creatTipAlertView];
    [self.view addSubview:self.noDataView];
    
    
}


#pragma mark - 注册弹框
- (void)creatTipAlertView
{
    self.alert = [WL_TipAlert_View sharedAlert];
    
}


#pragma mark - 发送网络请求请求订单数据
- (void)sendRequestToOrderDetail
{
    //请求订单详情的Url
    NSString *urlStr = DriverOrderDetailUrl;
    //请求参数
    //司机id
    NSString *driver_id = [WLUserTools getUserId];
    //用户密码
    NSString *user_password = [WLUserTools getUserPassword];
    //RSA加密
    NSString *encriptString = [MyRSA encryptString:user_password publicKey:RSAKey];
    //订单号
    NSString *sj_order_id = self.sj_order_id;
    //请求参数集合
    NSDictionary *params = @{
                             @"driver_id" : driver_id,
                             @"user_password" : encriptString,
                             @"sj_order_id" : sj_order_id
                             };
    //显示菊花
    [self showHud];
    //发送请求
    [[WLHttpManager shareManager] requestWithURL:urlStr RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
        WL_Network_Model *model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        //服务器返回数据失败
        if (![model.status isEqualToString:@"1"])
        {
            //弹框错误信息
            [self.alert createTip:model.msg];
            //隐藏菊花
            [self hidHud];
            return;
        }
        self.noDataView.hidden = YES;
        //将返回的订单详情数据转换为订单详情模型
        WL_Application_Driver_OrderDetail_Model *orderDetailModel = [WL_Application_Driver_OrderDetail_Model mj_objectWithKeyValues:model.data];
        self.guideModel = [WL_Application_Driver_OrderDetail_Guide_Model mj_objectWithKeyValues:orderDetailModel.guide];
            self.rushButton.enabled = YES;
            [self.rushButton setBackgroundColor:[WLTools stringToColor:@"#ff7e44"]];

        
        
        self.dispatcherModel = [WL_Application_Driver_OrderDetail_Dispatcher_Model mj_objectWithKeyValues:orderDetailModel.dispatcher];
        self.orderDetailModel = orderDetailModel;
        //获取时间差的秒数
        double differentSec = [WLTools setupDifferentTime:self.orderDetailModel.failure_expires];
        NSInteger differentTime = (NSInteger)differentSec;
        self.differentSec = differentTime;
        [self achieveCaptchaStartTime:differentTime];

        
        //出发城市
        self.orderDetailTopView.fromCityLable.text = self.orderDetailModel.start_city;
        //到达城市
        self.orderDetailTopView.endCityLable.text = self.orderDetailModel.end_city;
        //行程里程
        self.orderDetailTopView.mileageLable.text = @"";
        //出发日期
        NSString *departureTimeToMon = [self.orderDetailModel.start_time substringWithRange:NSMakeRange(5, 2)];
        NSString *departureTimeToDay = [self.orderDetailModel.start_time substringWithRange:NSMakeRange(8, 2)];
        self.orderDetailTopView.startTimeLable.text = [NSString stringWithFormat:@"%@月%@日", departureTimeToMon, departureTimeToDay];
        //结束日期
        NSString *endTimeToMon = [self.orderDetailModel.end_time substringWithRange:NSMakeRange(5, 2)];
        NSString *endTimeToDay = [self.orderDetailModel.end_time substringWithRange:NSMakeRange(8, 2)];
        self.orderDetailTopView.endTimeLable.text = [NSString stringWithFormat:@"%@月%@日", endTimeToMon, endTimeToDay];
        //总出游人数
        if ([self.orderDetailModel.persons_count isEqualToString:@""] || self.orderDetailModel.persons_count == nil) {
            self.orderDetailTopView.personCountLable.text = @"0座";
        }
        else
        {
            self.orderDetailTopView.personCountLable.text = [NSString stringWithFormat:@"%@座", self.orderDetailModel.persons_count];
        }
        //出发地点
        self.orderDetailTopView.startAddressLable.text = self.orderDetailModel.start_address;
        //出发时间
        //出发日期
        NSString *startTimeToYear = [self.orderDetailModel.start_time substringWithRange:NSMakeRange(0, 4)];
        NSString *startTimeToMon = [self.orderDetailModel.start_time substringWithRange:NSMakeRange(5, 2)];
        NSString *startTimeToDay = [self.orderDetailModel.start_time substringWithRange:NSMakeRange(8, 2)];
        NSString *startTimeToHour = [self.orderDetailModel.start_time substringWithRange:NSMakeRange(11, 2)];
        NSString *startTimeToMin = [self.orderDetailModel.start_time substringWithRange:NSMakeRange(14, 2)];
        self.orderDetailTopView.beginTimeLable.text = [NSString stringWithFormat:@"%@年%@月%@日 %@:%@ 出发", startTimeToYear, startTimeToMon, startTimeToDay, startTimeToHour, startTimeToMin];
        //结束地点
        self.orderDetailTopView.endAddressLable.text = self.orderDetailModel.end_address;
        //结束时间
        
        NSString *arriveTimeToYear = [self.orderDetailModel.end_time substringWithRange:NSMakeRange(0, 4)];
        NSString *arriveTimeToMon = [self.orderDetailModel.end_time substringWithRange:NSMakeRange(5, 2)];
        NSString *arriveTimeToDay = [self.orderDetailModel.end_time substringWithRange:NSMakeRange(8, 2)];
        NSString *arriveTimeToHour = [self.orderDetailModel.end_time substringWithRange:NSMakeRange(11, 2)];
        NSString *arriveTimeToMin = [self.orderDetailModel.end_time substringWithRange:NSMakeRange(14, 2)];
        self.orderDetailTopView.arriveTimeLable.text = [NSString stringWithFormat:@"%@年%@月%@日 %@:%@ 结束", arriveTimeToYear, arriveTimeToMon, arriveTimeToDay, arriveTimeToHour, arriveTimeToMin];
        
        if ([self.orderDetailModel.order_status isEqualToString:@"1"])
        {
            self.orderDetailBottomView.acceptStatusLable.text = @"接单状态: 待接单";
        }
        else if ([self.orderDetailModel.order_status isEqualToString:@"2"])
        {
            self.orderDetailBottomView.acceptStatusLable.text = @"接单状态: 已拒绝";
        }
        else if ([self.orderDetailModel.order_status isEqualToString:@"3"])
        {
            self.orderDetailBottomView.acceptStatusLable.text = @"接单状态: 已超时";
        }
        else if ([self.orderDetailModel.order_status isEqualToString:@"4"])
        {
            self.orderDetailBottomView.acceptStatusLable.text = @"接单状态: 已被抢";
        }
        else if ([self.orderDetailModel.order_status isEqualToString:@"5"])
        {
            self.orderDetailBottomView.acceptStatusLable.text = @"接单状态: 已接单";
        }
        else if ([self.orderDetailModel.order_status isEqualToString:@"6"])
        {
            self.orderDetailBottomView.acceptStatusLable.text = @"接单状态: 已被取消";
        }
        NSString *sendOrderStr = [self.orderDetailModel.create_date stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        NSString *sendOrderTimeStr = [sendOrderStr substringToIndex:16];
        self.orderDetailBottomView.timeLable.text = [NSString stringWithFormat:@"派单时间: %@", sendOrderTimeStr];
        //现实头部标题
        self.navTitleView.hidden = NO;
        //现实底部按钮
        self.rushButton.hidden = NO;
        self.refuseButton.hidden = NO;
        self.orderDetailTableView.hidden = NO;
        [self.orderDetailTableView reloadData];

        [self hidHud];
    } Failure:^(NSError *error) {
        //弹框提示错误信息
        if (error.code == -1009)
        {
            [self.alert createTip:@"似乎已断开与互联网的连接"];
            [self hideNoData:NO andType:WLNetworkTypeNONetWork];
        }
        else
        {
            [self.alert createTip:@"服务器错误,请稍后重试"];
            [self hideNoData:NO andType:WLNetworkTypeSeverError];
        }
        
        //隐藏菊花
        [self hidHud];
        
    }];
    

}

#pragma mark - 设置订单内容
static NSString *const cellId = @"cellId";
- (void)setupOrderDetailToContent
{
    //拒单按钮
    UIButton *refuseButton = [[UIButton alloc] init];
    //添加到父控件
    [self.view addSubview:refuseButton];
    //设置属性
    [refuseButton setBackgroundColor:[WLTools stringToColor:@"#ffffff"]];
    [refuseButton setTitle:@"拒绝" forState:UIControlStateNormal];
    [refuseButton setTitleColor:[WLTools stringToColor:@"#868686"] forState:UIControlStateNormal];
    //添加约束
    [refuseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.equalTo(@(50 * AUTO_IPHONE6_HEIGHT_667));
        make.width.equalTo(@(159 * AUTO_IPHONE6_WIDTH_375));
    }];
    [refuseButton addTarget:self action:@selector(refushButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.refuseButton = refuseButton;
    refuseButton.hidden = YES;
    
    //快速抢单按钮
    UIButton *rushButton = [[UIButton alloc] init];
    //添加到父控件
    [self.view addSubview:rushButton];
    //设置属性
    [rushButton setTitle:@"接单" forState:UIControlStateNormal];
    [rushButton setTitleColor:[WLTools stringToColor:@"#ffffff"] forState:UIControlStateNormal];
    
//    [rushButton setBackgroundColor:[WLTools stringToColor:@"#ff7e44"]];
    //添加约束
    [rushButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(refuseButton.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.equalTo(refuseButton.mas_height);
        make.right.equalTo(self.view.mas_right);
    }];
    [rushButton addTarget:self action:@selector(rushButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.rushButton = rushButton;
    rushButton.hidden = YES;
    //设置订单详情TableView
    UITableView *orderDetailTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    
    //添加到父控件
    [self.view addSubview:orderDetailTableView];
    [orderDetailTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(rushButton.mas_top);
    }];
    orderDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    orderDetailTableView.backgroundColor = BgViewColor;
    //设置代理与数据源
    orderDetailTableView.delegate = self;
    orderDetailTableView.dataSource = self;
    orderDetailTableView.hidden = YES;
    self.orderDetailTableView = orderDetailTableView;
    orderDetailTableView.showsVerticalScrollIndicator = NO;
    self.orderDetailTableView.backgroundColor = BgViewColor;
    
    UIView *view = [[UIView alloc] init];
    [orderDetailTableView addSubview:view];
    view.backgroundColor = [WLTools stringToColor:@"#4778e7"];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(orderDetailTableView.mas_top);
        make.height.equalTo(@375);
    }];
    
    //注册cell
    [orderDetailTableView registerClass:[WL_Application_Driver_Order_WaitOrderDetail_Cell  class] forCellReuseIdentifier:cellId];

    //TableView的头视图
    WL_Application_Driver_Order_OrderDetail_TopView *orderDetailTopView = [[WL_Application_Driver_Order_OrderDetail_TopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 280)];
    orderDetailTopView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    orderDetailTableView.tableHeaderView = orderDetailTopView;

    self.orderDetailTopView = orderDetailTopView;
    
    //TableView的尾视图
    WL_Application_Driver_Order_OrderDetail_BottomView *orderDetailBottomView = [[WL_Application_Driver_Order_OrderDetail_BottomView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 182)];
    orderDetailBottomView.backgroundColor = BgViewColor;
    orderDetailTableView.tableFooterView = orderDetailBottomView;
    
    self.orderDetailBottomView = orderDetailBottomView;
 
}

#pragma mark - 拒绝按钮点击方法
static NSString *const refuseCellId = @"refuseCellId";
- (void)refushButtonClick
{
    self.refuseReasons = @[@"价格太低", @"订单信息不全", @"车辆暂时无法正常行驶", @"其他"];
    [self.refuseReasonArr removeAllObjects];
    
    //弹框
    WL_Application_Driver_RefuseOrder_AlertView *refuseOrderAlertView = [[WL_Application_Driver_RefuseOrder_AlertView alloc] init];
    UIWindow *myWindow = [UIApplication sharedApplication].keyWindow;
    [myWindow addSubview:refuseOrderAlertView];
    self.refuseOrderAlertView = refuseOrderAlertView;
    //设置属性
    refuseOrderAlertView.backgroundColor = WLColor(0, 0, 0, 0.5);
    //添加约束
    [refuseOrderAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(myWindow.mas_left);
        make.top.equalTo(myWindow.mas_top);
        make.right.equalTo(myWindow.mas_right);
        make.bottom.equalTo(myWindow.mas_bottom);
    }];
    refuseOrderAlertView.refuseReasonTableView.delegate = self;
    refuseOrderAlertView.refuseReasonTableView.dataSource = self;
    //注册cell
    [refuseOrderAlertView.refuseReasonTableView registerClass:[WL_Application_Driver_Order_RefuseOrder_Cell class] forCellReuseIdentifier:refuseCellId];
    self.refuseReasonTableView = refuseOrderAlertView.refuseReasonTableView;
    
    [self.refuseOrderAlertView.cancleButton addTarget:self action:@selector(cancleRefuseOrderAlertView) forControlEvents:UIControlEventTouchUpInside];
    
    [self.refuseOrderAlertView.refuseButton addTarget:self action:@selector(sendRequestToRefuseOrder) forControlEvents:UIControlEventTouchUpInside];
    

    
}



#pragma mark - 提交确认拒绝请求
- (void)sendRequestToRefuseOrder
{
    NSMutableArray *refuseReasonsArr = self.refuseReasonArr;
    for (NSString *reasons in refuseReasonsArr)
    {
        if ([reasons isEqualToString:@"其他"])
        {
            [self.refuseReasonArr removeObject:reasons];
            NSString *otherReason = [NSString stringWithFormat:@"%@:%@",reasons, self.reasonTextView.text];
            [self.refuseReasonArr addObject:otherReason];
        }
    }
    
    if (self.refuseReasonArr.count == 0)
    {
        [self.alert createTip:@"请选择拒绝理由"];
        return;
    }
    

    //发送拒绝请求
    //发送更新订单状态的网络请求 请求数据
    NSString *urlStr = DriverOrderUpdateOrderUrl;
    //请求参数
    //司机id
    NSString *driver_id = [WLUserTools getUserId];
    //用户密码
    NSString *user_password = [WLUserTools getUserPassword];
    //RSA加密
    NSString *encriptString = [MyRSA encryptString:user_password publicKey:RSAKey];

    //订单状态
    NSString *status = @"2";
    //订单类型
    NSString *order_status_type = @"1";
    //拒绝原因
    NSData *remark  = [self.refuseReasonArr mj_JSONData];
    //参数集合
    NSDictionary *params = @{
                             @"driver_id" : driver_id,
                             @"user_password" : encriptString,
                             @"order_status_type" : order_status_type,
                             @"status" : status,
                             @"sj_order_id" : self.sj_order_id,
                             @"remark" : remark
                             };
    
    //显示菊花
    [self showHud];
    [[WLHttpManager shareManager] requestWithURL:urlStr RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
       //1.将返回的json转换为基础模型
        WL_Network_Model *baseModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (![baseModel.status isEqualToString:@"1"])
        {
            [self cancleRefuseOrderAlertView];
            //弹框提示信息
            [self.alert createTip:baseModel.msg];
            //隐藏菊花
            [self hidHud];
            return;
        }
        //隐藏菊花
        [self hidHud];
        //弹框提示
        [self.alert createTip:@"拒绝成功"];
        [self cancleRefuseOrderAlertView];
        [self.navigationController popViewControllerAnimated:YES];

    } Failure:^(NSError *error) {
        [self hidHud];
//        [self.alert createTip:[NSString stringWithFormat:@"%@", error]];
        if (error.code == -1009) {
            [self.alert createTip:@"登录失败,请检查您的网络"];
        }
        else
        {
            [self.alert createTip:@"登录失败,请稍后再试"];
        }

    }];

}

#pragma mark - 隐藏拒绝原因弹框
- (void)cancleRefuseOrderAlertView
{
    [self.refuseOrderAlertView removeFromSuperview];
}

#pragma mark - 抢单按钮点击方法
- (void)rushButtonClick
{
    //抢单按钮点击
    WL_Application_Driver_Order_Rush_AlertView *rushOrderAlertView = [[WL_Application_Driver_Order_Rush_AlertView alloc] init];
    UIWindow *myWindow = [UIApplication sharedApplication].keyWindow;
    [myWindow addSubview:rushOrderAlertView];
    rushOrderAlertView.backgroundColor = WLColor(0, 0, 0, 0.5);
    [rushOrderAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(myWindow.mas_left);
        make.right.equalTo(myWindow.mas_right);
        make.top.equalTo(myWindow.mas_top);
        make.bottom.equalTo(myWindow.mas_bottom);
    }];
    NSString *departureTimeToMon = [self.orderDetailModel.start_time substringWithRange:NSMakeRange(5, 2)];
    NSString *departureTimeToDay = [self.orderDetailModel.start_time substringWithRange:NSMakeRange(8, 2)];
    //出发时间字符串
    NSString *timeStr = [NSString stringWithFormat:@"%@月%@日", departureTimeToMon, departureTimeToDay];
    
    rushOrderAlertView.promptMessageLable.text = [NSString stringWithFormat:@"该订单需要在“%@－%@” 出发，是否确认接单", timeStr, self.orderDetailModel.start_city];
    
    [rushOrderAlertView.cancleButton addTarget:self action:@selector(cancleRushOrderButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [rushOrderAlertView.rushButton addTarget:self action:@selector(rushOrderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.rushOrderAlertView = rushOrderAlertView;
}

#pragma mark -确定抢单
- (void)rushOrderButtonClick:(UIButton *)button
{
    //隐藏弹框
    self.rushOrderAlertView.hidden = YES;
    //发送接单请求
    [self sendRequestToRushOrderWithOrderStatusType:@"1"];
}

#pragma mark - 发送接单请求方法
- (void)sendRequestToRushOrderWithOrderStatusType:(NSString *)order_status_type
{
    //发送接单请求
    //发送更新订单状态的网络请求 请求数据
    NSString *urlStr = DriverOrderUpdateOrderUrl;
    //请求参数
    //司机id
    NSString *driver_id = [WLUserTools getUserId];
    //用户密码
    NSString *user_password = [WLUserTools getUserPassword];
    //RSA加密
    NSString *encriptString = [MyRSA encryptString:user_password publicKey:RSAKey];
    //订单id
    NSString *sj_order_id = self.sj_order_id;
    //订单状态
    NSString *status = @"5";
    //参数集合
    NSDictionary *params = @{
                             @"driver_id" : driver_id,
                             @"user_password" : encriptString,
                             @"order_status_type" : order_status_type,
                             @"status" : status,
                             @"sj_order_id" : sj_order_id
                             };
    
    //显示菊花
    [self showHud];
    //发送网络请求
    [[WLHttpManager shareManager] requestWithURL:urlStr RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
        WL_Network_Model *model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (![model.status isEqualToString:@"1"])
        {
            //弹框返回信息
            [self.alert createTip:model.msg];
            //隐藏菊花
            [self hidHud];
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        //抢单成功提示
        [self.alert createTip:@"抢单成功"];
        //隐藏菊花
        [self hidHud];
        [self.navigationController popViewControllerAnimated:YES];
        
    } Failure:^(NSError *error) {
        //隐藏菊花
        [self hidHud];
//        [self.alert createTip:[NSString stringWithFormat:@"%@", error]];
        if (error.code == -1009) {
            [self.alert createTip:@"登录失败,请检查您的网络"];
        }
        else
        {
            [self.alert createTip:@"登录失败,请稍后再试"];
        }
    }];
    
}

#pragma mark - 隐藏抢单弹窗<取消方法>
- (void)cancleRushOrderButtonClick
{
     self.rushOrderAlertView.hidden = YES;
}

#pragma mark - 设置导航内容
- (void)setupContentToNav
{
    WL_Application_Driver_Order_OrderDetail_NavTitleView *navTitleView = [[WL_Application_Driver_Order_OrderDetail_NavTitleView alloc] initWithFrame:CGRectMake(0, 0, 98, 45)];
    self.navigationItem.titleView = navTitleView;
    self.navTitleView = navTitleView;
    navTitleView.hidden = YES;

}

#pragma mark - 开启获取验证码定时器
- (void)achieveCaptchaStartTime:(double)differentTime
{
    __block int timeout = differentTime; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                [self.navigationController popViewControllerAnimated:YES];
                
                
            });
        }
        else
        {
            int minutes = timeout / 61;
            int seconds = timeout % 61;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            NSString *strMinTime = [NSString stringWithFormat:@"%d", minutes];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                //DLog(@"____%@",strTime);
                self.navTitleView.timerLable.text = [NSString stringWithFormat:@"%@分%@秒",strMinTime, strTime];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.orderDetailTableView)
    {
        return 3;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.refuseReasonTableView)
    {
        return 4;
    }
    else
    {
        if (section == 1)
        {
            return 3;
        }
        else
        {
            return 1;
        }
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.orderDetailTableView)
    {
        WL_Application_Driver_Order_WaitOrderDetail_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        //给cell中的控件赋值
        if (indexPath.section == 0 && indexPath.row == 0)
        {
            cell.myTitleLable.text = @"订单金额";
            cell.contentLable.textColor = [WLTools stringToColor:@"#ff5b3d"];
            cell.contentLable.font = WLFontSize(15);
            NSString *moneyStr = nil;
            if ([self.orderDetailModel.receipted_amount containsString:@"."])
            {
                NSRange pointRange = [self.orderDetailModel.amount rangeOfString:@"."];
                moneyStr = [self.orderDetailModel.amount substringToIndex:pointRange.location];
            }
            else
            {
                moneyStr = self.orderDetailModel.amount;
            }
            
            cell.contentLable.text = [NSString stringWithFormat:@"¥%@", moneyStr];
            cell.lineView.hidden = YES;
        }
        else if (indexPath.section == 1 && indexPath.row == 0)
        {
            cell.myTitleLable.text = @"订单编码";
            cell.contentLable.font = WLFontSize(15);
            cell.contentLable.text = self.orderDetailModel.order_number;
            cell.lineView.hidden = NO;
        }
        else if (indexPath.section == 1 && indexPath.row == 1)
        {
            cell.myTitleLable.text = @"旅行社";
            cell.contentLable.font = WLFontSize(15);
            cell.contentLable.text = self.orderDetailModel.order_source_travel;
            cell.lineView.hidden = NO;
        }
        else if (indexPath.section == 1 && indexPath.row == 2)
        {
            cell.myTitleLable.text = @"车队";
            cell.contentLable.font = WLFontSize(15);
            cell.contentLable.text = self.orderDetailModel.order_source_Fleet;
            cell.lineView.hidden = YES;
        }
        else if (indexPath.section == 2 && indexPath.row == 0)
        {
            cell.myTitleLable.textColor = [WLTools stringToColor:@"#868686"];
            cell.orderDetail = self.orderDetailModel;
            [cell.myTitleLable sizeToFit];
            cell.lineView.hidden = YES;
        }
        
        return cell;
    }
    else
    {
        WL_Application_Driver_Order_RefuseOrder_Cell *cell = [tableView dequeueReusableCellWithIdentifier:refuseCellId];
        cell.reasonLable.text = self.refuseReasons[indexPath.row];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        if (indexPath.row == 3)
        {
            cell.reasonTextView.hidden = NO;
            cell.reasonTextView.delegate = self;
            self.placeholderLable = cell.placeholderLabel;
            [cell.selectedButton addTarget:self action:@selector(choiceRefuseReason:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        return cell;
        
        
    }
    return nil;
}

#pragma mark - 点击拒绝弹框中的按钮
- (void)choiceRefuseReason:(UIButton *)button
{
    WL_Application_Driver_Order_RefuseOrder_Cell *cell = (WL_Application_Driver_Order_RefuseOrder_Cell *)button.superview.superview;
    button.selected = !button.selected;
    if (button.selected)
    {
        
        [self.refuseReasonArr addObject:cell.reasonLable.text];
        
    }
    else
    {
        
        [self.refuseReasonArr removeObject:cell.reasonLable.text];
        
    }

    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 52.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.refuseReasonTableView)
    {
        if (indexPath.row == 3)
        {
            return 100.0f;
        }
        else
        {
            return 43.0f;
        }
    }
    else
    {
        if (indexPath.section == 2 && indexPath.row == 0)
        {
            return self.orderDetailModel.cellHeight;
        }
        return 52.0f;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == self.orderDetailTableView)
    {
        UIView *firstView = [[UIView alloc] init];
        UILabel *firstLable = [[UILabel alloc] init];
        [firstView addSubview:firstLable];
        [firstLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(firstView.mas_left).mas_offset(12);
            make.centerY.equalTo(firstView.mas_centerY);
        }];
        
        if (section == 0)
        {
            firstLable.text = @"支付信息";
        }
        if (section == 1)
        {
            firstLable.text = @"订单来源";
        }
        if (section == 2) {
            firstLable.text = @"备注";
        }
        return firstView;
    }
    else
    {
        return nil;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.refuseReasonTableView)
    {
        return 0.0001f;
    }
    else
    {
        return 45.0f;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.orderDetailTableView)
    {
        return;
    }
    WL_Application_Driver_Order_RefuseOrder_Cell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectedButton.userInteractionEnabled = NO;
    cell.selectedButton.selected = !cell.selectedButton.selected;
    self.reasonTextView = cell.reasonTextView;
    if (cell.selectedButton.selected)
    {

        [self.refuseReasonArr addObject:cell.reasonLable.text];

    }
    else
    {

        [self.refuseReasonArr removeObject:cell.reasonLable.text];
        
    }
    
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (IsiPhone4) {
        [self.refuseReasonTableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.refuseOrderAlertView.mas_top).offset(-80);
        }];
    }
    else
    {
        [self.refuseReasonTableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.refuseOrderAlertView.mas_top).offset(-50);
        }];
    }
    

    
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""] || textView.text == nil)
    {
        self.placeholderLable.hidden = NO;
    }
    else
    {
        self.placeholderLable.hidden = YES;
    }
}






@end
