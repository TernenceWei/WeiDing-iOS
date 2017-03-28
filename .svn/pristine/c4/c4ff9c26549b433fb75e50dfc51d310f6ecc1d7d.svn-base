//
//  WLTouristInfoController.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLTouristInfoController.h"
#import "WLNetworkManager.h"
#import "WLVisitorDetailInfo.h"
#import "WLVisitorCell1.h"
#import "WLVisitorCell2.h"

@interface WLTouristInfoController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WLVisitorDetailInfo *visitorInfo;
@end

@implementation WLTouristInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI
{
    self.title = @"团队联系人";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = HEXCOLOR(0xeff1fe);
    [self.view addSubview:self.tableView];
}

- (void)setVisitorID:(NSString *)visitorID
{
    _visitorID = visitorID;
    [self loadData];
}

- (void)loadData{
    
    [WLNetworkManager requestVisitorDetailInfoWithVisitorID:self.visitorID result:^(BOOL success, WLVisitorDetailInfo *visitorInfo) {
        if (success) {
            self.visitorInfo = visitorInfo;
            [self.tableView reloadData];
        }
        
    }];
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger count = 1;
    if (section == 1) {
        count = 6;
    }else if (section == 2){
        count = 3;
    }
    return count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        WLVisitorCell1 *cell = [WLVisitorCell1 cellWithTableView:tableView];
        cell.detailInfo = self.visitorInfo;
        return cell;
    }else{
        WLVisitorCell2 *cell = [WLVisitorCell2 cellWithTableView:tableView];
        BOOL withLine = YES;
        BOOL enable = NO;
        if ((indexPath.section == 1 && indexPath.row == 5) || (indexPath.section == 2 && indexPath.row == 2) || indexPath.section == 3) {
            withLine = NO;
        }
        if (indexPath.section == 2 && indexPath.row == 2) {
            enable = YES;
        }
        [cell setDataArry:[self getDataArrayWithIndexPath:indexPath] withLine:withLine enable:enable];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return  ScaleH(105);
    }
    return ScaleH(50);
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] init];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        return 0;
    }
    return ScaleH(15);
}



- (NSArray *)getDataArrayWithIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = nil;
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            array = @[@"线路名称",CHECKNIL(self.visitorInfo.lineName)];
        }else if (indexPath.row == 1) {
            array = @[@"出行人数",CHECKNIL(self.visitorInfo.adults)];
        }else if (indexPath.row == 2) {;
            array = @[@"接站时间",CHECKNIL([self getTimeStringWithDateString:self.visitorInfo.comeDate])];
        }else if (indexPath.row == 3) {
            array = @[@"接站地点",CHECKNIL(self.visitorInfo.comePlace)];
        }else if (indexPath.row == 4) {
            array = @[@"送站时间",CHECKNIL([self getTimeStringWithDateString:self.visitorInfo.backDate])];
        }else if (indexPath.row == 5) {
            array = @[@"送站地点",CHECKNIL(self.visitorInfo.backPlace)];
        }
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            array = @[@"组团社",CHECKNIL(self.visitorInfo.customerName)];
        }else if (indexPath.row == 1) {
            array = @[@"联系人",CHECKNIL(self.visitorInfo.contactName)];
        }else if (indexPath.row == 2) {
            array = @[@"联系电话",CHECKNIL(self.visitorInfo.contactPhoneNO)];
        }
    }else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            array = @[@"备注信息",CHECKNIL(self.visitorInfo.remark)];
        }
    }
    return array;
    
}

- (NSString *)getTimeStringWithDateString:(NSString *)dateString
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    
    NSDateComponents *dateComps = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:date];
    NSInteger year = [dateComps year];
    NSInteger month = [dateComps month];
    NSInteger day = [dateComps day];
    NSInteger hour = [dateComps hour];
    NSInteger minute = [dateComps minute];
    return [NSString stringWithFormat:@"%ld年%ld月%ld日 %ld:%02ld",year, month,day,hour,minute];
    
    
}
@end
