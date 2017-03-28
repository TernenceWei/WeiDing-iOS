//
//  WLBillTableFooterView.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLBillTableFooterView.h"

@implementation WLBillTableFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.textColor = HEXCOLOR(0x868686);
        textLabel.font = [UIFont WLFontOfSize:13];
        textLabel.textAlignment = NSTextAlignmentLeft;
        textLabel.frame = CGRectMake(ScaleW(12), 0, ScreenWidth - ScaleW(24), frame.size.height);
        textLabel.text = @"重要提示：\n有返现的项目，导游记录自己所带游客的消费信息。但必须将所有收款交由主导游进行统一管理。";
        textLabel.numberOfLines = 0;
        [self addSubview:textLabel];
    }
    return self;
}

@end
