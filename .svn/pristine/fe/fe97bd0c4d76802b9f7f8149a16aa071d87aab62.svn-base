//
//  WLTouristIncomeController.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLTouristIncomeController.h"
#import "WLIncomeCell.h"
#import "WLIncomeHeader.h"
#import "WLMyIncomeListInfo.h"
#import "WLNetworkManager.h"
#import "WLAllGroupHeader.h"
#import "WLTouristStatisticsController.h"
#import "WLAllGroupHeader.h"
#import "WLIncomeHeader.h"
#import "WL_Application_Driver_Bill_Statistics_ViewController.h"
#import "WLBillDetailController.h"

@interface WLTouristIncomeController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL isFinished;
@property (nonatomic, strong) NSMutableArray *isFoldArray;

@property (nonatomic, strong) NSMutableDictionary *dict1;
@property (nonatomic, strong) NSMutableDictionary *dict2;
@property (nonatomic, strong) WL_NoData_View *noDataView;
@end

@implementation WLTouristIncomeController
- (NSMutableArray *)isFoldArray
{
    if (!_isFoldArray) {
        _isFoldArray = [NSMutableArray array];
    }
    return _isFoldArray;
}

- (NSMutableDictionary *)dict1
{
    if (!_dict1) {
        _dict1 = [NSMutableDictionary dictionary];
    }
    return _dict1;
}

- (NSMutableDictionary *)dict2
{
    if (!_dict2) {
        _dict2 = [NSMutableDictionary dictionary];
    }
    return _dict2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    for (int i = 0; i < 40; i ++) {
        NSString *isFold = [NSString stringWithFormat:@"1"];
        if (i == 0) {
            isFold = [NSString stringWithFormat:@"0"];
        }
        [self.isFoldArray addObject:isFold];
    }
    [self setupNavigationBar];
    [self setupUI];
    self.isFinished = YES;
    
}

- (void)setIsFinished:(BOOL)isFinished
{
    _isFinished = isFinished;
    [self loadData];
}

- (void)setupNavigationBar{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"统计" style:UIBarButtonItemStyleDone target:self action:@selector(statisticsBtnDidClicked)];
    self.navigationItem.rightBarButtonItem = item;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont WLFontOfSize:16];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    
    WLAllGroupHeader *titleView = [[WLAllGroupHeader alloc] initWithFrame:CGRectMake(0, 0, ScaleW(150), 44) textArray:@[@"已结账",@"未结账"] selectAction:^(NSUInteger index) {
        self.isFinished = !index;

    }];
    self.navigationItem.titleView = titleView;
    
}

- (void)statisticsBtnDidClicked
{
    WLTouristStatisticsController *statVC = [[WLTouristStatisticsController alloc] init];
    [self.navigationController pushViewController:statVC animated:YES];
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

- (void)loadData{
    
    if (self.isFinished && [self.dict1.allKeys containsObject:@"0"]) {
        [self removeNoDataView];
        [self.tableView reloadData];
        return;
        
    }else if (!self.isFinished && [self.dict2.allKeys containsObject:@"0"]) {

        [self removeNoDataView];
        [self.tableView reloadData];
        return;
    }
    __weak __typeof__(self) weakSelf = self;
    [WLNetworkManager requestMyIncomeListWithSelectMonth:nil isFinished:!self.isFinished result:^(BOOL success, WLMyIncomeListInfo *info) {
        if (success) {
            if (info != nil) {
                [weakSelf removeNoDataView];
                if (weakSelf.isFinished) {
                
                    [weakSelf.dict1 setObject:info forKey:@"0"];
                }else{
                    [weakSelf.dict2 setObject:info forKey:@"0"];
                }
            }else{
                [weakSelf setupNoDataView];
            }
        }
        
        [weakSelf.tableView reloadData];
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

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.isFinished) {
        if ([self.dict1.allKeys containsObject:@"0"]) {
            WLMyIncomeListInfo *firstInfo = [self.dict1 objectForKey:@"0"];
            return firstInfo.incomeList.count;
        }
    }else{
        if ([self.dict2.allKeys containsObject:@"0"]) {
            WLMyIncomeListInfo *firstInfo = [self.dict2 objectForKey:@"0"];
            return firstInfo.incomeList.count;
        }
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BOOL isFold = ((NSString *)self.isFoldArray[section]).boolValue;
    if (isFold) {
        return 0;
    }
    if (self.isFinished) {
        if ([self.dict1.allKeys containsObject:[NSString stringWithFormat:@"%ld",section]]) {
            WLMyIncomeListInfo *firstInfo = [self.dict1 objectForKey:[NSString stringWithFormat:@"%ld",section]];
            return firstInfo.orderList.count;
        }
    }else{
        if ([self.dict2.allKeys containsObject:[NSString stringWithFormat:@"%ld",section]]) {
            WLMyIncomeListInfo *firstInfo = [self.dict2 objectForKey:[NSString stringWithFormat:@"%ld",section]];
            return firstInfo.orderList.count;
        }
    }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLIncomeCell *cell = [WLIncomeCell cellWithTableView:tableView withIndex:indexPath.row];
    if (self.isFinished) {
        if ([self.dict1.allKeys containsObject:[NSString stringWithFormat:@"%ld",indexPath.section]]) {
            WLMyIncomeListInfo *firstInfo = [self.dict1 objectForKey:[NSString stringWithFormat:@"%ld",indexPath.section]];
            cell.orderInfo = firstInfo.orderList[indexPath.row];
        }
    }else{
        if ([self.dict2.allKeys containsObject:[NSString stringWithFormat:@"%ld",indexPath.section]]) {
            WLMyIncomeListInfo *firstInfo = [self.dict2 objectForKey:[NSString stringWithFormat:@"%ld",indexPath.section]];
            cell.orderInfo = firstInfo.orderList[indexPath.row];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return ScaleH(200);
    }
    return ScaleH(215);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLBillDetailController *billVC = [[WLBillDetailController alloc] init];
    NSString *groupID;
    if (self.isFinished) {
        if ([self.dict1.allKeys containsObject:[NSString stringWithFormat:@"%ld",indexPath.section]]) {
            WLMyIncomeListInfo *firstInfo = [self.dict1 objectForKey:[NSString stringWithFormat:@"%ld",indexPath.section]];
            WLOrderListInfo *list = firstInfo.orderList[indexPath.row];
            groupID = list.groupListID;
            
        }
    }else{
        if ([self.dict2.allKeys containsObject:[NSString stringWithFormat:@"%ld",indexPath.section]]) {
            WLMyIncomeListInfo *firstInfo = [self.dict2 objectForKey:[NSString stringWithFormat:@"%ld",indexPath.section]];
            WLOrderListInfo *list = firstInfo.orderList[indexPath.row];
            groupID = list.groupListID;
            
        }
    }
    billVC.groupID = groupID;
    [self.navigationController pushViewController:billVC animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    __weak __typeof__(self) weakSelf = self;
    NSString *leftTitle = @"本月收入";
    NSString *rightTitle = @"1000";
    if (self.isFinished) {
        if ([self.dict1.allKeys containsObject:@"0"]) {
            WLMyIncomeListInfo *firstInfo = [self.dict1 objectForKey:@"0"];
            WLMyIncomeDateInfo *dateInfo = firstInfo.incomeList[section];
            leftTitle = dateInfo.month;
            rightTitle = dateInfo.income;
        }
    }else{
        if ([self.dict2.allKeys containsObject:@"0"]) {
            WLMyIncomeListInfo *firstInfo = [self.dict2 objectForKey:@"0"];
            WLMyIncomeDateInfo *dateInfo = firstInfo.incomeList[section];
            leftTitle = dateInfo.month;
            rightTitle = dateInfo.income;
        }
    }
    WLIncomeHeader *headerView = [[WLIncomeHeader alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(44)) textArray:@[leftTitle,rightTitle] foldAction:^(BOOL isFold) {
        
        [weakSelf.isFoldArray replaceObjectAtIndex:section withObject:[NSString stringWithFormat:@"%d",isFold]];
        [weakSelf.tableView reloadData];
        
        BOOL shouldReloadData = NO;
        if (weakSelf.isFinished) {
            if (![weakSelf.dict1.allKeys containsObject:[NSString stringWithFormat:@"%ld",section]]) {
                
                shouldReloadData = YES;
            }
        }else{
            if (![weakSelf.dict2.allKeys containsObject:[NSString stringWithFormat:@"%ld",section]]) {
                
                shouldReloadData = YES;
            }
        }
        if (section == 0) {
            shouldReloadData = NO;
        }
        if (shouldReloadData) {
            NSString *selectedMonth;
            if (weakSelf.isFinished) {
                WLMyIncomeListInfo *firstInfo = [weakSelf.dict1 objectForKey:@"0"];
                WLMyIncomeDateInfo *dateInfo = firstInfo.incomeList[section];
                selectedMonth = dateInfo.month;
                
            }else{
                WLMyIncomeListInfo *firstInfo = [weakSelf.dict2 objectForKey:@"0"];
                WLMyIncomeDateInfo *dateInfo = firstInfo.incomeList[section];
                selectedMonth = dateInfo.month;
            }
            
            
            [WLNetworkManager requestMyIncomeListWithSelectMonth:selectedMonth isFinished:!weakSelf.isFinished result:^(BOOL success, WLMyIncomeListInfo *info) {
                
                if (success && info != nil) {
                    
                    if (weakSelf.isFinished) {
                        [weakSelf.dict1 setObject:info forKey:[NSString stringWithFormat:@"%ld",section]];
                    }else{
                        [weakSelf.dict2 setObject:info forKey:[NSString stringWithFormat:@"%ld",section]];
                    }
                    [weakSelf.tableView reloadData];
                    
                }
                
            }];
        }else{
            
            [weakSelf.tableView reloadData];
        }
        
    } selected:((NSString *)self.isFoldArray[section]).boolValue];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ScaleH(45);
}

@end
