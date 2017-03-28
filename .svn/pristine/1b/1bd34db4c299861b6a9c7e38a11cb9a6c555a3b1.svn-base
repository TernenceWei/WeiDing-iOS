//
//  WLPaymentChooseView.m
//  WeiLvDJS
//
//  Created by ternence on 2017/1/16.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLPaymentChooseView.h"

@interface WLPaymentChooseView ()

@property (nonatomic, copy) void(^onClickAction)(NSUInteger index);
@property (nonatomic, copy) void(^onCancelAction)();

@end

@implementation WLPaymentChooseView

- (instancetype)initWithFrame:(CGRect)frame
                  clickAction:(void(^)(NSUInteger index))clickAction
                 cancelAction:(void (^)())cancelAction
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - ScaleW(150), ScreenWidth, ScaleW(150))];
        bottomView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bottomView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonClick:)];
        self.tag = 100;
        [self addGestureRecognizer:tapGesture];
        
        self.onClickAction = clickAction;
        self.onCancelAction = cancelAction;
        
        CGFloat bgWidth = ScaleW(100);
        CGFloat iconWith = ScaleW(80);
        CGFloat bgMargin = ScaleW(72);
        CGFloat bgX = (ScreenWidth - 2 * bgWidth - bgMargin) / 2;
        NSArray *textArray = @[@"支付宝支付",@"微信支付"];
        NSArray *imageArray = @[@"payment_alipay",@"payment_weixin"];
        for (int i = 0; i < 2; i++) {
            
            UIView *bgView = [[UIView alloc] init];
            bgView.backgroundColor = [UIColor whiteColor];
            bgView.frame = CGRectMake(bgX + (bgWidth + bgMargin) * i, 0, bgWidth, frame.size.height);
            bgView.tag = i + 1;
            [bottomView addSubview:bgView];
            
            UIButton *button = [UIButton buttonWithImageName:imageArray[i] target:self action:nil];
            button.frame = CGRectMake(ScaleW(10), ScaleW(28), iconWith, iconWith);
            button.userInteractionEnabled = NO;
            [bgView addSubview:button];
            
            UILabel *titleLabel = [UILabel labelWithText:textArray[i] textColor:Color2 fontSize:14];
            titleLabel.frame = CGRectMake(0, button.bottom + ScaleW(5), bgWidth, ScaleW(20));
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [bgView addSubview:titleLabel];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonClick:)];
            [bgView addGestureRecognizer:tapGesture];
        }
        
    }
    return self;
}

- (void)buttonClick:(UITapGestureRecognizer *)tapGesture
{
    NSUInteger tag = tapGesture.view.tag;
    if (tag == 100) {
        self.onCancelAction();
    }else{
        self.onClickAction(tag);
    }
    
}
@end
