//
//  WLIncomeStatisticsTopView.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLIncomeStatisticsTopView.h"

@implementation WLIncomeStatisticsTopView
- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [WLTools stringToColor:@"#4877e7"];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.frame = CGRectMake(0 , ScaleH(10), ScreenWidth, ScaleH(30));
        titleLabel.text = @"总收入（元）";
        titleLabel.textColor =HEXCOLOR(0xffffff);
        titleLabel.font = [UIFont WLFontOfSize:18];
        [self addSubview:titleLabel];
        
        UILabel *incomeLabel = [[UILabel alloc] init];
        incomeLabel.textAlignment = NSTextAlignmentCenter;
        incomeLabel.frame = CGRectMake(0 , CGRectGetMaxY(titleLabel.frame) + ScaleH(10), ScreenWidth, ScaleH(30));
        incomeLabel.text = text;
        incomeLabel.textColor =HEXCOLOR(0xffffff);
        incomeLabel.font = [UIFont WLFontOfSize:35];
        [self addSubview:incomeLabel];
    }
    return self;
}

@end
