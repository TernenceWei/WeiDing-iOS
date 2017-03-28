//
//  WL_Application_Driver_Order_Tour_Button.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/28.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_Order_Tour_Button.h"

@implementation WL_Application_Driver_Order_Tour_Button

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [WLTools stringToColor:@"#f2f2f2"];
        [self setupChildViewToButton];
    }
    return self;
}

- (void)setupChildViewToButton
{
    UILabel *nameLable = [[UILabel alloc] init];
    UIImageView *photoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lianxiren"]];
    nameLable.font = WLFontSize(12);
    nameLable.textAlignment = NSTextAlignmentCenter;
    nameLable.textColor = [WLTools stringToColor:@"#333333"];
    
    [self addSubview:nameLable];
     [self addSubview:photoImageView];
  
    [photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(5);
    }];
    [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(photoImageView.mas_bottom).offset(6);
    }];
    self.nameLable = nameLable;
    self.photoImageView = photoImageView;
    
    
}



@end
