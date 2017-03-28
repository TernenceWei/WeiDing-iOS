//
//  WLDepositingViewController.m
//  WeiLvDJS
//
//  Created by ternence on 2016/12/18.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLDepositingViewController.h"
#import "WLDepositingCell.h"
#import "WLNetworkAccountHandler.h"

@interface WLDepositingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *objectArray;
@property (nonatomic, strong) WL_NoData_View *noDataView;

@end

@implementation WLDepositingViewController

- (NSMutableArray *)objectArray
{
    if (!_objectArray) {
        _objectArray = [NSMutableArray array];
    }
    return _objectArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self loadData];
}

- (void)setupUI
{
    self.titleItem.title = @"提现账单";
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 65, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
    _tableView .delegate= self;
    _tableView.dataSource =self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView =[UIView new];
    [self.view addSubview:_tableView];
    
}

- (void)loadData{
    
    [self showHud];
    WS(weakSelf);
    [WLNetworkAccountHandler requestDepositingListWithDepositingStatus:WLDepositingStatusDefault resultBlock:^(WLResponseType responseType, id data, NSString *message) {
        [weakSelf hidHud];
        [[WL_TipAlert_View sharedAlert] createTip:message];
        if (responseType == WLResponseTypeSuccess) {
            weakSelf.objectArray = data;
            [weakSelf.tableView reloadData];
            if (weakSelf.objectArray.count) {
                [weakSelf removeNoDataView];
            }else{
                [weakSelf setupNoDataView];
            }
        }else{
            [weakSelf setupNoDataView];
        }
    }];
}

- (void)setupNoDataView
{
    if (_noDataView == nil) {
        WS(weakSelf);
        _noDataView = [[WL_NoData_View alloc] initWithFrame:CGRectMake(0, 65, ScreenWidth, ScreenHeight - 64) andRefreshBlock:^{
            [weakSelf loadData];
        }];
        _noDataView.type = WLNetworkTypeNOData;
        [self.view addSubview:_noDataView];
    }
}

- (void)removeNoDataView {
    
    if (self.noDataView) {
        [self.noDataView removeFromSuperview];
        self.noDataView = nil;
    }
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.objectArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLDepositingCell *cell = [WLDepositingCell cellWithTableView:tableView];
    cell.object = self.objectArray[indexPath.section];
    return cell;
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleH(320);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *marginView = [[UIView alloc] init];
    marginView.backgroundColor = bordColor;
    return marginView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ScaleH(10);
}

- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
