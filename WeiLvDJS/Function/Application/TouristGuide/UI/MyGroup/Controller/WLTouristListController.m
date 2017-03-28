//
//  WLTouristListController.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLTouristListController.h"
#import "WLNetworkManager.h"
#import "WLTouristListCell.h"
#import "WLVisitorListInfo.h"
#import "WLTouristInfoController.h"

@interface WLTouristListController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation WLTouristListController

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
}

- (void)setupUI
{
    self.title = @"游客列表";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = HEXCOLOR(0xf7f7f7);
    [self.view addSubview:self.tableView];
}

- (void)loadData{
    
    [WLNetworkManager requestVisitorListWithGroupNO:self.summaryInfo.groupNO result:^(BOOL success, NSArray *visitorList) {
        if (success) {
            self.dataArray = [visitorList mutableCopy];
            [self.tableView reloadData];
        }
    }];
}

- (void)setSummaryInfo:(WLChargeUpSummaryInfo *)summaryInfo
{
    _summaryInfo = summaryInfo;
    [self loadData];
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    WLVisitorListInfo *info = self.dataArray[section];
    return info.list.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLTouristListCell *cell = [WLTouristListCell cellWithTableView:tableView tag:indexPath.row];
    WLVisitorListInfo *info = self.dataArray[indexPath.section];
    cell.cellInfo = info.list[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleH(70);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLTouristInfoController *infoVC = [[WLTouristInfoController alloc] init];
    WLVisitorListInfo *info = self.dataArray[indexPath.section];
    WLVisitorListCellInfo *cellInfo = info.list[indexPath.row];
    infoVC.visitorID = cellInfo.visitorID;
    [self.navigationController pushViewController:infoVC animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    WLVisitorListInfo *info = self.dataArray[section];
    UIView *headerView = [[UIView alloc] init];

    UILabel *leftLabel = [[UILabel alloc] init];
    leftLabel.frame = CGRectMake(ScaleW(15), 0, ScreenWidth / 2, ScaleH(45));
    leftLabel.textColor = HEXCOLOR(0x2f2f2f);
    leftLabel.text = info.headerInfo.lineName;
    leftLabel.font = [UIFont WLFontOfSize:14];
    [headerView addSubview:leftLabel];
    
    UILabel *rightLabel = [[UILabel alloc] init];
    rightLabel.frame = CGRectMake(ScreenWidth - ScaleW(15) - ScreenWidth / 2, 0, ScreenWidth / 2, ScaleH(45));
    rightLabel.textColor = HEXCOLOR(0x6f7378);
    rightLabel.font = [UIFont WLFontOfSize:12];
    rightLabel.text = [self getTimeStringWithDateString:info.headerInfo.comeDate];
    rightLabel.textAlignment = NSTextAlignmentRight;
    [headerView addSubview:rightLabel];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ScaleH(45);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == self.dataArray.count - 1) {
        return nil;
    }
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = HEXCOLOR(0xeff1fe);
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == self.dataArray.count - 1) {
        return 0;
    }
    return ScaleH(15);
}


- (NSString *)getTimeStringWithDateString:(NSString *)dateString
{

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    
    NSDateComponents *dateComps = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    NSInteger year = [dateComps year];
    NSInteger month = [dateComps month];
    NSInteger day = [dateComps day];
    return [NSString stringWithFormat:@"%ld.%ld.%ld",year, month,day];
        
    
}
@end
