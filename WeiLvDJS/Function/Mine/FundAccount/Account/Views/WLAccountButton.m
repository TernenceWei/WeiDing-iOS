//
//  WLAccountButton.m
//  WeiLvDJS
//
//  Created by ternence on 16/12/15.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLAccountButton.h"

@interface WLAccountButton ()
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, copy)   void(^onAction)();
@end

@implementation WLAccountButton
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title action:(void (^)())action
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.onAction = action;
        UILabel *titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, ScaleH(5), frame.size.width, ScaleH(35))];
        titleLabel.font = WLFontSize(14);
        titleLabel.textColor = Color3;
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        
        UILabel *amountLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, ScaleH(28), frame.size.width, ScaleH(35))];
        amountLabel.font = WLFontSize(15);
        amountLabel.textColor = Color2;
        [self addSubview:amountLabel];
        amountLabel.textAlignment = NSTextAlignmentCenter;
        self.amountLabel = amountLabel;
        
        UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tapAction];
    }
    return self;
}

- (void)setAmount:(NSString *)amount
{
    self.amountLabel.text = amount;
}

- (void)tapAction
{
    self.onAction();
}
@end
