//
//  WLBillDetailController.m
//  WeiLvDJS
//
//  Created by ternence on 16/9/30.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLBillDetailController.h"
#import "WLBillTableFooterView.h"
#import "WLBillSummaryCell.h"
#import "WLBillItemCell.h"
#import "WLNetworkManager.h"
#import "WLBillDetailInfo.h"
#import "WLBillSectionHeaderView.h"
#import "WLBillItemHeaderView.h"
#import "WLCurrentGroupController.h"

@interface WLBillDetailController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIBarButtonItem *rightItem;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WLBillDetailInfo *billInfo;
@property (nonatomic, strong) NSMutableArray *isFoldArray;
@property (nonatomic, strong) NSMutableArray *guideArray;
@property (nonatomic, assign) BOOL mainGuideType;
@property (nonatomic, strong) WLBillSectionHeaderView *headerView;
@property (nonatomic, strong) WLGuideListInfo *currentGuideInfo;
@end

@implementation WLBillDetailController

- (NSMutableArray *)guideArray
{
    if (!_guideArray) {
        _guideArray = [NSMutableArray array];
    }
    return _guideArray;
}

- (NSMutableArray *)isFoldArray
{
    if (!_isFoldArray) {
        _isFoldArray = [NSMutableArray array];
    }
    return _isFoldArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账单详情";
    for (int i = 0; i < 8; i ++) {
        NSString *isFold = [NSString stringWithFormat:@"0"];
        [self.isFoldArray addObject:isFold];
    }
    
    [self setupUI];
    
}

- (void)setGroupID:(NSString *)groupID
{
    _groupID = groupID;
    [self loadGuideList];
}

- (void)setUpNavigationBar
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:self action:@selector(onClickRightBarButtonItem)];
    self.navigationItem.rightBarButtonItem = item;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont WLFontOfSize:14];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    self.rightItem = item;
    
    
}

- (void)navigationBarTitleExchange
{
    GroupStatus status = self.billInfo.status;
    if (status == GroupStatusUnBaoZhang) {//待提交
        
        if (self.mainGuideType) {
            self.rightItem.title = @"提交";
            self.navigationItem.rightBarButtonItem = self.rightItem;
        }else{
            self.rightItem.title = nil;
            self.navigationItem.rightBarButtonItem = nil;
        }
    }else if (status == GroupStatusYiShenHe){
        if (self.billInfo.settle.integerValue < 0) {
            self.rightItem.title = @"退款";
            self.navigationItem.rightBarButtonItem = self.rightItem;
        }else{
            self.rightItem.title = nil;
            self.navigationItem.rightBarButtonItem = nil;
        }
    }else if (status == GroupStatusShenHeFailure){
        if (self.mainGuideType) {
            self.rightItem.title = @"重新提交";
            self.navigationItem.rightBarButtonItem = self.rightItem;
        }else{
            self.rightItem.title = nil;
            self.navigationItem.rightBarButtonItem = nil;
        }
    }else{
        self.rightItem.title = nil;
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    
}

- (void)setupUI
{
    self.view.backgroundColor = HEXCOLOR(0xf7f7f8);
    WLBillSectionHeaderView *headerView = [[WLBillSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(150)) selectAction:^(WLGuideListInfo *guideInfo) {

        if (guideInfo.isMainGuide.boolValue) {
            self.mainGuideType = YES;
        }else{
            self.mainGuideType = NO;
        }
        [self loadDataWithGuideUserID:guideInfo.userID];
        
    }];
    [self.view addSubview:headerView];
    self.headerView = headerView;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, ScaleH(150), ScreenWidth, ScreenHeight - ScaleH(150) - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = HEXCOLOR(0xf7f7f8);
    [self.view addSubview:self.tableView];

}

- (void)setupFooter
{
    WLBillTableFooterView *footerView = [[WLBillTableFooterView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(80))];
    self.tableView.tableFooterView = footerView;
}

- (void)updateSubviewFrame
{
    CGFloat headerHeight = ScaleH(150);
    if (self.billInfo.failMessage.count) {
        headerHeight = (self.billInfo.failMessage.count + 1) * ScaleH(40) + ScaleH(10) + ScaleH(150);
    }
    self.headerView.frame = CGRectMake(0, 0, ScreenWidth, headerHeight);
    self.tableView.frame = CGRectMake(0, headerHeight, ScreenWidth, ScreenHeight - 64 - headerHeight);

}

- (void)loadGuideList
{
    [WLNetworkManager requestTouristGuideListWithGroupID:self.groupID result:^(BOOL success, NSArray *guideList) {
        if (success && guideList.count) {
            self.guideArray = [guideList mutableCopy];
            WLGuideListInfo *info = self.guideArray[0];
            if (info.isMainGuide.boolValue) {
                self.mainGuideType = YES;
            }else{
                self.mainGuideType = NO;
            }
            self.headerView.roleArray = self.guideArray;
            [self setUpNavigationBar];
            [self setupFooter];
            [self loadDataWithGuideUserID:info.userID];
        }

    }];
}

- (void)loadDataWithGuideUserID:(NSString *)userID
{
    [WLNetworkManager requestBillDetailInfoWithGroupID:self.groupID userID:userID result:^(BOOL success, WLBillDetailInfo *billInfo) {
        if (success) {
            self.billInfo = billInfo;
            [self updateSubviewFrame];
            [self navigationBarTitleExchange];
            self.headerView.detailInfo = billInfo;
            [self.tableView reloadData];
        }
        
    }];
}

- (void)onClickRightBarButtonItem
{
    if ([self.rightItem.title isEqualToString:@"提交"] || [self.rightItem.title isEqualToString:@"重新提交"]) {
        //提交
        [WLNetworkManager submmitBillDetailWithGroupID:self.groupID result:^(BOOL success, BOOL result, NSString *message) {
            [[WL_TipAlert_View sharedAlert] createTip:message];
            if (success && result) {
                self.rightItem.title = nil;
                self.navigationItem.rightBarButtonItem = nil;
                [self loadGuideList];
            }
            
        }];
    }else if ([self.rightItem.title isEqualToString:@"退款"]){
        //退款
        [WLNetworkManager refundWithGroupID:self.groupID amount:[NSString stringWithFormat:@"%@", self.billInfo.settle] result:^(BOOL success, BOOL result, NSString *message) {
            [[WL_TipAlert_View sharedAlert] createTip:message];
            if (success && result) {
                self.rightItem.title = nil;
                self.navigationItem.rightBarButtonItem = nil;
            }
        }];
    }
    
    
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self getSectionCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BOOL isFold = ((NSString *)self.isFoldArray[section]).boolValue;
    if (isFold) {
        return 0;
    }
    return [self getRowCountWithSection:section];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak __typeof__(self) weakSelf = self;
    if (indexPath.section == 0) {
        WLBillSummaryCell *cell = [WLBillSummaryCell cellWithTableView:tableView mainGuideType:self.mainGuideType];
        cell.billInfo = self.billInfo;
        [cell setEditAction:^{
            
            NSArray *vcs = weakSelf.navigationController.viewControllers;
            UIViewController *lastVC;
            if (vcs.count >= 2) {
                 lastVC = vcs[vcs.count - 2];
            }
            if ([lastVC isKindOfClass:[WLCurrentGroupController class]]) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                WLCurrentGroupController *groupVC = [[WLCurrentGroupController alloc] init];
                [groupVC setupGroupListID:weakSelf.groupID];
                [weakSelf.navigationController pushViewController:groupVC animated:YES];
            }
            
            
        }];
        return cell;
    }else{
        WLBillItemCell *cell = [WLBillItemCell cellWithTableView:tableView];
        cell.type = [self getCellTypeWithIndexPath:indexPath];
        cell.textArray = [self getCellTextArrayWithIndexPath:indexPath];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getRowHeightWithIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    WLBillItemHeaderView *headerView = [[WLBillItemHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(50))
                                                                         leftTitle:[self getSectionHeaderLeftTitleWithSection:section]
                                                                        rightTitle:[self getSectionHeaderRightTitleWithSection:section]
                                                                        foldAction:^(BOOL isFold) {
        
        [self.isFoldArray replaceObjectAtIndex:section withObject:[NSString stringWithFormat:@"%d",isFold]];
        [self.tableView reloadData];
        
    } selected:((NSString *)self.isFoldArray[section]).boolValue];
    return headerView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return ScaleH(50);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = HEXCOLOR(0xf7f7f8);
    return footerView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([self getSectionCount] - 1 == section) {
        return 0;
    }
    return ScaleH(10);
}


#pragma mark sample method
- (NSUInteger)getSectionCount{
    NSUInteger count = 1;
    if (self.billInfo.hotelList.count) {
        count += 1;
    }
    if (self.billInfo.mealList.count) {
        count += 1;
    }
    if (self.billInfo.carList.count) {
        count += 1;
    }
    if (self.billInfo.playList.count) {
        count += 1;
    }
    if (self.billInfo.shoppingList.count) {
        count += 1;
    }
    if (self.billInfo.additionalList.count) {
        count += 1;
    }
    return count;
}

- (NSUInteger)getRowCountWithSection:(NSUInteger)section
{
    if (section == 0) {
        return 1;
    }
    if (self.mainGuideType) {//主导游模式
        if (section == 1) {
            return self.billInfo.hotelList.count + 1;
        }else if (section == 2) {
            return self.billInfo.mealList.count + 1;
        }else if (section == 3) {
            return self.billInfo.carList.count + 1;
        }else if (section == 4) {
            return self.billInfo.playList.count + 1;
        }else if (section == 5) {
            return self.billInfo.shoppingList.count + 1;
        }else if (section == 6) {
            return self.billInfo.additionalList.count + 1;
        }
    }else{//副导游模式
        if (section == 1) {
            return self.billInfo.shoppingList.count + 1;
        }else if (section == 2) {
            return self.billInfo.additionalList.count + 1;
        }
    }
    return 0;
    
}

- (CGFloat)getRowHeightWithIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (self.mainGuideType) {
            return ScaleH(400);
        }else{
            return ScaleH(300);
        }
    }
    return ScaleH(45);
}

- (NSString *)getSectionHeaderLeftTitleWithSection:(NSUInteger )section
{
    if (self.mainGuideType) {
        if (section == 1) {
            return @"酒店住宿（元）";
            
        }else if (section == 2) {
            return @"用餐（元）";
            
        }else if (section == 3) {
            return @"用车（元）";
            
        }else if (section == 4) {
            return @"游玩（元）";
            
        }else if (section == 5) {
            return @"购物店（元）";
            
        }else if (section == 6) {
            return @"加点项目（元）";
            
        }
    }else{
        
        if (section == 1) {
            return @"购物店（元）";
            
        }else if (section == 2) {
            return @"加点项目（元）";
            
        }
        
    }
    return nil;
}

- (NSAttributedString *)getAttributedStringWithFirstTitle:(NSString *)firstTitle secondTitle:(NSString *)secondTitle
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = HEXCOLOR(0x2f2f2f);
    attrs[NSFontAttributeName] = [UIFont WLFontOfSize:14];
    NSAttributedString *string1 = [[NSAttributedString alloc] initWithString:firstTitle attributes:attrs];
    
    NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc] initWithAttributedString:string1];
    
    NSMutableDictionary *attrs2 = [NSMutableDictionary dictionary];
    attrs2[NSForegroundColorAttributeName] = HEXCOLOR(0xff5b3d);
    attrs2[NSFontAttributeName] = [UIFont WLFontOfSize:14];
    NSAttributedString *string2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",secondTitle] attributes:attrs2];
    [mutableString  appendAttributedString:string2];

    
    return mutableString;
}
 
                               
- (NSAttributedString *)getSectionHeaderRightTitleWithSection:(NSUInteger )section
{
    if (self.mainGuideType) {
        if (section == 1) {
            WLBillHotelInfo *info = [self.billInfo.hotelList firstObject];
            return [self getAttributedStringWithFirstTitle:@"现付：" secondTitle:info.payAmount];
            
        }else if (section == 2) {
            WLBillHotelInfo *info = [self.billInfo.mealList firstObject];
            return [self getAttributedStringWithFirstTitle:@"现付：" secondTitle:info.payAmount];
            
        }else if (section == 3) {
            WLBillCarInfo *info = [self.billInfo.carList firstObject];
            return [self getAttributedStringWithFirstTitle:@"现付：" secondTitle:info.payAmount];
            
        }else if (section == 4) {
            WLBillHotelInfo *info = [self.billInfo.playList firstObject];
            return [self getAttributedStringWithFirstTitle:@"现付：" secondTitle:info.payAmount];
            
        }else if (section == 5) {
            WLBillShoppingInfo *info = [self.billInfo.shoppingList firstObject];
            return [self getAttributedStringWithFirstTitle:@"应返现：" secondTitle:info.payAmount];
            
        }else if (section == 6) {
            WLBillShoppingInfo *info = [self.billInfo.additionalList firstObject];
            return [self getAttributedStringWithFirstTitle:@"应返现：" secondTitle:info.payAmount];
            
        }
    }else{
        
        if (section == 1) {
            WLBillShoppingInfo *info = [self.billInfo.shoppingList firstObject];
            return [self getAttributedStringWithFirstTitle:@"应返现：" secondTitle:info.payAmount];
            
        }else if (section == 2) {
            WLBillShoppingInfo *info = [self.billInfo.additionalList firstObject];
            return [self getAttributedStringWithFirstTitle:@"应返现：" secondTitle:info.payAmount];
            
        }
    }
    
    return nil;
}

- (BillItemCellType)getCellTypeWithIndexPath:(NSIndexPath *)indexPath
{
    if (self.mainGuideType) {
        if (indexPath.section == 1) {
            
            if (indexPath.row == 0) {
                return BillItemCellTypeTitle;
            }else{
                return BillItemCellTypeHotel;
            }
            
        }else if (indexPath.section == 2){
            
            if (indexPath.row == 0) {
                return BillItemCellTypeTitle;
            }else{
                return BillItemCellTypeHotel;
            }
            
        }else if (indexPath.section == 3){
            
            if (indexPath.row == 0) {
                return BillItemCellTypeTitle;
            }else{
                return BillItemCellTypeCar;
            }
            
        }else if (indexPath.section == 4){
            
            if (indexPath.row == 0) {
                return BillItemCellTypeTitle;
            }else{
                return BillItemCellTypeHotel;
            }
            
        }else if (indexPath.section == 5){
            
            if (indexPath.row == 0) {
                return BillItemCellTypeTitle;
            }else{
                return BillItemCellTypeShop;
            }
            
        }else if (indexPath.section == 6){
            
            if (indexPath.row == 0) {
                return BillItemCellTypeTitle;
            }else{
                return BillItemCellTypeShop;
            }
            
        }
        
    }else{
        
        if (indexPath.section == 1){
            
            if (indexPath.row == 0) {
                return BillItemCellTypeTitle;
            }else{
                return BillItemCellTypeShop;
            }
            
        }else if (indexPath.section == 2){
            
            if (indexPath.row == 0) {
                return BillItemCellTypeTitle;
            }else{
                return BillItemCellTypeShop;
            }
            
        }
        
    }
    return BillItemCellTypeTitle;

}

- (NSArray *)getCellTextArrayWithIndexPath:(NSIndexPath *)indexPath
{
    if (self.mainGuideType) {
        if (indexPath.section == 1) {
            
            if (indexPath.row == 0) {
                return @[@"时间",@"酒店名称",@"支付方式",@"实际消费"];
            }else{
                WLBillHotelInfo *info = self.billInfo.hotelList[indexPath.row - 1];
                NSString *payment = @"挂账";
                if (info.payMode == PaymentModeCash) {
                    payment = @"现金";
                }
                return @[[NSString stringWithFormat:@"%@",info.date],[NSString stringWithFormat:@"%@",info.companyName],payment,[NSString stringWithFormat:@"%@",info.actualSpend]];
            }
            
        }else if (indexPath.section == 2){
            
            if (indexPath.row == 0) {
                return @[@"时间",@"酒店名称",@"支付方式",@"实际消费"];
            }else{
                WLBillHotelInfo *info = self.billInfo.mealList[indexPath.row - 1];
                NSString *payment = @"挂账";
                if (info.payMode == PaymentModeCash) {
                    payment = @"现金";
                }
                return @[[NSString stringWithFormat:@"%@",info.date],[NSString stringWithFormat:@"%@",info.companyName],payment,[NSString stringWithFormat:@"%@",info.actualSpend]];
            }
            
        }else if (indexPath.section == 3){
            
            if (indexPath.row == 0) {
                return @[@"时间",@"车队名称",@"实际消费",@"实际现付"];
            }else{
                WLBillCarInfo *info = self.billInfo.carList[indexPath.row - 1];
                return @[[NSString stringWithFormat:@"%@",info.date],[NSString stringWithFormat:@"%@",info.companyName],[NSString stringWithFormat:@"%@",info.actualSpend],[NSString stringWithFormat:@"%@",info.actualPay]];
            }
            
        }else if (indexPath.section == 4){
            
            if (indexPath.row == 0) {
                return @[@"时间",@"景点名称",@"支付方式",@"实际消费"];
            }else{
                WLBillHotelInfo *info = self.billInfo.playList[indexPath.row - 1];
                NSString *payment = @"挂账";
                if (info.payMode == PaymentModeCash) {
                    payment = @"现金";
                }
                return @[[NSString stringWithFormat:@"%@",info.date],[NSString stringWithFormat:@"%@",info.companyName],payment,[NSString stringWithFormat:@"%@",info.actualSpend]];
            }
            
        }else if (indexPath.section == 5){
            
            if (indexPath.row == 0) {
                return @[@"时间",@"商家名称",@"实际消费",@"返点",@"应返现"];
            }else{
                WLBillShoppingInfo *info = self.billInfo.shoppingList[indexPath.row - 1];
                
                return @[[NSString stringWithFormat:@"%@",info.date],[NSString stringWithFormat:@"%@",info.companyName],[NSString stringWithFormat:@"%@",info.actualSpend],[NSString stringWithFormat:@"%@",info.rate],[NSString stringWithFormat:@"%@",info.cashBack]];
            }
            
        }else if (indexPath.section == 6){
            
            if (indexPath.row == 0) {
                return @[@"时间",@"商家名称",@"结余",@"返点",@"应返现"];
            }else{
                WLBillShoppingInfo *info = self.billInfo.additionalList[indexPath.row - 1];
                
                return @[[NSString stringWithFormat:@"%@",info.date],[NSString stringWithFormat:@"%@",info.companyName],[NSString stringWithFormat:@"%@",info.actualSpend],[NSString stringWithFormat:@"%@",info.rate],[NSString stringWithFormat:@"%@",info.cashBack]];
            }
            
        }
        
    }else{
        
        if (indexPath.section == 1){
            
            if (indexPath.row == 0) {
                return @[@"时间",@"商家名称",@"实际消费",@"返点",@"应返现"];
            }else{
                WLBillShoppingInfo *info = self.billInfo.shoppingList[indexPath.row - 1];
                
                return @[[NSString stringWithFormat:@"%@",info.date],[NSString stringWithFormat:@"%@",info.companyName],[NSString stringWithFormat:@"%@",info.actualSpend],[NSString stringWithFormat:@"%@",info.rate],[NSString stringWithFormat:@"%@",info.cashBack]];
            }
            
        }else if (indexPath.section == 2){
            
            if (indexPath.row == 0) {
                return @[@"时间",@"商家名称",@"结余",@"返点",@"应返现"];
            }else{
                WLBillShoppingInfo *info = self.billInfo.additionalList[indexPath.row - 1];
                
                return @[[NSString stringWithFormat:@"%@",info.date],[NSString stringWithFormat:@"%@",info.companyName],[NSString stringWithFormat:@"%@",info.actualSpend],[NSString stringWithFormat:@"%@",info.rate],[NSString stringWithFormat:@"%@",info.cashBack]];
            }
            
        }

    }
    return nil;
}
@end
