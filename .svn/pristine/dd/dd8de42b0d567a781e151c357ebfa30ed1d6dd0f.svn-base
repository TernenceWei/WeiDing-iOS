//
//  WLNoGroupOnView.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/8.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLNoGroupOnView.h"

@interface WLNoGroupOnView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *iconView;
@end

@implementation WLNoGroupOnView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.iconView = [[UIImageView alloc] init];
        self.iconView.image = [UIImage imageNamed:@"noGroupOn"];
        self.iconView.frame = CGRectMake((ScreenWidth - 212) / 2, 100, 212, 162);
        [self addSubview:self.iconView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = HEXCOLOR(0x868686);
        self.titleLabel.font = WLFontSize(16);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.iconView.frame) + 10, ScreenWidth, 100);
        self.titleLabel.text = @"您当前无正在出团任务\n可前往查看历史出团";
        self.titleLabel.numberOfLines = 0;
        [self addSubview:self.titleLabel];
    }
    return self;
}

@end
