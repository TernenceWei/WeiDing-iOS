//
//  WLConsumeTopView.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/27.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLConsumeTopView.h"

@interface WLConsumeTopView ()<UITextFieldDelegate>
@property (nonatomic, assign) TouristItemType itemType;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSMutableArray *labelArray;
@property (nonatomic, assign) BOOL canEdit;
@property (nonatomic, strong) WLChargeUpCarObject *carObject;
@property (nonatomic, strong) WLChargeUpHotelObject *hotelObject;
@property (nonatomic, strong) WLChargeUpRoleObject *roleObject;
@property (nonatomic, strong) WLChargeUpMiddleObject *middleObject;
@property (nonatomic, strong) NSMutableArray *textFildArray;
@property (nonatomic, copy) void(^onEndEditingBlock)();

@end

@implementation WLConsumeTopView
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
                      canEdit:(BOOL)canEdit
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
        
        NSArray *textArray = @[@"入住人数",@"avb",@"入住时间",CHECKNIL(self.hotelObject.whichDay)];
        if (self.itemType == TouristItemTypeMeal || self.itemType == TouristItemTypeTicket) {
            textArray = @[@"消费人数",@"avb",@"消费时间",CHECKNIL(self.hotelObject.whichDay)];
        }
        for (int i = 0; i < 4; i++) {
            if (i != 1) {
                [self setupHotelLabelWithIndex:i text:textArray[i]];
            }
            
        }
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(ScreenWidth - ScaleW(12) - ScreenWidth / 3, 0, ScreenWidth / 3, ScaleH(45))];
        self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.textField.textAlignment = NSTextAlignmentRight;
        self.textField.text = self.hotelObject.actualPerson;
        self.textField.textColor = HEXCOLOR(0x879efb);
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
        self.textField.delegate = self;
        self.textField.font = [UIFont WLFontOfSize:14];
        [self addSubview:self.textField];
        if (self.middleObject.actualPerson != nil && ![self.middleObject.actualPerson isEqualToString:@""]) {
            self.textField.text = self.middleObject.actualPerson;
        }
        
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = HEXCOLOR(0xd8d9dd);
        line.frame = CGRectMake(ScaleW(12), ScaleH(45), ScreenWidth, 1);
        [self addSubview:line];
        
    }else if (self.itemType == TouristItemTypeCar) {
        if (self.carObject == nil) {
            return;
        }
        NSArray *btnTextArray = @[self.carObject.startAddress,self.carObject.endAddress];
        for (int i = 0; i < 2; i++) {
           
            [self setupCarBtnWithIndex:i text:btnTextArray[i]];
        }
        NSArray *labeltextArray = @[self.carObject.startTime,self.carObject.endTime,@"实际总价"];
        for (int i = 0; i < 3; i++) {
            
            [self setupCarLabelWithIndex:i text:labeltextArray[i]];
        }
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(ScreenWidth - ScaleW(12) - ScreenWidth / 3, ScaleH(120), ScreenWidth / 3, ScaleH(45))];
        self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.textField.textAlignment = NSTextAlignmentRight;
        self.textField.text = self.carObject.actualPrice;
        self.textField.textColor = HEXCOLOR(0xff5b3d);
        self.textField.userInteractionEnabled = YES;
        self.textField.font = [UIFont WLFontOfSize:14];
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
        self.textField.delegate = self;
        [self addSubview:self.textField];
        
        UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(12), ScaleH(58), ScreenWidth, 2)];
        line1.image = [self drawLineByImageView:line1];
        [self addSubview:line1];
        
        UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(12), ScaleH(118), ScreenWidth, 2)];
        line2.image = [self drawLineByImageView:line2];
        [self addSubview:line2];
        
    }else if (self.itemType == TouristItemTypeShopping || self.itemType == TouristItemTypeAdditional){
        
        if (self.roleObject == nil) {
            return;
        }
        NSArray *btnTextArray;
        NSArray *labeltextArray;
        if (self.itemType == TouristItemTypeAdditional) {
            btnTextArray = @[@"消费人数",@"消费时间",@"支付方式",CHECKNIL(self.roleObject.whichDate)];
            NSString *settlementString = @"挂账";
            if (self.roleObject.settlementMode == 0) {
                settlementString = @"现付";
            }
            labeltextArray = @[CHECKNIL(self.roleObject.actualPersons),settlementString];
        }else{
            btnTextArray = @[@"消费人数",@"消费时间",@"消费金额",CHECKNIL(self.roleObject.whichDate)];
            labeltextArray = @[CHECKNIL(self.roleObject.actualPersons),CHECKNIL(self.roleObject.actualPrice)];
        }
        for (int i = 0; i < 4; i++) {
            
            [self setupShopLabelWithIndex:i text:btnTextArray[i]];
        }
        
        for (int i = 0; i < 2; i++) {
            
            [self setupShopFieldWithIndex:i text:labeltextArray[i]];
        }
        UITextField *countField = self.textFildArray[0];
        UITextField *priceField = self.textFildArray[1];
        if (self.middleObject.actualPerson != nil && ![self.middleObject.actualPerson isEqualToString:@""]) {
            countField.text = self.middleObject.actualPerson;
        }
        if (self.middleObject.consumePrice != nil && ![self.middleObject.consumePrice isEqualToString:@""]) {
            priceField.text = self.middleObject.consumePrice;
        }
        for (int i = 0; i < 2; i++) {
            UIView *line = [[UIView alloc] init];
            line.backgroundColor = HEXCOLOR(0xd8d9dd);
            line.frame = CGRectMake(ScaleW(12), ScaleH(45) * (i + 1), ScreenWidth, 1);
            [self addSubview:line];
        }
        
    }
    if (self.canEdit) {
        self.textField.userInteractionEnabled = YES;
    }else{
        self.textField.userInteractionEnabled = NO;
    }
}


- (void)setupHotelLabelWithIndex:(NSUInteger)index text:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = HEXCOLOR(0x6f7378);
    label.font = [UIFont WLFontOfSize:14];
    CGFloat x = ScaleW(12);
    CGFloat width = ScreenWidth / 2;
    CGFloat height = ScaleH(45);
    if (index % 2 == 0) {
        label.textColor = HEXCOLOR(0x2f2f2f);
        label.textAlignment = NSTextAlignmentLeft;
        
    }else {
        label.textColor = HEXCOLOR(0x868686);
        label.textAlignment = NSTextAlignmentRight;
        x = ScreenWidth - ScaleW(12) - width;
    }
    
    label.frame = CGRectMake(x, height * (index / 2), width, height);
    label.text = text;
    [self addSubview:label];
}

- (void)setupCarBtnWithIndex:(NSUInteger)index text:(NSString *)text
{
    UIButton *addBtn = [[UIButton alloc] init];
    NSString *iconName = @"chargeup_car_startIcon";
    if (index == 1) {
        iconName = @"chargeup_car_endIcon";
    }
    [addBtn setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
    [addBtn setTitle:text forState:UIControlStateNormal];
    [addBtn setTitleColor:HEXCOLOR(0x2f2f2f) forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont WLFontOfSize:14];
    addBtn.frame = CGRectMake(ScaleW(12), ScaleH(60) * index, ScreenWidth, ScaleH(30));
    addBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    addBtn.titleEdgeInsets = UIEdgeInsetsMake(0, ScaleW(6), 0, 0);
    [self addSubview:addBtn];
    
}

- (void)setupCarLabelWithIndex:(NSUInteger)index text:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont WLFontOfSize:14];
    CGFloat width = ScreenWidth;
    CGFloat height = ScaleH(30);
    label.textColor = HEXCOLOR(0x868686);
    label.textAlignment = NSTextAlignmentLeft;
    CGFloat x = ScaleW(35);
    CGFloat y = ScaleH(30) + ScaleH(60) * index;
    if (index == 2) {
        x = ScaleW(12);
        y = ScaleH(60) * 2;
        width = ScreenWidth / 2;
        height = ScaleH(45);
        label.textColor = HEXCOLOR(0x2f2f2f);

    }
    label.frame = CGRectMake(x, y, width, height);
    label.text = text;
    [self addSubview:label];
}

- (void)setupShopLabelWithIndex:(NSUInteger)index text:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = HEXCOLOR(0x2f2f2f);
    label.font = [UIFont WLFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    CGFloat x = ScaleW(12);
    CGFloat width = ScreenWidth / 2;
    CGFloat height = ScaleH(45);
    CGFloat y = height * index;
    if (index == 3) {
        x = ScreenWidth - ScaleW(12) - width;
        y = height ;
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = HEXCOLOR(0x868686);
    }
    label.frame = CGRectMake(x, y, width, height);
    label.text = text;
    [self addSubview:label];
}

- (void)setupShopFieldWithIndex:(NSUInteger)index text:(NSString *)text{
    
    UITextField *textField = [[UITextField alloc] init];
    CGFloat width = ScreenWidth / 2;
    CGFloat height = ScaleH(45);
    CGFloat x = ScreenWidth - ScaleW(12) - width;
    CGFloat y = 0;
    if (index == 0) {
        textField.textColor = HEXCOLOR(0x2f2f2f);
    }else{
        y = ScaleH(45) * 2;
        textField.textColor = HEXCOLOR(0xff5b3d);
        if (self.itemType == TouristItemTypeAdditional) {
            textField.textColor = HEXCOLOR(0x868686);
        }
        
    }
    textField.text = text;
    textField.frame = CGRectMake(x, y, width, height);
    textField.textAlignment = NSTextAlignmentRight;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.delegate = self;
    textField.font = [UIFont WLFontOfSize:14];
    [self addSubview:textField];
    [self.textFildArray addObject:textField];
    if (index == 0 && self.middleObject.actualPerson != nil && ![self.middleObject.actualPerson isEqualToString:@""]) {
        textField.text = self.middleObject.actualPerson;
    }else{
        if (index == 1 && self.middleObject.consumePrice != nil && ![self.middleObject.consumePrice isEqualToString:@""]){
        textField.text = self.middleObject.consumePrice;
        }
    }
    if (self.canEdit) {
        textField.userInteractionEnabled = YES;
        if (self.itemType == TouristItemTypeAdditional && index == 1) {
            textField.userInteractionEnabled = NO;
        }
    }else{
        textField.userInteractionEnabled = NO;
    }
    
}

- (UIImage *)drawLineByImageView:(UIImageView *)imageView
{
    UIGraphicsBeginImageContext(imageView.frame.size);
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGFloat lengths[] = {9,6};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, [WLTools stringToColor:@"#d8d9dd"].CGColor);
    CGContextSetLineDash(line, 0, lengths, 1);
    CGContextMoveToPoint(line, 0.0, 2.0);
    CGContextAddLineToPoint(line, ScreenWidth - 10, 2.0);
    CGContextStrokePath(line);
    return UIGraphicsGetImageFromCurrentImageContext();
}

- (NSArray *)getTopViewTextArray
{
 
    if (self.itemType == TouristItemTypeShopping) {
        UITextField *field0 = self.textFildArray[0];
        UITextField *field1 = self.textFildArray[1];
        return @[CHECKNIL(field0.text), CHECKNIL(field1.text)];
    }if (self.itemType == TouristItemTypeAdditional) {
        UITextField *field0 = self.textFildArray[0];
        UITextField *field1 = self.textFildArray[1];
        return @[CHECKNIL(field0.text), CHECKNIL(field1.text)];
    }
    return @[CHECKNIL(self.textField.text)];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.onEndEditingBlock();
}

- (void)setEndEditingBlock:(void (^)())endEditingBlock
{
    self.onEndEditingBlock = endEditingBlock;
}
@end
