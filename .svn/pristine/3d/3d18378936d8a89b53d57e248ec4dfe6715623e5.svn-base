//
//  WLIncomeHeader.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLIncomeHeader.h"

@interface WLIncomeHeader ()
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UIButton *foldBtn;
@property (nonatomic, strong) NSArray *textArray;
@property (nonatomic, copy) void (^onFoldAction)(BOOL isFold);
@property (nonatomic, strong) UIView *lineView;
@end

@implementation WLIncomeHeader

- (instancetype)initWithFrame:(CGRect)frame textArray:(NSArray *)textArray foldAction:(void (^)(BOOL))action selected:(BOOL)selected
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = HEXCOLOR(0xf0f3f8);
        self.textArray = textArray;
        self.onFoldAction = action;
        [self setupUI];
        self.foldBtn.selected = selected;
        
    }
    return self;
}

- (void)setupUI{
    
    self.leftLabel = [[UILabel alloc] init];
    self.leftLabel.textColor = HEXCOLOR(0x2f2f2f);
    self.leftLabel.font = [UIFont WLFontOfSize:14];
    self.leftLabel.textAlignment = NSTextAlignmentLeft;
    self.leftLabel.frame = CGRectMake(ScaleW(12), 0, ScreenWidth / 2, self.bounds.size.height);
    self.leftLabel.text = self.textArray[0];
    [self addSubview:self.leftLabel];
    
    self.rightLabel = [[UILabel alloc] init];
    self.rightLabel.textAlignment = NSTextAlignmentRight;
    self.rightLabel.frame = CGRectMake(ScreenWidth - 50 - ScreenWidth / 2, 0, ScreenWidth / 2, self.bounds.size.height);
    self.rightLabel.attributedText = [self getRightText];
    [self addSubview:self.rightLabel];
    
    self.foldBtn = [[UIButton alloc] init];
    [self.foldBtn setImage:[UIImage imageNamed:@"group_angel_up"] forState:UIControlStateNormal];
    [self.foldBtn setImage:[UIImage imageNamed:@"group_angel_down"] forState:UIControlStateSelected];
    self.foldBtn.frame = CGRectMake(ScreenWidth - 50, 0, 50, self.bounds.size.height);
    [self.foldBtn addTarget:self action:@selector(foldThelist) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.foldBtn];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = HEXCOLOR(0xdce0d8);
    lineView.frame = CGRectMake(0, self.bounds.size.height - 1, ScreenWidth, 1);
    [self addSubview:lineView];
    self.lineView = lineView;
    
}

- (void)foldThelist
{
    self.foldBtn.selected = !self.foldBtn.selected;
    self.onFoldAction(self.foldBtn.selected);

}

- (NSAttributedString *)getRightText
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = HEXCOLOR(0x2f2f2f);
    attrs[NSFontAttributeName] = [UIFont WLFontOfSize:14];
    NSAttributedString *string1 = [[NSAttributedString alloc] initWithString:@"累计：" attributes:attrs];
    
    NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc] initWithAttributedString:string1];
    
    NSMutableDictionary *attrs2 = [NSMutableDictionary dictionary];
    attrs2[NSForegroundColorAttributeName] = HEXCOLOR(0xff3d5b);
    attrs2[NSFontAttributeName] = [UIFont WLFontOfSize:15];
    NSAttributedString *string2 = [[NSAttributedString alloc] initWithString:self.textArray[1] attributes:attrs2];
    [mutableString  appendAttributedString:string2];

    return mutableString;
    
}

@end
