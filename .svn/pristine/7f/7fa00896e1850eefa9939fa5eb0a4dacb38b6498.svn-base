//
//  WLCarPayFrozenListController.m
//  WeiLvDJS
//
//  Created by ternence on 2017/2/24.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLCarPayFrozenListController.h"
#import "WLCarFrozenCell.h"
#import "WLNetworkAccountHandler.h"

@interface WLCarPayFrozenListController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *objectArray;
@property (nonatomic, strong) WL_NoData_View *noDataView;

@end

@implementation WLCarPayFrozenListController

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
    self.titleItem.title = @"车费结算";
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 65, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
    _tableView .delegate= self;
    _tableView.dataSource =self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView =[UIView new];
    [self.view addSubview:_tableView];
}

- (void)setupNoticeView
{
    UIView *noticeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    noticeView.backgroundColor = HEXCOLOR(0xfff3b8);
    UILabel *noticeLabel = [UILabel labelWithText:@"提示:行程结束3天后，金额将自动解冻" textColor:HEXCOLOR(0xfb8200) fontSize:13];
    noticeLabel.frame = CGRectMake(ScaleW(12), 0, ScreenWidth - 50, 30);
    [noticeView addSubview:noticeLabel];
    
    UIButton *closeBtn = [[UIButton alloc] init];
    [closeBtn setImage:[UIImage imageNamed:@"Driver_Order_Close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeNoticeView) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.frame = CGRectMake(ScreenWidth - 30, 2, 25, 25);
    [noticeView addSubview:closeBtn];
    
    self.tableView.tableHeaderView = noticeView;
}

- (void)closeNoticeView
{
    self.tableView.tableHeaderView = nil;
}

- (void)loadData{
    
    [self showHud];
    WS(weakSelf);
    [WLNetworkAccountHandler requestFrozenListWithResultBlock:^(WLResponseType responseType, id data, NSString *message) {
        [weakSelf hidHud];
        [[WL_TipAlert_View sharedAlert] createTip:message];
        if (responseType == WLResponseTypeSuccess) {
            weakSelf.objectArray = data;
            [weakSelf.tableView reloadData];
            if (weakSelf.objectArray.count) {
                [weakSelf removeNoDataView];
                [weakSelf setupNoticeView];
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
    WLCarFrozenCell *cell = [WLCarFrozenCell cellWithTableView:tableView];
    cell.object = self.objectArray[indexPath.section];
    return cell;
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLCarFrozenListObject *object = self.objectArray[indexPath.section];
    if (object.trade_status.integerValue == 5) {
        return ScaleH(160) + ScaleH(32) * 3;
    }
    return ScaleH(160) + ScaleH(32) * 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *marginView = [[UIView alloc] init];
    marginView.backgroundColor = bordColor;
    return marginView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ScaleH(5);
}

- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
