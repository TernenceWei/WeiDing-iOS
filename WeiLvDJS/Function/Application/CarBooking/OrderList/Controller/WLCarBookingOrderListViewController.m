//
//  WLCarBookingOrderListViewController.m
//  WeiLvDJS
//
//  Created by hsliang on 2017/1/19.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLCarBookingOrderListViewController.h"
#import "WLTopGroupChooseView.h"
#import "WLCarBookingOrderListTableViewCell.h"
#import "WLNetworkCarBookingHandler.h"
#import "WLCarBookingOrderDetailController.h"
#import "WLCarBookingAddCostController.h"
#import "WLBookingCarResultObject.h"
#import "WLCarBookingChooseDriverController.h"

@interface WLCarBookingOrderListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) WLTopGroupChooseView * topChooseView;
@property (nonatomic, strong) WL_NoData_View *noDataView;
@property (nonatomic, strong) UITableView * OrderListTable;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, assign) NSInteger thisStatus;
@property (nonatomic, assign) NSInteger thisPage;
@property (nonatomic, strong) NSString *nextUrl;

@end

@implementation WLCarBookingOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setThisTitle];
    [self createUI];
    [self refresh];
    
    _thisStatus = 1;
    _thisPage = 1;
    _dataArr = [[NSMutableArray alloc] init];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.nextUrl = nil;
    _thisPage = 1;
    [self dataLoad];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)setCompanyID:(NSString *)companyID
{
    _companyID = companyID;
}

- (void)setThisTitle
{
    self.title = @"我的订单";
}

- (void)createUI
{
    _topChooseView = [[WLTopGroupChooseView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(40)) textArray:@[@"待处理",@"行程中",@"已完成",@"已关闭"] selectAction:^(NSUInteger index) {
        _thisPage = 1;
        _nextUrl = nil;
        _thisStatus = index + 1;
        [_OrderListTable.mj_footer resetNoMoreData];
        [self dataLoad];
    }];
    [self.view addSubview:_topChooseView];
    
    _OrderListTable = [[UITableView alloc] initWithFrame:CGRectMake(0, _topChooseView.frame.origin.y + _topChooseView.frame.size.height, ScreenWidth, ScreenHeight - _topChooseView.frame.origin.y - _topChooseView.frame.size.height - ScaleH(64)) style:UITableViewStylePlain];
    _OrderListTable.delegate = self;
    _OrderListTable.dataSource = self;
    _OrderListTable.backgroundColor = [WLTools stringToColor:@"#e4e4e4"];
    _OrderListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_OrderListTable];
}

- (void)dataLoad
{
    WS(weakSelf);
    [self showHud];
    [WLNetworkCarBookingHandler CarbookingOrderListWithType:[NSString stringWithFormat:@"%ld",(long)_thisStatus] companyID:self.companyID nextUrl:self.nextUrl dataBlock:^(WLResponseType responseType, id data, NSString *nextUrl, NSString *message) {

        [self hidHud];
        if (responseType == WLResponseTypeSuccess) {
            
            if (weakSelf.thisPage == 1) {//第一次刷新
                [_dataArr removeAllObjects];
            }
            [_dataArr addObjectsFromArray:data];
            if (_dataArr.count == 0) {
                [weakSelf setupNoDataView];
            }else{
                [weakSelf removeNoDataView];
            }
            weakSelf.nextUrl = nextUrl;
            [_OrderListTable.mj_footer endRefreshing];
            [_OrderListTable.mj_header endRefreshing];
            
        }else if (responseType == WLResponseTypeNoMoreData){
            
            if (weakSelf.thisPage == 1) {//第一次刷新
                [_dataArr removeAllObjects];
            }
            [_dataArr addObjectsFromArray:data];
            if (_dataArr.count == 0) {
                [weakSelf setupNoDataView];
            }else{
                [weakSelf removeNoDataView];
            }
            weakSelf.nextUrl = nextUrl;
            
            [_OrderListTable.mj_header endRefreshing];
            [weakSelf.OrderListTable.mj_footer endRefreshingWithNoMoreData];
            
        }else{
            
            [weakSelf setupNoDataView];
            [[WL_TipAlert_View sharedAlert] createTip:message];
            [_OrderListTable.mj_footer endRefreshing];
            [_OrderListTable.mj_header endRefreshing];
        }
        [_OrderListTable reloadData];
        
    }];
}

-(void)refresh{
    //注册下拉刷新
    //WS(weakSelf);
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _thisPage = 1;
        _nextUrl = nil;
        [self dataLoad];
    }];
    _OrderListTable.mj_header = header;
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
    
    
    MJRefreshAutoNormalFooter *footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _thisPage ++;
        [self dataLoad];
        
    }];
    _OrderListTable.mj_footer = footer;
    [footer setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [footer setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多数据啦" forState:MJRefreshStateNoMoreData];
    
}

- (void)removeNoDataView{
    if (self.noDataView) {
        [self.noDataView removeFromSuperview];
        self.noDataView = nil;
    }
    
}

- (void)setupNoDataView
{
    if (!self.noDataView) {
        WL_NoData_View *view = [[WL_NoData_View alloc] initWithFrame:CGRectMake(0, ScaleH(41), ScreenWidth, ScreenHeight) andRefreshBlock:nil];
        view.type = WLNetworkTypeNOData;
        [self.view addSubview:view];
        self.noDataView = view;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLCarBookingOrderListTableViewCell * cell = [WLCarBookingOrderListTableViewCell cellcreateTableView:tableView];
    WLCarBookingOrderListObject * model = _dataArr[indexPath.row];
    [cell setCellModel:model status:_thisStatus];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLCarBookingOrderListObject * model = _dataArr[indexPath.row];
    if ([model.via_address isEqual:@""]) {
        
        return ScaleH(180);
    }else{
        if ((model.reception_status == 1) && (model.pay_status == 0) && _thisStatus == 1) {
            return ScaleH(220);
        }
        
        return ScaleH(210);
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLCarBookingOrderListObject * model = _dataArr[indexPath.row];
    
    if (model.reception_status == 0) {//待接单
        [self iSBidCount:model];
    }else if (model.reception_status == 1){//已接单
        
        WLCarBookingOrderDetailController *detailVC = [[WLCarBookingOrderDetailController alloc] init];
        detailVC.orderID = model.thisid;
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
        
    }else{//已取消
        
        WLCarBookingOrderDetailController *detailVC = [[WLCarBookingOrderDetailController alloc] init];
        detailVC.orderID = model.thisid;
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

- (void)iSBidCount:(WLCarBookingOrderListObject *)thismodel
{
    [self showHud];
    [WLNetworkCarBookingHandler someDriversHadBidPriceWithOrderID:thismodel.thisid resultBlock:^(BOOL success, BOOL result, NSString *message) {
        [self hidHud];
        if (success) {
            if (result) {//已有报价
                WLCarBookingChooseDriverController *detailVC = [[WLCarBookingChooseDriverController alloc] init];
                detailVC.orderID = thismodel.thisid;
                detailVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:detailVC animated:YES];
            }
            else//无报价
            {
                WLCarBookingAddCostController *detailVC = [[WLCarBookingAddCostController alloc] init];
                WLBookingCarResultObject *object = [[WLBookingCarResultObject alloc] init];
                object.orderID = thismodel.thisid;
                object.driverCount = thismodel.notice_count;
                object.nowTime = thismodel.created_at;
                object.orderPice = thismodel.order_price;
                object.fromList = YES;
                detailVC.object = object;
                detailVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:detailVC animated:YES];
            }
        }
        else
        {
            [[WL_TipAlert_View sharedAlert] createTip:message];
        }
    }];
}

@end
