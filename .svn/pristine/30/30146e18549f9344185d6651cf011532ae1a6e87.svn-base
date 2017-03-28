//
//  WLIncomeStatisticsCenterView.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLIncomeStatisticsCenterView.h"
#import "LXMPieView.h"
#import "WLIncomeStatisInfo.h"

@implementation WLIncomeStatisticsItemView
- (instancetype)initWithFrame:(CGRect)frame flagColor:(UIColor *)color text:(NSString *)text value:(NSUInteger)value
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *flagView = [[UIView alloc] initWithFrame:CGRectMake(0, (ScaleH(30) - ScaleW(10)) / 2, ScaleW(10), ScaleW(10))];
        flagView.backgroundColor = color;
        [self addSubview:flagView];
        
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.textAlignment = NSTextAlignmentLeft;
        textLabel.frame = CGRectMake(CGRectGetMaxX(flagView.frame) + ScaleW(5) , 0, ScaleW(150), ScaleH(30));
        textLabel.text = text;
        textLabel.textColor =HEXCOLOR(0xb5b5b5);
        textLabel.font = [UIFont WLFontOfSize:14];
        [self addSubview:textLabel];
        
        UILabel *valueLabel = [[UILabel alloc] init];
        valueLabel.textAlignment = NSTextAlignmentRight;
        valueLabel.frame = CGRectMake(CGRectGetMaxX(textLabel.frame) + ScaleW(2) , 0, ScaleW(45), ScaleH(30));
        valueLabel.text = [NSString stringWithFormat:@"%ld%%",value];
        valueLabel.textColor =HEXCOLOR(0xb5b5b5);
        valueLabel.font = [UIFont WLFontOfSize:14];
        [self addSubview:valueLabel];
    }
    return self;
}


@end

@interface WLIncomeStatisticsCenterView ()

@end

@implementation WLIncomeStatisticsCenterView
- (instancetype)initWithFrame:(CGRect)frame objectArray:(NSArray *)objectArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.textAlignment = NSTextAlignmentLeft;
        textLabel.frame = CGRectMake(ScaleW(10) , ScaleH(8), ScreenWidth, ScaleH(30));
        textLabel.text = @"各旅行社占比";
        textLabel.textColor =HEXCOLOR(0xb5b5b5);
        textLabel.font = WLFontSize(16);
        [self addSubview:textLabel];
        
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < objectArray.count; i ++) {
            WLIncomeCompanyInfo *info = objectArray[i];
            LXMPieModel *model = [[LXMPieModel alloc] initWithColor:[self getBgColorWithIndex:i] value:info.percent.floatValue text:nil];
            [array addObject:model];
        }
        LXMPieView *pieView = [[LXMPieView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(textLabel.frame), ScaleW(150), ScaleW(150)) values:array];
        [self addSubview:pieView];
        
        for (int i = 0; i < objectArray.count; i ++) {
            WLIncomeCompanyInfo *info = objectArray[i];
            CGFloat beginX = CGRectGetMaxX(pieView.frame);
            CGFloat beginY = CGRectGetMaxY(textLabel.frame);
            WLIncomeStatisticsItemView *itemView = [[WLIncomeStatisticsItemView alloc] initWithFrame:CGRectMake(beginX, beginY + ScaleH(30) * i, ScaleW(150), ScaleH(30)) flagColor:[self getBgColorWithIndex:i] text:info.companyName value:info.percent.floatValue];
            [self addSubview:itemView];
        }
    }
    return self;
}

- (UIColor *)getBgColorWithIndex:(NSUInteger)index
{
    UIColor *color = HEXCOLOR(0x2ddfa3);
    NSUInteger temp = index % 6;
    if (temp == 1) {
        color = HEXCOLOR(0x97c931);
    }else if (temp == 2){
        color = HEXCOLOR(0xf78925);
    }else if (temp == 3){
        color = HEXCOLOR(0xd144ff);
    }else if (temp == 4){
        color = HEXCOLOR(0x01c255);
    }else if (temp == 5){
        color = HEXCOLOR(0x4499ff);
    }
    return color;
}
@end
