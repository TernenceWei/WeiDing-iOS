//
//  WL_OrderDetail_BottomTwoView.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/28.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_OrderDetail_BottomTwoView.h"

@implementation WL_OrderDetail_BottomTwoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //添加子控件
        [self setupContentViewToAcceptOrderDetailBottomView];
    }
    return self;
}


#pragma mark - 添加子控件
- (void)setupContentViewToAcceptOrderDetailBottomView
{
    
    NSInteger distace = 0;
    if (IsiPhone5||IsiPhone4) {
        
        distace = 25;
        
    }else if (IsiPhone6)
    {
        distace = 39;
        
    }else if (IsiPhone6P)
    {
        distace = 48;
    }
    
    //设置联系计调按钮
    UIButton *tourOperatorButton = [[UIButton alloc] init];
    //添加到父控件
    [self addSubview:tourOperatorButton];
    
    self.tourOperatorButton = tourOperatorButton;
    //设置属性
    [tourOperatorButton setBackgroundColor:[WLTools stringToColor:@"#ffffff"]];
    [tourOperatorButton setTitle:@"联系计调" forState:UIControlStateNormal];
    [tourOperatorButton setTitleColor:[WLTools stringToColor:@"#868686"] forState:UIControlStateNormal];
    [tourOperatorButton setImage:[UIImage imageNamed:@"tripService"] forState:UIControlStateNormal];
    tourOperatorButton.titleLabel.font = WLFontSize(15);
    
    tourOperatorButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    tourOperatorButton.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    
    
    
    UIImage *ima =[UIImage imageNamed:@"tripTour"];

    //添加约束
    [tourOperatorButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.width.equalTo(@(ScreenWidth/2));
        make.height.equalTo(@(56));
    }];
    
    //调整图片与文字的位置
    [tourOperatorButton setImageEdgeInsets:UIEdgeInsetsMake(3,(ScreenWidth/2-ima.size.width)/2, 15, 0)];
    [tourOperatorButton setTitleEdgeInsets:UIEdgeInsetsMake(38,distace, 0, 0)];
    
    tourOperatorButton.tag =101;
    
    [tourOperatorButton addTarget:self action:@selector(tourOperatorButton:) forControlEvents:UIControlEventTouchUpInside];
    //设置联系导游按钮
    UIButton *tourGuideButton = [[UIButton alloc] init];
    //添加到父控件
    [self addSubview:tourGuideButton];
    
    self.tourGuideButton = tourGuideButton;
    //设置属性
    [tourGuideButton setBackgroundColor:[WLTools stringToColor:@"#ffffff"]];
    [tourGuideButton setTitle:@"联系导游" forState:UIControlStateNormal];
    [tourGuideButton setTitleColor:[WLTools stringToColor:@"#868686"] forState:UIControlStateNormal];
    [tourGuideButton setImage:[UIImage imageNamed:@"tripTour"] forState:UIControlStateNormal];
    tourGuideButton.titleLabel.font = WLFontSize(15);
    
    tourGuideButton.tag =102;
    
    tourGuideButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    tourGuideButton.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    //调整图片与文字的位置
    [tourGuideButton setImageEdgeInsets:UIEdgeInsetsMake(3, (ScreenWidth/2-ima.size.width)/2, 15,0)];
    [tourGuideButton setTitleEdgeInsets:UIEdgeInsetsMake(38,distace, 0, 0)];
    //添加约束
    [tourGuideButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tourOperatorButton.mas_right);
        make.bottom.equalTo(tourOperatorButton.mas_bottom);
        make.width.equalTo(tourOperatorButton.mas_width);
        make.height.equalTo(tourOperatorButton.mas_height);
    }];
    
    [tourGuideButton addTarget:self action:@selector(tourGuideButton:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)tourGuideButton:(UIButton *)button
{
    if (self.buttonClick) {
        
        self.buttonClick(button.tag);
        
    }
}

-(void)tourOperatorButton:(UIButton*)button

{
    if (self.buttonClick) {
        
        self.buttonClick(button.tag);
        
    }
}
@end
