//
//  WLCarBookingRemarkCell.m
//  WeiLvDJS
//
//  Created by ternence on 2017/2/23.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLCarBookingRemarkCell.h"

#define cellIdentifier @"WLCarBookingRemarkCell"

@interface WLCarBookingRemarkCell ()

@property (nonatomic, strong) UIButton *remarkBtn;
@property (nonatomic, copy) void(^onClickAction)(NSUInteger index);
@property (nonatomic, strong) NSString *placeHoldText;

@end

@implementation WLCarBookingRemarkCell

+ (WLCarBookingRemarkCell *)cellWithTableView:(UITableView *)tableView
                                  clickAction:(void (^)(NSUInteger))clickAction
                                placeHoldText:(NSString *)placeHoldText{
    WLCarBookingRemarkCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLCarBookingRemarkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.onClickAction = clickAction;
    cell.placeHoldText = placeHoldText;
    [cell setupUI];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
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

    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.image = [UIImage imageNamed:@"bookingCar_remark"];
    iconView.frame = CGRectMake(ScaleW(20), (ScaleH(45) - 17) / 2, 17, 17);
    [self.contentView addSubview:iconView];
    
    UIButton *actionBtn = [[UIButton alloc] init];
    [actionBtn setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    actionBtn.frame = CGRectMake(ScreenWidth - ScaleW(20), 0, ScaleW(8), ScaleH(45));
    [self.contentView addSubview:actionBtn];
    
    
    CGFloat buttonX = ScaleW(45);
    CGFloat buttonH = ScaleH(45);
    
    UIButton *beginBtn = [UIButton buttonWithTitle:@"备注" titleColor:Color3 font:[UIFont WLFontOfSize:15] target:self action:@selector(buttonClick:)];
    beginBtn.frame = CGRectMake(buttonX, 0, ScreenWidth - buttonX - ScaleW(20), buttonH);
    beginBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.contentView addSubview:beginBtn];
    self.remarkBtn = beginBtn;
    
    if (self.placeHoldText) {
        if (![self.placeHoldText isEqualToString:@"备注"]) {
            [self setRemark:self.placeHoldText];
        }
    }
}

- (void)buttonClick:(UIButton *)button
{
    self.onClickAction(button.tag);
}

- (void)setRemark:(NSString *)remark
{
    [self.remarkBtn setTitleColor:Color2 forState:UIControlStateNormal];
    [self.remarkBtn setTitle:remark forState:UIControlStateNormal];
}
@end
