//
//  WLConsumeBotView.m
//  WeiLvDJS
//
//  Created by ternence on 16/11/25.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLConsumeBotView.h"
#import "WLConsumeItemCell.h"

@interface WLConsumeBotView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) TouristItemType itemType;
@property (nonatomic, strong) WLChargeUpHotelObject *hotelObject;
@property (nonatomic, strong) WLChargeUpRoleObject *roleObject;
@property (nonatomic, strong) WLChargeUpMiddleObject *middleObject;
@property (nonatomic, copy) void(^onAddNewItemClickBlock)(BOOL showList);
@property (nonatomic, copy) void(^onChooseAItemClickBlock)(WLChargeUpScheduleObject *object);
@property (nonatomic, copy) void(^onEndEditingBlock)();
@property (nonatomic, copy) void(^onDeleteScheduleBlock)(NSUInteger index);
@property (nonatomic, assign) BOOL showList;
@property (nonatomic, assign) BOOL canEdit;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *itemArray;
@property (nonatomic, strong) NSString *additionalPrice;
@end

@implementation WLConsumeBotView
- (instancetype)initWithFrame:(CGRect)frame
                     itemType:(TouristItemType)itemType
                       object:(id)object
                     showList:(BOOL)showList
                      canEdit:(BOOL)canEdit
                 newItemArray:(NSArray *)newItemArray
                 middleObject:(WLChargeUpMiddleObject *)middleObject
              additionalPrice:(NSString *)additionalPrice
{
    self = [super initWithFrame:frame];
    if (self) {
        _itemType = itemType;
        
        if (self.itemType == TouristItemTypeShopping || self.itemType == TouristItemTypeAdditional) {
            
            self.roleObject = (WLChargeUpRoleObject *)object;
            
        }else{
            
            self.hotelObject = (WLChargeUpHotelObject *)object;
        }
        self.canEdit = canEdit;
        self.showList = showList;
        self.itemArray = newItemArray;
        self.middleObject = middleObject;
        self.additionalPrice = additionalPrice;
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI{
    
    self.tableView = [[UITableView alloc] initWithFrame:self.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = HEXCOLOR(0xf7f7f8);
    [self addSubview:self.tableView];
    self.clipsToBounds = YES;
}

#pragma mark tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self getCellItemTypeArray].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ItemCellType type = [self getCellItemTypeWithSection:indexPath.row];
    WLConsumeItemCell *cell = [WLConsumeItemCell cellWithTableView:tableView
                                                              type:type
                                                    scheduleObject:[self getScheduleObjectWithIndex:indexPath.row]
                                                         textArray:[self getTitleTextArrayWithIndex:indexPath.row]
                                                           canEdit:self.canEdit
                                                          showList:self.showList
                                                      middleObject:[self getMiddleObjectWithIndex:indexPath.row]];
    cell.tag = indexPath.row;
    __weak __typeof(self)weakSelf = self;
    [cell setAddNewItemClickBlock:^(BOOL showList) {
        
        weakSelf.onAddNewItemClickBlock(showList);
        
    } chooseAItemBlock:^(NSUInteger index) {
        
        WLChargeUpScheduleObject *newObject = [[WLChargeUpScheduleObject alloc] init];
        WLChargeUpScheduleObject *modelObject;
        if (weakSelf.itemType == TouristItemTypeAdditional) {
            modelObject = weakSelf.roleObject.pricelist[index];
            newObject.primePrice = @"0";
            
        }else{
            modelObject = weakSelf.hotelObject.priceList[index];
            newObject.checkCount = @"0";
        }
        
        newObject.pricelistID = modelObject.pricelistID;
        newObject.priceName = modelObject.priceName;
        newObject.checklistID = modelObject.checklistID;
        newObject.canDelete = modelObject.canDelete;
        weakSelf.onChooseAItemClickBlock(newObject);
        
        
    } endEditingBlock:^{
        
        if (weakSelf.itemType == TouristItemTypeAdditional) {

            WLConsumeItemCell *cell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[self getCellItemTypeArray].count - 1 inSection:0]];
            [cell setTotalJieyu:[self getAdditionalJieyuWithInit:NO]];
        }
        weakSelf.onEndEditingBlock();
    }];

    if (indexPath.row == [self getCellItemTypeArray].count - 1 && self.itemType == TouristItemTypeAdditional) {
        [cell setTotalJieyu:[self getAdditionalJieyuWithInit:YES]];
        [cell setTotalJieyu:self.additionalPrice];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleH(50);
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ItemCellType type = [self getCellItemTypeWithSection:indexPath.row];
    WLChargeUpScheduleObject *object = [self getScheduleObjectWithIndex:indexPath.row];
    if (type == ItemCellTypeHotelItem || type == ItemCellTypeAddItem) {
        if (object.canDelete) {
            return UITableViewCellEditingStyleDelete;
        }
    }
    
    return UITableViewCellEditingStyleNone;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        self.onDeleteScheduleBlock(indexPath.row - 1);
        
    }
}

#pragma mark private method

- (NSString *)getAdditionalJieyuWithInit:(BOOL)isInit
{
    int count = 0;
    NSArray *array = [self getScheduleObjectArray];
    if (isInit) {
        array = self.roleObject.scheduleList;
    }
    for (WLChargeUpScheduleObject *object in array) {
        count += ((object.actualDanJia.intValue - object.actualPrice.intValue) * object.actualCount.intValue);
    }
    if (count < 0) {
        count = 0;
    }
    return [NSString stringWithFormat:@"%d", count];
}

- (NSArray *)getCellItemTypeArray
{
    NSMutableArray *typeArray = [NSMutableArray array];
    
    [typeArray addObject:[NSString stringWithFormat:@"%ld",ItemCellTypeTitle]];
    
    if (self.itemType == TouristItemTypeAdditional) {
        [self.roleObject.scheduleList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [typeArray addObject:[NSString stringWithFormat:@"%ld", ItemCellTypeAddItem]];
        }];
        [self.itemArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [typeArray addObject:[NSString stringWithFormat:@"%ld", ItemCellTypeAddItem]];
        }];
        
        if (self.roleObject.pricelist.count) {
            [typeArray addObject:[NSString stringWithFormat:@"%ld", ItemCellTypeAddBtn]];
        }
        if (self.showList) {
            [typeArray addObject:[NSString stringWithFormat:@"%ld", ItemCellTypeItemList]];
        }
        [typeArray addObject:[NSString stringWithFormat:@"%ld", ItemCellTypeAddFooter]];
    }else{

        [self.hotelObject.scheduleList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [typeArray addObject:[NSString stringWithFormat:@"%ld", ItemCellTypeHotelItem]];
        }];
        [self.itemArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [typeArray addObject:[NSString stringWithFormat:@"%ld", ItemCellTypeHotelItem]];
        }];
        if (self.hotelObject.priceList.count) {
            [typeArray addObject:[NSString stringWithFormat:@"%ld", ItemCellTypeAddBtn]];
        }
        if (self.showList) {
            [typeArray addObject:[NSString stringWithFormat:@"%ld", ItemCellTypeItemList]];
        }
    }


    return [typeArray copy];
}

- (ItemCellType)getCellItemTypeWithSection:(NSUInteger)section
{
    NSArray *tempArray = [self getCellItemTypeArray];
    return (ItemCellType)((NSString *)tempArray[section]).integerValue;
}

- (WLChargeUpScheduleObject *)getScheduleObjectWithIndex:(NSUInteger)index
{
    ItemCellType type = [self getCellItemTypeWithSection:index];
    if (self.itemType == TouristItemTypeAdditional) {
        if (type != ItemCellTypeAddItem) {
            return nil;
        }
        if (index >= 1 && index <= self.roleObject.scheduleList.count) {
            return self.roleObject.scheduleList[index - 1];
        }
        if (index > self.roleObject.scheduleList.count ) {
            return self.itemArray[index - self.roleObject.scheduleList.count - 1];
        }
    }else{
        if (type != ItemCellTypeHotelItem) {
            return nil;
        }
        if (index >= 1 && index <= self.hotelObject.scheduleList.count) {
            return self.hotelObject.scheduleList[index - 1];
        }
        if (index > self.hotelObject.scheduleList.count ) {
            return self.itemArray[index - self.hotelObject.scheduleList.count - 1];
        }
    }
    return nil;
}

- (NSArray *)getTitleTextArrayWithIndex:(NSUInteger)index
{
    ItemCellType type = [self getCellItemTypeWithSection:index];
    NSMutableArray *titleArray = [NSMutableArray array];
    if (type == ItemCellTypeTitle) {
        if (self.itemType == TouristItemTypeHotel) {
            titleArray = [@[@"房型",@"实际单价\n（元/间）",@"调配数量\n（间）",@"实际数量\n（间）"] mutableCopy];
        }else if (self.itemType == TouristItemTypeMeal) {
            titleArray = [@[@"团餐类型",@"实际单价\n（元/桌）",@"调配数量\n（桌）",@"实际数量\n（桌）"] mutableCopy];
        }else if (self.itemType == TouristItemTypeTicket) {
            titleArray = [@[@"门票类别",@"实际单价\n（元/张）",@"调配数量\n（人）",@"实际数量\n（人）"] mutableCopy];
        }else if (self.itemType == TouristItemTypeAdditional) {
            titleArray = [@[@"门票类别",@"调配单价\n（元）",@"实际单价\n（元）",@"实际收费\n（元）",@"实际数量\n（张）"] mutableCopy];
        }
    }else if(type == ItemCellTypeItemList){
        if (self.itemType == TouristItemTypeAdditional ) {
            if (self.roleObject.pricelist.count) {
                for (WLChargeUpScheduleObject *object in self.roleObject.pricelist) {
                    [titleArray addObject:object.priceName];
                }
            }
            
        }else{
            if (self.hotelObject.priceList.count) {
                for (WLChargeUpScheduleObject *object in self.hotelObject.priceList) {
                    [titleArray addObject:object.priceName];
                }
            }
        }
        
    }else if (type == ItemCellTypeAddFooter){
        
        [titleArray addObject:CHECKNIL(self.additionalPrice)];
    }else if (type == ItemCellTypeAddBtn){
        
        [titleArray addObject: [self getAddBtnTitle]];
    }
    
    return [titleArray copy];
    
}

- (NSString *)getAddBtnTitle
{
    NSString *title= @"添加额外房型";
    if (self.itemType == TouristItemTypeMeal) {
        title= @"添加额外餐型";
    }else if (self.itemType == TouristItemTypeTicket){
        title= @"添加额外票型";
    }else if (self.itemType == TouristItemTypeAdditional){
        title= @"添加新的报价方式";
    }
    return title;
}

- (void)setAddNewItemClickBlock:(void (^)(BOOL))block chooseAItemBlock:(void (^)(WLChargeUpScheduleObject *object))chooseBlock endEditingBlock:(void (^)())endEditingBlock deleteScheduleBlock:(void (^)(NSUInteger))deleteBlock
{
    self.onAddNewItemClickBlock = block;
    self.onChooseAItemClickBlock = chooseBlock;
    self.onEndEditingBlock = endEditingBlock;
    self.onDeleteScheduleBlock = deleteBlock;
}
- (NSArray *)getScheduleObjectArray
{
    NSMutableArray *totalArray = [NSMutableArray array];
    if (self.itemType == TouristItemTypeAdditional) {
        
        for (int i = 0; i < self.roleObject.scheduleList.count; i ++) {
            WLChargeUpScheduleObject *object = self.roleObject.scheduleList[i];
            
            WLConsumeItemCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i + 1 inSection:0]];
            if (cell == nil) {
                break;
            }
            NSArray *array = [cell getScheduleObjectFieldArray];
            object.actualDanJia = array[0];
            object.actualPrice = array[1];
            object.actualCount = array[2];
            [totalArray addObject:object];
        }
        
        for (int i = 0; i < self.itemArray.count; i ++) {
            WLChargeUpScheduleObject *object = self.itemArray[i];
            
            WLConsumeItemCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i + 1 + self.roleObject.scheduleList.count inSection:0]];
            if (cell == nil) {
                break;
            }
            NSArray *array = [cell getScheduleObjectFieldArray];
            object.actualDanJia = array[0];
            object.actualPrice = array[1];
            object.actualCount = array[2];
            [totalArray addObject:object];
        }
        
    }else{
        
        for (int i = 0; i < self.hotelObject.scheduleList.count; i ++) {
            WLChargeUpScheduleObject *object = self.hotelObject.scheduleList[i];
            
            WLConsumeItemCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i + 1 inSection:0]];
            if (cell == nil) {
                break;
            }
            NSArray *array = [cell getScheduleObjectFieldArray];
            object.actualPrice = array[0];
            object.actualCount = array[1];
            
            [totalArray addObject:object];
        }
        
        for (int i = 0; i < self.itemArray.count; i ++) {
            WLChargeUpScheduleObject *object = self.itemArray[i];
            
            WLConsumeItemCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i + 1 + self.hotelObject.scheduleList.count inSection:0]];
            if (cell == nil) {
                break;
            }
            NSArray *array = [cell getScheduleObjectFieldArray];
            object.actualPrice = array[0];
            object.actualCount = array[1];
            
            [totalArray addObject:object];
        }
        
    }
    
    return [totalArray copy];
    
}

- (WLChargeUpScheduleObject *)getMiddleObjectWithIndex:(NSUInteger)index
{
    if (_middleObject && _middleObject.middleArray.count) {
        ItemCellType type = [self getCellItemTypeWithSection:index];
        if (self.itemType == TouristItemTypeAdditional && type == ItemCellTypeAddItem) {
            
            if (index >= 1 && index <= self.middleObject.middleArray.count) {
                return self.middleObject.middleArray[index - 1];
            }
            
        }else{
            if (type != ItemCellTypeHotelItem) {
                return nil;
            }
            if (index >= 1 && index <= self.middleObject.middleArray.count) {
                return self.middleObject.middleArray[index - 1];
            }
        }

    }
    return nil;
}


@end
