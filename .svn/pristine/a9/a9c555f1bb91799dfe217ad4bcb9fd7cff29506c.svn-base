//
//  WL_Application_Driver_AcceptOrderDetail_ViewController.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/24.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_Order_AcceptOrderDetail_ViewController.h"

#import "WL_Application_Driver_OrderDetail_Model.h"
#import "WL_Application_Driver_OrderDetail_Guide_Model.h"
#import "WL_Application_Driver_OrderDetail_Dispatcher_Model.h"
#import "WL_Application_Driver_OrderDetail_PayRecord_Model.h"

#import "WL_Application_Driver_Order_OrderDetail_TopView.h"
#import "WL_Application_Driver_Order_WaitOrderDetail_Cell.h"
#import "WL_Application_Driver_Order_AcceptOrderDetail_Cell.h"
#import "WL_Application_Driver_Order_AcceptOrderDetail_TableViewBottomView.h"
#import "WL_TwicePay_ViewController.h"

#import "WL_Application_Driver_Order_AcceptOrder_AlertView.h"

#import "WL_Application_Driver_Order_Tour_Button.h"
#import "WL_Application_Driver_RefuseOrder_AlertView.h"
#import "WL_Application_Driver_Order_RefuseOrder_Cell.h"

#import "WL_Pop_CallWindow.h"
#import "WL_Warning_Window.h"

@interface WL_Application_Driver_Order_AcceptOrderDetail_ViewController ()<UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>
@property(nonatomic, strong)WL_Application_Driver_OrderDetail_Model *orderDetailModel;

@property(nonatomic, strong)WL_TipAlert_View *alert;

//TableView的头视图
@property(nonatomic, weak)WL_Application_Driver_Order_OrderDetail_TopView *orderDetailTopView;
//内容TableView
@property(nonatomic, weak)UITableView *orderDetailTableView;
//TableView的底部视图
@property(nonatomic, weak)WL_Application_Driver_Order_AcceptOrderDetail_TableViewBottomView *orderDetailBottomView;


/** 导游模型 */
@property(nonatomic, strong) WL_Application_Driver_OrderDetail_Guide_Model *guideModel;
/** 计调模型 */
@property(nonatomic, strong) WL_Application_Driver_OrderDetail_Dispatcher_Model *dispatcherModel;
//联系弹框
@property(nonatomic,strong)WL_Pop_CallWindow *CallWindow;
/** 取消订单原因数组 */
@property(nonatomic, strong) NSArray *cancleReasonsToDetail;
/** 取消订单参数数组 */
@property(nonatomic, strong) NSMutableArray *cancleReasonArrToDetail;

@property(nonatomic, weak)WL_Application_Driver_RefuseOrder_AlertView *refuseOrderAlert;
/** 内容TableView */
@property(nonatomic, weak)UITableView *refuseReasonTableView;
/** 拒绝原因列表中其他原因输入框 */
@property(nonatomic, weak) UITextView *reasonTextView;
/** 占位文字Lable */
@property(nonatomic, weak) UILabel *placeholderLabel;

/** 无网络View */
@property(nonatomic, strong) WL_NoData_View *noDataView;

@property(nonatomic, strong)WL_Warning_Window *warningAlert;
/** 支付次数模型数组 */
@property(nonatomic, strong) NSMutableArray *paycounts;
@end

@implementation WL_Application_Driver_Order_AcceptOrderDetail_ViewController

#pragma mark - Lazy

- (NSMutableArray *)paycounts
{
    if (!_paycounts) {
        _paycounts = [NSMutableArray array];
    }
    return _paycounts;
}

-(WL_Pop_CallWindow *)CallWindow
{
    
    if (_CallWindow==nil) {
        
        _CallWindow =[[WL_Pop_CallWindow alloc]init];
        
        [_CallWindow setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        
    }
    return _CallWindow;
}

- (WL_Warning_Window *)warningAlert
{
    if (!_warningAlert) {
        _warningAlert = [[WL_Warning_Window alloc] init];
        [_warningAlert setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    }
    
    
    return _warningAlert;
}


- (NSMutableArray *)cancleReasonArrToDetail
{
    if (!_cancleReasonArrToDetail) {
        _cancleReasonArrToDetail = [NSMutableArray array];
    }
    return _cancleReasonArrToDetail;
}


- (WL_NoData_View *)noDataView
{
    if (_noDataView == nil) {
        
        WS(weakSelf);
        
        _noDataView = [[WL_NoData_View alloc] initWithFrame:self.view.frame andRefreshBlock:^{
            [weakSelf sendRequestToAcceptOrderDetail];
            
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


- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置头部标题
    self.title = @"订单详情";
    //设置内容
    [self setupAcceptOrderDetailToContent];
    //发送订单详情网络请求
    [self sendRequestToAcceptOrderDetail];
    //注册弹框
    [self creatTipAlertView];
    
    [self.view addSubview:self.noDataView];
    
     self.cancleReasonsToDetail = @[@"接单时看错信息", @"订单信息不全", @"车辆暂时无法正常行驶", @"个人身体不适,需要休息", @"其他原因"];
    
}

#pragma mark - 注册弹框
- (void)creatTipAlertView
{
    self.alert = [WL_TipAlert_View sharedAlert];
    
}

#pragma mark - 发送订单详情网络请求
- (void)sendRequestToAcceptOrderDetail
{
    //请求Url
    NSString *urlStr = DriverOrderDetailUrl;
    //请求参数
    //司机id
    NSString *driver_id = [WLUserTools getUserId];
    //用户密码
    NSString *user_password = [WLUserTools getUserPassword];
    //RSA加密
    NSString *encriptString = [MyRSA encryptString:user_password publicKey:RSAKey];
    //请求参数集合
    NSDictionary *params = @{
                             @"driver_id" : driver_id,
                             @"user_password" : encriptString,
                             @"sj_order_id" : self.sj_order_id
                             };
    //显示菊花
    [self showHud];
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
        self.dispatcherModel = [WL_Application_Driver_OrderDetail_Dispatcher_Model mj_objectWithKeyValues:orderDetailModel.dispatcher];
        
        self.paycounts = [WL_Application_Driver_OrderDetail_PayRecord_Model mj_objectArrayWithKeyValuesArray:orderDetailModel.pay_record];
        
        self.orderDetailModel = orderDetailModel;
        self.orderDetailTableView.hidden = NO;
        
        
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
        if ([self.orderDetailModel.persons_count isEqualToString:@""] || self
            .orderDetailModel.persons_count == nil) {
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
        self.orderDetailTopView.beginTimeLable.text = [NSString stringWithFormat:@"%@ 出发",[self returnCustomStringWith:self.orderDetailModel.start_time]];
        //结束地点
        self.orderDetailTopView.endAddressLable.text = self.orderDetailModel.end_address;
        //结束时间
        self.orderDetailTopView.arriveTimeLable.text = [NSString stringWithFormat:@"%@ 结束",[self returnCustomStringWith:self.orderDetailModel.end_time]];
        
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

        //行程状态
        if ([self.orderDetailModel.trip_status isEqualToString:@"1"])
        {
            self.orderDetailBottomView.journeyStatusLable.text = @"行程状态: 待出发";
        }
        else if ([self.orderDetailModel.trip_status isEqualToString:@"2"])
        {
            self.orderDetailBottomView.journeyStatusLable.text = @"行程状态: 行程中";
        }
        else if ([self.orderDetailModel.trip_status isEqualToString:@"3"])
        {
            self.orderDetailBottomView.journeyStatusLable.text = @"行程状态: 已结束";
        }
        
        
        if ([self.orderDetailModel.trip_status integerValue] == 3) {
            switch ([self.orderDetailModel.pay_status integerValue])
            {
                case 1:
                    self.orderDetailBottomView.payStatusLable.text = @"支付状态: 结算中";
                    break;
                case 2:
                    self.orderDetailBottomView.payStatusLable.text = @"支付状态: 已结算";
                    break;
                    
                default:
                    break;
            }
        }
        else
        {
            self.orderDetailBottomView.payStatusLable.hidden = YES;
            
            self.orderDetailBottomView.frame = CGRectMake(0, 0, ScreenWidth, 200);
            
            
        }

        //联系计调按钮
        WL_Application_Driver_Order_Tour_Button *tourOperatorButton = [[WL_Application_Driver_Order_Tour_Button alloc] init];
        [self.view addSubview:tourOperatorButton];
        //设置属性
        tourOperatorButton.nameLable.text = @"联系计调";
        tourOperatorButton.photoImageView.image = [UIImage imageNamed:@"tripService"];
        //添加约束
        [tourOperatorButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
            make.width.equalTo(@(ScreenWidth / 2));
            make.bottom.equalTo(self.view.mas_bottom);
            make.height.equalTo(@55);
        }];
        [tourOperatorButton addTarget:self action:@selector(tourOperator) forControlEvents:UIControlEventTouchUpInside];
        
        //联系导游按钮
        WL_Application_Driver_Order_Tour_Button *tourGuideButton = [[WL_Application_Driver_Order_Tour_Button alloc] init];
        [self.view addSubview:tourGuideButton];
        //设置属性

        tourGuideButton.nameLable.text = @"联系导游";
        tourGuideButton.photoImageView.image = [UIImage imageNamed:@"tripTour"];

        //添加约束
        [tourGuideButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view.mas_right);
            make.width.equalTo(@(ScreenWidth / 2));
            make.bottom.equalTo(self.view.mas_bottom);
            make.height.equalTo(@55);
        }];
        [tourGuideButton addTarget:self action:@selector(tourGuide) forControlEvents:UIControlEventTouchUpInside];
        
        if (self.guideModel == nil)
        {
            tourGuideButton.enabled = NO;
            tourGuideButton.photoImageView.image = [UIImage imageNamed:@"tripTourGray"];
        } else {
            tourGuideButton.enabled = YES;
            tourGuideButton.photoImageView.image = [UIImage imageNamed:@"tripTour"];
        }
        
//        }

        
        //派单时间
        //3.派单时间
        NSString *sendOrderStr = [self.orderDetailModel.create_date stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        NSString *sendOrderTimeStr = [sendOrderStr substringToIndex:16];
        self.orderDetailBottomView.timeLable.text = [NSString stringWithFormat:@"派单时间: %@", sendOrderTimeStr];

        //接单时间
        NSString *receiveOrderStr = [self.orderDetailModel.accept_date stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        NSString *receiveOrderTimeStr = [receiveOrderStr substringToIndex:16];
        self.orderDetailBottomView.receiveTimeLable.text = [NSString stringWithFormat:@"接单时间: %@", receiveOrderTimeStr];
    
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
#pragma mark -返回指定字符串
- (NSString *)returnCustomStringWith:(NSString *)oldString
{
    NSString *arriveTimeToYear = [oldString substringWithRange:NSMakeRange(0, 4)];
    NSString *arriveTimeToMon = [oldString substringWithRange:NSMakeRange(5, 2)];
    NSString *arriveTimeToDay = [oldString substringWithRange:NSMakeRange(8, 2)];
    NSString *arriveTimeToHour = [oldString substringWithRange:NSMakeRange(11, 2)];
    NSString *arriveTimeToMin = [oldString substringWithRange:NSMakeRange(14, 2)];
    return [NSString stringWithFormat:@"%@年%@月%@日 %@:%@", arriveTimeToYear, arriveTimeToMon, arriveTimeToDay, arriveTimeToHour, arriveTimeToMin];
    
}
#pragma mark - 联系计调方法
- (void)tourOperator
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.CallWindow];
    
    self.CallWindow.dispatcher_Model= self.orderDetailModel.dispatcher;
    
}



#pragma mark - 联系导游方法
- (void)tourGuide
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.CallWindow];
    
    self.CallWindow.guide_Model= self.orderDetailModel.guide;
    
    
}

#pragma mark - 设置页面内容
static NSString *const cellId = @"cellId";
static NSString *const acceptCellId = @"acceptCellId";
- (void)setupAcceptOrderDetailToContent
{
    self.view.backgroundColor = BgViewColor;
    //内容TableView
    UITableView *orderDetailTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:orderDetailTableView];
    //添加约束
    [orderDetailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom).offset(-55);
    }];
    orderDetailTableView.showsVerticalScrollIndicator = NO;
    orderDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    orderDetailTableView.backgroundColor = BgViewColor;
    //设置代理与数据源
    orderDetailTableView.delegate = self;
    orderDetailTableView.dataSource = self;
    
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
    
    [orderDetailTableView registerClass:[WL_Application_Driver_Order_AcceptOrderDetail_Cell class] forCellReuseIdentifier:acceptCellId];
    
    //TableView的头视图
    WL_Application_Driver_Order_OrderDetail_TopView *orderDetailTopView = [[WL_Application_Driver_Order_OrderDetail_TopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 280)];
    orderDetailTopView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    orderDetailTableView.tableHeaderView = orderDetailTopView;
    self.orderDetailTableView = orderDetailTableView;
    self.orderDetailTopView = orderDetailTopView;
    
    orderDetailTableView.hidden = YES;
   
    
    //TableView的尾视图
    WL_Application_Driver_Order_AcceptOrderDetail_TableViewBottomView *orderDetailBottomView = [[WL_Application_Driver_Order_AcceptOrderDetail_TableViewBottomView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 225)];
    orderDetailTableView.tableFooterView = orderDetailBottomView;
    self.orderDetailBottomView = orderDetailBottomView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.orderDetailTableView)
    {
        return 3;
    }
    else
    {
        return 1;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.orderDetailTableView)
    {
        if (section == 0)
        {
            if ([self.orderDetailModel.trip_status isEqualToString:@"3"]) {
                return 4;
            }
            else
            {
                return 3;
            }
 
        }
        else if (section == 1)
        {
            return 3;
        }
        else if (section == 2)
        {
            return 1;
        }
    }
    else
    {
        return 5;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

        WL_Application_Driver_Order_WaitOrderDetail_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (indexPath.section == 0 && indexPath.row == 0)
        {
            cell.myTitleLable.text = @"订单金额";
            cell.receiptLable.textColor = [WLTools stringToColor:@"#b5b5b5"];
            cell.receiptLable.font = WLFontSize(15);
            NSString *moneyStr = nil;
            if ([self.orderDetailModel.amount containsString:@"."])
            {
                NSRange pointRange = [self.orderDetailModel.amount rangeOfString:@"."];
                moneyStr = [self.orderDetailModel.amount substringToIndex:pointRange.location];
            }
            else
            {
                moneyStr = self.orderDetailModel.amount;
            }
            cell.receiptLable.text = [NSString stringWithFormat:@"¥%@", moneyStr];
            cell.lineView.hidden = NO;
            cell.receiptLable.hidden = NO;
            
        }
        else if (indexPath.section == 0 && indexPath.row == 1)
        {
            cell.myTitleLable.text = @"实际金额";
            cell.contentLable.hidden = YES;
            cell.receiptLable.hidden = NO;
            cell.indicatorImageView.hidden = YES;
            cell.receiptLable.textColor = [WLTools stringToColor:@"#b5b5b5"];
            cell.receiptLable.font = WLFontSize(15);
            cell.promptButton.hidden = NO;
            [cell.promptButton addTarget:self action:@selector(alertToPrompt) forControlEvents:UIControlEventTouchUpInside];
            
            NSString *moneyStr = nil;
            
            if ([self.orderDetailModel.actual_amount containsString:@"."])
            {
                NSRange pointRange = [self.orderDetailModel.receipted_amount rangeOfString:@"."];
                moneyStr = [self.orderDetailModel.actual_amount substringToIndex:pointRange.location];
            }
            else
            {
                moneyStr = self.orderDetailModel.actual_amount;
            }
            
            switch (moneyStr.integerValue) {
                case 0:
                    cell.receiptLable.text = @"待导游记账";
                    break;
                    
                default:
                    cell.receiptLable.text = [NSString stringWithFormat:@"¥%@", moneyStr];
                    break;
            }
            
            
            cell.lineView.hidden = NO;
            
        }
        else if (indexPath.section == 0 && indexPath.row == 2)
        {
            cell.myTitleLable.text = @"已支付";
            cell.receiptLable.hidden = NO;
            cell.indicatorImageView.hidden = NO;
            cell.receiptLable.textColor = [WLTools stringToColor:@"#b5b5b5"];
            cell.receiptLable.font = WLFontSize(15);
            NSString *recepitMoneyStr = nil;
            if ([self.orderDetailModel.receipted_amount containsString:@"."])
            {
                NSRange pointRange = [self.orderDetailModel.receipted_amount rangeOfString:@"."];
                recepitMoneyStr = [self.orderDetailModel.receipted_amount substringToIndex:pointRange.location];
            }
            else
            {
                recepitMoneyStr = self.orderDetailModel.receipted_amount;
            }
            if ([self.orderDetailModel.trip_status isEqualToString:@"3"]) {
                cell.lineView.hidden = NO;
            }
            else
            {
                cell.lineView.hidden = YES;
            }

            cell.receiptLable.text = [NSString stringWithFormat:@"¥%@", recepitMoneyStr];
            
            
        }
        else if (indexPath.section == 0 && indexPath.row == 3)
        {
            cell.waitPayTitelLable.hidden = NO;
            cell.waitPayLable.hidden = NO;
            cell.myTitleLable.hidden = YES;
            NSString *moneyStr = nil;
            
            if ([self.orderDetailModel.actual_amount containsString:@"."])
            {
                NSRange pointRange = [self.orderDetailModel.receipted_amount rangeOfString:@"."];
                moneyStr = [self.orderDetailModel.actual_amount substringToIndex:pointRange.location];
            }
            else
            {
                moneyStr = self.orderDetailModel.actual_amount;
            }
            
            NSInteger waitPayMoney = moneyStr.integerValue - self.orderDetailModel.receipted_amount.integerValue;
            
            switch (moneyStr.integerValue) {
                case 0:
                    cell.waitPayLable.text = @"待导游记账";
                    cell.waitPayLable.textColor = [WLTools stringToColor:@"#b5b5b5"];
                    cell.waitPayLable.font = WLFontSize(14);
                    break;
                    
                default:
                    cell.waitPayLable.text = [NSString stringWithFormat:@"¥%zd", waitPayMoney];
                    cell.waitPayLable.font = WLFontSize(17);
                    cell.waitPayLable.textColor = [WLTools stringToColor:@"#ff5b3d"];
                    break;
            }

            cell.lineView.hidden = YES;
        }
        
        else if (indexPath.section == 1 && indexPath.row == 0)
        {
            cell.myTitleLable.text = @"订单编码";
            cell.contentLable.text = self.orderDetailModel.order_number;
            cell.lineView.hidden = NO;
        }
        else if (indexPath.section == 1 && indexPath.row == 1)
        {
            cell.myTitleLable.text = @"旅行社";
            cell.contentLable.text = self.orderDetailModel.order_source_travel;
            cell.lineView.hidden = NO;
        }
        else if (indexPath.section == 1 && indexPath.row == 2)
        {
            cell.myTitleLable.text = @"车队";
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

#pragma mark - 弹框提示导游记账规则
- (void)alertToPrompt
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.warningAlert];
    
    self.warningAlert.tipString = @"若您因为实际出行与订单不符，需要调整订单价格请与导游商议，并由导游记账后更新";
    self.warningAlert.buttonTittle = @"知道了";
}



#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 52.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.orderDetailTableView)
    {
        if (indexPath.section == 2 && indexPath.row == 0)
        {
            return self.orderDetailModel.cellHeight;
        }
        else if (indexPath.section == 0 && indexPath.row == 3)
        {
            return 72.0f;
        }
        return 52.0f;
    }
    else if (tableView == self.refuseReasonTableView)
    {
        if (indexPath.row == 4)
        {
            return 100;
        }
        else
        {
            return 43;
        }
    }
    return 0;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == self.orderDetailTableView)
    {
        UIView *firstView = [[UIView alloc] init];
        UILabel *firstLable = [[UILabel alloc] init];
        [firstView addSubview:firstLable];
        firstLable.textColor = [WLTools stringToColor:@"#868686"];
        firstLable.font = WLFontSize(15);
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
            firstLable.text = @"备注信息";
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
    if (tableView == self.orderDetailTableView)
    {
        return 45.0f;
    }
    else
    {
        return 0.001f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.orderDetailTableView)
    {
        if (indexPath.section == 0 && indexPath.row == 2)
        {
            
            if ([self.orderDetailModel.receipted_amount isEqualToString:@"0"] || self.orderDetailModel.receipted_amount == nil)
            {
                [self.alert createTip:@"暂无支付记录,没有支付记录明细"];
            }
            else
            {
                //跳转支付明细控制器
                WL_TwicePay_ViewController *receiptedListVc = [[WL_TwicePay_ViewController alloc] init];
                receiptedListVc.pay_record = self.paycounts;
                [self.navigationController pushViewController:receiptedListVc animated:YES];
            }
 
        }

    }
    else
    {
        WL_Application_Driver_Order_RefuseOrder_Cell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.selectedButton.selected = !cell.selectedButton.selected;
        self.reasonTextView = cell.reasonTextView;
        if (cell.selectedButton.selected)
        {
            
            [self.cancleReasonArrToDetail addObject:cell.reasonLable.text];
            
        }
        else
        {
            
            [self.cancleReasonArrToDetail removeObject:cell.reasonLable.text];
            
        }

    }
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (IsiPhone4) {
        [self.refuseReasonTableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.refuseOrderAlert.mas_top).offset(-80);
        }];
    }
    else
    {
        [self.refuseReasonTableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.refuseOrderAlert.mas_top).offset(-50);
        }];
    }
    
    
    
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""] || textView.text == nil)
    {
        self.placeholderLabel.hidden = NO;
    }
    else
    {
        self.placeholderLabel.hidden = YES;
    }
}

@end
