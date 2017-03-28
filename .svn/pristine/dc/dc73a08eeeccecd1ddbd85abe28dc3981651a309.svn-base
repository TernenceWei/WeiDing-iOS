//
//  WLRecieveOrderHeader.m
//  WeiLvDJS
//
//  Created by whw on 16/10/25.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLRecieveOrderHeader.h"
@interface WLRecieveOrderHeader()

@property(nonatomic,copy)void(^onSelectAction)(OrderStatus status);

@property(nonatomic,strong) UIView *indicatorView;

@property(nonatomic, strong) UIButton *selectedBtn;

@property(nonatomic, strong) NSArray *textArray;


@end

@implementation WLRecieveOrderHeader

-(instancetype)initWithFrame:(CGRect)frame textArray:(NSArray *)textArray selectAction:(void (^)(NSUInteger))selectAction{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = HEXCOLOR(0x4877e7);
        self.onSelectAction = selectAction;
        self.textArray = textArray;
        
        [self creatView];
        
        
    }
    return self;
}

-(void)creatView{
    for (int i = 0; i < self.textArray.count; i++) {
        [self setUpButtonWithIndex:i];
    }
    self.indicatorView = [[UIView alloc] init];
    _indicatorView.backgroundColor = HEXCOLOR(0xffc961);
    self.indicatorView.frame = CGRectMake(0, self.bounds.size.height - 2, ScaleW(50), 2);
    [self addSubview:self.indicatorView];
    
    [self updateIndicatorViewFrame];
}

-(void)setUpButtonWithIndex:(NSUInteger)index{
    CGFloat width = self.bounds.size.width / self.textArray.count;
    CGFloat height = self.bounds.size.height;
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(width * index, 0, width, height);
    [button setTitle:self.textArray[index] forState:UIControlStateNormal];
    [button setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateSelected];
    [button setTitleColor:HEXCOLOR(0x96b5fe) forState:UIControlStateNormal];
    button.titleLabel.font = WLFontSize(16);
    button.tag = index;
    [button addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    if (index == 0) {
        self.selectedBtn = button;
        button.selected = YES;
    }
}

-(void)buttonClickAction:(UIButton *)button{
    self.selectedBtn.selected = NO;
    button.selected = YES;
    self.selectedBtn = button;
    
    self.onSelectAction(button.tag);
    
    [self updateIndicatorViewFrame];
    
}

-(void)updateIndicatorViewFrame{
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint center = CGPointMake(0, 0);
        center.x = self.selectedBtn.center.x;
        center.y = self.bounds.size.height - 1;
        self.indicatorView.center = center;
    }];
}

@end











