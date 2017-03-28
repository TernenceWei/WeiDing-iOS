//
//  WL_AccountHeaderView.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AccountHeaderView.h"
#import "WLAccountButton.h"

@interface WL_AccountHeaderView()

@property (nonatomic, copy) void(^onAction)(ActionType type);
@property(nonatomic,strong) UILabel *meansNum;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, assign) HeaderType headerType;

@end

@implementation WL_AccountHeaderView
- (NSMutableArray *)buttonArray
{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
    
}

- (instancetype)initWithFrame:(CGRect)frame headerType:(HeaderType)headerType
{
    return [self initWithFrame:frame headerType:headerType action:nil];
}

-(instancetype)initWithFrame:(CGRect)frame headerType:(HeaderType)headerType action:(void (^)(ActionType))action
{
    if (self= [super initWithFrame:frame]) {
        self.backgroundColor =[UIColor whiteColor];
        self.onAction = action;
        self.headerType = headerType;
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    CGFloat topHeight = 240;
    UIColor *topColor = Color1;
    NSString *titleText = @"资金帐户";
    if (self.headerType == HeaderTypeFrozenPage) {
        topHeight = 200;
        topColor = WSColor(7, 190, 230);
        titleText = @"冻结金额";
    }
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, topHeight)];
    topView.backgroundColor = topColor;
    [self addSubview:topView];

    UIButton *backButton =[[UIButton alloc] init];
    [backButton setImage:[UIImage imageNamed:@"NavigationBack"] forState:UIControlStateNormal];
    [self addSubview:backButton];
    backButton.tag = 0;
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(40,30));
    }];
    [backButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLabel =[UILabel new];
    titleLabel.font =WLFontSize(18);
    titleLabel.textColor =[UIColor whiteColor];
    titleLabel.text = titleText;
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(30);
    }];
    
    if (self.headerType == HeaderTypeAccountHome) {
        UILabel *meansLabel =[UILabel new];
        meansLabel.textColor = [UIColor whiteColor];
        meansLabel.font = WLFontSize(18);
        meansLabel.text = @"总资产(元)";
        meansLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:meansLabel];
        [meansLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(105);
        }];
        
        CGFloat width = ScreenWidth / 2;
        WS(weakSelf);
        NSArray *titleArray = @[@"可用余额", @"冻结金额"];
        for (int i = 0; i < 2; i++) {
            __block WLAccountButton *button = [[WLAccountButton alloc] initWithFrame:CGRectMake(width * i, topHeight, width, ScaleH(70))
                                                                               title:titleArray[i]
                                                                              action:^{
                                                                                  [weakSelf buttonClickAction:button];
                                                                              }];
            button.tag = i + 1;
            [self addSubview:button];
            [self.buttonArray addObject:button];
        }
        
        UILabel *line1 =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2, topHeight, 1, ScaleH(70))];
        line1.backgroundColor = bordColor;
        [self addSubview:line1];
    }
    
    self.meansNum =[UILabel new];
    self.meansNum.textColor =[UIColor whiteColor];
    self.meansNum.font =WLFontSize(30);
    [self addSubview:self.meansNum];
    self.meansNum.text = @"¥ 0.00";
    [self.meansNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(topView.mas_bottom).offset(-50);
    }];

}

- (void)buttonClickAction:(UIView *)button
{
    self.onAction(button.tag);
}

- (void)setModel:(WLFundAccountObject *)model
{
    _model = model;
    self.meansNum.text= [NSString stringWithFormat:@"¥ %@",self.model.total_asset];

    WLAccountButton *reaminBtn = self.buttonArray[0];
    NSString *balanceString = [NSString stringWithFormat:@"%@",self.model.balance];
    [reaminBtn setAmount:balanceString];
    
    WLAccountButton *frozenBtn = self.buttonArray[1];
    NSString *frozenString = [NSString stringWithFormat:@"%0.2f",[self.model.frozen floatValue]];
    [frozenBtn setAmount:frozenString];


}

- (void)refreshFrozenCount:(NSString *)price
{
    self.meansNum.text = price;
}

@end
