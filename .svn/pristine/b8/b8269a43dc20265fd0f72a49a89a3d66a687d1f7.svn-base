//
//  WLCurrentGroupCell.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/14.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLCurrentGroupCell.h"
#import "WLCurrentGroupHeader.h"
#import "WLCurrentGroupItemCell.h"
#import "WLCurrentGroupCellTool.h"
#import "WLCurrentGroupCellTool.h"
#import "WLCurrentGroupCell2.h"

#define cellIdentifier @"WLCurrentGroupCell"

@interface WLCurrentGroupCell ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *isFoldArray;
@property (nonatomic, strong) WLCurrentGroupCellTool *cellTool;
@property (nonatomic,copy) void (^onLeftBtnClickBlock)(NSString *phoneNO);
@property (nonatomic,copy) void (^onRightBtnClickBlock)(TouristItemType itemType, id object);
@property (nonatomic,copy) void (^onSectionClickBlock)(TouristItemType itemType, id object);
@property (nonatomic,copy) void (^onArrowBtnClickBlock)(NSUInteger section, BOOL isFold);
@end

@implementation WLCurrentGroupCell

+ (WLCurrentGroupCell *)cellWithTableView:(UITableView*)tableView
                                 gropInfo:(WLCurrentGroupInfo *)groupInfo
                              isFoldArray:(NSArray *)isFoldArray{
    WLCurrentGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLCurrentGroupCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.isFoldArray = isFoldArray;
    cell.groupInfo = groupInfo;
    [cell setupUI];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.exclusiveTouch = YES;
        self.multipleTouchEnabled = NO;
    }
    return self;
}



- (void)setupUI{
    if (self.groupInfo == nil) {
        return;
    }

    self.cellTool = [[WLCurrentGroupCellTool alloc] init];
    self.cellTool.groupInfo = _groupInfo;

    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10000)];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.scrollEnabled = NO;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.backgroundColor = HEXCOLOR(0xf7f7f8);
    [self addSubview:self.myTableView];
    
    self.clipsToBounds = YES;
    
    
}

#pragma mark tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.cellTool getCellSectionCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BOOL isFold = ((NSString *)self.isFoldArray[section]).boolValue;
    if (isFold) {
        return 0;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TouristItemType itemType = [self.cellTool getCellItemTypeWithSection:indexPath.section];
    NSArray *dataArray = [self.cellTool getCellDataArrayWithSection:indexPath.section];
    WLCurrentGroupCell2 *cell = [WLCurrentGroupCell2 cellWithTableView:tableView type:itemType dataArray:dataArray];
    cell.canChargeup = self.canChargeup;
    __weak __typeof__(self) weakSelf = self;
    [cell setLeftBtnClickAction:^(NSString *phoneNO) {
        
        weakSelf.onLeftBtnClickBlock(phoneNO);
        
    }rightBtnClickAction:^(id object){
        
        weakSelf.onRightBtnClickBlock(itemType, object);
        
    }sectionClickAction:^(id object){
        
        weakSelf.onSectionClickBlock(itemType,object);
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.cellTool getCell2RowHeightWithIndexPath:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *selected = self.isFoldArray[section];
    __weak __typeof__(self) weakSelf = self;
    WLCurrentGroupHeader *headerView = [[WLCurrentGroupHeader alloc] initWithType:[self.cellTool getCellItemTypeWithSection:section] foldAction:^(BOOL isFold) {

        weakSelf.onArrowBtnClickBlock(section, isFold);
        
    } selected:selected.boolValue];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ScaleH(45);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return ScaleH(15);
}


- (void)setLeftBtnClickAction:(void (^)(NSString *))leftBlock rightBtnClickAction:(void (^)(TouristItemType, id))rightBlock sectionClickAction:(void (^)(TouristItemType, id))sectionBlock arrowClickAction:(void (^)(NSUInteger, BOOL))foldAction
{
    self.onLeftBtnClickBlock = leftBlock;
    self.onRightBtnClickBlock = rightBlock;
    self.onSectionClickBlock = sectionBlock;
    self.onArrowBtnClickBlock = foldAction;
}

- (void)dealloc
{
    self.myTableView.dataSource = nil;
    self.myTableView.delegate = nil;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
}
@end
