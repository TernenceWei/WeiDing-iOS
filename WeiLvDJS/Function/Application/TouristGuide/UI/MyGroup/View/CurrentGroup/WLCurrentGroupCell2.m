//
//  WLCurrentGroupCell2.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLCurrentGroupCell2.h"
#import "WLCurrentGroupCellTool.h"
#import "WLCurrentGroupItemCell.h"
#import "WLCurrentGroupHeader.h"

#define cell2Identifier @"WLCurrentGroupCell2"

@interface WLCurrentGroupCell2 ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) WLCurrentGroupCellTool *cellTool;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) TouristItemType type;

@property (nonatomic,copy) void (^onLeftBtnClickBlock)(NSString *phoneNO);
@property (nonatomic,copy) void (^onRightBtnClickBlock)(id object);
@property (nonatomic,copy) void (^onSectionClickBlock)(id object);
@end

@implementation WLCurrentGroupCell2

+ (WLCurrentGroupCell2 *)cellWithTableView:(UITableView*)tableView
                                      type:(TouristItemType)type
                                 dataArray:(NSArray *)dataArray{
    WLCurrentGroupCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cell2Identifier];
    if (!cell) {
        cell = [[WLCurrentGroupCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell2Identifier];
    }
    cell.type = type;
    cell.dataArray = dataArray;
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
    
    if (self.dataArray == nil) {
        return;
    }

    self.cellTool = [[WLCurrentGroupCellTool alloc] init];
    self.cellTool.dataArray = self.dataArray;
    
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
    return  self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cellTool getCell2RowCountWithSection:section type:self.type];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLCurrentGroupItemCell *cell = [WLCurrentGroupItemCell cellWithTableView:tableView];
    cell.canChargeup = self.canChargeup;
    cell.type = [self.cellTool getCell2TypeWithIndexPath:indexPath type:self.type];
    [cell setDataArray:[self.cellTool getCell2DataArrayWithIndexPath:indexPath type:self.type]];
    
    __weak __typeof__(self) weakSelf = self;
    [cell setLeftBtnClickAction:^{
        
        NSString *phoneNo;
        if (weakSelf.type == TouristItemTypeCar) {
            WLCurrentGroupCarObject *objcet = weakSelf.dataArray[indexPath.section];
            phoneNo = objcet.contactMobile;
        }else if (weakSelf.type == TouristItemTypeShopping || weakSelf.type == TouristItemTypeAdditional) {
            WLCurrentGroupShopObject *objcet = weakSelf.dataArray[indexPath.section];
            phoneNo = objcet.contactMobile;
        }else{
            WLCurrentGroupHotelObject *objcet = weakSelf.dataArray[indexPath.section];
            phoneNo = objcet.contactMobile;
        }
        weakSelf.onLeftBtnClickBlock(phoneNo);
        
    } rightBtnClickAction:^{
        weakSelf.onRightBtnClickBlock(self.dataArray[indexPath.section]);
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
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
    return ScaleH(10);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.onSectionClickBlock(self.dataArray[indexPath.section]);
}

- (void)setLeftBtnClickAction:(void (^)(NSString *))leftBlock rightBtnClickAction:(void (^)(id))rightBlock sectionClickAction:(void (^)(id))sectionBlock
{
    self.onLeftBtnClickBlock = leftBlock;
    self.onRightBtnClickBlock = rightBlock;
    self.onSectionClickBlock = sectionBlock;
}

- (void)dealloc
{
    self.myTableView.delegate = nil;
    self.myTableView.dataSource = nil;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
}
@end
