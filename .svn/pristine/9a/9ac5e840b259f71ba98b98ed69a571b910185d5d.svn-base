//
//  WLCurrentGroupController.m
//  WeiLvDJS
//
//  Created by ternence on 16/9/30.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLCurrentGroupController.h"
#import "WLAllGroupController.h"
#import "WLGroupSummaryView.h"
#import "WLGroupScheduleView.h"
#import "WLNoGroupOnView.h"
#import "WLBillDetailController.h"
#import "WLChargeUpController.h"
#import "WL_BaseNavigationViewController.h"
#import "WLNetworkManager.h"
#import "WLCurrentGroupCell.h"
#import "WLNameCardAlertView.h"
#import "UIViewController+LewPopupViewController.h"
#import "LewPopupViewAnimationFade.h"
#import "LewPopupViewAnimationSlide.h"
#import "LewPopupViewAnimationSpring.h"
#import "LewPopupViewAnimationDrop.h"
#import "WLTouristListController.h"

#import "WLTouristGuideInfo.h"
#import "WLPriceListObject.h"
#import "WLOrderListInfo.h"
#import "WLCurrentGroupInfo.h"
#import "WLChargeUpObject.h"
#import "WLChargeUpCarObject.h"
#import "WLChargeUpHotelObject.h"
#import "WLChargeUpShopObject.h"
#import "WLCurrentGroupCellTool.h"
#import "WLGroupItemController.h"
#import "WLHotelPopView.h"


@interface WLCurrentGroupController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WLGroupScheduleView *scheduleView;
@property (nonatomic, strong) WLGroupSummaryView *summaryView;

@property (nonatomic, strong) WLChargeUpSummaryInfo *summaryInfo;
@property (nonatomic, strong) WLCurrentGroupInfo *detailInfo;
@property (nonatomic, strong) WLCurrentGroupCellTool *cellTool;

@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, strong) NSMutableArray *isFoldArray;
@property (nonatomic, assign) CGFloat offsetX;
@property (nonatomic, strong) NSString *groupID;

@property (nonatomic, assign) BOOL canChargeup;
@property (nonatomic, strong) NSString *currentDate;
@end

@implementation WLCurrentGroupController
- (NSMutableArray *)isFoldArray
{
    if (!_isFoldArray) {
        _isFoldArray = [NSMutableArray array];
    }
    return _isFoldArray;
}

- (void)setupGroupListID:(NSString *)groupID
{
    self.groupID = groupID;
    
    self.title = @"正在出团";
    self.view.backgroundColor = [UIColor whiteColor];
    self.offsetX = 0;
    self.canChargeup = NO;
    [self setNavigationRightTitle:@"所有出团" fontSize:14 titleColor:[UIColor whiteColor] isEnable:YES];
    if (self.groupID) {
        
        [self setupUI];
        [self loadData];
        
    }else{
        [WLNetworkManager requestNowOnGroupIDWithResult:^(BOOL success, NSString *groupID) {
            if (success) {
                if (groupID) {//正在出团
                    self.groupID = groupID;
                    
                    [self setupUI];
                    [self loadData];
                    
                }else{//无出团信息
                    
                    [self setupNoGroupOnView];
                }
            }else{
                [self setupNoGroupOnView];
            }
        }];
    }
    
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.currentDate) {
        [self changeGroupDetailInfoWithDate:self.currentDate];
    }
}


- (void)setupNoGroupOnView
{
    WLNoGroupOnView *noView = [[WLNoGroupOnView alloc] init];
    [self.view addSubview:noView];
}

/**
 *  设置右侧导航栏标题
 *
 *  @param titleName  右侧导航标题名称
 *  @param fontSize   标题字号
 *  @param titleColor 标题颜色
 *  @param isEnable   是否可用
 */
-(void)setNavigationRightTitle:(NSString *)titleName fontSize:(CGFloat)fontSize titleColor:(UIColor *)titleColor isEnable:(BOOL)isEnable
{
    UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithTitle:titleName style:UIBarButtonItemStyleDone target:self action:isEnable?@selector(NavigationRightEvent):nil];
    self.navigationItem.rightBarButtonItem=item;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont WLFontOfSize:fontSize];
    attrs[NSForegroundColorAttributeName] =titleColor;
    [item setTitleTextAttributes:attrs forState:isEnable?UIControlStateNormal:UIControlStateDisabled];
    
    [item setTarget:self];
    [item setAction:@selector(NavigationRightEvent)];
}

-(void)NavigationRightEvent
{
    WLAllGroupController *groupVC = [[WLAllGroupController alloc] init];
    [self.navigationController pushViewController:groupVC animated:YES];

}

- (void)setupUI
{
    for (int i = 0; i < 7; i ++) {
        NSString *isFold = [NSString stringWithFormat:@"0"];
        [self.isFoldArray addObject:isFold];
    }
    self.cellTool = [[WLCurrentGroupCellTool alloc] init];
    self.cellTool.isFoldArray = [self.isFoldArray copy];
    
    self.selectedIndex = 0;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = HEXCOLOR(0xeff1fe);
    [self.view addSubview:self.tableView];
    

    __weak __typeof__(self) weakSelf = self;
    WLGroupSummaryView *summaryView = [[WLGroupSummaryView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(357))];
    [summaryView setTouristInfoClickBlock:^{
        //跳转到游客资料界面
        WLTouristListController *listVC = [[WLTouristListController alloc] init];
        listVC.summaryInfo = weakSelf.summaryInfo;
        [weakSelf.navigationController pushViewController:listVC animated:YES];
    }];
    [summaryView setPeopleInfoClickBlock:^(NSUInteger tag){
        
        WLChargeUpNameCardObject *object = self.summaryInfo.nameCardList[tag];
        WLNameCardAlertView *conten = [[WLNameCardAlertView alloc] initWithFrame:CGRectMake(0, 0, ScaleW(300), ScaleH(285)) object:object clickAction:^(BOOL phone) {
            
            
            [weakSelf lew_dismissPopupViewWithanimation:weakSelf.lewPopupAnimation];
            if (phone) {
                [weakSelf giveSomebodyACallWithPhoneNO:object.mobile];
            }else{//发私信
                
            }
        }];
        [weakSelf lew_presentPopupView:conten animation:[LewPopupViewAnimationFade new] dismissed:^{
            
        }];
    }];
    self.tableView.tableHeaderView = summaryView;
    self.summaryView = summaryView;
    
}

- (void)loadData{
    [WLNetworkManager requestCurrentGroupSummaryDetailWithGroupID:self.groupID result:^(BOOL success, WLChargeUpSummaryInfo *summaryInfo) {
        if (success) {
            self.title = summaryInfo.statusString;
            if (summaryInfo.status == JourneyStatusChuTuanZhong) {
                self.canChargeup = YES;
            }else{
                self.canChargeup = NO;
            }
            self.summaryInfo = summaryInfo;
            self.summaryView.summaryInfo = self.summaryInfo;
            [self.scheduleView setSummaryInfo: self.summaryInfo];
            
            if (self.summaryInfo.nameCardList.count <= 4) {
                CGRect rect = self.summaryView.frame;
                rect.size.height -= ScaleH(70);
                self.summaryView.frame = rect;
                self.tableView.tableHeaderView = self.summaryView;
            }else if (self.summaryInfo.nameCardList.count > 8){
                CGRect rect = self.summaryView.frame;
                rect.size.height += ScaleH(70);
                self.summaryView.frame = rect;
                self.tableView.tableHeaderView = self.summaryView;
            }

            NSDate *currentDate = [NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"YYYY-MM-dd"];
            NSString *dateString = [dateFormatter stringFromDate:currentDate];
            for (int i = 0; i < self.summaryInfo.tripList.count; i++) {
                WLChargeUpTripObject *object = self.summaryInfo.tripList[i];
                if ([dateString isEqualToString:object.date]) {
                    self.selectedIndex = i;
                }
            }
            WLChargeUpTripObject *object = self.summaryInfo.tripList[self.selectedIndex];
            self.currentDate = object.date;
            [self changeGroupDetailInfoWithDate:object.date];
            
        }
        if (summaryInfo == nil) {
            WL_NoData_View *view = [[WL_NoData_View alloc] initWithFrame:self.view.bounds andRefreshBlock:nil];
            view.type = WLNetworkTypeNOData;
            [self.view addSubview:view];
        }
    }];
    
    
    
}

- (void)changeGroupDetailInfoWithDate:(NSString *)date
{
    [WLNetworkManager requestCurrentGroupDetailWithGroupID:self.groupID date:date result:^(BOOL success, WLCurrentGroupInfo *groupInfo) {
        if (success) {
            self.detailInfo = groupInfo;
            self.cellTool.groupInfo = groupInfo;
            [self.scheduleView setNoticeMessage:groupInfo.message];
            [self.tableView reloadData];
        }
    }];
}

- (void)giveSomebodyACallWithPhoneNO:(NSString *)phoneNO
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",phoneNO];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}


#pragma mark tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak __typeof__(self) weakSelf = self;
    WLCurrentGroupCell *cell = [WLCurrentGroupCell cellWithTableView:tableView gropInfo:self.detailInfo isFoldArray:weakSelf.isFoldArray];
    cell.canChargeup = self.canChargeup;
    [cell setLeftBtnClickAction:^(NSString *phoneNO) {
        
        [weakSelf giveSomebodyACallWithPhoneNO:phoneNO];
        
    } rightBtnClickAction:^(TouristItemType itemType,id object) {
        
        WLChargeUpController *chargeUpVC = [[WLChargeUpController alloc] init];
        NSString *groupID = nil;
        NSString *resourceID = nil;
        NSString *date = nil;
        NSString *buttonName = nil;
        if (itemType == TouristItemTypeCar) {
            
            WLCurrentGroupCarObject *hotelObject = (WLCurrentGroupCarObject *)object;
            resourceID = hotelObject.orderID;
            groupID = weakSelf.groupID;
            buttonName = hotelObject.buttonName;
            
        }else if (itemType == TouristItemTypeShopping || itemType == TouristItemTypeAdditional) {
           
            WLCurrentGroupShopObject *shopObject = (WLCurrentGroupShopObject *)object;
            resourceID = shopObject.resourceID;
            groupID = weakSelf.groupID;
            date = shopObject.date;
            buttonName = shopObject.buttonName;
            
        }else{
            WLCurrentGroupHotelObject *hotelObject = (WLCurrentGroupHotelObject *)object;
            resourceID = hotelObject.resourceID;
            groupID = hotelObject.groupID;
            date = hotelObject.date;
            buttonName = hotelObject.buttonName;
        }
        BOOL canEdit = YES;
        if ([buttonName isEqualToString:@"查看"]) {
            canEdit = NO;
        }
        
        [chargeUpVC setItemType:itemType roleType:TouristRoleTypeMine resourceID:resourceID groupID:groupID date:date canEdit:canEdit];
        [weakSelf.navigationController pushViewController:chargeUpVC animated:YES];
        
    } sectionClickAction:^(TouristItemType itemType,id object){
        
        WLGroupItemController *chargeVC = [[WLGroupItemController alloc] init];
        NSString *groupID = nil;
        NSString *resourceID = nil;
        NSString *date = nil;
        NSString *buttonName = nil;
        if (itemType == TouristItemTypeCar) {
            
            WLCurrentGroupCarObject *hotelObject = (WLCurrentGroupCarObject *)object;
            resourceID = hotelObject.orderID;
            groupID = weakSelf.groupID;
            buttonName = hotelObject.buttonName;
            
        }else if (itemType == TouristItemTypeShopping || itemType == TouristItemTypeAdditional) {
            
            WLCurrentGroupShopObject *shopObject = (WLCurrentGroupShopObject *)object;
            resourceID = shopObject.resourceID;
            groupID = weakSelf.groupID;
            date = shopObject.date;
            buttonName = shopObject.buttonName;
            
        }else{
            WLCurrentGroupHotelObject *hotelObject = (WLCurrentGroupHotelObject *)object;
            resourceID = hotelObject.resourceID;
            groupID = hotelObject.groupID;
            date = hotelObject.date;
            buttonName = hotelObject.buttonName;
        }
        BOOL canEdit = YES;
        if ([buttonName isEqualToString:@"查看"]) {
            canEdit = NO;
        }
        
        canEdit = weakSelf.canChargeup;
        
        [chargeVC setItemType:itemType resourceID:resourceID groupID:groupID date:date canEdit:canEdit];
        [weakSelf.navigationController pushViewController:chargeVC animated:YES];
        
    } arrowClickAction:^(NSUInteger section, BOOL isFold){
        
        [weakSelf.isFoldArray replaceObjectAtIndex:section withObject:[NSString stringWithFormat:@"%d",isFold]];
        weakSelf.cellTool.isFoldArray = weakSelf.isFoldArray;
        [weakSelf.tableView reloadData];
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [self.cellTool getCellRowHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    __weak __typeof__(self) weakSelf = self;
    WLGroupScheduleView *scheduleView = [[WLGroupScheduleView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)selectedIndex:self.selectedIndex offsetX:self.offsetX scrollAction:^(CGFloat offsetX) {
        weakSelf.offsetX = offsetX;
    }];
    [scheduleView setSummaryInfo:self.summaryInfo];
    [scheduleView setBillDetailClickBlock:^{
        
        WLBillDetailController *billVC = [[WLBillDetailController alloc] init];
        billVC.groupID = weakSelf.groupID;
        [weakSelf.navigationController pushViewController:billVC animated:YES];
        
    }];
    [scheduleView setScheduleSelectBlock:^(NSInteger index) {
        //选择了某一天的行程
        weakSelf.selectedIndex = index;
        WLChargeUpTripObject *object = weakSelf.summaryInfo.tripList[index];
        self.currentDate = object.date;
        [weakSelf changeGroupDetailInfoWithDate:object.date];
        
    }];
    [scheduleView setMessageClickBlock:^(NSInteger index) {
        //消息提醒点击事件
        WLTouristListController *listVC = [[WLTouristListController alloc] init];
        listVC.summaryInfo = weakSelf.summaryInfo;
        [weakSelf.navigationController pushViewController:listVC animated:YES];
    }];
    self.scheduleView = scheduleView;
    return scheduleView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (![self.detailInfo.message isEqualToString:@""] && self.detailInfo != nil) {
        return ScaleH(178);
    }
    return ScaleH(138);
}

- (void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}
@end
