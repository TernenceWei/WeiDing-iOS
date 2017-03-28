//
//  WLApplicationNavButton.m
//  WeiLvDJS
//
//  Created by ternence on 2017/3/15.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLApplicationNavButton.h"

@interface WLApplicationNavButton ()

@property (nonatomic, assign) CGFloat textWidth;

@end

@implementation WLApplicationNavButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitle:@"微叮" forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont WLFontOfSize:14]];
        [self setImage:[UIImage imageNamed:@"xiangxia"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"xiangshang"] forState:UIControlStateSelected];
        [self setTitleColor:Color2 forState:UIControlStateNormal];
    }
    return self;
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    _textWidth = [WLUITool sizeWithString:self.titleLabel.text font:self.titleLabel.font].width;
    CGFloat imageX = self.frame.size.width/2 + _textWidth/2;
    return CGRectMake(imageX + 2, 16, 15, 10);
    
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = (self.frame.size.width - _textWidth)/2;
    CGFloat height = contentRect.size.height;
    return CGRectMake(imageX, 0, 220, height);
    
}
@end
