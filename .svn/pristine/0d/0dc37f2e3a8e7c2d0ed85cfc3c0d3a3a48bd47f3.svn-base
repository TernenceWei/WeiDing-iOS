//
//  WLNameCardAlertView.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/19.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLNameCardAlertView.h"

@interface WLNameCardAlertView()
@property (nonatomic, copy) void(^onClickAction)(BOOL phone);
@end

@implementation WLNameCardAlertView
- (instancetype)initWithFrame:(CGRect)frame object:(WLChargeUpNameCardObject *)object
                  clickAction:(void (^)(BOOL phone))action
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        
        UIButton *titleBtn = [[UIButton alloc] init];
        [titleBtn setTitle:@"名片" forState:UIControlStateNormal];
        [titleBtn setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateNormal];
        [titleBtn setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0x878fff)] forState:UIControlStateNormal];
        titleBtn.frame = CGRectMake(0, 0, frame.size.width, ScaleH(53));
        titleBtn.titleLabel.font = WLFontSize(18);
        [self addSubview:titleBtn];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:titleBtn.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8, 8)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = titleBtn.bounds;
        maskLayer.path = maskPath.CGPath;
        titleBtn.layer.mask = maskLayer;
        
        titleBtn.clipsToBounds = YES;
        
        NSArray *textArray = @[@"角色",CHECKNIL(object.roleName),@"称呼", CHECKNIL(object.name),@"电话", CHECKNIL(object.mobile)];
        for (int i = 0; i < 6; i++) {
            [self setupLabelWithIndex:i text:textArray[i]];
        }
        
        for (int i = 0; i < 2; i++) {
            [self setupBtnWithIndex:i];
        }
        self.onClickAction = action;
    }
    return self;
}

- (void)setupLabelWithIndex:(NSUInteger)index text:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    label.font = WLFontSize(15);
    UIColor *textColor = HEXCOLOR(0x2f2f2f);
    label.textAlignment = NSTextAlignmentCenter;
    if (index % 2 == 1) {
        textColor = HEXCOLOR(0x868686);
        label.textAlignment = NSTextAlignmentLeft;
    }
    label.textColor = textColor;
    CGFloat width = self.bounds.size.width / 2;
    CGFloat height = 50;
    label.frame = CGRectMake(width * (index % 2), index / 2 * height + ScaleH(60), width, height);
    label.text = text;
    [self addSubview:label];
}

- (void)setupBtnWithIndex:(NSUInteger)index
{
    UIButton *titleBtn = [[UIButton alloc] init];
    titleBtn.layer.cornerRadius = ScaleH(15);
    titleBtn.layer.masksToBounds = YES;
    NSString *title = @"拨打电话";
    UIColor *backColor = HEXCOLOR(0x879efa);
    if (index == 1) {
        title = @"发私信";
        backColor = HEXCOLOR(0x69c95f);
    }
    [titleBtn setTitle:title forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [titleBtn setBackgroundImage:[UIImage imageWithColor:backColor] forState:UIControlStateNormal];
    CGFloat width = ScaleW(80);
    titleBtn.frame = CGRectMake(ScaleW(52) + width * index + ScaleW(39) * index, self.bounds.size.height - ScaleH(65), width, ScaleH(30));
    titleBtn.titleLabel.font = WLFontSize(14);
    [titleBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    titleBtn.tag = index;
    [self addSubview:titleBtn];
}

- (void)buttonClickAction:(UIButton *)button
{
    self.onClickAction(button.tag == 0);
}
@end
