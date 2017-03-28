//
//  WLTopGroupChooseView.m
//  WeiLvDJS
//
//  Created by hsliang on 2016/11/15.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLTopGroupChooseView.h"

@interface WLTopGroupChooseView ()

@property (nonatomic, copy) void (^onSelectAction)(NSUInteger index);
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) NSArray *textArray;

@end

@implementation WLTopGroupChooseView

- (instancetype)initWithFrame:(CGRect)frame
                    textArray:(NSArray *)textArray
                 selectAction:(void (^)(NSUInteger))selectAction
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [WLTools stringToColor:@"#ffffff"];
        self.onSelectAction = selectAction;
        self.textArray = textArray;
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI{
    
    for (int i = 0; i < self.textArray.count; i ++) {
        [self setupButtonWithIndex:i];
    }
    
    self.indicatorView = [[UIView alloc] init];
    self.indicatorView.backgroundColor = [WLTools stringToColor:@"#00cc99"];//HEXCOLOR(0xffc961);
    self.indicatorView.frame = CGRectMake(0, self.bounds.size.height - 2, self.bounds.size.width / self.textArray.count, 2);
    [self addSubview:self.indicatorView];
    [self updateIndicateViewFrame];
    
}

- (void)setupButtonWithIndex:(NSUInteger)index
{
    CGFloat width = self.bounds.size.width / self.textArray.count;
    CGFloat height = self.bounds.size.height;
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(width * index, 0, width, height);
    [button setTitle:self.textArray[index] forState:UIControlStateNormal];
    [button setTitleColor:[WLTools stringToColor:@"#2f2f2f"] forState:UIControlStateNormal];
    [button setTitleColor:[WLTools stringToColor:@"#2f2f2f"] forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont WLFontOfSize:14];
    button.tag = index;
    [button addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
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
    [self updateIndicateViewFrame];
    
    self.onSelectAction(button.tag);
    
    
}

- (void)updateIndicateViewFrame
{
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint center = self.selectBtn.center;
        center.x = self.selectBtn.center.x;
        center.y = self.bounds.size.height - 1;
        self.indicatorView.center = center;
    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
