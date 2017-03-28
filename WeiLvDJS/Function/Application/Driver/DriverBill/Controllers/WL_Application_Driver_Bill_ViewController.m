//
//  WL_Application_Driver_Bill_ViewController.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/18.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  [应用] --> [司机] --> [账单] 控制器

#import "WL_Application_Driver_Bill_ViewController.h"
#import "WL_Application_Driver_Bill_NavTitle_View.h"
#import "WL_Application_Driver_Bill_Top_View.h"
#import "WL_Application_Driver_Bill_Bottom_View.h"
#import "WL_Application_Driver_Bill_Settlement_Cell.h"
#import "WL_Application_Driver_BillList_Cell.h"


#import "WL_Application_Driver_BillList_Model.h"
#import "WL_Application_Driver_Bill_Model.h"
#import "WL_Application_Driver_Bill_Month_Model.h"
#import "WL_Application_Driver_Bill_Company_Model.h"
#import "WL_Application_Driver_Bill_CompanyMessage_Model.h"

#import "WL_Application_Driver_Bill_TableHeaderView.h"
#import "WL_Application_Driver_Bill_Statistics_ViewController.h"
//#import "WL_Application_Driver_Order_AcceptOrderDetail_ViewController.h"

#import "WLNetworkDriverHandler.h"
#import "WLDriverOrderObject.h"
#import "WL_Application_Driver_OrderDetailBottomView.h"
#import "WL_Application_Driver_OrderDetail_ViewController.h"

#import "WLApplicationDriverBookOrderDetailViewController.h"

@interface WL_Application_Driver_Bill_ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, weak) WL_Application_Driver_Bill_NavTitle_View *navTitleView;

/** 弹框 */
@property(nonatomic, strong) WL_TipAlert_View *alert;

/***
 结算中数组
 **/
@property (nonatomic, strong) NSMutableArray * settlementArr;

/** 设置账单界面按照时间排序的TableView */
@property(nonatomic, weak) UITableView *sortWithTimeTableView;

/** 订单状态 1结算中 2已结清 （默认已结清） */
@property(nonatomic, assign) int status;
/** 排序方式1:按时间 2:按车队 （默认按时间） */
@property(nonatomic, assign) int order;
/** 底部选择View */
@property(nonatomic, weak) WL_Application_Driver_Bill_Bottom_View *orientationView;

/** 列表中每组的表头View */
@property(nonatomic, weak) WL_Application_Driver_Bill_TableHeaderView *titleView;

/** 是否展开 */
@property (nonatomic, strong)NSMutableArray<NSNumber *> *isExpland;//是否展开

/** 无网络的View */
@property (nonatomic, strong) WL_NoData_View *noDataView;
@end

@implementation WL_Application_Driver_Bill_ViewController

#pragma mark - lazy

- (NSMutableArray *)settlementArr
{
    if (!_settlementArr) {
        _settlementArr = [NSMutableArray array];
    }
    
    return _settlementArr;
}

- (NSMutableArray<NSNumber *> *)isExpland
{
    if (!_isExpland) {
        _isExpland = [NSMutableArray array];
    }
    return _isExpland;
}

- (WL_NoData_View *)noDataView
{
    if (_noDataView == nil) {
        
                WS(weakSelf);
        
        _noDataView = [[WL_NoData_View alloc] initWithFrame:self.view.frame andRefreshBlock:^{
            
            [weakSelf sendRequestToBillListWithStatus:self.status order:self.order];
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
    
    //初始化数据
    [self initData];
    
    //设置View内容
    [self setupContentViewToBill];
    //发送网络请求账单列表
    [self sendRequestToBillListWithStatus:self.status order:self.order];
    //注册弹框
    [self creatTipAlertView];
     [self.view addSubview:self.noDataView];
    
}

#pragma mark - 初始化数据
- (void)initData
{
    //订单状态
    self.status = 1;
    //排序方式
    self.order = 1;

}

#pragma mark - 注册弹框
- (void)creatTipAlertView
{
    self.alert = [WL_TipAlert_View sharedAlert];
    
}

#pragma mark - 发送网络请求账单列表
- (void)sendRequestToBillListWithStatus:(int)status order:(int)order
{
    //显示菊花
    [self showHud];

    [[WLNetworkDriverHandler sharedInstance] requestDriverBillListWithType:[NSString stringWithFormat:@"%d",status] dataBlock:^(WLResponseType responseType, id data, NSString *message) {
        
        self.navTitleView.hidden = NO;
        
        if (responseType == WLResponseTypeSuccess) {
            self.navTitleView.hidden = YES;
            
            _settlementArr = data;
            
            for (int i = 0; i < _settlementArr.count; i++)
            {
                if(i == 0)
                {
                    [self.isExpland addObject:@1];
                }
                else
                {
                    [self.isExpland addObject:@0];
                }
            }
            
            if (_settlementArr.count == 0) {
                WL_NoData_View *view = [[WL_NoData_View alloc] initWithFrame:CGRectMake(0, ScaleH(60), ScreenWidth, ScreenHeight) andRefreshBlock:nil];
                view.type = WLNetworkTypeNOData;
                [self.view addSubview:view];
                self.noDataView = view;
            }
            else
            {
                self.noDataView.hidden = YES;
            }
            
            self.sortWithTimeTableView.hidden = NO;
            [self.sortWithTimeTableView reloadData];
        }
        else if (responseType == WLResponseTypeNoNetwork) {
            [self.alert createTip:@"无网络,请稍后重试"];
        }
        else if (responseType == WLResponseTypeServerError) {
            [self.alert createTip:@"服务器错误,请稍后重试"];
        }
        //隐藏菊花
        [self hidHud];
        
    }];
}


#pragma mark - 设置内容View
static NSString *const BillCellId = @"billCellId";
- (void)setupContentViewToBill
{
    self.view.backgroundColor = BgViewColor;
    
    self.title = @"账单";
    [self setNavigationRightTitle:@"统计" fontSize:15.0 titleColor:[WLTools stringToColor:@"#00cc99"] isEnable:YES];
    //self.view.backgroundColor = [WLTools stringToColor:@"#e4e4e4"];
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, ScaleH(60))];
    topView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    [self.view addSubview:topView];
    
    //设置中间选择器
    NSArray *items = @[ @"结算中",@"已结清"];
    UISegmentedControl *orderSegmented = [[UISegmentedControl alloc]initWithItems:items];
    [orderSegmented setSelectedSegmentIndex:0];
    [orderSegmented setTintColor:[WLTools stringToColor:@"#333333"]];
    
    [topView addSubview:orderSegmented];
    [orderSegmented mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView).offset(80);
        make.right.equalTo(topView).offset(-80);
        make.centerY.equalTo(topView);
    }];
    
    [orderSegmented addTarget:self action:@selector(didClicksegmentedControlAction:)forControlEvents:UIControlEventValueChanged];

    //2.设置中间的TableView
    UITableView *sortWithTimeTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    //添加到父控件
    [self.view addSubview:sortWithTimeTableView];
    sortWithTimeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //添加约束
    [sortWithTimeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    sortWithTimeTableView.backgroundColor = BgViewColor;
    sortWithTimeTableView.showsVerticalScrollIndicator = NO;
    //注册cell
    [sortWithTimeTableView registerClass:[WL_Application_Driver_BillList_Cell class] forCellReuseIdentifier:BillCellId];
    
    //设置tableView的代理与数据源为控制器本身
    sortWithTimeTableView.delegate = self;
    sortWithTimeTableView.dataSource = self;
    self.sortWithTimeTableView = sortWithTimeTableView;
    sortWithTimeTableView.hidden = YES;

}

#pragma mark - 切换订单状态的点击事件
- (void)didClicksegmentedControlAction:(UISegmentedControl *)orderSegmented
{
    NSInteger selectIndex = orderSegmented.selectedSegmentIndex;
    
    switch (selectIndex) {
        case 0:
            //发送结算中数据请求
            self.status = 1;
            [self sendRequestToBillListWithStatus:self.status order:self.order];
            break;
        case 1:
            //发送已结清数据请求
            self.status = 2;
            [self sendRequestToBillListWithStatus:self.status order:self.order];
            break;

        default:
            break;
    }
}

#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.settlementArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    WLDriverBillListObject *dataModel = self.settlementArr[section];
    
    if ([self.isExpland[section] boolValue])
    {
        return dataModel.items.count;
    }
    else
    {
        return 0;
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WL_Application_Driver_BillList_Cell *cell = [WL_Application_Driver_BillList_Cell cellCreateTableView:tableView];
    
    WLDriverBillListObject *dataModell = self.settlementArr[indexPath.section];
    WLDriverBillItemObject *monthModel = dataModell.items[indexPath.row];
    
    [cell setCellModel:monthModel stauts:self.status];
    
//    switch (self.status) {
//        case 2:
//            cell.nonPayLable.hidden = YES;
//            cell.nonPayTitleLable.hidden = YES;
//            break;
//            
//        default:
//            cell.nonPayLable.hidden = NO;
//            cell.nonPayTitleLable.hidden = NO;
//            break;
//    }


    return cell;
}

#pragma mark - UITableViewDelegate
/** 点击方法 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLDriverBillListObject *dataModell = self.settlementArr[indexPath.section];
    WLDriverBillItemObject *monthModel = dataModell.items[indexPath.row];
    
    if (monthModel.order_type == 2) {
        //跳到订单详情页
        WLApplicationDriverBookOrderDetailViewController *bookVC = [[WLApplicationDriverBookOrderDetailViewController alloc]init];
//        bookVC.bookStatus = WLOrderStatusFinish;//WLOrderDetailFinished;
        bookVC.orderID = monthModel.orderID;
        bookVC.company_id = _company_id;
        [self.navigationController pushViewController:bookVC animated:YES];
    }
    else
    {
        [self goDetail:monthModel.orderID];
    }
    
//    //跳转已接单控制器//WL_Application_Driver_OrderDetail_ViewController
//    WL_Application_Driver_Order_AcceptOrderDetail_ViewController *acceptOrderDetailVc = [[WL_Application_Driver_Order_AcceptOrderDetail_ViewController alloc] init];
//    acceptOrderDetailVc.sj_order_id = cell.billModel.sj_order_id;
//    [self.navigationController pushViewController:acceptOrderDetailVc animated:YES];
}

/** 返回cell的高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleH(165);
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 223.0f;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //tableView每个分组的头部视图
    WL_Application_Driver_Bill_TableHeaderView *titleView = [[WL_Application_Driver_Bill_TableHeaderView alloc] init];
    
    WLDriverBillListObject *dataModell = self.settlementArr[section];
    
    titleView.backgroundColor = [WLTools stringToColor:@"#f0f3f8"];
    titleView.indicatorButton.tag = section;
    if ([self.isExpland[section] isEqual: @0])
    {
        titleView.indicatorButton.selected = NO;
    }
    else
    {
        titleView.indicatorButton.selected = YES;
    }
    [titleView.indicatorButton addTarget:self action:@selector(indicatorButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
        //获取当前月份
        NSDate *now = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |   NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
        //当前月份
        NSInteger nowMonth = [dateComponent month];
        //判断月份是否为本月
        if ([dataModell.month integerValue] == nowMonth)
        {
            titleView.titleLable.text = @"本月账单";
        }
        else
        {
            NSString *month = [self figureConvertToSinogramme:[dataModell.month intValue]];
            titleView.titleLable.text = [NSString stringWithFormat:@"%@月账单", month];
        }

    
   //订单结算中
    if (self.status == 1 && self.order == 1)
    {
        titleView.balanceTitleLable.text = @"累计: ";
        titleView.balanceLable.text = dataModell.no_pay;
    }
    else if (self.status == 2 && self.order == 1) //订单已结清
    {
        titleView.balanceTitleLable.text = @"累计: ";
        titleView.balanceLable.text = dataModell.pay;
        
    }

    
    self.titleView = titleView;
    return titleView;
}

//每个与账单titleView上的指示器按钮被点击
- (void)indicatorButtonClick:(UIButton *)button
{
    NSInteger section = button.tag;
    button.selected = !button.selected;
    if (button.selected)
    {
        self.isExpland[section] = @1;

            [self.sortWithTimeTableView reloadData];

    }
    else
    {
        self.isExpland[section] = @0;

        [self.sortWithTimeTableView reloadData];

    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001f;
}

- (void)goDetail:(NSString *)goId
{
    [[WLNetworkDriverHandler sharedInstance] requestOrderDetailWithOrderID:goId dataBlock:^(WLResponseType responseType, id data, NSString *message) {
        if (responseType == WLResponseTypeSuccess) {
            WLOrderDetailStatus detailStatus;
            if (self.status == 1) {
                detailStatus = WLOrderDetailSettlement;//结算中
            }
            else if(self.status == 2)
            {
                detailStatus = WLOrderDetailFinished;//已结算
            }
            
            [self jumpToOrderDetailViewControllerWithStatus:WLOrderDetailSettlement andOrderDetailData:data];
        }
    }];
}

#pragma mark - 抽取跳转到订单详情页面的方法
- (void)jumpToOrderDetailViewControllerWithStatus:(WLOrderDetailStatus)status andOrderDetailData:(WLDriverOrderObject *)orderDetailData
{
    WL_Application_Driver_OrderDetail_ViewController *orderDetailViewController = [[ WL_Application_Driver_OrderDetail_ViewController alloc]init];
    orderDetailViewController.orderDetailStatus = status;
    orderDetailViewController.orderDetailData = orderDetailData;
    if (status == WLOrderDetailSettlement ||status == WLOrderDetailFinished) {
        orderDetailViewController.orderDetailSectionArray = @[
                                                              @{@"iconImage":@"chuxing",@"listLabel":@"出行信息"},
                                                              @{@"iconImage":@"dingdanlaiyuan",@"listLabel":@"支付信息"},
                                                              @{@"iconImage":@"dingdanlaiyuan",@"listLabel":@"订单来源"},
                                                              @{@"iconImage":@"beihzu",@"listLabel":@"备注信息"},
                                                              ];
    }else
    {
        orderDetailViewController.orderDetailSectionArray = @[
                                                              @{@"iconImage":@"chuxing",@"listLabel":@"出行信息"},
                                                              @{@"iconImage":@"dingdanlaiyuan",@"listLabel":@"订单来源"},
                                                              @{@"iconImage":@"beizhu",@"listLabel":@"备注信息"},
                                                              ];
    }
    [self.navigationController pushViewController:orderDetailViewController animated:YES];
}

#pragma mark - 右侧点击方法
- (void)NavigationRightEvent
{
    //跳转账单统计控制器
    WL_Application_Driver_Bill_Statistics_ViewController *billStatistics = [[WL_Application_Driver_Bill_Statistics_ViewController alloc] init];
    billStatistics.title = @"账单统计";
    [self.navigationController pushViewController:billStatistics animated:YES];
}

#pragma mark - (1-12)月份数字转字符串
- (NSString *)figureConvertToSinogramme:(int)number
{
    NSString *Singoramme;
    
    switch (number) {
        case 1:
                Singoramme = @"一";
                break;
        case 2:
                Singoramme = @"二";
                break;
        case 3:
                Singoramme = @"三";
                break;
        case 4:
                Singoramme = @"四";
                break;
        case 5:
                Singoramme = @"五";
                break;
        case 6:
                Singoramme = @"六";
                break;
        case 7:
                Singoramme = @"七";
                break;
        case 8:
                Singoramme = @"八";
                break;
        case 9:
                Singoramme = @"九";
                break;
        case 10:
                Singoramme = @"十";
                break;
        case 11:
                Singoramme = @"十一";
                break;
        case 12:
                Singoramme = @"十二";
                break;
        default:
            break;
    }
    
    return Singoramme;
}

@end
