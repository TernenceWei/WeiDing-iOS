//
//  WLAllGroupController.m
//  WeiLvDJS
//
//  Created by ternence on 16/9/30.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLAllGroupController.h"
#import "WLGroupCell.h"
#import "WLAllGroupHeader.h"
#import "WLNetworkManager.h"
#import "WLOrderListInfo.h"
#import "WLBillDetailController.h"
#import "WLCurrentGroupController.h"


@interface WLAllGroupController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WLAllGroupHeader *headerView;
@property (nonatomic, assign) GroupStatus status;

@property (nonatomic, strong) NSMutableArray *firstArray;
@property (nonatomic, strong) NSMutableArray *secondArray;
@property (nonatomic, strong) NSMutableArray *thirdArray;
@property (nonatomic, strong) NSMutableArray *fourthArray;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *pageArray;
@property (nonatomic, strong) WL_NoData_View *noDataView;
@end

@implementation WLAllGroupController

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)firstArray
{
    if (!_firstArray) {
        _firstArray = [NSMutableArray array];
    }
    return _firstArray;
}

- (NSMutableArray *)secondArray
{
    if (!_secondArray) {
        _secondArray = [NSMutableArray array];
    }
    return _secondArray;
}

- (NSMutableArray *)thirdArray
{
    if (!_thirdArray) {
        _thirdArray = [NSMutableArray array];
    }
    return _thirdArray;
}

- (NSMutableArray *)fourthArray
{
    if (!_fourthArray) {
        _fourthArray = [NSMutableArray array];
    }
    return _fourthArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"所有出团";
    self.view.backgroundColor = BgViewColor;
    
    [self setupUI];
    self.pageArray = [@[@"2",@"2",@"2",@"2"] mutableCopy];
    self.status = GroupStatusAll;
    
    
}

- (void)setStatus:(GroupStatus)status
{
    _status = status;
    [self loadData];
}

- (void)setupUI
{
    self.headerView = [[WLAllGroupHeader alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(45))
                                                    textArray:@[@"全部",@"未出团",@"未报账",@"未结账"]
                                                 selectAction:^(NSUInteger index) {
        if (index == 0) {
            self.status = GroupStatusAll;
        }else if(index == 1){
            self.status = GroupStatusUnChuTuan;
        }else if(index == 2){
            self.status = GroupStatusUnBaoZhang;
        }else if(index == 3){
            self.status = GroupStatusUnJieZhang;
        }
    }];
    [self.view addSubview:self.headerView];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame), ScreenWidth, ScreenHeight - 44 - 64)];
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
    footer.stateLabel.textColor = HEXCOLOR(0x868686);
}

- (void)removeRefreshFooter
{
    self.tableView.mj_footer = nil;
}

- (void)loadMoreData
{
    [WLNetworkManager requestOrderListOrGroupListWithType:GroupOrderTypeGroup miniType:self.status page:[self getPageCount] result:^(BOOL success, NSArray *listArray) {
        if (success) {
            switch (self.status) {
                case GroupStatusAll:
                    [self.firstArray addObjectsFromArray:listArray];
                    self.dataSource = self.firstArray;
                    break;
                case GroupStatusUnChuTuan:
                    [self.secondArray addObjectsFromArray:listArray];
                    self.dataSource = self.secondArray;
                    break;
                case GroupStatusUnBaoZhang:
                    [self.thirdArray addObjectsFromArray:listArray];
                    self.dataSource = self.thirdArray;
                    break;
                case GroupStatusUnJieZhang:
                    [self.fourthArray addObjectsFromArray:listArray];
                    self.dataSource = self.fourthArray;
                    break;
                default:
                    break;
            }
            
            [self.tableView reloadData];
        }
        
    }];

}


- (void)loadData{
    
    if (self.status == GroupStatusAll && self.firstArray.count) {
        self.dataSource = self.firstArray;
        [self setupRefreshFooter];
        [self removeNoDataView];
        [self.tableView reloadData];
        return;
     
    }else if (self.status == GroupStatusUnChuTuan && self.secondArray.count) {
        self.dataSource = self.secondArray;
        [self setupRefreshFooter];
        [self removeNoDataView];
        [self.tableView reloadData];
        return;
       
    }else if (self.status == GroupStatusUnBaoZhang && self.thirdArray.count) {
        self.dataSource = self.thirdArray;
        [self setupRefreshFooter];
        [self removeNoDataView];
        [self.tableView reloadData];
        return;
        
    }else if (self.status == GroupStatusUnJieZhang && self.fourthArray.count) {
        self.dataSource = self.fourthArray;
        [self setupRefreshFooter];
        [self removeNoDataView];
        [self.tableView reloadData];
        return;
    }
    [WLNetworkManager requestOrderListOrGroupListWithType:GroupOrderTypeGroup miniType:self.status page:1 result:^(BOOL success, NSArray *listArray) {
        if (success) {
            switch (self.status) {
                case GroupStatusAll:
                    [self.firstArray addObjectsFromArray:listArray];
                    break;
                case GroupStatusUnChuTuan:
                    [self.secondArray addObjectsFromArray:listArray];
                    break;
                case GroupStatusUnBaoZhang:
                    [self.thirdArray addObjectsFromArray:listArray];
                    break;
                case GroupStatusUnJieZhang:
                    [self.fourthArray addObjectsFromArray:listArray];
                    break;
                default:
                    break;
            }
            self.dataSource = [listArray mutableCopy];
            if (listArray.count) {
                [self setupRefreshFooter];
                [self removeNoDataView];
            }else{
                [self removeRefreshFooter];
                [self setupNodataView];
                
            }
            [self.tableView reloadData];
        }
        
    }];
}

- (void)setupNodataView
{
    if (self.noDataView == nil) {
        WL_NoData_View *view = [[WL_NoData_View alloc] initWithFrame:CGRectMake(0, ScaleH(45), ScreenWidth, ScreenHeight - ScaleH(45)) andRefreshBlock:nil];
        view.type = WLNetworkTypeNOData;
        [self.view addSubview:view];
        self.noDataView = view;
    }
}

- (void)removeNoDataView{
 
    if (self.noDataView) {
        [self.noDataView removeFromSuperview];
        self.noDataView = nil;
    }
}

- (NSUInteger)getPageCount
{
    NSUInteger count = 1;
    if (self.status == GroupStatusAll) {
        count = [self.pageArray[0] integerValue];
        [self.pageArray replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%lu",count + 1]];
        
    }if (self.status == GroupStatusUnChuTuan) {
        count = [self.pageArray[1] integerValue];
        [self.pageArray replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%lu",count + 1]];
        
    }if (self.status == GroupStatusUnBaoZhang) {
        count = [self.pageArray[2] integerValue];
        [self.pageArray replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%lu",count + 1]];
        
    }if (self.status == GroupStatusUnJieZhang) {
        count = [self.pageArray[3] integerValue];
        [self.pageArray replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%lu",count + 1]];
        
    }
    return count;
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLGroupCell *cell = [WLGroupCell cellWithTableView:tableView];
    cell.orderInfo = self.dataSource[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleH(218);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLOrderListInfo *info = self.dataSource[indexPath.section];
    if (info.groupListStatus == GroupStatusUnJieZhang || info.groupListStatus == GroupStatusUnBaoZhang) {
        
        WLBillDetailController *groupVC = [[WLBillDetailController alloc] init];
        groupVC.groupID = info.groupListID;
        [self.navigationController pushViewController:groupVC animated:YES];
    }else{
        
        
        WLCurrentGroupController *groupVC = [[WLCurrentGroupController alloc] init];
        [groupVC setupGroupListID: info.groupListID];
        [self.navigationController pushViewController:groupVC animated:YES];
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section != 0) {
        UIView *footerView = [[UIView alloc] init];
        footerView.backgroundColor = HEXCOLOR(0xeff1fe);
        return footerView;
    }
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return ScaleH(15);
}
@end
