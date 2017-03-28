//
//  WLOneCardHeaderView.m
//  WeiLvDJS
//
//  Created by ternence on 2017/1/10.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLOneCardHeaderView.h"

@interface WLOneCardHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *logoView;

@end

@implementation WLOneCardHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel = [UILabel labelWithText:@"请仔细核对游客身份信息及一卡通有效期！" textColor:Color2 fontSize:13];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.frame = CGRectMake(0, ScaleH(18), ScreenWidth, ScaleH(30));
        [self addSubview:self.titleLabel];
        
        self.logoView = [[UIImageView alloc] init];
        self.logoView.frame = CGRectMake(ScaleW(64), self.titleLabel.bottom + ScaleH(15), ScaleW(248), ScaleH(157));
        self.logoView.image = [UIImage imageNamed:@"oneCard"];
        [self.logoView sd_setImageWithURL:[NSURL URLWithString:_imgimg] placeholderImage:[UIImage imageNamed:@"oneCard"]];
        self.logoView.layer.cornerRadius = 6;
        self.logoView.layer.masksToBounds = YES;
        [self addSubview:self.logoView];
        
    }
    return self;
}
@end
