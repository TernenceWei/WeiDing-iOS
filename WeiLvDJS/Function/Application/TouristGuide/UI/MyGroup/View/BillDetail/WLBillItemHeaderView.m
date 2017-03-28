//
//  WLBillItemHeaderView.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLBillItemHeaderView.h"

@interface WLBillItemHeaderView ()
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UIButton *foldBtn;
@property (nonatomic, copy) void (^onFoldAction)(BOOL isFold);
@property (nonatomic, strong) UIView *lineView;
@end

@implementation WLBillItemHeaderView

- (instancetype)initWithFrame:(CGRect)frame
                    leftTitle:(NSString *)leftTitle
                   rightTitle:(NSAttributedString *)rightTitle
                   foldAction:(void (^)(BOOL))action
                     selected:(BOOL)selected
{
    self = [super initWithFrame:frame];
    if (self) {

        self.onFoldAction = action;
        [self setupUIWithLeftTitle:leftTitle rightTitle:rightTitle];
        self.foldBtn.selected = selected;
        self.lineView.hidden = selected;
        
    }
    return self;
}

- (void)setupUIWithLeftTitle:(NSString *)leftTitle rightTitle:(NSAttributedString *)rightTitle{
    
    self.backgroundColor = [UIColor whiteColor];

    
    self.leftLabel = [[UILabel alloc] init];
    self.leftLabel.textColor = HEXCOLOR(0x2f2f2f);
    self.leftLabel.font = [UIFont WLFontOfSize:14];
    self.leftLabel.textAlignment = NSTextAlignmentLeft;
    self.leftLabel.frame = CGRectMake(ScaleW(15), 0, ScreenWidth / 2, ScaleH(50));
    self.leftLabel.text = leftTitle;
    [self addSubview:self.leftLabel];
    
    self.rightLabel = [[UILabel alloc] init];
    self.rightLabel.textAlignment = NSTextAlignmentRight;
    self.rightLabel.frame = CGRectMake(ScreenWidth - ScaleW(150) - ScaleW(50), 0, ScaleW(150), ScaleH(50));
    self.rightLabel.attributedText = rightTitle;
    [self addSubview:self.rightLabel];
    
    self.foldBtn = [[UIButton alloc] init];
    [self.foldBtn setImage:[UIImage imageNamed:@"group_angel_down"] forState:UIControlStateNormal];
    [self.foldBtn setImage:[UIImage imageNamed:@"group_angel_up"] forState:UIControlStateSelected];
    self.foldBtn.frame = CGRectMake(ScreenWidth - ScaleW(50), 0, ScaleW(50), ScaleH(50));
    [self.foldBtn addTarget:self action:@selector(foldThelist) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.foldBtn];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = HEXCOLOR(0xd8d9dd);
    lineView.frame = CGRectMake(ScaleW(12), ScaleH(50) - 1, ScreenWidth, 1);
    [self addSubview:lineView];
    self.lineView = lineView;
    
}

- (void)foldThelist
{
    self.foldBtn.selected = !self.foldBtn.selected;
    self.lineView.hidden = self.foldBtn.selected;
    
    self.onFoldAction(self.foldBtn.selected);

}
@end
