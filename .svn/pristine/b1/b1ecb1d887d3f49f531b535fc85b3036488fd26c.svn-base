//
//  WL_WarningView.m
//  WeiLvDJS
//
//  Created by whw on 16/11/8.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_WarningView.h"
@interface WL_WarningView ()

@property(nonatomic,strong)UILabel *topLabel;

@property(nonatomic,strong)UIButton *button;

@end

@implementation WL_WarningView

-(instancetype)initWithFrame:(CGRect)frame

{
    if (self =[super initWithFrame:frame]) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapRemove)];
        
        
        [self addGestureRecognizer:tap];
        
        [self setUp];
        
    }
    return self;
}

-(void)setUp
{
    
    UIView *whiteView =[UIView new];
    
    whiteView.backgroundColor =[UIColor whiteColor];
    
    [whiteView setFrame:CGRectMake((ScreenWidth-280)/2, ScaleH(290), ScaleW(280), ScaleH(150))];
    
    whiteView.layer.cornerRadius =3.0;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapWhiteView)];
    
    [whiteView addGestureRecognizer:tap];
    
    [self addSubview:whiteView];
    
    UILabel *topLabel =[UILabel new];
    
    [topLabel setFrame:CGRectMake(10, 20, ScaleW(280-20), ScaleH(70))];
    
    topLabel.numberOfLines =0;
    
    topLabel.font =WLFontSize(15);
    
    topLabel.textAlignment = NSTextAlignmentCenter;
    
    topLabel.textColor =BlackColor;
    
    topLabel.text = @"";
    
    
    self.topLabel =topLabel;
    
    [whiteView addSubview:topLabel];
    
    UILabel *line =[[UILabel alloc]initWithFrame:CGRectMake(10, ScaleH(150-50), ScaleW(280-20), 0.5)];
    
    line.backgroundColor = bordColor;
    
    [whiteView addSubview:line];
    
    
    UIButton *knowButton =[[UIButton alloc]initWithFrame:CGRectMake(0, ViewBelow(line), ScaleW(280), ScaleH(50))];
    
    [knowButton setTitle:@"" forState:UIControlStateNormal];
    
    
    [knowButton setTitleColor:WLColor(122, 146, 228, 1) forState:UIControlStateNormal];
    
    [knowButton addTarget:self action:@selector(knowClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.button =knowButton;
    
    [whiteView addSubview:knowButton];
}

-(void)getAttributedStringFrom:(UILabel *)label
{
    
    NSMutableAttributedString *attrawardLabel = [[NSMutableAttributedString alloc] initWithString:label.text];
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 6; // 调整行间距
    NSRange rang = NSMakeRange(0, [label.text length]);
    [attrawardLabel addAttribute:NSParagraphStyleAttributeName value:paragraph range:rang];
    
    label.attributedText =attrawardLabel;
    
    label.textAlignment =NSTextAlignmentCenter;
}

-(void)setTipString:(NSString *)tipString
{
    self.topLabel.text = tipString;
    
    [self getAttributedStringFrom:self.topLabel];
}
-(void)setButtonTittle:(NSString *)buttonTittle
{
    [self.button setTitle:buttonTittle forState:UIControlStateNormal];
}
-(void)knowClick

{
    [self removeFromSuperview];
}
-(void)tapRemove

{
    [self removeFromSuperview];
}
-(void)tapWhiteView
{
    
}
@end
