//
//  WL_OrderDetail_BottomThreeView.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/28.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_OrderDetail_BottomThreeView.h"

@implementation WL_OrderDetail_BottomThreeView

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
    if (IsiPhone5||IsiPhone4)
    {

        distace = 15;
        
    }else if (IsiPhone6)
    {
        distace = 35;
        
    }else if (IsiPhone6P)
    {
        distace = 48;
    }
    
    //设置联系计调按钮
    self.tourOperatorButton = [[UIButton alloc] init];
    //添加到父控件
    [self addSubview:self.tourOperatorButton];
    //设置属性
    [self.tourOperatorButton setBackgroundColor:[WLTools stringToColor:@"#ffffff"]];
    [self.tourOperatorButton setTitle:@"联系计调" forState:UIControlStateNormal];
    [self.tourOperatorButton setTitleColor:[WLTools stringToColor:@"#868686"] forState:UIControlStateNormal];
    [self.tourOperatorButton setImage:[UIImage imageNamed:@"tripService"] forState:UIControlStateNormal];
    self.tourOperatorButton.titleLabel.font = WLFontSize(15);
    
    self.tourOperatorButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    self.tourOperatorButton.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    
    UIImage *ima =[UIImage imageNamed:@"tripService"];
    
   
    //添加约束
    [self.tourOperatorButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.width.equalTo(@(ScreenWidth/3));
        make.height.equalTo(@(56));
    }];
    
    //调整图片与文字的位置
    [self.tourOperatorButton setImageEdgeInsets:UIEdgeInsetsMake(3,(ScreenWidth/3-ima.size.width)/2, 15, 0)];
    [self.tourOperatorButton setTitleEdgeInsets:UIEdgeInsetsMake(38,-(ScreenWidth/3-70)/2+distace, 0, 0)];

    [self.tourOperatorButton addTarget:self action:@selector(tourOperatorButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    //设置联系导游按钮
    self.tourGuideButton = [[UIButton alloc] init];
    //添加到父控件
    [self addSubview:self.tourGuideButton];
    //设置属性
    [self.tourGuideButton setBackgroundColor:[WLTools stringToColor:@"#ffffff"]];
    [self.tourGuideButton setTitle:@"联系导游" forState:UIControlStateNormal];
    [self.tourGuideButton setTitleColor:[WLTools stringToColor:@"#868686"] forState:UIControlStateNormal];
    [self.tourGuideButton setImage:[UIImage imageNamed:@"tripTour"] forState:UIControlStateNormal];
    self.tourGuideButton.titleLabel.font = WLFontSize(15);
    
    self.tourGuideButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    self.tourGuideButton.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    //调整图片与文字的位置
    [self.tourGuideButton setImageEdgeInsets:UIEdgeInsetsMake(3, (ScreenWidth/3-ima.size.width)/2, 15,0)];
    [self.tourGuideButton setTitleEdgeInsets:UIEdgeInsetsMake(38,-(ScreenWidth/3-70)/2+distace, 0, 0)];
    
    [self.tourGuideButton addTarget:self action:@selector(tourGuideButtonClick) forControlEvents:UIControlEventTouchUpInside];
    //添加约束
    [self.tourGuideButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tourOperatorButton.mas_right);
        make.bottom.equalTo(self.tourOperatorButton.mas_bottom);
        make.width.equalTo(self.tourOperatorButton.mas_width);
        make.height.equalTo(self.tourOperatorButton.mas_height);
    }];
    
    //设置催款按钮
    UIButton *reminderButton = [[UIButton alloc] init];
    //添加到父控件
    [self addSubview:reminderButton];
    //设置属性
    
    [reminderButton setTitle:@"催款" forState:UIControlStateNormal];
    [reminderButton setTitleColor:[WLTools stringToColor:@"#ffffff"] forState:UIControlStateNormal];
    reminderButton.titleLabel.font =WLFontSize(15);
    
    [reminderButton addTarget:self action:@selector(reminderButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //添加约束
    [reminderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tourGuideButton.mas_right);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(self.tourGuideButton.mas_height);
    }];

    self.statusButton = reminderButton;

    
}

-(void)tourOperatorButtonClick
{
    if (self.buttonClick) {
        
        self.buttonClick(ClickTourOperator);
        
    }
}

-(void)reminderButtonClick

{
    if (self.buttonClick) {
        
        self.buttonClick(ClickReminderButton);
        
    }
}

-(void)tourGuideButtonClick

{
    if (self.buttonClick) {
        
        self.buttonClick(ClickTourGuide);
        
    }
}
@end
