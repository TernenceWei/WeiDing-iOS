//
//  WLConsumeItemCell.m
//  WeiLvDJS
//
//  Created by ternence on 16/11/25.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLConsumeItemCell.h"

#define cell2Identifier @"WLConsumeItemCell"

@interface WLConsumeItemCell ()<UITextFieldDelegate>
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, assign) ItemCellType type;
@property (nonatomic, strong) WLChargeUpScheduleObject *scheduleObject;
@property (nonatomic, strong) WLChargeUpScheduleObject *middleObject;
@property (nonatomic, strong) NSMutableArray *textFildArray;
@property (nonatomic, assign) BOOL canEdit;
@property (nonatomic, assign) BOOL showList;
@property (nonatomic, strong) UILabel *remainLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, copy) void(^onAddNewItemClickBlock)(BOOL showList);
@property (nonatomic, copy) void(^onChooseAItemClickBlock)(NSUInteger index);
@property (nonatomic, copy) void(^onEndEditingBlock)();
@end

@implementation WLConsumeItemCell
- (NSMutableArray *)textFildArray
{
    if (!_textFildArray) {
        _textFildArray = [NSMutableArray array];
    }
    return _textFildArray;
}

+ (WLConsumeItemCell *)cellWithTableView:(UITableView*)tableView
                                    type:(ItemCellType)cellType
                          scheduleObject:(WLChargeUpScheduleObject *)scheduleObject
                               textArray:(NSArray *)textArray
                                 canEdit:(BOOL)canEdit
                                showList:(BOOL)showList
                            middleObject:(WLChargeUpScheduleObject *)middleObject{
    WLConsumeItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cell2Identifier];
    if (!cell) {
        cell = [[WLConsumeItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell2Identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.showList = showList;
    cell.canEdit = canEdit;
    cell.type = cellType;
    cell.titleArray = textArray;
    cell.scheduleObject = scheduleObject;
    cell.middleObject = middleObject;
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

- (void)setTag:(NSInteger)tag
{
    if (tag == 0) {
        self.line.hidden = YES;
    }else{
        if (self.type == ItemCellTypeItemList) {
            self.line.hidden = YES;
        }else{
            self.line.hidden = NO;
        }
    }
}

- (void)setupUI{
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = HEXCOLOR(0xd8d9dd);
    line.frame = CGRectMake(ScaleW(12), 0, ScreenWidth - ScaleW(12), 1);
    [self addSubview:line];
    self.line = line;
    
    if (self.type == ItemCellTypeTitle) {
        for (int i = 0; i < self.titleArray.count; i++) {
            [self setupTitleLabelWithIndex:i];
        }
        
    }else if (self.type == ItemCellTypeHotelItem){
        
        NSArray *labelArray = @[CHECKNIL(self.scheduleObject.priceName), CHECKNIL(self.scheduleObject.checkCount)];
        NSArray *fieldArray = @[CHECKNIL(self.scheduleObject.actualPrice), CHECKNIL(self.scheduleObject.actualCount)];
        for (int j = 0; j < 2; j ++) {
            [self setupLabelWithIndex:j textArray:labelArray additional:NO];
        }
        for (int j = 0; j < 2; j ++) {
            [self setupTextFieldWithIndex:j textArray:fieldArray additional:NO];
        }
        
    }else if (self.type == ItemCellTypeAddItem){
        
        NSArray *labelArray = @[CHECKNIL(self.scheduleObject.priceName), CHECKNIL(self.scheduleObject.primePrice)];
        NSArray *fieldArray = @[CHECKNIL(self.scheduleObject.actualDanJia),CHECKNIL(self.scheduleObject.actualPrice), CHECKNIL(self.scheduleObject.actualCount)];
        for (int j = 0; j < 2; j ++) {
            [self setupLabelWithIndex:j textArray:labelArray additional:YES];
        }
        for (int j = 0; j < 3; j ++) {
            [self setupTextFieldWithIndex:j textArray:fieldArray additional:YES];
        }
        
    }else if (self.type == ItemCellTypeAddBtn){
        
        UIButton *addBtn = [[UIButton alloc] init];
        [addBtn setImage:[UIImage imageNamed:@"addQuote"] forState:UIControlStateNormal];
        [addBtn setTitle:self.titleArray[0] forState:UIControlStateNormal];
        [addBtn setTitleColor:HEXCOLOR(0x879efb) forState:UIControlStateNormal];
        addBtn.frame = CGRectMake(0, 0, ScreenWidth, ScaleH(50));
        addBtn.titleLabel.font = [UIFont WLFontOfSize:15];
        [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addBtn];
        if (self.canEdit) {
            addBtn.userInteractionEnabled = YES;
        }else{
            addBtn.userInteractionEnabled = NO;
        }
        
    }else if (self.type == ItemCellTypeItemList){
        
        [self setupChoiceItem];
        
    }else if (self.type == ItemCellTypeAddFooter){
        
        [self setupAdditionalRemainLabel];
    }
    [self fillMiddleObject];
    
}

- (void)fillMiddleObject
{
    if (self.type == ItemCellTypeAddItem && self.middleObject) {
        UITextField *filed0 = self.textFildArray[0];
        filed0.text = self.middleObject.actualDanJia;
        UITextField *filed1 = self.textFildArray[1];
        filed1.text = self.middleObject.actualPrice;
        UITextField *filed2 = self.textFildArray[2];
        filed2.text = self.middleObject.actualCount;
        
    }
    if (self.type == ItemCellTypeHotelItem && self.middleObject) {
        UITextField *filed0 = self.textFildArray[0];
        filed0.text = self.middleObject.actualPrice;
        UITextField *filed1 = self.textFildArray[1];
        filed1.text = self.middleObject.actualCount;
        
    }
}

- (void)setAddNewItemClickBlock:(void (^)(BOOL))block chooseAItemBlock:(void (^)(NSUInteger index))chooseBlock endEditingBlock:(void (^)())endEditingBlock
{
    self.onAddNewItemClickBlock = block;
    self.onChooseAItemClickBlock = chooseBlock;
    self.onEndEditingBlock = endEditingBlock;
}

- (void)setupTitleLabelWithIndex:(NSUInteger)index
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = HEXCOLOR(0x6f7378);
    label.font = [UIFont WLFontOfSize:12];
    CGFloat width = ScreenWidth / self.titleArray.count;
    CGFloat height = ScaleH(50);
    label.frame = CGRectMake(width * index, 0, width, height);
    label.text = self.titleArray[index];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    [self addSubview:label];
}

- (void)setupLabelWithIndex:(NSUInteger)index textArray:(NSArray *)textArray additional:(BOOL)additional
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
    label.frame = CGRectMake(x, 0, width, height);
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    [self addSubview:label];
}

- (void)setupTextFieldWithIndex:(NSUInteger)index textArray:(NSArray *)textArray additional:(BOOL)additional
{
    UITextField *textField = [[UITextField alloc] init];
    CGFloat width = ScreenWidth / 4;
    if (additional) {
        width = ScreenWidth / 5;
    }
    CGFloat height = ScaleH(50);
    CGFloat x = width;
    NSString *text = textArray[index];
    if ([text isEqualToString:@""]) {
        text = @"0";
    }
    textField.text = text;
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
    textField.frame = CGRectMake(x, 0, width, height);
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

- (void)setupAdditionalRemainLabel
{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, ScreenWidth - ScaleW(12), ScaleH(50));
    label.textAlignment = NSTextAlignmentRight;
    label.textColor = HEXCOLOR(0x2f2f2f);
    [self addSubview:label];
    self.remainLabel = label;
    NSString *text = self.titleArray[0];
    if ([text isEqualToString:@""]) {
        text = @"0";
    }
    self.remainLabel.attributedText = [self getAdditionalRemainLabelTextWithActualPrice:text];
    
}
- (NSAttributedString *)getAdditionalRemainLabelTextWithActualPrice:(NSString *)actualPrice
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = HEXCOLOR(0x2f2f2f);
    attrs[NSFontAttributeName] = [UIFont WLFontOfSize:14];
    NSAttributedString *string1 = [[NSAttributedString alloc] initWithString:@"结余：    " attributes:attrs];
    
    NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc] initWithAttributedString:string1];
    
    NSMutableDictionary *attrs2 = [NSMutableDictionary dictionary];
    attrs2[NSForegroundColorAttributeName] = HEXCOLOR(0xff5b3d);
    attrs2[NSFontAttributeName] = [UIFont WLFontOfSize:14];
    NSAttributedString *string2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",actualPrice] attributes:attrs2];
    [mutableString  appendAttributedString:string2];
    
    return mutableString;
    
}

- (void)setupChoiceItem
{
    for (int i = 0;i < self.titleArray.count; i++) {
        UIButton *priceBtn = [[UIButton alloc] init];
        [priceBtn setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [priceBtn setTitleColor:HEXCOLOR(0x879efb) forState:UIControlStateNormal];
        [priceBtn setBackgroundImage:[UIImage imageNamed:@"addnewitem_bg"] forState:UIControlStateNormal];
        CGFloat width = ScreenWidth / 4;
        priceBtn.titleLabel.font = [UIFont WLFontOfSize:13];
        priceBtn.frame = CGRectMake(ScaleW(10) + (ScaleW(10) + width - ScaleW(20)) * i, ScaleH(8), width - ScaleW(20), ScaleH(34));
        priceBtn.tag = 1000 + i;
        [priceBtn addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:priceBtn];
        
    }
}

- (void)addBtnClick
{
    self.showList = !self.showList;
    self.onAddNewItemClickBlock(self.showList);
}

- (void)itemBtnClick:(UIButton *)button
{
    self.onChooseAItemClickBlock(button.tag - 1000);
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.onEndEditingBlock();
}

- (NSArray *)getScheduleObjectFieldArray
{
    UITextField *firstField = self.textFildArray[0];
    UITextField *secondField = self.textFildArray[1];
    if (self.type == ItemCellTypeAddItem) {
        UITextField *thirdField = self.textFildArray[2];
        return @[CHECKNIL(firstField.text), CHECKNIL(secondField.text),CHECKNIL(thirdField.text)];
    }else{
        return @[CHECKNIL(firstField.text), CHECKNIL(secondField.text)];
    }
}

- (void)setTotalJieyu:(NSString *)price
{
    if (price) {
        self.remainLabel.attributedText = [self getAdditionalRemainLabelTextWithActualPrice:price];
    }
    
}
@end
