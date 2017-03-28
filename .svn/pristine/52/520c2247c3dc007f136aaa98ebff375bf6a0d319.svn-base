//
//  WLFiltrateView.m
//  WeiLvDJS
//
//  Created by hsliang on 2016/12/29.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLFiltrateView.h"

@interface WLFiltrateView ()

@property (nonatomic, copy) void (^onSelectAction)(NSUInteger index);
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) NSArray *textArray;

@end

@implementation WLFiltrateView

- (instancetype)initWithFrame:(CGRect)frame textArray:(NSArray *)textArray selectAction:(void (^)(NSUInteger))selectAction
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.onSelectAction = selectAction;
        self.textArray = textArray;
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.indicatorView = [[UIView alloc] init];
    self.indicatorView.frame = CGRectMake(ScaleW(1), ScaleH(1), self.bounds.size.width - 2, self.bounds.size.height - 2);
    self.indicatorView.backgroundColor = [WLTools stringToColor:@"#f2f2f2"];
    [self addSubview:self.indicatorView];
    
    for (int i = 0; i < self.textArray.count; i ++) {
        [self setupButtonWithIndex:i];
    }
}

- (void)setupButtonWithIndex:(NSUInteger)index
{
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height / self.textArray.count;
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(0, height * index, width, height);
    [button setTitle:self.textArray[index] forState:UIControlStateNormal];
    [button setTitleColor:[WLTools stringToColor:@"#2f2f2f"] forState:UIControlStateNormal];
    [button setTitleColor:[WLTools stringToColor:@"#2f2f2f"] forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont WLFontOfSize:14];
    button.tag = index;
    [button addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.indicatorView addSubview:button];
    if (index == 0) {
        button.selected = YES;
        self.selectBtn = button;
    }
}

- (void)buttonClickAction:(UIButton *)button
{
    self.selectBtn.selected = NO;
    button.selected = YES;
    self.selectBtn = button;
    
    self.onSelectAction(button.tag);
}

@end
