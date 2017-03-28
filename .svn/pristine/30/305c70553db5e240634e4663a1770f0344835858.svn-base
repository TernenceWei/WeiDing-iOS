//
//  WLConsumeCell.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/27.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLConsumeCell.h"
#import "WLConsumeTopView.h"
#import "WLConsumeBotView.h"

#define cellIdentifier @"WLConsumeCell"

@interface WLConsumeCell ()
@property (nonatomic, strong) WLConsumeTopView *topView;
@property (nonatomic, strong) UIView *marginView;
@property (nonatomic, strong) WLConsumeBotView *bottomView;

@property (nonatomic, assign) TouristItemType itemType;
@property (nonatomic, strong) WLChargeUpCarObject *carObject;
@property (nonatomic, strong) WLChargeUpHotelObject *hotelObject;
@property (nonatomic, strong) WLChargeUpRoleObject *roleObject;
@property (nonatomic, strong) WLChargeUpMiddleObject *middleObject;
@property (nonatomic, copy) void(^onAddNewItemClickBlock)(BOOL showList);
@property (nonatomic, copy) void(^onChooseAItemClickBlock)(WLChargeUpScheduleObject *object);
@property (nonatomic, copy) void(^onEndEditingBlock)();
@property (nonatomic, copy) void(^onDeleteScheduleBlock)(NSUInteger index);
@property (nonatomic, assign) BOOL showList;
@property (nonatomic, assign) BOOL canEdit;
@property (nonatomic, strong) NSArray *itemArray;

@property (nonatomic, strong) NSString *additionalPrice;
@end

@implementation WLConsumeCell

+ (WLConsumeCell *)cellWithTableView:(UITableView *)tableView
                            ItemType:(TouristItemType)itemType
                              object:(id)object
                            showList:(BOOL)showList
                             canEdit:(BOOL)canEdit
                        newItemArray:(NSArray *)newItemArray
                        middleObject:(WLChargeUpMiddleObject *)middleObject
                     additionalPrice:(NSString *)additionalPrice{
    
    WLConsumeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLConsumeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];

    }
    cell.itemType = itemType;
    if (cell.itemType == TouristItemTypeCar) {
        
        cell.carObject = (WLChargeUpCarObject *)object;
    }else if (cell.itemType == TouristItemTypeShopping || cell.itemType == TouristItemTypeAdditional) {
        
        cell.roleObject = (WLChargeUpRoleObject *)object;
    }else{
        
        cell.hotelObject = (WLChargeUpHotelObject *)object;
    }
    cell.canEdit = canEdit;
    cell.middleObject = middleObject;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.showList = showList;
    cell.itemArray = newItemArray;
    cell.additionalPrice = additionalPrice;
    [cell setupUI];
    cell.clipsToBounds = YES;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
    }
    return self;
}

- (void)setupUI{

    __weak __typeof(self)weakSelf = self;
    self.highlighted = NO;
    CGFloat topHeight = ScaleH(90);
    CGFloat bottomHeight = ScaleH(50) * (self.itemArray.count + 1 + self.hotelObject.scheduleList.count);
    if (self.showList) {
        bottomHeight += ScaleH(50);
    }
    if (self.hotelObject.priceList.count) {
        bottomHeight += ScaleH(50);
    }
    if (self.itemType == TouristItemTypeHotel || self.itemType == TouristItemTypeMeal || self.itemType == TouristItemTypeTicket || self.itemType == TouristItemTypeAdditional) {
        
        id object = self.hotelObject;
        if (self.itemType == TouristItemTypeAdditional) {
            object = self.roleObject;
            topHeight = ScaleH(135);
            bottomHeight = ScaleH(50) * (self.itemArray.count + 2 + self.roleObject.scheduleList.count);
            if (self.showList) {
                bottomHeight += ScaleH(50);
            }
            if (self.roleObject.pricelist.count) {
                bottomHeight += ScaleH(50);
            }
        }
        
        self.topView = [[WLConsumeTopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, topHeight) itemType:self.itemType object:object canEdit:self.canEdit middleObject:self.middleObject];
        [self.topView setEndEditingBlock:^{
            weakSelf.onEndEditingBlock();
        }];
        [self addSubview:self.topView];
        
        self.marginView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), ScreenWidth, ScaleH(10))];
        self.marginView.backgroundColor = HEXCOLOR(0xeff1fe);
        [self addSubview:self.marginView];
        
        
        self.bottomView = [[WLConsumeBotView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.marginView.frame), ScreenWidth, bottomHeight) itemType:self.itemType object:object showList:self.showList canEdit:self.canEdit newItemArray:self.itemArray middleObject:self.middleObject additionalPrice:self.additionalPrice];
        
        
        [self.bottomView setAddNewItemClickBlock:^(BOOL showList) {
            
            weakSelf.onAddNewItemClickBlock(showList);
            
        } chooseAItemBlock:^(WLChargeUpScheduleObject *object) {
            
            weakSelf.onChooseAItemClickBlock(object);
            
        } endEditingBlock:^{
            
            weakSelf.onEndEditingBlock();
        } deleteScheduleBlock:^(NSUInteger index) {
            
            weakSelf.onDeleteScheduleBlock(index);
        }];
        [self addSubview:self.bottomView];

        
    }else{//用车和购物店
        id object;
        if (self.itemType == TouristItemTypeCar) {
            object = self.carObject;
            topHeight = ScaleH(165);
        }else{
            topHeight = ScaleH(135);
            object = self.roleObject;
        }
        self.topView = [[WLConsumeTopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, topHeight) itemType:self.itemType object:object canEdit:self.canEdit middleObject:self.middleObject];
        [self.topView setEndEditingBlock:^{
            weakSelf.onEndEditingBlock();
        }];
        [self addSubview:self.topView];
        
    }
    
    
}

- (void)setAddNewItemClickBlock:(void (^)(BOOL))block
               chooseAItemBlock:(void (^)(WLChargeUpScheduleObject *))chooseBlock
                endEditingBlock:(void (^)())endEditingBlock
            deleteScheduleBlock:(void (^)(NSUInteger))deleteBlock
{
    self.onAddNewItemClickBlock = block;
    self.onChooseAItemClickBlock = chooseBlock;
    self.onEndEditingBlock = endEditingBlock;
    self.onDeleteScheduleBlock = deleteBlock;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [self.topView removeFromSuperview];
    [self.bottomView removeFromSuperview];
    [self.marginView removeFromSuperview];
    self.topView = nil;
    self.bottomView = nil;
}

- (NSArray *)getTopViewTextArray
{
    return [self.topView getTopViewTextArray];
}

- (NSArray *)getScheduleObjectArray
{
    return [self.bottomView getScheduleObjectArray];
    
}

- (WLChargeUpMiddleObject *)getMiddleObject
{
    WLChargeUpMiddleObject *object = [[WLChargeUpMiddleObject alloc] init];
    object.actualPerson = [self.topView getTopViewTextArray][0];
    if (self.itemType == TouristItemTypeAdditional || self.itemType == TouristItemTypeShopping) {
        object.consumePrice = [self.topView getTopViewTextArray][1];
    }
    
    if ([self.topView getTopViewTextArray].count == 2) {
        object.consumePrice = [self.topView getTopViewTextArray][1];
    }
    object.middleArray = [self.bottomView getScheduleObjectArray];

    return object;
}


@end
