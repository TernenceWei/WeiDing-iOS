//
//  WLCurrentGroupItemCell.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/14.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLCurrentGroupItemCell.h"

#define cellIdentifier @"WLCurrentGroupItemCell"

@interface WLCurrentGroupItemCell ()

@property (nonatomic,copy) void (^onLeftBtnClickBlock)();
@property (nonatomic,copy) void (^onRightBtnClickBlock)();



@property (nonatomic, strong) UILabel *firstLabel;
@property (nonatomic, strong) UILabel *secondLabel;
@property (nonatomic, strong) UILabel *thirdLabel;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@end

@implementation WLCurrentGroupItemCell

+ (WLCurrentGroupItemCell *)cellWithTableView:(UITableView*)tableView{
    WLCurrentGroupItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLCurrentGroupItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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

- (void)setType:(GroupItemCellType)type
{
    _type = type;
    
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    
    self.firstLabel = [[UILabel alloc] init];
    self.firstLabel.textColor = HEXCOLOR(0x868686);
    self.firstLabel.font = WLFontSize(14);
    self.firstLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.firstLabel];
    
    self.secondLabel = [[UILabel alloc] init];
    self.secondLabel.textColor = HEXCOLOR(0x868686);
    self.secondLabel.font = WLFontSize(14);
    self.secondLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.secondLabel];
    
    self.thirdLabel = [[UILabel alloc] init];
    self.thirdLabel.textColor = HEXCOLOR(0x868686);
    self.thirdLabel.font = WLFontSize(14);
    self.thirdLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.thirdLabel];
    
    
    CGFloat width = ScreenWidth / 3;
    CGFloat height = ScaleH(45);
    CGFloat itemX = ScaleW(10);
    if (self.type == GroupItemCellTypeTitle) {
        
        self.firstLabel.textColor = HEXCOLOR(0x2f2f2f);
        self.firstLabel.textAlignment = NSTextAlignmentLeft;
        self.firstLabel.frame = CGRectMake(itemX, 0, width - itemX, height);
        
        self.secondLabel.textColor = HEXCOLOR(0x2f2f2f);
        self.secondLabel.textAlignment = NSTextAlignmentCenter;
        self.secondLabel.frame = CGRectMake(width, 0, width, height);
        
        self.thirdLabel.textColor = HEXCOLOR(0x2f2f2f);
        self.thirdLabel.textAlignment = NSTextAlignmentRight;
        self.thirdLabel.frame = CGRectMake(width * 2 , 0, width - itemX, height);
        
    }else if (self.type == GroupItemCellTypeItem){
        
        self.firstLabel.textColor = HEXCOLOR(0x868686);
        self.firstLabel.textAlignment = NSTextAlignmentLeft;
        self.firstLabel.frame = CGRectMake(itemX, 0, width - itemX, height);
        
        self.secondLabel.textColor = HEXCOLOR(0x868686);
        self.secondLabel.textAlignment = NSTextAlignmentCenter;
        self.secondLabel.frame = CGRectMake(width, 0, width, height);
        
        self.thirdLabel.textColor = HEXCOLOR(0x868686);
        self.thirdLabel.textAlignment = NSTextAlignmentRight;
        self.thirdLabel.frame = CGRectMake(width * 2 , 0, width - itemX, height);
        
    }else if (self.type == GroupItemCellTypeContact){
        
        self.firstLabel.textColor = HEXCOLOR(0x868686);
        self.firstLabel.textAlignment = NSTextAlignmentLeft;
        self.firstLabel.frame = CGRectMake(itemX, 0, ScreenWidth / 2 - itemX, height);
        
        self.secondLabel.textColor = HEXCOLOR(0x868686);
        self.secondLabel.textAlignment = NSTextAlignmentCenter;
        self.secondLabel.frame = CGRectMake(ScreenWidth / 2, 0, ScreenWidth / 2, height);

        
    }else if (self.type == GroupItemCellTypeAction){
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = HEXCOLOR(0xd8d9dd);
        line.frame = CGRectMake(ScaleW(10), 0, ScreenWidth - ScaleW(10), 1);
        [self addSubview:line];
        
        self.leftBtn = [[UIButton alloc] init];
        [self.leftBtn setTitle:@"联系酒店" forState:UIControlStateNormal];
        [self.leftBtn setTitleColor:HEXCOLOR(0x868686) forState:UIControlStateNormal];
        [self.leftBtn setImage:[UIImage imageNamed:@"group_contact_phone"] forState:UIControlStateNormal];
        [self.leftBtn addTarget:self action:@selector(onClickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, ScaleW(10), 0, 0)];
        self.leftBtn.titleLabel.font = WLFontSize(15);
        [self addSubview:self.leftBtn];
        
        self.rightBtn = [[UIButton alloc] init];
        [self.rightBtn setTitle:@"记账" forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:HEXCOLOR(0x868686) forState:UIControlStateNormal];
        [self.rightBtn setImage:[UIImage imageNamed:@"group_chargeup"] forState:UIControlStateNormal];
        [self.rightBtn addTarget:self action:@selector(onClickRightBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, ScaleW(10), 0, 0)];
        self.rightBtn.titleLabel.font = WLFontSize(15);
        [self addSubview:self.rightBtn];
        
        self.leftBtn.frame = CGRectMake(0, 0, ScreenWidth / 2, ScaleH(45));
        self.rightBtn.frame = CGRectMake(ScreenWidth / 2, 0, ScreenWidth / 2, ScaleH(45));
    }else if (self.type == GroupItemCellTypeCarTitle) {
        
        self.firstLabel.textColor = HEXCOLOR(0x2f2f2f);
        self.firstLabel.textAlignment = NSTextAlignmentLeft;
        self.firstLabel.frame = CGRectMake(itemX, 0, ScreenWidth / 2, height);
        
        self.secondLabel.textColor = HEXCOLOR(0x2f2f2f);
        self.secondLabel.textAlignment = NSTextAlignmentCenter;
        self.secondLabel.frame = CGRectMake(ScreenWidth / 2, 0, ScreenWidth / 2, height);
        
    }else if (self.type == GroupItemCellTypeCarItem){
        
        self.firstLabel.textColor = HEXCOLOR(0x868686);
        self.firstLabel.textAlignment = NSTextAlignmentLeft;
        self.firstLabel.frame = CGRectMake(itemX, 0, ScreenWidth / 2, height);
        
        self.secondLabel.textColor = HEXCOLOR(0x868686);
        self.secondLabel.textAlignment = NSTextAlignmentCenter;
        self.secondLabel.frame = CGRectMake(ScreenWidth / 2, 0, ScreenWidth / 2, height);
   
    }else{
        UIView *marginView = [[UIView alloc] init];
        marginView.frame = CGRectMake(0, 0, ScreenWidth, ScaleH(10));
        [self addSubview:marginView];
    }

}

- (void)setDataArray:(NSArray *)dataArray
{
    if (dataArray.count == 0) {
        return;
    }
    if (self.type == GroupItemCellTypeItem || self.type == GroupItemCellTypeTitle) {
        self.firstLabel.text = dataArray[0];
        self.secondLabel.text = dataArray[1];
        if (dataArray.count >= 3) {
            self.thirdLabel.text = dataArray[2];
        }
        
    }else if (self.type == GroupItemCellTypeContact){
        
        self.firstLabel.text = dataArray[0];
        self.secondLabel.text = dataArray[1];
        
    }else if (self.type == GroupItemCellTypeAction){
        [self.leftBtn setTitle:dataArray[0] forState:UIControlStateNormal];
        
        if (dataArray.count >= 2) {
            NSString *rightText = dataArray[1];
            [self.rightBtn setTitle:rightText forState:UIControlStateNormal];
            if ([rightText isEqualToString:@"记账"]) {
                [self.rightBtn setImage:[UIImage imageNamed:@"group_chargeup"] forState:UIControlStateNormal];
            }else if([rightText isEqualToString:@"编辑账单"]){
                [self.rightBtn setImage:[UIImage imageNamed:@"group_edit"] forState:UIControlStateNormal];
            }else if([rightText isEqualToString:@"查看账单"]){
                [self.rightBtn setImage:[UIImage imageNamed:@"group_check"] forState:UIControlStateNormal];
            }
        }
        
    }else if (self.type == GroupItemCellTypeCarTitle){
        
        self.firstLabel.text = dataArray[0];
        self.secondLabel.text = dataArray[1];
        
    }else if (self.type == GroupItemCellTypeCarItem){
        
        self.firstLabel.text = dataArray[0];
        self.secondLabel.text = dataArray[1];
        
    }
    
    if (!self.canChargeup) {
        [self.rightBtn setImage:nil forState:UIControlStateNormal];
        [self.rightBtn setTitle:nil forState:UIControlStateNormal];
    }
}

- (void)onClickLeftBtn
{
    self.onLeftBtnClickBlock();
}

- (void)onClickRightBtn
{
    NSString *title = [self.rightBtn titleForState:UIControlStateNormal];
    if (title == nil) {
        return;
    }
    self.onRightBtnClickBlock();
}

- (void)setLeftBtnClickAction:(void (^)())leftBlock rightBtnClickAction:(void (^)())rightBlock
{
    self.onLeftBtnClickBlock = leftBlock;
    self.onRightBtnClickBlock = rightBlock;
}


@end
