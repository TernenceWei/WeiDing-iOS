//
//  WLdetailHeadView.m
//  WeiLvDJS
//
//  Created by hsliang on 2017/1/5.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLdetailHeadView.h"

@implementation WLdetailHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置子控件
        [self setupContentViewToBillTableHeaderView];
        self.backgroundColor = [WLTools stringToColor:@"#333333"];
    }
    return self;
}

- (void)setupContentViewToBillTableHeaderView
{
    _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(ScaleW(10), ScaleH(20), ScaleW(200), ScaleH(20))];
    _titleLable.text = @"10月29日";
    _titleLable.textColor = [UIColor whiteColor];
    [self addSubview:_titleLable];
    
    UILabel * WriteOffLabel = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth/2) - ScaleW(50), ScaleH(60), ScaleW(100), ScaleH(20))];
    WriteOffLabel.textColor = [UIColor lightGrayColor];
    WriteOffLabel.text = @"核销（单）";
    WriteOffLabel.font = [UIFont WLFontOfSize:12.0];
    WriteOffLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:WriteOffLabel];
    
    _balanceLable = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth/2) - ScaleW(100), WriteOffLabel.frame.origin.y + WriteOffLabel.frame.size.height + ScaleH(10), ScaleW(200), ScaleH(25))];
    _balanceLable.textColor = [UIColor whiteColor];
    _balanceLable.text = @"2000";
    _balanceLable.font = [UIFont WLFontOfSize:18.0];
    _balanceLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_balanceLable];
    
    UIImageView * blackImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, ScaleH(138), ScreenWidth, ScaleH(20))];
    [blackImg setImage:[UIImage imageNamed:@"hexiaomingxi"]];
    [self addSubview:blackImg];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
