//
//  WLFiltrateViewController.m
//  WeiLvDJS
//
//  Created by hsliang on 2016/12/29.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLFiltrateViewController.h"
#import "WLTradeRecordCell.h"
#import "WLTradeRecordDetailController.h"


@interface WLFiltrateViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *objectArray;
@property (nonatomic, strong) WL_NoData_View *noDataView;

@end

@implementation WLFiltrateViewController

- (NSMutableArray *)objectArray
{
    if (!_objectArray) {
        _objectArray = [NSMutableArray array];
    }
    return _objectArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavTitle];
    [self setUI];
    [self loadData];
}

- (void)setNavTitle
{
    NSString *title = @"充值";
    if (self.recordType == WLTradeRecordTypeDeposit) {
        title = @"提现";
    }else if(self.recordType == WLTradeRecordTypeGrabOrderPay){
        title = @"车费结算";
    }
    self.titleItem.title = title;
}

- (void)setUI
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, ScreenWidth, ScreenHeight - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = BgViewColor;
    [self.view addSubview:self.tableView];
}

- (void)loadData{
    WS(weakSelf);
    [WLNetworkAccountHandler requestTradeRecordListWithTradeType:self.recordType resultBlock:^(WLResponseType responseType, id data, NSString *message) {
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.objectArray.count;

}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLTradeRecordCell *cell = [WLTradeRecordCell cellWithTableView:tableView];
    cell.object = self.objectArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleH(65);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLTradeRecordDetailController *detailVC = [[WLTradeRecordDetailController alloc] init];
    detailVC.object = self.objectArray[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}


@end
