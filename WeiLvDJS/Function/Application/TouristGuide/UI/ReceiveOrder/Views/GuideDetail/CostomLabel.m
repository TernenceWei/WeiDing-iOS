//
//  CostomLabel.m
//  WeiLvDJS
//
//  Created by whw on 16/11/9.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "CostomLabel.h"

@implementation CostomLabel

- (instancetype)init {
    if (self = [super init]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _textInsets)];
}


@end
