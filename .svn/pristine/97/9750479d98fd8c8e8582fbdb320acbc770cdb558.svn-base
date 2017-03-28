//
//  WL_Mine_Setting_AboutWeiDing_View.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/14.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Mine_Setting_AboutWeiDing_View.h"

@implementation WL_Mine_Setting_AboutWeiDing_View

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置子控件
        [self setupChildViewToAboutWeiDing];
    }
    return self;
}

#pragma mark - 设置子控件
- (void)setupChildViewToAboutWeiDing
{
    //头部LogoImageView
    UIImageView *logoImageView = [[UIImageView alloc] init];
    //添加到父控件
    [self addSubview:logoImageView];
    //设置属性
    logoImageView.layer.cornerRadius = 15.0f;
    logoImageView.layer.masksToBounds = YES;
    logoImageView.image = [UIImage imageNamed:@"about_logo60x60"];
    logoImageView.backgroundColor = WLColor(255, 0, 0, 1);
    //添加约束
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@80);
        make.height.equalTo(@80);
        make.top.equalTo(self.mas_top).offset(50);
    }];
    
    //版本号Lable
    UILabel *versionLable = [[UILabel alloc] init];
    //添加到父控件
    [self addSubview:versionLable];
    //设置属性
    versionLable.textColor = WLColor(176, 183, 193, 1);
    versionLable.font = WLFontSize(16);
    versionLable.textAlignment = NSTextAlignmentCenter;
    versionLable.text = [NSString stringWithFormat:@"微叮%@", AppVersion];
    //添加约束
    [versionLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImageView.mas_bottom).offset(33);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    

    
}
@end
