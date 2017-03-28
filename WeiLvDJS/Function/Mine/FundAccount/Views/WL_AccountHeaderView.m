//
//  WL_AccountHeaderView.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AccountHeaderView.h"


@interface WL_AccountHeaderView()



@end



@implementation WL_AccountHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self= [super initWithFrame:frame]) {
        
        self.backgroundColor =[WLTools stringToColor:@"#4877e7"];
        
        [self createUI];
    }
    
    return self;
}

-(void)createUI
{
   
    UIImageView *back =[UIImageView new];

    back.image =[UIImage imageNamed:@"NavigationBack"];
    
    [self addSubview:back];
    
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.top.mas_equalTo(28);
        
    }];

    self.backButton =[UIButton new];

    [self addSubview:self.backButton];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(0);
        
        make.top.mas_equalTo(20);
        
        make.size.mas_equalTo(CGSizeMake(40,30));
        
    }];
    
    UILabel *titleLabel =[UILabel new];
    
    titleLabel.font =WLFontSize(18);
    
    titleLabel.textColor =[UIColor whiteColor];
    
    titleLabel.text = @"资金帐户";
    
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(self);
        
        make.top.mas_equalTo(30);
        
    }];
    
    UILabel *meansLabel =[UILabel new];
    
    meansLabel.textColor =[UIColor whiteColor];
    
    meansLabel.font =WLFontSize(15);
    
    meansLabel.text =@"总资产(元)";
    
    [self addSubview:meansLabel];
    
    [meansLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(self).offset(-7);
        
        make.top.mas_equalTo(105);
        
    }];
    
    UIImageView *img =[UIImageView new];
    
    img.image = [UIImage imageNamed:@"AccountCalculate"];
    
    [self addSubview:img];
    
    [img mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.mas_equalTo(meansLabel.mas_right).offset(2);
        
        make.top.mas_equalTo(meansLabel.mas_top).offset(3);
        
    }];
    
    self.meansNum =[UILabel new];
    
    self.meansNum.textColor =[UIColor whiteColor];
    
    self.meansNum.font =WLFontSize(30);
    
    //self.meansNum.text =@"36587.25";
    
    [self addSubview:self.meansNum];
    
    [self.meansNum mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.centerX.mas_equalTo(self);
        
        make.top.mas_equalTo(meansLabel.mas_bottom).offset(30);
        
    }];
    
}

@end
