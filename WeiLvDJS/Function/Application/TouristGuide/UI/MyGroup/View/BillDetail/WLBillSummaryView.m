//
//  WLBillSummaryView.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLBillSummaryView.h"

@interface WLBillSummaryView ()
@property(nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) NSArray *textArray;
@end

@implementation WLBillSummaryView

- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)title
                    textArray:(NSArray *)textArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textArray = textArray;
        [self setupUIWithTitle:title];
        
    }
    return self;
}

- (void)setupUIWithTitle:(NSString *)title{
    
    self.topLabel = [[UILabel alloc] init];
    self.topLabel.textColor = HEXCOLOR(0x2f2f2f);
    self.topLabel.font = [UIFont WLFontOfSize:14];
    self.topLabel.textAlignment = NSTextAlignmentLeft;
    self.topLabel.frame = CGRectMake(ScaleW(15), 0, ScreenWidth, ScaleH(50));
    self.topLabel.text = title;
    [self addSubview:self.topLabel];
    
    for (int i = 0; i < 6; i++) {
        [self setupLabelWithIndex:i];
    }
    
    for (int i = 0; i < 2; i++) {
        [self setupLineWithIndex:i];
    }
    
}

- (void)setupLabelWithIndex:(NSUInteger)index
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = HEXCOLOR(0x6f7378);
    label.font = [UIFont WLFontOfSize:11];
    label.textAlignment = NSTextAlignmentCenter;
    
    CGFloat width = (ScreenWidth - ScaleW(15)) / 3;
    CGFloat height = ScaleH(25);
    if (index > 2) {
        label.textColor = HEXCOLOR(0xff5b3d);
    }
    label.frame = CGRectMake(ScaleW(15) + width * (index % 3), index / 3 * height + ScaleH(50), width, height);
    label.text = self.textArray[index];
    [self addSubview:label];
}

- (void)setupLineWithIndex:(NSUInteger)index
{
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = HEXCOLOR(0xd8d9dd);

    CGFloat width = 1;
    CGFloat height = ScaleH(40);
    line.frame = CGRectMake(ScreenWidth / 3 * (index % 2 + 1), ScaleH(55), width, height);
    [self addSubview:line];
}
@end
