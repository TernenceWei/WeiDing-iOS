//
//  WLRoleSelectView.m
//  WeiLvDJS
//
//  Created by ternence on 16/9/30.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLRoleSelectView.h"

@interface WLRoleSelectView ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation WLRoleSelectView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textColor = [UIColor blackColor];
    [self.titleLabel setExclusiveTouch:YES];
    self.titleLabel.text = @"备注信息";
    [self addSubview:self.titleLabel];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(10, 10, 100, 40);
}

@end