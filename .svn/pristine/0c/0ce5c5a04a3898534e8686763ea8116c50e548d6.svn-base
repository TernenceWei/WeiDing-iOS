//
//  WL_Application_Driver_Order_FailureOrderDetail_ViewController.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_Order_FailureOrderDetail_ViewController.h"
//导入订单详情模型
#import "WL_Application_Driver_OrderDetail_Model.h"
//导入自定义的cell
#import "WL_Application_Driver_Order_WaitOrderDetail_Cell.h"
//导入订单详情的头试图
#import "WL_Application_Driver_Order_OrderDetail_TopView.h"
//导入订单详情列表的底部视图
#import "WL_Application_Driver_Order_FailureOrderDetail_BottomView.h"

@interface WL_Application_Driver_Order_FailureOrderDetail_ViewController ()<UITableViewDelegate, UITableViewDataSource>
//订单详情模型
@property(nonatomic, strong)WL_Application_Driver_OrderDetail_Model *orderDetailModel;
//弹框
@property(nonatomic, strong)WL_TipAlert_View *alert;

//设置TableView的头视图
@property(nonatomic, weak)WL_Application_Driver_Order_OrderDetail_TopView *orderDetailTopView;

//设置TableView的底部视图
@property(nonatomic, weak)WL_Application_Driver_Order_FailureOrderDetail_BottomView *failureOrderDetailBottomView;

/** 无网络View */
@property(nonatomic, strong) WL_NoData_View *noDataView;

//添加订单详情TableView
@property(nonatomic, weak) UITableView *failureOrderDetailTableView;
@end

@implementation WL_Application_Driver_Order_FailureOrderDetail_ViewController

- (WL_NoData_View *)noDataView
{
    if (_noDataView == nil) {
        
        WS(weakSelf);
        
        _noDataView = [[WL_NoData_View alloc] initWithFrame:self.view.frame andRefreshBlock:^{
            [weakSelf sendRequestToFailureOrderDetail];
            
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


#pragma mark - view载入内存时调用一次
- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置Nav内容
    [self setupNavTitle];
    //设置内容,绘制UI
    [self setupContentViewToFailureOrderDetail];
    //发送请求
    [self sendRequestToFailureOrderDetail];
    
    //注册弹框
    [self creatTipAlertView];
    [self.view addSubview:self.noDataView];
    
}

#pragma mark - 注册弹框
- (void)creatTipAlertView
{
    self.alert = [WL_TipAlert_View sharedAlert];
    
}


#pragma mark - 设置头部标题
- (void)setupNavTitle
{
    //设置标题
    self.navigationItem.title = @"订单详情";
}

#pragma mark - 发送网络请求
- (void)sendRequestToFailureOrderDetail
{
    //请求Url
    NSString *urlStr = DriverOrderDetailUrl;
    //参数
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
    //发送网络请求
    [[WLHttpManager shareManager] requestWithURL:urlStr RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
        //与服务器交互成功

        //打印返回的参数<测试>
        
        //将返回的json数据,转换为基础模型
        WL_Network_Model *baseModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        //如果服务器返回的状态码不为1
        if (![baseModel.status isEqualToString:@"1"]) {
            [self.alert createTip:baseModel.msg];
            //隐藏菊花
            [self hidHud];
            //退出请求方法
            return;
        }
        
        self.noDataView.hidden = YES;
        //服务器返回的状态码为1
        WL_Application_Driver_OrderDetail_Model *orderDetailModel = [WL_Application_Driver_OrderDetail_Model mj_objectWithKeyValues:baseModel.data];
        self.orderDetailModel = orderDetailModel;
        self.failureOrderDetailTableView.hidden = NO;
        //出发城市
        self.orderDetailTopView.fromCityLable.text = orderDetailModel.start_city;
        //到达城市
        self.orderDetailTopView.endCityLable.text = self.orderDetailModel.end_city;
        //行程里程
        self.orderDetailTopView.mileageLable.text = @"";
        //出发日期
        NSString *departureTimeToMon = [self.orderDetailModel.start_time substringWithRange:NSMakeRange(5, 2)];
        NSString *departureTimeToDay = [self.orderDetailModel.start_time substringWithRange:NSMakeRange(8, 2)];
        self.orderDetailTopView.startTimeLable.text = [NSString stringWithFormat:@"%@月%@日", (departureTimeToMon == nil)?@"-":departureTimeToMon, (departureTimeToDay == NULL)?@"-":departureTimeToDay];
        //结束日期
        NSString *endTimeToMon = [self.orderDetailModel.end_time substringWithRange:NSMakeRange(5, 2)];
        NSString *endTimeToDay = [self.orderDetailModel.end_time substringWithRange:NSMakeRange(8, 2)];
        self.orderDetailTopView.endTimeLable.text = [NSString stringWithFormat:@"%@月%@日", (endTimeToMon == nil)?@"-":endTimeToMon, (endTimeToDay == nil)?@"-":endTimeToDay];
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
        //NSString *startTimeToHour = [self.orderDetailModel.start_time substringWithRange:NSMakeRange(11, 2)];
        //NSString *startTimeToMin = [self.orderDetailModel.start_time substringWithRange:NSMakeRange(14, 2)];
        //self.orderDetailTopView.beginTimeLable.text = [NSString stringWithFormat:@"%@年%@月%@日 %@:%@ 出发", startTimeToYear, startTimeToMon, startTimeToDay, startTimeToHour, startTimeToMin];
        self.orderDetailTopView.beginTimeLable.text = [NSString stringWithFormat:@"%@年%@月%@日 出发", (startTimeToYear == nil)?@"-":startTimeToYear, (startTimeToMon == nil)?@"-":startTimeToMon, (startTimeToDay == nil)?@"-":startTimeToDay];
        //结束地点
        self.orderDetailTopView.endAddressLable.text = self.orderDetailModel.end_address;
        //结束时间
        
        NSString *arriveTimeToYear = [self.orderDetailModel.end_time substringWithRange:NSMakeRange(0, 4)];
        NSString *arriveTimeToMon = [self.orderDetailModel.end_time substringWithRange:NSMakeRange(5, 2)];
        NSString *arriveTimeToDay = [self.orderDetailModel.end_time substringWithRange:NSMakeRange(8, 2)];
        //NSString *arriveTimeToHour = [self.orderDetailModel.end_time substringWithRange:NSMakeRange(11, 2)];
        //NSString *arriveTimeToMin = [self.orderDetailModel.end_time substringWithRange:NSMakeRange(14, 2)];
        //self.orderDetailTopView.arriveTimeLable.text = [NSString stringWithFormat:@"%@年%@月%@日 %@:%@ 结束", arriveTimeToYear, arriveTimeToMon, arriveTimeToDay, arriveTimeToHour, arriveTimeToMin];
        self.orderDetailTopView.arriveTimeLable.text = [NSString stringWithFormat:@"%@年%@月%@日 结束", (arriveTimeToYear == nil)?@"-":arriveTimeToYear, (arriveTimeToMon == nil)?@"-":arriveTimeToMon, (arriveTimeToDay == nil)?@"-":arriveTimeToDay];
        
        
        //接单状态
        if ([self.orderDetailModel.order_status isEqualToString:@"1"])
        {
            self.failureOrderDetailBottomView.acceptStatusLable.text = @"接单状态: 待接单";
        }
        else if ([self.orderDetailModel.order_status isEqualToString:@"2"])
        {
            self.failureOrderDetailBottomView.acceptStatusLable.text = @"接单状态: 已拒绝";
            self.failureOrderDetailBottomView.refuseTitleLable.text = @"拒绝原因:";
            [self.failureOrderDetailBottomView.sendOrderTimeLable mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.failureOrderDetailBottomView.refuseTitleLable.mas_bottom).offset(11);
            }];

            //2.拒绝原因
            NSString *string = [self.orderDetailModel.cancel_remark componentsJoinedByString:@","];
            self.failureOrderDetailBottomView.refuseReasonLable.text = string;

        }
        else if ([self.orderDetailModel.order_status isEqualToString:@"3"])
        {
            self.failureOrderDetailBottomView.acceptStatusLable.text = @"接单状态: 已超时";
        }
        else if ([self.orderDetailModel.order_status isEqualToString:@"4"])
        {
            self.failureOrderDetailBottomView.acceptStatusLable.text = @"接单状态: 已被抢";
        }
        else if ([self.orderDetailModel.order_status isEqualToString:@"5"])
        {
            self.failureOrderDetailBottomView.acceptStatusLable.text = @"接单状态: 已接单";
        }
        else if ([self.orderDetailModel.order_status isEqualToString:@"6"])
        {
            self.failureOrderDetailBottomView.acceptStatusLable.text = @"接单状态: 已被取消";
            self.failureOrderDetailBottomView.refuseTitleLable.text = @"取消原因:";
            [self.failureOrderDetailBottomView.sendOrderTimeLable mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.failureOrderDetailBottomView.refuseTitleLable.mas_bottom).offset(11);
            }];
            if (self.orderDetailModel.revoke_reason == nil || [self.orderDetailModel.revoke_reason isEqualToString:@""]) {
                //2.撤销原因为空, 显示拒绝原因
                NSString *string = [self.orderDetailModel.cancel_remark componentsJoinedByString:@","];
                self.failureOrderDetailBottomView.refuseReasonLable.text = string;
            }
            else
            {
                //2.撤销原因不为空,显示撤销原因
                self.failureOrderDetailBottomView.refuseReasonLable.text = self.orderDetailModel.revoke_reason;
            }
            
            
            
        }

        //3.派单时间
        NSString *sendOrderStr = [self.orderDetailModel.create_date stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        NSString *sendOrderTimeStr = [sendOrderStr substringToIndex:16];
        self.failureOrderDetailBottomView.sendOrderTimeLable.text = [NSString stringWithFormat:@"派单时间: %@", sendOrderTimeStr];
        [self.failureOrderDetailBottomView.sendOrderTimeLable mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.failureOrderDetailBottomView.refuseTitleLable.mas_left);
            make.top.equalTo(self.failureOrderDetailBottomView.refuseReasonLable.mas_bottom).offset(11);
        }];
        //4.失效时间
        NSString *failureStr = [self.orderDetailModel.failure_expires stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        NSString *failureTimeStr = [failureStr substringToIndex:16];
        self.failureOrderDetailBottomView.failureTimeLable.text = [NSString stringWithFormat:@"失效时间: %@", failureTimeStr];
        [self.failureOrderDetailBottomView.failureTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.failureOrderDetailBottomView.sendOrderTimeLable.mas_left);
            make.top.equalTo(self.failureOrderDetailBottomView.sendOrderTimeLable.mas_bottom).offset(11);
        }];
        
        [self.failureOrderDetailTableView reloadData];
        
        
        //隐藏菊花
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

#pragma mark - 绘制UI内容
static NSString *const cellId = @"failureCellId";
- (void)setupContentViewToFailureOrderDetail
{
    self.view.backgroundColor = BgViewColor;
    //添加订单详情TableView
    UITableView *failureOrderDetailTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    //添加到父控件
    [self.view addSubview:failureOrderDetailTableView];
    //添加约束
    [failureOrderDetailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.view.mas_top);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    //设置属性
    UIView *view = [[UIView alloc] init];
    [failureOrderDetailTableView addSubview:view];
    view.backgroundColor = [WLTools stringToColor:@"#4778e7"];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(failureOrderDetailTableView.mas_top);
        make.height.equalTo(@375);
    }];
    
    //cell的分隔线隐藏
    failureOrderDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    failureOrderDetailTableView.showsVerticalScrollIndicator = NO;
    //注册cell
    [failureOrderDetailTableView registerClass:[WL_Application_Driver_Order_WaitOrderDetail_Cell class] forCellReuseIdentifier:cellId];
    //设置代理和数据源为控制器本身
    failureOrderDetailTableView.delegate = self;
    failureOrderDetailTableView.dataSource = self;
    failureOrderDetailTableView.backgroundColor = BgViewColor;
    self.failureOrderDetailTableView = failureOrderDetailTableView;
    failureOrderDetailTableView.hidden = YES;
    //设置TableView的头视图
    WL_Application_Driver_Order_OrderDetail_TopView *orderDetailTopView = [[WL_Application_Driver_Order_OrderDetail_TopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 280)];
    orderDetailTopView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    failureOrderDetailTableView.tableHeaderView = orderDetailTopView;
    self.orderDetailTopView = orderDetailTopView;
    //底部视图
    WL_Application_Driver_Order_FailureOrderDetail_BottomView *failureOrderDetailBottomView = [[WL_Application_Driver_Order_FailureOrderDetail_BottomView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 235)];
    failureOrderDetailTableView.tableFooterView = failureOrderDetailBottomView;
    self.failureOrderDetailBottomView = failureOrderDetailBottomView;
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else if (section == 1)
    {
        return 3;
    }
    else if (section == 2)
    {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WL_Application_Driver_Order_WaitOrderDetail_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
   
    //给cell中的控件赋值
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        cell.myTitleLable.text = @"订单金额";
        cell.contentLable.textColor = [WLTools stringToColor:@"#ff5b3d"];
        cell.contentLable.font = WLFontSize(15);
        NSString *advanceStr = nil;
        if ([self.orderDetailModel.amount containsString:@"."])
        {
            NSRange pointRange = [self.orderDetailModel.amount rangeOfString:@"."];
            advanceStr = [self.orderDetailModel.amount substringToIndex:pointRange.location];
        }
        else
        {
            advanceStr = self.orderDetailModel.amount;
        }
        cell.contentLable.text = [NSString stringWithFormat:@"¥%@", advanceStr];
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

#pragma mark - UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2 && indexPath.row == 0)
    {
        return self.orderDetailModel.cellHeight;
    }
    return 52.0f;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45.0f;
}

@end
