//
//  WL_TradeRecord_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/18.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_TradeRecord_ViewController.h"
#import "WL_TradeRecord_Model.h"
#import "WLTradeRecordDetailController.h"
#import "WLTradeRecordCell.h"
#import "WLTradeRecordSectionHeader.h"
#import "WLNetworkAccountHandler.h"
#import "WLFiltrateView.h"
#import "WLFiltrateViewController.h"
#import "WLTradeRecordListObject.h"

@interface WL_TradeRecord_ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)WL_NoData_View *noDataView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) WLFiltrateView * chooseView;

@end

@implementation WL_TradeRecord_ViewController
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupUI];
    [self loadData];
}

- (void)setupUI
{
    self.titleItem.title = @"账单列表";
    self.titleItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(personUpdate)];
    
    NSMutableDictionary *PersonAttrs = [NSMutableDictionary dictionary];
    PersonAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    PersonAttrs[NSForegroundColorAttributeName] = [WLTools stringToColor:@"#00cc99"];
    [self.titleItem.rightBarButtonItem setTitleTextAttributes:PersonAttrs forState:UIControlStateNormal];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, ScreenWidth, ScreenHeight - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = BgViewColor;
    [self.view addSubview:self.tableView];
    
    _chooseView = [[WLFiltrateView alloc] initWithFrame:CGRectMake(ScreenWidth - ScaleW(90), 65, ScaleW(90), ScaleH(100)) textArray:[NSArray arrayWithObjects:@"充值",@"提现",@"车费结算", nil] selectAction:^(NSUInteger index) {
        
        WLFiltrateViewController *chooseVC = [[WLFiltrateViewController alloc] init];
        
        if (index == 0) {
            chooseVC.recordType = WLTradeRecordTypeRecharge;
        }else if(index == 1){
            chooseVC.recordType = WLTradeRecordTypeDeposit;
        }else if(index == 2){
            chooseVC.recordType = WLTradeRecordTypeGrabOrderPay;
        }
        _chooseView.hidden = YES;
        [self.navigationController pushViewController:chooseVC animated:YES];
    }];
    [self.view addSubview:_chooseView];
    _chooseView.hidden = YES;
}

- (void)personUpdate
{
    if (_chooseView.hidden) {
        _chooseView.hidden = NO;
    }else{
        _chooseView.hidden = YES;
    }
    [self.view bringSubviewToFront:_chooseView];
}

- (void)loadData{
    
    __weak __typeof__(self) weakSelf = self;

    [WLNetworkAccountHandler requestTradeRecordListWithResultBlock:^(WLResponseType responseType, id data, NSString *message) {
        if (responseType == WLResponseTypeSuccess) {
            weakSelf.dataArray = data;
            weakSelf.chooseView.hidden = YES;
            if (weakSelf.dataArray.count) {
                [weakSelf removeNoDataView];
                [weakSelf.tableView reloadData];
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


#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    WLTradeRecordListObject *object = self.dataArray[section];
    return object.items.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLTradeRecordCell *cell = [WLTradeRecordCell cellWithTableView:tableView];
    WLTradeRecordListObject *object = self.dataArray[indexPath.section];
    if (object.items > 0) {
        cell.object = object.items[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleH(65);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _chooseView.hidden = YES;
    WLTradeRecordListObject *listObject = self.dataArray[indexPath.section];
    WLTradeRecordDetailController *detailVC = [[WLTradeRecordDetailController alloc] init];
    detailVC.object = listObject.items[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];

    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    WLTradeRecordSectionHeader *header = [[WLTradeRecordSectionHeader alloc] init];
    header.object = self.dataArray[section];
    return header;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ScaleH(35);
}

- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
