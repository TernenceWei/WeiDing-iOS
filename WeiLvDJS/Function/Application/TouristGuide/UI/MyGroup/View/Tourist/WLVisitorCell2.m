//
//  WLVisitorCell2.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLVisitorCell2.h"

#define cellIdentifier @"WLVisitorCell2"

@interface WLVisitorCell2 ()

@end

@implementation WLVisitorCell2

+ (WLVisitorCell2 *)cellWithTableView:(UITableView*)tableView{
    
    WLVisitorCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLVisitorCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.exclusiveTouch = YES;
        self.multipleTouchEnabled = NO;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setDataArry:(NSArray *)dataArry withLine:(BOOL)withLine enable:(BOOL)enable
{
    _dataArry = dataArry;

    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    
    CGFloat height = ScaleH(50);

    UIView *line = [[UIView alloc] init];
    line.backgroundColor = HEXCOLOR(0xd8d9dd);
    line.frame = CGRectMake(ScaleW(10), height - 1, ScreenWidth, 1);
    [self addSubview:line];
    if (withLine) {
        line.hidden = NO;
    }else{
       line.hidden = YES;
    }
    
    UILabel *leftLabel = [[UILabel alloc] init];
    leftLabel.textAlignment = NSTextAlignmentLeft;
    leftLabel.text = self.dataArry[0];
    leftLabel.font = [UIFont WLFontOfSize:14];
    leftLabel.frame = CGRectMake(ScaleW(15) , 0, ScaleW(80), height);
    leftLabel.textColor =HEXCOLOR(0x2f2f2f);
    [self addSubview:leftLabel];
    
    UILabel *rightLabel = [[UILabel alloc] init];
    rightLabel.textAlignment = NSTextAlignmentLeft;
    rightLabel.text = self.dataArry[1];
    rightLabel.font = [UIFont WLFontOfSize:12];
    rightLabel.frame = CGRectMake(CGRectGetMaxX(leftLabel.frame) + ScaleW(10) , 0, ScreenWidth / 2, height);
    rightLabel.textColor =HEXCOLOR(0x2f2f2f);
    rightLabel.userInteractionEnabled = YES;
    [self addSubview:rightLabel];
    
    if (enable) {
        rightLabel.textColor = HEXCOLOR(0x4877e7);
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightLabelClick)];
        [rightLabel addGestureRecognizer:tapGesture];
    }
    

    
}

- (void)rightLabelClick
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.dataArry[1]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

@end
