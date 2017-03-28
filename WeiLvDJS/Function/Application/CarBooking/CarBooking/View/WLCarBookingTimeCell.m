//
//  WLCarBookingTimeCell.m
//  WeiLvDJS
//
//  Created by ternence on 2017/1/19.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLCarBookingTimeCell.h"
#define cellIdentifier @"WLCarBookingTimeCell"

@interface WLCarBookingTimeCell ()

@property (nonatomic, copy) void(^onClickAction)(NSUInteger index);
@property (nonatomic, strong) NSMutableArray *itemArray;
@property (nonatomic, assign) BOOL busy;

@end

@implementation WLCarBookingTimeCell
- (NSMutableArray *)itemArray
{
    if (!_itemArray) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

+ (WLCarBookingTimeCell *)cellWithTableView:(UITableView*)tableView
                                clickAction:(void (^)(NSUInteger))clickAction{
    WLCarBookingTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLCarBookingTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.onClickAction = clickAction;
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
    self.busy = NO;
    NSArray *pointArray = @[@"bookingCar_startPoint",@"bookingCar_endPoint"];
    for (int i = 0; i < 2; i++) {
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.image = [UIImage imageNamed:pointArray[i]];
        iconView.frame = CGRectMake(ScaleW(20), ScaleH(45) * i + (ScaleH(45) - 9) / 2, 9, 9);
        [self.contentView addSubview:iconView];
        
        UIButton *actionBtn = [[UIButton alloc] init];
        [actionBtn setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
        actionBtn.frame = CGRectMake(ScreenWidth - ScaleW(20), ScaleH(45) * i, ScaleW(8), ScaleH(45));
        [self.contentView addSubview:actionBtn];
    }
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(ScaleW(20) + 3, (ScaleH(45) - 9) / 2 + 11, 2, ScaleH(32))];
    line.backgroundColor = bordColor;
    [self.contentView addSubview:line];
    
    CGFloat buttonX = ScaleW(40);
    CGFloat buttonH = ScaleH(45);
    NSArray *nameArray = @[@"出发时间",@"结束时间"];
    for (int i = 0; i < 2; i++) {
        UIButton *beginBtn = [UIButton buttonWithTitle:nameArray[i] titleColor:Color3 font:[UIFont WLFontOfSize:15] target:self action:@selector(buttonClick:)];
        beginBtn.tag = i;
        beginBtn.frame = CGRectMake(buttonX, buttonH * i, ScreenWidth - buttonX - ScaleW(20), buttonH);
        beginBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.contentView addSubview:beginBtn];
        beginBtn.exclusiveTouch = YES;
        [self.itemArray addObject:beginBtn];
        
    }
    
    
}

- (void)buttonClick:(UIButton * )button
{
    if (!self.busy) {
        self.busy = YES;
        self.onClickAction(button.tag);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.busy = NO;
        });
    }
    
}

- (void)setTime:(NSString *)time index:(NSUInteger)index
{
    UIButton *button = self.itemArray[index];
    [button setTitle:time forState:UIControlStateNormal];
    [button setTitleColor:Color2 forState:UIControlStateNormal];
    
}
@end
