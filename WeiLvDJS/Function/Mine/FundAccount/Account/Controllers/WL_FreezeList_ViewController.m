//
//  WL_FreezeList_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/18.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_FreezeList_ViewController.h"
#import "WL_TradeRecord_Model.h"
#import "WL_AccountHeaderView.h"
#import "WLFundAccountCell.h"
#import "WLDepositingViewController.h"
#import "WLNetworkAccountHandler.h"
#import "WLCarPayFrozenListController.h"

@interface WL_FreezeList_ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)WL_NoData_View *noDataView;
@property (nonatomic, strong) WL_AccountHeaderView *headerView;

@property (nonatomic, strong) NSString *frozenCount;
@property (nonatomic, strong) NSString *depositCount;
@property (nonatomic, strong) NSString *carFrozenCount;
@end

@implementation WL_FreezeList_ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupUI];
    [self initData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)setupUI
{
    self.view.backgroundColor = BgViewColor;
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, -20, ScreenWidth, ScreenHeight + 20) style:UITableViewStylePlain];
    _tableView .delegate= self;
    _tableView.dataSource =self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = BgViewColor;
    _tableView.tableFooterView =[UIView new];
    [self.view addSubview:_tableView];
    
    WS(weakSelf);
    self.headerView =[[WL_AccountHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 210)
                                                      headerType:HeaderTypeFrozenPage
                                                          action:^(ActionType type) {
                                                              if (type == ActionTypeBack) {
                                                                  [weakSelf.navigationController popViewControllerAnimated:YES];
                                                              }
                                                          }];
    self.tableView.tableHeaderView = self.headerView;

}

-(void)initData
{
    WS(weakSelf);
    [self showHud];
    [WLNetworkAccountHandler requestFrozenAccountWithResultBlock:^(WLResponseType responseType, NSString *frozenCount, NSString *depositCount,NSString *carFrozenCount, NSString *message) {
        
        [weakSelf hidHud];
        if (responseType == WLResponseTypeSuccess) {
            weakSelf.frozenCount = frozenCount;
            weakSelf.depositCount = depositCount;
            weakSelf.carFrozenCount = carFrozenCount;
            [weakSelf.headerView refreshFrozenCount:frozenCount];
            [weakSelf.tableView reloadData];
        }
        [[WL_TipAlert_View sharedAlert] createTip:message];
    }];
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleH(55);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLFundAccountCell *cell = [WLFundAccountCell cellWithTableView:tableView];
    if (indexPath.row == 0) {
        NSString *count = self.depositCount?self.depositCount:@"0";
        [cell setTitleArray:@[@"提现中", count]];
    }else{
        NSString *count = self.carFrozenCount?self.carFrozenCount:@"0";
        [cell setTitleArray:@[@"车费结算", count]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        WLDepositingViewController *depositVC = [[WLDepositingViewController alloc] init];
        [self.navigationController pushViewController:depositVC animated:YES];
    }else{
        WLCarPayFrozenListController *depositVC = [[WLCarPayFrozenListController alloc] init];
        [self.navigationController pushViewController:depositVC animated:YES];
    }
    
}

@end
