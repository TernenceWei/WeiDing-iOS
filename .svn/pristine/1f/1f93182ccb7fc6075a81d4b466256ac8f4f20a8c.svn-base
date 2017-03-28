//
//  WLCarBookingAddressCell.m
//  WeiLvDJS
//
//  Created by ternence on 2017/1/19.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLCarBookingAddressCell.h"

#define cellIdentifier @"WLCarBookingAddressCell"

@interface WLCarBookingAddressCell ()

@property (nonatomic, copy) void(^onAddressAction)(AddressActionType actionType, NSInteger deleteIndex);
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray *pointArray;
@property (nonatomic, strong) NSMutableArray *buttonArray;

@end

@implementation WLCarBookingAddressCell
+ (WLCarBookingAddressCell *)cellWithTableView:(UITableView*)tableView
                                    titleArray:(NSArray *)titleArray
                                 addressAction:(void (^)(AddressActionType, NSInteger))addressAction
                                   detailArray:(NSArray *)detailArray
{
    
    WLCarBookingAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLCarBookingAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.onAddressAction = addressAction;
    cell.titleArray = titleArray;
    [cell setupUI];
    [cell setDetailAddress:detailArray];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.exclusiveTouch = YES;
        self.multipleTouchEnabled = NO;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI
{
    for (UIView *subview in self.contentView.subviews) {
        [subview removeFromSuperview];
    }
    [self.buttonArray removeAllObjects];
    CGFloat titleBtnX = ScaleW(40);
    CGFloat titleBtnH = ScaleH(45);
    CGFloat titleBtnW = ScreenWidth - titleBtnX - ScaleW(50);
    
    NSMutableArray *actionIconArray = [NSMutableArray arrayWithObject:@"arrow"];
    NSMutableArray *adressIconArray = [NSMutableArray arrayWithObject:@"bookingCar_startPoint"];
    self.pointArray = [NSMutableArray array];
    for (int i = 1; i < self.titleArray.count - 1; i ++) {
        [actionIconArray addObject:@"bookingCar_delete"];
        [adressIconArray addObject:@"bookingCar_visaPoint"];
    }
    [actionIconArray addObject:@"bookingCar_add"];
    [adressIconArray addObject:@"bookingCar_endPoint"];
    
    for (int i = 0; i < self.titleArray.count; i ++) {
        
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.image = [UIImage imageNamed:adressIconArray[i]];
        iconView.frame = CGRectMake(ScaleW(20), ScaleH(45) * i + (ScaleH(45) - 9) / 2, 9, 9);
        [self.contentView addSubview:iconView];
        [self.pointArray addObject:iconView];
        
        UIColor *beginColor = Color2;
        if ([self.titleArray[i] isEqualToString:@"出发地点"] || [self.titleArray[i] isEqualToString:@"结束地点"]|| [self.titleArray[i] isEqualToString:@"途经城市"]) {
            beginColor = Color3;
        }
        UIButton *beginBtn = [UIButton buttonWithTitle:self.titleArray[i]
                                            titleColor:beginColor
                                                  font:[UIFont WLFontOfSize:15]
                                                target:self
                                                action:@selector(textButtonClick:)];
        beginBtn.tag = i;
        beginBtn.frame = CGRectMake(titleBtnX, titleBtnH * i, titleBtnW, titleBtnH);
        beginBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        beginBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [self.buttonArray addObject:beginBtn];
        [self.contentView addSubview:beginBtn];
        
        UIButton *actionBtn = [[UIButton alloc] init];
        [actionBtn setImage:[UIImage imageNamed:actionIconArray[i]] forState:UIControlStateNormal];
        [actionBtn addTarget:self action:@selector(actionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        actionBtn.frame = CGRectMake(ScreenWidth - ScaleW(42), titleBtnH * i, ScaleW(30), titleBtnH);
        actionBtn.tag = i;
        [self.contentView addSubview:actionBtn];
    }
    
    for (int i = 0; i < self.titleArray.count - 1; i++) {
        UIImageView *firstPoint = self.pointArray[i];
        UIImageView *secondPoint = self.pointArray[i + 1];
        CGFloat lineY = firstPoint.bottom + 2;
        CGFloat lineH = secondPoint.top - 2 - lineY;
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(ScaleW(20) + 3, lineY, 2, lineH)];
        line.backgroundColor = bordColor;
        [self.contentView addSubview:line];
    }
}

- (void)setDetailAddress:(NSArray*)detailArray
{
    [detailArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (![obj isEqualToString:@""]) {
            
            UIButton *beginBtn = idx == 0 ? [self.buttonArray firstObject]: [self.buttonArray lastObject];
            CGRect frame = beginBtn.frame;
            
            beginBtn.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, ScaleH(30));
            [self.buttonArray replaceObjectAtIndex:idx withObject:beginBtn];
            
            UILabel *beginLabel = [[UILabel alloc] init];
            beginLabel.frame = CGRectMake(frame.origin.x, frame.origin.y + ScaleH(30), frame.size.width, ScaleH(15));
            beginLabel.text = detailArray[idx];
            beginLabel.textColor = Color3;
            beginLabel.font = [UIFont WLFontOfSize:10];
            [self.contentView addSubview:beginLabel];
        }
        
        
    }];

}

- (void)textButtonClick:(UIButton *)button
{
    NSUInteger tag = button.tag;
    if (tag == 0) {
        
        self.onAddressAction(AddressActionTypeInputStartingPoint, -1);
    }else if (tag == self.titleArray.count - 1) {
        
        self.onAddressAction(AddressActionTypeInputTerminalPoint, -1);
    }else{
        self.onAddressAction(AddressActionTypeInputVisaPoint, tag);
    }
}

- (void)actionButtonClick:(UIButton *)button
{
    NSUInteger tag = button.tag;
    if (tag == 0) {
        
        self.onAddressAction(AddressActionTypeInputStartingPoint, -1);
        
    }else if (tag == self.titleArray.count - 1) {
        
        self.onAddressAction(AddressActionTypeAddPoint, -1);
        
    }else{
        
        self.onAddressAction(AddressActionTypeDeletePoint, tag);
    }
}

- (NSMutableArray *)buttonArray
{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}
@end
