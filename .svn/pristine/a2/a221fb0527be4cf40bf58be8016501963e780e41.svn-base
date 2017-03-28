//
//  WLTradeRecordDetailController.m
//  WeiLvDJS
//
//  Created by ternence on 16/12/14.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLTradeRecordDetailController.h"
#import "WLTradeRecordDetailCell.h"
#import "WLNetworkAccountHandler.h"
#import "WLTradeRecordDetailObject.h"

@interface WLTradeRecordDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WLTradeRecordDetailObject *detailObject;

@end

@implementation WLTradeRecordDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self loadData];
}

- (void)setupUI
{
    self.titleItem.title = @"账单详情";
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 65, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
    _tableView .delegate= self;
    _tableView.dataSource =self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView =[UIView new];
    [self.view addSubview:_tableView];
    
}

- (void)loadData{
    WS(weakSelf);
    [WLNetworkAccountHandler requestTradeRecordDetailWithTradeType:self.object.trade_type.integerValue tradeID:self.object.tradeID resultBlock:^(WLResponseType responseType, id data, NSString *message) {
        
        if (responseType == WLResponseTypeSuccess) {

            weakSelf.detailObject = data;
            [weakSelf.tableView reloadData];
            
        }
    }];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLTradeRecordDetailCell *cell = [WLTradeRecordDetailCell cellWithTableView:tableView];
    cell.detailObject = self.detailObject;
    return cell;
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleH(160) + self.detailObject.bottomArray.count / 2 * ScaleH(32);
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
