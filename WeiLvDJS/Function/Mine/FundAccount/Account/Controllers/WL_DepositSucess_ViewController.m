//
//  WL_DepositSucess_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/18.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_DepositSucess_ViewController.h"

@interface WL_DepositSucess_ViewController ()

@end

@implementation WL_DepositSucess_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = BgViewColor;
    self.navigationItem.title =@"账户充值";
    
    [self initUI];
}

-(void)initUI
{
    UIView *backGroundWhiteView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 280)];
    backGroundWhiteView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:backGroundWhiteView];
    
    UIImageView *imageView =[[UIImageView alloc]init];
    
    imageView.image =[UIImage imageNamed:@"WLSetSucessImage"];
    
    [backGroundWhiteView addSubview:imageView];
    
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(45);
        
        make.centerX.mas_equalTo(backGroundWhiteView);
        
    }];
    
    UILabel *label =[UILabel new];
    
    label.font = WLFontSize(18);
    
    label.textColor = GrayColor;
    
    label.text = self.string1;
    
    [backGroundWhiteView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(backGroundWhiteView);
        
        make.top.mas_equalTo(imageView.mas_bottom).offset(20);
        
    }];
    
    UILabel *dateLabel =[UILabel new];
    
    dateLabel.font = WLFontSize(18);
    
    dateLabel.textColor = GrayColor;
    
    dateLabel.text =self.string2;
    
    [backGroundWhiteView addSubview:dateLabel];
    
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(backGroundWhiteView);
        
        make.top.mas_equalTo(label.mas_bottom).offset(0);
        
    }];

    UIButton *completeButton =[UIButton new];
    
    [completeButton setBackgroundColor:Color1];
    
    [completeButton setTitle:@"完成" forState:UIControlStateNormal];
    
    [completeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [completeButton addTarget:self action:@selector(completeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    completeButton.layer.cornerRadius = 22.5;
    
    completeButton.layer.masksToBounds = YES;
    
    [backGroundWhiteView addSubview:completeButton];
    
    [completeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.top.mas_equalTo(dateLabel.mas_bottom).offset(30);
        
        make.centerX.mas_equalTo(backGroundWhiteView);
        
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-90, 45));
    }];
}

-(void)completeButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
