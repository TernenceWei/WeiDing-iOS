//
//  WLConsumeBottomView.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/27.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLConsumeBottomView.h"

@interface WLConsumeBottomView ()<UITextFieldDelegate>
@property (nonatomic, assign) TouristItemType itemType;
@property (nonatomic, strong) WLChargeUpCarObject *carObject;
@property (nonatomic, strong) WLChargeUpHotelObject *hotelObject;
@property (nonatomic, strong) WLChargeUpRoleObject *roleObject;
@property (nonatomic, strong) WLChargeUpMiddleObject *middleObject;
@property (nonatomic, copy) void(^onAddNewItemClickBlock)(BOOL showList);
@property (nonatomic, copy) void(^onChooseAItemClickBlock)(WLChargeUpScheduleObject *object);
@property (nonatomic, copy) void(^onEndEditingBlock)();
@property (nonatomic, assign) BOOL showList;
@property (nonatomic, assign) BOOL canEdit;
@property (nonatomic, strong) NSArray *itemArray;
@property (nonatomic, strong) NSMutableArray *textFildArray;
@property (nonatomic, strong) UIButton *priceBtn;
@property (nonatomic, strong) UILabel *remainLabel;
@end

@implementation WLConsumeBottomView
- (NSMutableArray *)textFildArray
{
    if (!_textFildArray) {
        _textFildArray = [NSMutableArray array];
    }
    return _textFildArray;
}

- (instancetype)initWithFrame:(CGRect)frame
                     itemType:(TouristItemType)itemType
                       object:(id)object
                     showList:(BOOL)showList
                      canEdit:(BOOL)canEdit
                 newItemArray:(NSArray *)newItemArray
                 middleObject:(WLChargeUpMiddleObject *)middleObject
{
    self = [super initWithFrame:frame];
    if (self) {
        _itemType = itemType;

        if (self.itemType == TouristItemTypeCar) {
            
            self.carObject = (WLChargeUpCarObject *)object;
            
        }else if (self.itemType == TouristItemTypeShopping || self.itemType == TouristItemTypeAdditional) {
            
            self.roleObject = (WLChargeUpRoleObject *)object;
            
        }else{
            
            self.hotelObject = (WLChargeUpHotelObject *)object;
        }
        self.canEdit = canEdit;
        self.showList = showList;
        self.itemArray = newItemArray;
        self.middleObject = middleObject;
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI
{

    if (self.itemType == TouristItemTypeHotel || self.itemType == TouristItemTypeMeal || self.itemType == TouristItemTypeTicket) {
        if (self.hotelObject == nil) {
            return;
        }

        for (int i = 0; i < 4; i++) {
            [self setupTitleLabelWithIndex:i];
        }
        
        for (int i = 0; i < self.hotelObject.scheduleList.count; i++) {
            WLChargeUpScheduleObject *object = self.hotelObject.scheduleList[i];
            NSArray *labelArray = @[CHECKNIL(object.priceName), CHECKNIL(object.checkCount)];
            NSArray *fieldArray = @[CHECKNIL(object.actualPrice), CHECKNIL(object.actualCount)];
            for (int j = 0; j < 2; j ++) {
                [self setupLabelWithIndex:j yIndex:i textArray:labelArray additional:NO];
            }
            for (int j = 0; j < 2; j ++) {
                [self setupTextFieldWithIndex:j yIndex:i textArray:fieldArray additional:NO];
            }
        }
        for (int i = 0; i < self.itemArray.count; i ++) {
            WLChargeUpScheduleObject *object = self.itemArray[i];
            NSUInteger yIndex = i + (self.hotelObject.scheduleList.count);
            NSArray *labelArray = @[CHECKNIL(object.priceName), CHECKNIL(object.checkCount)];
            NSArray *fieldArray = @[CHECKNIL(object.actualPrice), CHECKNIL(object.actualCount)];
            for (int j = 0; j < 2; j ++) {
                [self setupLabelWithIndex:j yIndex:yIndex textArray:labelArray additional:NO];
            }
            for (int j = 0; j < 2; j ++) {
                [self setupTextFieldWithIndex:j yIndex:yIndex textArray:fieldArray additional:NO];
            }
        }

        
        for (int i = 0; i < self.hotelObject.scheduleList.count + self.itemArray.count + 1; i++) {
            [self setupLineWithIndex:i];
        }
        [self setupAddBtnWithY:ScaleH(50) * (self.hotelObject.scheduleList.count + self.itemArray.count + 1)];
        if (self.showList) {
            [self setupChoiceItem];
        }

        
    }else if (self.itemType == TouristItemTypeAdditional){//加点项目
        
        if (self.roleObject == nil) {
            return;
        }
        
        for (int i = 0; i < 5; i++) {
            [self setupTitleLabelWithIndex:i];
        }
        
        for (int i = 0; i < self.roleObject.scheduleList.count; i++) {
            WLChargeUpScheduleObject *object = self.roleObject.scheduleList[i];
            NSArray *labelArray = @[CHECKNIL(object.priceName), CHECKNIL(object.primePrice)];
            NSArray *fieldArray = @[CHECKNIL(object.actualDanJia),CHECKNIL(object.actualPrice), CHECKNIL(object.actualCount)];
            for (int j = 0; j < 2; j ++) {
                [self setupLabelWithIndex:j yIndex:i textArray:labelArray additional:YES];
            }
            for (int j = 0; j < 3; j ++) {
                [self setupTextFieldWithIndex:j yIndex:i textArray:fieldArray additional:YES];
            }
        }
        for (int i = 0; i < self.itemArray.count; i ++) {
            WLChargeUpScheduleObject *object = self.itemArray[i];
            NSUInteger yIndex = i + (self.roleObject.scheduleList.count);
            NSArray *labelArray = @[CHECKNIL(object.priceName), CHECKNIL(object.checkCount)];
            NSArray *fieldArray = @[CHECKNIL(object.actualPrice), CHECKNIL(object.actualCount)];
            for (int j = 0; j < 2; j ++) {
                [self setupLabelWithIndex:j yIndex:yIndex textArray:labelArray additional:YES];
            }
            for (int j = 0; j < 2; j ++) {
                [self setupTextFieldWithIndex:j yIndex:yIndex textArray:fieldArray additional:YES];
            }
        }
        
        
        for (int i = 0; i < self.roleObject.scheduleList.count + self.itemArray.count + 2; i++) {
            [self setupLineWithIndex:i];
        }
        [self setupAddBtnWithY:ScaleH(50) * (self.roleObject.scheduleList.count + self.itemArray.count + 1)];
        if (self.showList) {
            [self setupChoiceItem];
        }
        [self setupAdditionalRemainLabelWithY:self.bounds.size.height - ScaleH(45)];

    }
    [self fillMiddleObject];
    
}

- (void)setupTitleLabelWithIndex:(NSUInteger)index
{
    NSArray *textArray = [self getTitleTextArray];
    UILabel *label = [[UILabel alloc] init];
    label.textColor = HEXCOLOR(0x6f7378);
    label.font = [UIFont WLFontOfSize:12];
    CGFloat width = ScreenWidth / textArray.count;
    CGFloat height = ScaleH(50);
    label.frame = CGRectMake(width * index, 0, width, height);
    label.text = textArray[index];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    [self addSubview:label];
}

- (void)setupLabelWithIndex:(NSUInteger)index yIndex:(NSUInteger)yIndex textArray:(NSArray *)textArray additional:(BOOL)additional
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = HEXCOLOR(0x6f7378);
    label.font = [UIFont WLFontOfSize:12];
    CGFloat x = 0;
    CGFloat width = ScreenWidth / 4;
    if (additional) {
        width = ScreenWidth / 5;
    }
    CGFloat height = ScaleH(50);
    label.text = textArray[index];
    if (index == 0) {
        
    }else if (index == 1) {
        if (additional) {
            x = width;
        }else{
            x = width * 2;
        }
        
    }
    label.frame = CGRectMake(x, height * (yIndex+ 1), width, height);
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    [self addSubview:label];
}

- (void)setupTextFieldWithIndex:(NSUInteger)index yIndex:(NSUInteger)yIndex textArray:(NSArray *)textArray additional:(BOOL)additional
{
    UITextField *textField = [[UITextField alloc] init];
    CGFloat width = ScreenWidth / 4;
    if (additional) {
        width = ScreenWidth / 5;
    }
    CGFloat height = ScaleH(50);
    CGFloat x = width;
    textField.text = textArray[index];
    if (index == 0) {
        if (additional) {
            x = width * 2;
        }
        
    }else if (index == 1) {
        if (additional) {
            x = width * 3;
        }else{
            x = width * 3;
        }
        
    }else if (index == 2) {
        x = width * 4;
    }
    textField.frame = CGRectMake(x, height * (yIndex+ 1), width, height);
    textField.textAlignment = NSTextAlignmentCenter;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.textColor = HEXCOLOR(0x879efb);
    textField.delegate = self;
    textField.font = [UIFont WLFontOfSize:14];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:textField];
    [self.textFildArray addObject:textField];
    
    if (self.canEdit) {
        textField.userInteractionEnabled = YES;
    }else{
        textField.userInteractionEnabled = NO;
    }
}

- (void)setupLineWithIndex:(NSUInteger)index
{
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = HEXCOLOR(0xd8d9dd);
    line.frame = CGRectMake(ScaleW(12), ScaleH(50) * (index+1), ScreenWidth, 1);
    [self addSubview:line];
}

- (void)setupAddBtnWithY:(CGFloat)y
{
    UIButton *addBtn = [[UIButton alloc] init];
    [addBtn setImage:[UIImage imageNamed:@"addQuote"] forState:UIControlStateNormal];
    [addBtn setTitle:[self getAddBtnTitle] forState:UIControlStateNormal];
    [addBtn setTitleColor:HEXCOLOR(0x879efb) forState:UIControlStateNormal];
    addBtn.frame = CGRectMake(0, y, ScreenWidth, ScaleH(50));
    addBtn.titleLabel.font = [UIFont WLFontOfSize:15];
    [addBtn addTarget:self action:@selector(showItemListBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addBtn];
    if (self.canEdit) {
        addBtn.userInteractionEnabled = YES;
    }else{
        addBtn.userInteractionEnabled = NO;
    }
    if (self.hotelObject.priceList.count) {
        addBtn.userInteractionEnabled = YES;
    }else{
        addBtn.userInteractionEnabled = NO;
    }
    
}

- (void)setupChoiceItem
{
    if (self.itemType == TouristItemTypeHotel || self.itemType == TouristItemTypeMeal || self.itemType == TouristItemTypeTicket) {
        for (int i = 0;i < self.hotelObject.priceList.count; i++) {
            WLChargeUpScheduleObject *priceObject = self.hotelObject.priceList[i];
            UIButton *priceBtn = [[UIButton alloc] init];
            [priceBtn setTitle:priceObject.priceName forState:UIControlStateNormal];
            [priceBtn setTitleColor:HEXCOLOR(0x879efb) forState:UIControlStateNormal];
            [priceBtn setBackgroundImage:[UIImage imageNamed:@"addnewitem_bg"] forState:UIControlStateNormal];
            CGFloat width = ScreenWidth / 4;
            priceBtn.titleLabel.font = [UIFont WLFontOfSize:13];
            priceBtn.frame = CGRectMake(ScaleW(10) + (ScaleW(10) + width - ScaleW(20)) * i, ScaleH(50) * (self.hotelObject.scheduleList.count + 2 + self.itemArray.count) + ScaleH(8), width - ScaleW(20), ScaleH(34));
            priceBtn.tag = 1000 + i;
            [priceBtn addTarget:self action:@selector(addNewItemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:priceBtn];
        
        }
    }
    
}

- (void)addNewItemBtnClick:(UIButton *)button
{
    self.onChooseAItemClickBlock(self.hotelObject.priceList[button.tag - 1000]);
}

- (void)showItemListBtnClick
{
    self.showList = !self.showList;
    self.onAddNewItemClickBlock(self.showList);
}

- (NSArray *)getTitleTextArray
{
    NSArray *titleArray = nil;
    if (self.itemType == TouristItemTypeHotel) {
        titleArray = @[@"房型",@"实际单价\n（元/间）",@"调配数量\n（间）",@"实际数量\n（间）"];
    }else if (self.itemType == TouristItemTypeMeal) {
        titleArray = @[@"团餐类型",@"实际单价\n（元/桌）",@"调配数量\n（桌）",@"实际数量\n（桌）"];
    }else if (self.itemType == TouristItemTypeTicket) {
        titleArray = @[@"门票类别",@"实际单价\n（元/张）",@"调配数量\n（人）",@"实际数量\n（人）"];
    }else if (self.itemType == TouristItemTypeAdditional) {
        titleArray = @[@"门票类别",@"调配单价\n（元）",@"实际单价\n（元）",@"实际收费\n（元）",@"实际数量\n（张）"];
    }
    return titleArray;

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

- (void)setAddNewItemClickBlock:(void (^)(BOOL))block chooseAItemBlock:(void (^)(WLChargeUpScheduleObject *object))chooseBlock endEditingBlock:(void (^)())endEditingBlock
{
    self.onAddNewItemClickBlock = block;
    self.onChooseAItemClickBlock = chooseBlock;
    self.onEndEditingBlock = endEditingBlock;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.itemType == TouristItemTypeAdditional) {
        NSArray *middleObject = [self getScheduleObjectArray];
        int count = 0;
        for (WLChargeUpScheduleObject *object in middleObject) {
            count += ((object.actualPrice.intValue - object.actualDanJia.intValue) * object.actualCount.intValue);
        }
        self.remainLabel.attributedText = [self getAdditionalRemainLabelTextWithActualPrice:count];
        
    }else{
        self.onEndEditingBlock();
    }
    
    
}

- (void)setupAdditionalRemainLabelWithY:(CGFloat)y
{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, y, ScreenWidth - ScaleW(12), ScaleH(50));
    label.textAlignment = NSTextAlignmentRight;
    label.text = @"结余：0";
    label.textColor = HEXCOLOR(0x2f2f2f);
    [self addSubview:label];
    self.remainLabel = label;

    int count = 0;
    for (WLChargeUpScheduleObject *object in self.roleObject.scheduleList) {
        count += ((object.actualPrice.intValue - object.actualDanJia.intValue) * object.actualCount.intValue);
    }
    self.remainLabel.attributedText = [self getAdditionalRemainLabelTextWithActualPrice:count];
    
}

- (NSAttributedString *)getAdditionalRemainLabelTextWithActualPrice:(NSUInteger)actualPrice
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = HEXCOLOR(0x2f2f2f);
    attrs[NSFontAttributeName] = [UIFont WLFontOfSize:14];
    NSAttributedString *string1 = [[NSAttributedString alloc] initWithString:@"结余：    " attributes:attrs];
    
    NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc] initWithAttributedString:string1];
    
    NSMutableDictionary *attrs2 = [NSMutableDictionary dictionary];
    attrs2[NSForegroundColorAttributeName] = HEXCOLOR(0xff5b3d);
    attrs2[NSFontAttributeName] = [UIFont WLFontOfSize:14];
    NSAttributedString *string2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%ld",(unsigned long)actualPrice] attributes:attrs2];
    [mutableString  appendAttributedString:string2];
    
    return mutableString;
    
}


- (void)setRemainLabelText
{
    NSArray *array = [self getScheduleObjectArray];
    NSUInteger count = 0;
    for (WLChargeUpScheduleObject *object in array) {
        count += ((object.actualPrice.integerValue - object.actualDanJia.integerValue) * object.checkCount.integerValue);
    }
    self.remainLabel.attributedText = [self getAdditionalRemainLabelTextWithActualPrice:count];
    
}

- (void)fillMiddleObject
{
    if (self.middleObject == nil || self.middleObject.middleArray.count == 0) {
        return;
    }
    if (self.itemType == TouristItemTypeAdditional) {
        
        for (int i = 0; i < self.roleObject.scheduleList.count; i ++) {
            WLChargeUpScheduleObject *object = self.middleObject.middleArray[i];
            UITextField *priceField = self.textFildArray[i * 2];
            if (object.actualPrice != nil) {
                priceField.text = object.actualPrice;
            }
            
            UITextField *countField = self.textFildArray[i * 2 + 1];
            if (object.actualCount != nil) {
                countField.text = object.actualCount;
            }
            
        }
        
        for (int i = 0; i < self.itemArray.count; i ++) {
            WLChargeUpScheduleObject *object = self.middleObject.middleArray[i + self.roleObject.scheduleList.count];
            
            UITextField *priceField = self.textFildArray[(i + self.roleObject.scheduleList.count) * 2];
            if (object.actualPrice != nil) {
                priceField.text = object.actualPrice;
            }
            
            UITextField *countField = self.textFildArray[(i + self.roleObject.scheduleList.count) * 2 + 1];
            if (object.actualCount != nil) {
                countField.text = object.actualCount;
            }
            
            
        }
        
    }else{
        
        for (int i = 0; i < self.hotelObject.scheduleList.count; i ++) {
            WLChargeUpScheduleObject *object = self.middleObject.middleArray[i];
            UITextField *priceField = self.textFildArray[i * 2];
            if (object.actualPrice != nil) {
                priceField.text = object.actualPrice;
            }
            
            UITextField *countField = self.textFildArray[i * 2 + 1];
            if (object.actualCount != nil) {
                countField.text = object.actualCount;
            }
            
            
        }
        
        for (int i = 0; i < self.itemArray.count; i ++) {
            if (self.middleObject.middleArray.count > i + self.hotelObject.scheduleList.count) {
                WLChargeUpScheduleObject *object = self.middleObject.middleArray[i + self.hotelObject.scheduleList.count];
                
                UITextField *priceField = self.textFildArray[(i + self.hotelObject.scheduleList.count) * 2];
                if (object.actualPrice != nil) {
                    priceField.text = object.actualPrice;
                }
                
                UITextField *countField = self.textFildArray[(i + self.hotelObject.scheduleList.count) * 2 + 1];
                if (object.actualCount != nil) {
                    countField.text = object.actualCount;
                }
            }
            
        }
        
    }

}

- (NSArray *)getScheduleObjectArray
{
    NSMutableArray *totalArray = [NSMutableArray array];
    if (self.itemType == TouristItemTypeAdditional) {
        
        for (int i = 0; i < self.roleObject.scheduleList.count; i ++) {
            WLChargeUpScheduleObject *object = self.roleObject.scheduleList[i];
            UITextField *danjiaField = self.textFildArray[i * 2];
            object.actualDanJia = danjiaField.text;
            UITextField *priceField = self.textFildArray[i * 2 + 1];
            object.actualPrice = priceField.text;
            UITextField *countField = self.textFildArray[i * 2 + 2];
            object.actualCount = countField.text;
            
            [totalArray addObject:object];
        }
        
        for (int i = 0; i < self.itemArray.count; i ++) {
            WLChargeUpScheduleObject *object = self.itemArray[i];
            
            UITextField *danjiaField = self.textFildArray[(i + self.roleObject.scheduleList.count) * 2];
            object.actualDanJia = danjiaField.text;
            UITextField *priceField = self.textFildArray[(i + self.roleObject.scheduleList.count) * 2 + 1];
            object.actualPrice = priceField.text;
            UITextField *countField = self.textFildArray[(i + self.roleObject.scheduleList.count) * 2 + 2];
            object.actualCount = countField.text;
            
            [totalArray addObject:object];
        }
        
    }else{
        
        for (int i = 0; i < self.hotelObject.scheduleList.count; i ++) {
            WLChargeUpScheduleObject *object = self.hotelObject.scheduleList[i];
            UITextField *priceField = self.textFildArray[i * 2];
            object.actualPrice = priceField.text;
            UITextField *countField = self.textFildArray[i * 2 + 1];
            object.actualCount = countField.text;
            
            [totalArray addObject:object];
        }
        
        for (int i = 0; i < self.itemArray.count; i ++) {
            WLChargeUpScheduleObject *object = self.itemArray[i];
            
            UITextField *priceField = self.textFildArray[(i + self.hotelObject.scheduleList.count) * 2];
            object.actualPrice = priceField.text;
            UITextField *countField = self.textFildArray[(i + self.hotelObject.scheduleList.count) * 2 + 1];
            object.actualCount = countField.text;
            
            [totalArray addObject:object];
        }
        
    }

    return [totalArray copy];

}

@end
