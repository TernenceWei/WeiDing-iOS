//
//  WLGroupItemController.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/31.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLGroupItemController.h"
#import "WLItemTableHeaderView.h"
#import "WLItemSelectionHeaderView.h"
#import "WLCarItemTopCell.h"
#import "WLCarItemBottomCell.h"
#import "WLItemCheckCell.h"
#import "WLItemDetailCell.h"
#import "WLItemPaymentCell.h"
#import "WLItemDetailCarObject.h"
#import "WLItemDetailHotelObject.h"
#import "WLNetworkManager.h"
#import "WLChargeUpController.h"

@interface WLGroupItemController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WLItemTableHeaderView *header;
@property (nonatomic, strong) WLItemDetailCarObject *carObject;
@property (nonatomic, strong) WLItemDetailHotelObject *hotelObject;
@property (nonatomic, assign) TouristItemType itemType;
@property (nonatomic, strong) NSString *groupID;
@property (nonatomic, strong) NSString *resourceID;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, assign) BOOL canEdit;

@end

@implementation WLGroupItemController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)setItemType:(TouristItemType)itemType resourceID:(NSString *)resourceID groupID:(NSString *)groupID date:(NSString *)date canEdit:(BOOL)canEdit
{
    self.itemType = itemType;
    self.resourceID = resourceID;
    self.groupID = groupID;
    self.date = date;
    self.canEdit = canEdit;
    [self setUpNavigationBar];
    [self setupUI];
    [self loadData];
    
    self.title = @"详情--用车";
    if (self.itemType == TouristItemTypeHotel) {
        self.title = @"详情--酒店";
    }else if (self.itemType == TouristItemTypeMeal) {
        self.title = @"详情--用餐";
    }else if (self.itemType == TouristItemTypeTicket) {
        self.title = @"详情--门票";
    }else if (self.itemType == TouristItemTypeShopping) {
        self.title = @"详情--购物店";
    }else if (self.itemType == TouristItemTypeAdditional) {
        self.title = @"详情--加点项目";
    }
}

-(void)setUpNavigationBar
{
    
    self.view.backgroundColor = HEXCOLOR(0xeff1fe);
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont WLFontOfSize:15];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    if (self.canEdit) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"记账" style:UIBarButtonItemStyleDone target:self action:@selector(goToChargeupPage)];
        self.navigationItem.rightBarButtonItem=item;
        [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    }
    
}

- (void)setupUI
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = HEXCOLOR(0xeff1fe);
    [self.view addSubview:self.tableView];
    
    WLItemTableHeaderView *header = [[WLItemTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(140)) type:self.itemType];
    self.tableView.tableHeaderView = header;
    self.header = header;
    
}

- (void)loadData
{
    [WLNetworkManager requestCurrentGroupItemDetailWithType:self.itemType resourceID:self.resourceID groupID:self.groupID date:self.date result:^(BOOL success, id responseObject) {
        
        if (success) {
            if (self.itemType == TouristItemTypeCar) {
                self.carObject = (WLItemDetailCarObject *)responseObject;
            }else{
                self.hotelObject = (WLItemDetailHotelObject *)responseObject;
                
            }
            [self.header setObject:responseObject];
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.itemType == TouristItemTypeCar) {
        return 3;
    }
    if (self.hotelObject.details == nil || [self.hotelObject.details isEqualToString:@""]) {
        return 1;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object;
    if (self.itemType == TouristItemTypeCar) {
        object = self.carObject;
    }else{
        object = self.hotelObject;
    }

    if (self.itemType == TouristItemTypeCar) {
        if (indexPath.section == 0) {
            
            WLCarItemTopCell *cell = [WLCarItemTopCell cellWithTableView:tableView object:self.carObject];
            return cell;
            
        }else if (indexPath.section == 1){
            
            WLCarItemBottomCell *cell = [WLCarItemBottomCell cellWithTableView:tableView object:self.carObject];
            return cell;
            
        }else if (indexPath.section == 2){
            
            WLItemPaymentCell *cell = [WLItemPaymentCell cellWithTableView:tableView object:self.carObject];
            return cell;
            
        }
    }else{
        
        if (indexPath.section == 0) {
            
            WLItemCheckCell *cell = [WLItemCheckCell cellWithTableView:tableView itemType:self.itemType object:self.hotelObject];
            
            return cell;
            
        }else if (indexPath.section == 1){
            
            WLItemDetailCell *cell = [WLItemDetailCell cellWithTableView:tableView detail:self.hotelObject.details];
            return cell;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.itemType == TouristItemTypeCar) {
        if (indexPath.section == 0) {
            if (self.carObject.photolist.count) {
                return ScaleH(190);
            }
            return ScaleH(90);
            
        }else if (indexPath.section == 1){
            return ScaleH(120);
            
        }else if (indexPath.section == 2){
            return ScaleH(45);
            
        }
    }else{
       
        CGFloat detailHeight = [WLUITool attributedSizeWithString:self.hotelObject.details constrainedToSize:CGSizeMake(ScreenWidth - ScaleW(24), MAXFLOAT)].height + ScaleH(30);
        if (self.itemType == TouristItemTypeShopping || self.itemType == TouristItemTypeAdditional) {
            if (indexPath.section == 0) {
                return ScaleH(90);
                
            }else if (indexPath.section == 1){
                
                return detailHeight;
            }
            
        }else{
            
            if (indexPath.section == 0) {
                return ScaleH(45) * 3 + ScaleH(10) + ScaleH(50) * (self.hotelObject.scheduleList.count + 1);
                
            }else if (indexPath.section == 1){
                return detailHeight;
            }
            
        }
        
    }
    return ScreenHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    WLItemSelectionHeaderView *header = [[WLItemSelectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(45)) itemType:self.itemType section:section];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ScaleH(45);
}


- (void)goToChargeupPage
{
    WLChargeUpController *chargeVC = [[WLChargeUpController alloc] init];
    [chargeVC setItemType:self.itemType roleType:TouristRoleTypeMine resourceID:self.resourceID groupID:self.groupID date:self.date canEdit:YES];
    [self.navigationController pushViewController:chargeVC animated:YES];
}
@end
