//
//  WL_SetSucess_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/14.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_SetSucess_ViewController.h"

@interface WL_SetSucess_ViewController ()

@end

@implementation WL_SetSucess_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title =self.titleSting;
    
    self.view.backgroundColor = BgViewColor;
    
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
    
    label.text = self.tip;
    
    [backGroundWhiteView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerX.mas_equalTo(backGroundWhiteView);
        
        make.top.mas_equalTo(imageView.mas_bottom).offset(20);
        
    }];
    
    
    UIButton *completeButton =[UIButton new];
    
    [completeButton setBackgroundColor:WLColor(140, 157, 244, 1)];
    
    [completeButton setTitle:@"完成" forState:UIControlStateNormal];
    [completeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [completeButton addTarget:self action:@selector(completeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    completeButton.layer.cornerRadius = 3.0;
   
    [backGroundWhiteView addSubview:completeButton];
    
    [completeButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(label.mas_bottom).offset(45);
        
        make.centerX.mas_equalTo(backGroundWhiteView);
        
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-90, 45));
    }];

    
}

-(void)completeButtonClick
{
    
    NSArray *array =self.navigationController.viewControllers;
    
    
    
    [self.navigationController popToViewController:array[1] animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
