//
//  WLHotelBillDetailController.m
//  WeiLvDJS
//
//  Created by ternence on 16/11/16.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLHotelBillDetailController.h"
#import "WLNetworkManager.h"
#import "WLHotelBillDetailInfo.h"
#import "WLHotelBillDetailSectionHeader.h"
#import "WLHotelBillDetailRealCell.h"
#import "WLHotelBillDetailCheckCell.h"
#import "WLHotelBillDetailDateCell.h"
#import "WLHotelBillDetailCheckerCell.h"
#import "WLHotelBillDetailSectionFooter.h"
#import "WLHotelBillDetailPriceCell.h"

@interface WLHotelBillDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WLHotelBillDetailInfo *detailInfo;
@end

@implementation WLHotelBillDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"账单详情";
}


- (void)setItemInfo:(WLHotelBillListItemInfo *)itemInfo
{
    _itemInfo = itemInfo;
    [self setupUI];
    [self loadData];
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
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *date = [dateformatter dateFromString:self.itemInfo.cDate];
    NSTimeInterval a =[date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    
    __weak __typeof__(self) weakSelf = self;
    [WLNetworkManager requestHotelBillDetailWithGroupID:self.itemInfo.grouplistID groupNO:self.itemInfo.groupNO checklistID:self.itemInfo.checkerID companyID:self.itemInfo.djCompanyID date:timeString result:^(BOOL success, WLHotelBillDetailInfo *detailInfo) {
        if (success) {
            
            weakSelf.detailInfo = detailInfo;
            [weakSelf.tableView reloadData];
            
        }
    }];
}


#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return  self.detailInfo.itemList.count + 2;
    }
    return self.detailInfo.itemList.count + 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == self.detailInfo.itemList.count + 1) {
            
            WLHotelBillDetailDateCell *cell = [WLHotelBillDetailDateCell cellWithTableView:tableView];
            cell.detailInfo = self.detailInfo;
            return cell;
            
        }else if (indexPath.row == 0) {
            
            WLHotelBillDetailPriceCell *cell = [WLHotelBillDetailPriceCell cellWithTableView:tableView detailInfo:self.detailInfo];
            return cell;
            
        }else{
            
            WLHotelBillDetailRealCell *cell = [WLHotelBillDetailRealCell cellWithTableView:tableView];
            cell.itemInfo = self.detailInfo.itemList[indexPath.row - 1];
            return cell;
            
        }
    }else{
        if (indexPath.row == 0) {
            
            WLHotelBillDetailCheckerCell *cell = [WLHotelBillDetailCheckerCell cellWithTableView:tableView];
            cell.detailInfo = self.detailInfo;
            return cell;
            
        }else{
            
            WLHotelBillDetailCheckCell *cell = [WLHotelBillDetailCheckCell cellWithTableView:tableView];
            cell.itemInfo = self.detailInfo.itemList[indexPath.row - 1];
            return cell;
            
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == self.detailInfo.itemList.count) {
            return  ScaleH(85);
        }else if (indexPath.row == 0) {
            return  ScaleH(225);
        }else{
            return  ScaleH(88);
        }
    }else{
        if (indexPath.row == 0) {
            return  ScaleH(104);
        }else{
            return  ScaleH(85);
            
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {

        WLHotelBillDetailSectionHeader *header = [[WLHotelBillDetailSectionHeader alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(53)) isPriceHeader:NO detailInfo:self.detailInfo];
        return header;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        WLHotelBillDetailSectionFooter *footer = [[WLHotelBillDetailSectionFooter alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(20)) isPriceHeader:YES text:nil];
        return footer;
    }else{
        WLHotelBillDetailSectionFooter *footer = [[WLHotelBillDetailSectionFooter alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(40)) isPriceHeader:NO text:self.detailInfo.checkPayPrice];
        return footer;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return ScaleH(53);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return ScaleH(20);
    }
    return ScaleH(40);
}

@end
