//
//  WLTradeRecordSectionHeader.m
//  WeiLvDJS
//
//  Created by ternence on 2016/12/20.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLTradeRecordSectionHeader.h"

@interface WLTradeRecordSectionHeader ()
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UILabel *bottomLabel;
@end

@implementation WLTradeRecordSectionHeader
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = Color4;
        
        CGFloat height = ScaleH(35);
        self.leftLabel = [UILabel labelWithText:@"2016-12" textColor:Color3 fontSize:14];
        self.leftLabel.frame = CGRectMake(ScaleW(12), 0, ScreenWidth - ScaleW(12), height);
        [self addSubview:self.leftLabel];
        
        self.topLabel = [UILabel labelWithText:@"收入+12000" textColor:Color3 fontSize:12];
        self.topLabel.frame = CGRectMake(0, 0, ScreenWidth - ScaleW(12), height / 2);
        self.topLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.topLabel];
        
        self.bottomLabel = [UILabel labelWithText:@"支出-150" textColor:Color3 fontSize:12];
        self.bottomLabel.frame = CGRectMake(0, height / 2, ScreenWidth - ScaleW(12), height / 2);
        self.bottomLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.bottomLabel];
    }
    return self;
}

- (void)setObject:(WLTradeRecordListObject *)object
{
    _object = object;
    self.leftLabel.text = [NSString stringWithFormat:@"%@",object.current_date];
    self.topLabel.text = [NSString stringWithFormat:@"收入%@",object.income];
    self.bottomLabel.text = [NSString stringWithFormat:@"支出%@",object.expenditure];
}
@end
