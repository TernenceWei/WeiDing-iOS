//
//  WL_ConditionSelectionView.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/18.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_ConditionSelectionView.h"

@interface WL_ConditionSelectionView()
{
    UIButton *lastStatusBtn;
}
@end

@implementation WL_ConditionSelectionView


-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.5];
        
        [self createUI];
    }
    
    return self;
}

#pragma mark  - 创建UI
-(void)createUI
{
    
    UIView *whiteView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 70)];
   
    whiteView.backgroundColor=[UIColor whiteColor];
   
    UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(whiteViewTap)];
    
    [whiteView addGestureRecognizer:tap2];
    
    [self addSubview:whiteView];
    
    //第一行布局
    NSArray *statusArr=[NSArray arrayWithObjects:@"全部",@"充值",@"提现",@"转账",nil];
    CGFloat with=(ScreenWidth-20-10*3)/4;
    
    for (int i=0; i<statusArr.count; i++)
    {
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(10+10*i+i*with, 15, with, 40)];
        button.tag=101+i;
        [button setTitleColor:[WLTools stringToColor:@"#6f7378"] forState:UIControlStateNormal];
        [button setTitle:statusArr[i] forState:UIControlStateNormal];
        
        button.titleLabel.font=WLFontSize(15);
        
        [button addTarget:self action:@selector(statusBtn:) forControlEvents:UIControlEventTouchUpInside];
                [whiteView addSubview:button];
        if (i==0){
            
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        [button setBackgroundColor:[WLTools stringToColor:@"#4877e7"]];
            
        button.layer.cornerRadius =3.0;
            
        lastStatusBtn=button;
      }
    }

//    //第二行布局
//    NSArray *incomeArr=[NSArray arrayWithObjects:@"付款",@"转账",nil];
//    CGFloat with2=(ScreenWidth-20-10*3)/4;
//    for (int i=0; i<incomeArr.count; i++)
//    {
//        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(10+10*i+i*with2, 85, with2, 40)];
//        button.tag=201+i;
//        [button setTitleColor:[WLTools stringToColor:@"#6f7378"] forState:UIControlStateNormal];
//        [button setTitle:incomeArr[i] forState:UIControlStateNormal];
//        button.titleLabel.font=WLFontSize(15);
//        
//        [button addTarget:self action:@selector(statusBtn:) forControlEvents:UIControlEventTouchUpInside];
//        
//        [whiteView addSubview:button];
//        
//    }
}

-(void)statusBtn:(UIButton *)button
{
    
    [lastStatusBtn setBackgroundColor:[UIColor whiteColor]];
    
    [lastStatusBtn setTitleColor:[WLTools stringToColor:@"#6f7378"] forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [button setBackgroundColor:[WLTools stringToColor:@"#4877e7"]];
    
    button.layer.cornerRadius = 3.0;
    
    lastStatusBtn =button;

    if (self.confirmButtonClick)
    {
        
        self.confirmButtonClick(button);
        
    }
    
}

-(void)whiteViewTap
{
    
}

@end
