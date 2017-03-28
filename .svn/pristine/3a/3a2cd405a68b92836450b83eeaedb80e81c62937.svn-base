//
//  WLBillListViewController.m
//  WeiLvDJS
//
//  Created by ternence on 16/11/15.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLBillListViewController.h"
#import "WLNetworkManager.h"
#import "WLHotelSearchView.h"
#import "WLHotelOrderInfo.h"
#import "WLHotelBillListInfo.h"
#import "WLHotelBillListCell.h"
#import "WLHotelBillHeaderView.h"
#import "WLHotelBillDetailController.h"

@interface WLBillListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) WLHotelSearchView *searchView;
@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, strong) UIView *noDataView;

@end

@implementation WLBillListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavigationBar];
    [self setupUI];
    [self loadData];
}

- (void)setupNavigationBar
{
    self.title = @"账单";
    
}

- (void)setupUI
{
    self.view.backgroundColor = BgViewColor;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = HEXCOLOR(0xeff1fe);
    [self.view addSubview:self.tableView];
}

- (void)setupRefreshFooter
{
    __weak __typeof__(self) weakSelf = self;
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
    self.tableView.mj_footer = footer;
    [footer setTitle:@"上拉或点击加载更多数据" forState:MJRefreshStateIdle];
    [footer setTitle:@"松开马上加载更多数据了" forState:MJRefreshStateRefreshing];
}

- (void)removeRefreshFooter
{
    self.tableView.mj_footer = nil;
}

- (void)loadData{

    __weak __typeof__(self) weakSelf = self;
    [WLNetworkManager requestHotelBillListWithPage:1 result:^(BOOL success, NSArray *listArray, NSUInteger currentPage, NSUInteger totalPage) {
        if (success && listArray.count) {
            [weakSelf removeNoDataView];
            if (totalPage >= 2) {
                [weakSelf setupRefreshFooter];
            }
            weakSelf.dataArray = [listArray mutableCopy];
            [weakSelf.tableView reloadData];
            weakSelf.currentPage = currentPage;
        }else{
            [weakSelf removeRefreshFooter];
            [weakSelf setupNoDataView];
        }
        
    }];

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
        WL_NoData_View *view = [[WL_NoData_View alloc] initWithFrame:self.view.bounds andRefreshBlock:nil];
        view.type = WLNetworkTypeNOData;
        [self.view addSubview:view];
        self.noDataView = view;
    }
}

- (void)loadMoreData{
    
    __weak __typeof__(self) weakSelf = self;
    [WLNetworkManager requestHotelBillListWithPage:(self.currentPage +1) result:^(BOOL success, NSArray *listArray, NSUInteger currentPage, NSUInteger totalPage) {
        if (success && listArray.count) {
            
            weakSelf.currentPage = currentPage;
            [weakSelf.dataArray addObjectsFromArray:listArray];
            [weakSelf.tableView reloadData];
        }
        
    }];
}


#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    WLHotelBillListInfo *info = self.dataArray[section];
    return info.listArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLHotelBillListInfo *info = self.dataArray[indexPath.section];
    BOOL withLine = YES;
    if (indexPath.row == info.listArray.count - 1) {
        withLine = NO;
    }
    WLHotelBillListCell *cell = [WLHotelBillListCell cellWithTableView:tableView withLine:withLine];
    cell.itemInfo = info.listArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleH(90);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLHotelBillListInfo *info = self.dataArray[indexPath.section];
    WLHotelBillDetailController *detailVC = [[WLHotelBillDetailController alloc] init];
    detailVC.itemInfo = info.listArray[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    WLHotelBillListInfo *info = self.dataArray[section];
    WLHotelBillHeaderView *header = [[WLHotelBillHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(45)) textArray:@[info.ymDate, info.totalPrice]];
    return header;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ScaleH(45);
}

@end
