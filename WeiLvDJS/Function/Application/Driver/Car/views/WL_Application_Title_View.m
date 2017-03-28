//
//  WL_Application_Title_View.m
//  WeiLvDJS
//
//  Created by zhaoxiao on 16/9/9.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Title_View.h"

@implementation WL_Application_Title_View

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupChildViewToApplyTop];
    }
    return self;
}

//设置产品页面Nav上View的子控件
- (void)setupChildViewToApplyTop
{
    
    //组织名称Lable
    UILabel *organizationLable = [[UILabel alloc] init];
    [self addSubview:organizationLable];
    //添加约束
    [organizationLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.width.offset(ScaleW(300));
    }];
    //设置属性
    organizationLable.textAlignment = NSTextAlignmentCenter;
    organizationLable.numberOfLines = 1;
//    organizationLable.lineBreakMode = UILineBreakModeMiddleTruncation;// 以单词为单位换行。无论是单行还是多行，都是中间有省略号，省略号后面只有2个字符。
    organizationLable.textColor = [WLTools stringToColor:@"#333333"];
    organizationLable.font = WLFontSize(17);
    self.organizationLable = organizationLable;
    organizationLable.userInteractionEnabled = YES;
    //强制布局
    [organizationLable sizeToFit];
    //指示器按钮
    UIButton *sliderButton = [[UIButton alloc] init];
    [self addSubview:sliderButton];
    sliderButton.adjustsImageWhenHighlighted = NO;
    [sliderButton setBackgroundImage:[UIImage imageNamed:@"xiangxia"] forState:UIControlStateNormal];
    [sliderButton setBackgroundImage:[UIImage imageNamed:@"xiangshang"] forState:UIControlStateSelected];
    sliderButton.userInteractionEnabled = YES;
    [sliderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(organizationLable.mas_right).offset(5);
        make.centerY.equalTo(organizationLable.mas_centerY);
    }];
    self.sliderButton = sliderButton;
}


@end
