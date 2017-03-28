//
//  WL_PasswordView.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_PasswordView.h"

#import "TPPasswordTextView.h"
@implementation WL_PasswordView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        
        self.backgroundColor =[UIColor colorWithWhite:0.2 alpha:0.7];
        
        [self createUI];
        
    }

    return self;
}

-(void)createUI
{
    
   
    NSInteger height=0;
    
    NSInteger top =0;
    
    NSInteger distance =0;
    
    if (IsiPhone4||IsiPhone5) {
        
        height = 35;
        
        top = 85;
        
        
    }else
    {
        height = 45;
        
        top =75;
    
    }
    
    TPPasswordTextView *view1 = [[TPPasswordTextView alloc] initWithFrame:CGRectMake(30, top, ScreenWidth - 120, height)];
    
    view1.elementCount = 6;
    
    if (IsiPhone4) {
        
        distance = 80;
    }else if (IsiPhone5)
    
    {
        distance = 140;
    }
    
    else
    {
        distance =170;
    }
    
    
    UIView *bgView =[[UIView alloc]initWithFrame:CGRectMake(35, distance, ScreenWidth-70, 160)];
    
    bgView.backgroundColor =[UIColor whiteColor];
    
    bgView.layer.cornerRadius = 3.0;
    
    [self addSubview:bgView];
    
    [bgView addSubview:view1];
    
    UILabel *tipLabel =[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-70-120)/2, 20, 120, 20)];
    tipLabel.textColor =WLColor(103, 138, 240, 1);
    
    tipLabel.font =WLFontSize(17);
    
    tipLabel.text = @"请输入支付密码";
    
    tipLabel.textAlignment =NSTextAlignmentCenter;
    
    [bgView addSubview:tipLabel];
    
    
    UIButton *cancel =[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-70-36, 20, 16, 16)];
    
    [cancel setBackgroundImage:[UIImage imageNamed:@"AccountCancel"] forState:UIControlStateNormal];
    
    [cancel addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [bgView addSubview:cancel];
    
    WS(weakSelf);
    
    view1.passwordBlock = ^(NSString *password) {
        
       
        [weakSelf performSelector:@selector(click:) withObject:password afterDelay:0.5];

    };

    
}
-(void)click:(NSString *)password
{
   
    if (self.removeKeyboard) {
        
        self.removeKeyboard(password);
        
    }
    [self endEditing:YES];
    
    [self removeFromSuperview];
    
   
    
   
}

-(void)cancelClick
{
    [self removeFromSuperview];
}
@end
