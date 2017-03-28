//
//  WLIncomeStatisticsBottomView.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLIncomeStatisticsBottomView.h"
#import "GrowingLineView.h"
#import "FlowViewFrame.h"
#import "FlowmeterTool.h"
#import "WLUITool.h"

@interface WLIncomeStatisticsBottomView ()
@property (nonatomic, strong) UILabel *noticeLabel;
@property (nonatomic, strong) GrowingLineView *growingView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation WLIncomeStatisticsBottomView

- (instancetype)initWithFrame:(CGRect)frame xData:(NSArray *)xArray yData:(NSArray *)yArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupNoticeView];
        [self setupGrowingViewWithXArray:xArray yArray:yArray];
        [self setupDividerLineYArray:yArray];
        
        
        
        
    }
    return self;
}

- (void)setupNoticeView
{
    self.noticeLabel = [[UILabel alloc] init];
    self.noticeLabel.text = @"收益趋势";
    self.noticeLabel.textColor = HEXCOLOR(0xb5b5b5);
    self.noticeLabel.font = [UIFont WLFontOfSize:16];
    self.noticeLabel.textAlignment = NSTextAlignmentLeft;
    self.noticeLabel.frame = CGRectMake(ScaleW(10), 0, ScreenWidth, ScaleH(45));
    [self addSubview:self.noticeLabel];
    
    UILabel *yearLabel = [[UILabel alloc] init];
    yearLabel.text = @"2016";
    yearLabel.textColor = HEXCOLOR(0xb5b5b5);
    yearLabel.font = [UIFont WLFontOfSize:16];
    yearLabel.textAlignment = NSTextAlignmentCenter;
    yearLabel.frame = CGRectMake(0, self.bounds.size.height - ScaleH(75),ScaleW(60) , ScaleH(45));
    [self addSubview:yearLabel];
    
}

- (void)setupGrowingViewWithXArray:(NSArray *)xArray yArray:(NSArray *)yArray
{
    self.growingView = [[GrowingLineView alloc] initWithFrame:CGRectMake(ScaleW(65), CGRectGetMaxY(self.noticeLabel.frame) + ScaleH(10), ScreenWidth - ScaleW(65), flowGrowingView_H - flowGrowingView_topView_H) xData:xArray yData:yArray];
    [self addSubview:self.growingView];
}


- (void)setupDividerLineYArray:(NSArray *)yArray
{
    for (UIView *subView in self.growingView.subviews) {
        if (subView.tag == 100) {
            [subView removeFromSuperview];
        }
    }
    
    FlowmeterTool *tool = [[FlowmeterTool alloc] init];
    NSNumber *maxValue = [tool getMaxFlowCount:yArray];
    NSUInteger margin = maxValue.integerValue / 5;
    
    
    for (int i = 0; i < 5; i ++) {
        UIView *dividerLine = [[UIView alloc] init];
        dividerLine.backgroundColor = HEXCOLOR(0xd8d9dd);
        CGFloat dividerLineY = flowGrowingView_growingView_H / 4 * i;
        dividerLine.frame = CGRectMake(0, dividerLineY, ScreenWidth - ScaleW(65), 1);
        dividerLine.tag = 100;
        [self.growingView addSubview:dividerLine];
        
        if (i < 4) {
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.frame = CGRectMake(0 ,ScaleH(40) + dividerLineY, ScaleW(65), ScaleH(30));
            NSString *amount = [NSString stringWithFormat:@"%ld", maxValue.integerValue + 10 - margin * i];
            if (amount.floatValue > 10000) {
                amount = [NSString stringWithFormat:@"%.1f",amount.floatValue / 10000.0];
            }
            titleLabel.text = [NSString stringWithFormat:@"¥ %@",amount];
            titleLabel.textColor =WLColor(255, 74, 18, 1.0);
            titleLabel.font = [UIFont WLFontOfSize:14];
            [self addSubview:titleLabel];
        }
        
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];

}
@end
