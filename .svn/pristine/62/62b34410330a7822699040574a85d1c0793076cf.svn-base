//
//  WLDriverReceiptTopView.m
//  WeiLvDJS
//
//  Created by ternence on 2016/12/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLDriverReceiptTopView.h"
#import "WL_Application_Driver_OrderTipView.h"
@interface WLDriverReceiptTopView ()

@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UIButton *statusBtn;

@end

@implementation WLDriverReceiptTopView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.backgroundColor = HEXCOLOR(0xf2f2f2);
    CGFloat margin = ScaleW(12);
    CGFloat height = ScaleH(44);
    
    UILabel *titleLabel = [UILabel labelWithText:@"我的订单价"
                                       textColor:Color3
                                        fontSize:13];
    titleLabel.frame = CGRectMake(margin, 0, ScreenWidth, ScaleH(33));
    [self addSubview:titleLabel];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, ScaleH(33), ScreenWidth, height * 2)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    
    NSArray *textArray = @[@"订单金额", @"¥6464.00", @"实际金额"];
    CGFloat width = ScreenWidth / 2 - margin;
    for (int i = 0; i < 3; i++) {
        CGFloat beginX = margin;
        NSTextAlignment alignment = NSTextAlignmentLeft;
        if (i == 1) {
            beginX = ScreenWidth / 2;
            alignment = NSTextAlignmentRight;
        }
        UILabel *label = [UILabel labelWithText:textArray[i]
                                      textColor:Color2
                                       fontSize:14];
        label.frame = CGRectMake(beginX, height * (i / 2), width, height);
        label.textAlignment = alignment;
        [bgView addSubview:label];
        if (i == 1) {
            self.moneyLabel = label;
        }
 
    }
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(margin, ScaleH(77), ScreenWidth, 1)];
    line.backgroundColor = bordColor;
    [self addSubview:line];
    
    UIButton *statusBtn = [UIButton buttonWithTitle:@"待确定"
                                         titleColor:Color1
                                               font:[UIFont WLFontOfSize:15]
                                          imageName:@"tshi01"
                                             target:self
                                             action:@selector(didClickTipButton)];
    statusBtn.frame = CGRectMake(ScreenWidth / 2, ScaleH(77), width, height);
    statusBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    statusBtn.adjustsImageWhenHighlighted = NO;
    statusBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self addSubview:statusBtn];
    self.statusBtn = statusBtn;
    
}

- (void)didClickTipButton
{
   WL_Application_Driver_OrderTipView *receviedTipView = [[ WL_Application_Driver_OrderTipView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(ScreenWidth - 95), ScaleH(165)) andTipType:WLReceivedRecord];
    [KWLBaseShowView showWithContentView:receviedTipView andTouch:NO andCallBlack:nil];
    
    receviedTipView.seletedCallBack = ^(BOOL isAccept)
    {
        [KWLBaseShowView dismiss];
    };

}
- (void)setOrderPrice:(NSString *)orderPrice
{
    _orderPrice = orderPrice;
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",orderPrice];
}

@end
