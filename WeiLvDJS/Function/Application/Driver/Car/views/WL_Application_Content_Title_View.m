//
//  WL_Application_Content_Title_View.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Content_Title_View.h"
#import "CycleScrollView.h"

@interface WL_Application_Content_Title_View ()

@end


@implementation WL_Application_Content_Title_View


- (NSMutableArray *)pictures
{
    if (!_pictures) {
        _pictures = [NSMutableArray array];
    }
    return _pictures;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupChildViewToContentTitleView];
    }
    return self;
}


#pragma mark - 设置子控件
- (void)setupChildViewToContentTitleView
{
  
    //添加应用标题
    UILabel *titleLable = [[UILabel alloc] init];
//    UIButton *selectCityButton = [[UIButton alloc]init];
    //添加到父控件
//    [self addSubview:selectCityButton];
    [self addSubview:titleLable];
    //设置属性
    titleLable.font = WLFontSize(14);
    titleLable.textAlignment = NSTextAlignmentLeft;
    titleLable.textColor = [WLTools stringToColor:@"#929292"];
//    [selectCityButton setTitle:@"北京市" forState:UIControlStateNormal];
//    [selectCityButton setTitleColor:Color2 forState:UIControlStateNormal];
//    selectCityButton.titleLabel.font = [UIFont WLFontOfSize:14];
    //添加约束
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(ScaleW(12));
        make.bottom.equalTo(self).offset(- ScaleH(7));
    }];
    
//    [selectCityButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self).offset(-ScaleH(12));
//        make.bottom.equalTo(self);
//    }];
    self.titleLable = titleLable;
//    selectCityButton.hidden = YES;
//    self.selectCityButton = selectCityButton;
}


- (void)creatScrollViewToTitleView
{
    
    if (self.cycle) {
        [self.cycle removeFromSuperview];
        [self.noticeLabel removeFromSuperview];
    }
    self.cycle = [[CycleScrollView alloc] initWithFrameRect:CGRectMake(0, 0, ScreenWidth, ScaleH(200)) ImageArray:self.pictures];
    [self addSubview:self.cycle];
    UILabel *noticeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, ScaleH(CGRectGetMaxY(self.cycle.frame)-49), ScreenWidth, ScaleH(49))];
    noticeLabel.textColor = [UIColor whiteColor];
    noticeLabel.font = systemFont(17);
    noticeLabel.text = @"   公告:春节旅游旺季平台奖励通知事项";
    noticeLabel.textAlignment = NSTextAlignmentLeft;
    noticeLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
//    [self addSubview:noticeLabel];
//    self.noticeLabel = noticeLabel;
}








@end
