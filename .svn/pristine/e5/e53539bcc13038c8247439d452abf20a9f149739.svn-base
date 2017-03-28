//
//  WL_Application_Driver_Order_OrderDetail_TopView.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_Order_OrderDetail_TopView.h"

@implementation WL_Application_Driver_Order_OrderDetail_TopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //设置子控件
        [self setupContentViewToOrderDetailTopView];
    }
    return self;
}

#pragma mark - 设置子控件
- (void)setupContentViewToOrderDetailTopView
{
    //头部行程View
    UIView *topView = [[UIView alloc] init];
    [self addSubview:topView];
    //设置头部行程View的背景颜色
    topView.backgroundColor = [WLTools stringToColor:@"#4877e7"];
    //添加约束
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@125);
    }];
    
    //箭头ImageView
    UIImageView *arrowImageView = [[UIImageView alloc] init];
    //添加到父控件
    [topView addSubview:arrowImageView];
    //设置属性
    arrowImageView.image = [UIImage imageNamed:@"Driver_Order_Directing2"];
    //添加约束
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView.mas_centerX);
        make.width.equalTo(@(72));
        make.top.equalTo(topView.mas_top).offset(44);
        make.height.equalTo(@10);
    }];
    
    //行程数
    UILabel *mileageLable = [[UILabel alloc] init];
    //添加到父控件
    [topView addSubview:mileageLable];
    //设置属性
    mileageLable.font = WLFontSize(14);
    mileageLable.textColor = [WLTools stringToColor:@"#b7cbfd"];
    mileageLable.textAlignment = NSTextAlignmentCenter;
    //添加约束
    [mileageLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(arrowImageView.mas_top);
        make.centerX.equalTo(arrowImageView.mas_centerX);
    }];
    self.mileageLable = mileageLable;
    //出发城市Lable
    UILabel *fromCityLable = [[UILabel alloc] init];
    //添加到父控件
    [topView addSubview:fromCityLable];
    //设置属性
    fromCityLable.textColor = [WLTools stringToColor:@"#ffffff"];
    fromCityLable.font = WLFontSize(20);
    fromCityLable.textAlignment = NSTextAlignmentRight;
    //添加约束
    [fromCityLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(arrowImageView.mas_left).offset(-22);
        make.top.equalTo(topView.mas_top).offset(38);
    }];
    self.fromCityLable = fromCityLable;
    //到达城市Lable
    UILabel *endCityLable = [[UILabel alloc] init];
    //添加到父控件
    [topView addSubview:endCityLable];
    //设置属性
    endCityLable.textColor = fromCityLable.textColor;
    endCityLable.font = fromCityLable.font;
    endCityLable.textAlignment = NSTextAlignmentLeft;
    //添加约束
    [endCityLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(arrowImageView.mas_right).offset(22);
        make.top.equalTo(fromCityLable.mas_top);
    }];
    self.endCityLable = endCityLable;
    //出发日期Lable
    UILabel *startTimeLable = [[UILabel alloc] init];
    [topView addSubview:startTimeLable];
    //设置属性
    startTimeLable.font = WLFontSize(14);
    startTimeLable.textColor = [WLTools stringToColor:@"#ffd241"];
    startTimeLable.textAlignment = NSTextAlignmentRight;
    //添加约束
    [startTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(fromCityLable.mas_right);
        make.top.equalTo(fromCityLable.mas_bottom).offset(20);
    }];
    self.startTimeLable = startTimeLable;
    //结束日期Lable
    UILabel *endTimeLable = [[UILabel alloc] init];
    [topView addSubview:endTimeLable];
    //设置属性
    endTimeLable.font = WLFontSize(14);
    endTimeLable.textColor = [WLTools stringToColor:@"#ffd241"];
    endCityLable.textAlignment = NSTextAlignmentLeft;
    //添加约束
    [endTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(endCityLable.mas_left);
        make.top.equalTo(fromCityLable.mas_bottom).offset(20);
    }];
    self.endTimeLable = endTimeLable;
    
    //出行人数Lable
    UILabel *personCountLable = [[UILabel alloc] init];
    [topView addSubview:personCountLable];
    //设置属性
    personCountLable.textAlignment = NSTextAlignmentCenter;
    personCountLable.font = endTimeLable.font;
    personCountLable.textColor = [WLTools stringToColor:@"#ffffff"];
    //添加约束
    [personCountLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView.mas_centerX);
        make.centerY.equalTo(startTimeLable.mas_centerY);
    }];
    self.personCountLable = personCountLable;
/***********************************************开始城市详细信息与到达城市详细信息***********************************************/
    
    //出发地点
    //出发地点Logo
    UILabel *startLogo = [[UILabel alloc] init];
    [self addSubview:startLogo];
    //设置属性
    startLogo.layer.cornerRadius = 9.0f;
    startLogo.layer.masksToBounds = YES;
    startLogo.backgroundColor = [WLTools stringToColor:@"#69c95f"];
    startLogo.textColor = [WLTools stringToColor:@"#ffffff"];
    startLogo.text = @"始";
    startLogo.font = WLFontSize(14);
    startLogo.textAlignment = NSTextAlignmentCenter;
    [startLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(12);
        make.top.equalTo(topView.mas_bottom).offset(9);
        make.height.equalTo(@18);
        make.width.equalTo(@18);
    }];
    
    //出发地点Lable
    UILabel *startAddressLable = [[UILabel alloc] init];
    [self addSubview:startAddressLable];
    //设置属性
    startAddressLable.font = WLFontSize(18);
    startAddressLable.textColor = [WLTools stringToColor:@"#000000"];
//    startAddressLable.text = @"深圳市南山区腾讯大厦";
    [startAddressLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(startLogo.mas_right).offset(11);
        make.centerY.equalTo(startLogo.mas_centerY);
    }];
    self.startAddressLable = startAddressLable;
    //出发时间Lable
    UILabel *beginTimeLable = [[UILabel alloc] init];
    [self addSubview:beginTimeLable];
    beginTimeLable.font = WLFontSize(16);
    beginTimeLable.textColor = [WLTools stringToColor:@"#b5b5b5"];
    [beginTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(startAddressLable.mas_left);
        make.top.equalTo(startAddressLable.mas_bottom).offset(15);
    }];
    beginTimeLable.text = @"2017-09-11";
    self.beginTimeLable = beginTimeLable;
    //画虚线
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 200, ScreenWidth, 2)];
    lineImage.image = [self drawLineByImageView:lineImage];
    [self addSubview:lineImage];
    
    //到达地点
    //到达地点Logo
    UILabel *endLogo = [[UILabel alloc] init];
    [self addSubview:endLogo];
    //设置属性
    endLogo.layer.cornerRadius = 9.0f;
    endLogo.layer.masksToBounds = YES;
    endLogo.backgroundColor = [WLTools stringToColor:@"#fe798c"];
    endLogo.textColor = [WLTools stringToColor:@"#ffffff"];
    endLogo.text = @"终";
    endLogo.font = WLFontSize(14);
    endLogo.textAlignment = NSTextAlignmentCenter;
    [endLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(12);
        make.top.equalTo(lineImage.mas_bottom).offset(15);
        make.height.equalTo(@18);
        make.width.equalTo(@18);
    }];

    //结束地点Lable
    UILabel *endAddressLable = [[UILabel alloc] init];
    [self addSubview:endAddressLable];
    //设置属性
    endAddressLable.font = WLFontSize(18);
    endAddressLable.textColor = [WLTools stringToColor:@"#000000"];
//    endAddressLable.text = @"深圳市南山区腾讯大厦";
    [endAddressLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(endLogo.mas_right).offset(11);
        make.centerY.equalTo(endLogo.mas_centerY);
    }];
    self.endAddressLable = endAddressLable;
    //结束时间Lable
    UILabel *arriveTimeLable = [[UILabel alloc] init];
    [self addSubview:arriveTimeLable];
    arriveTimeLable.text = @"2016-09-19";
    arriveTimeLable.font = WLFontSize(16);
    arriveTimeLable.textColor = [WLTools stringToColor:@"#b5b5b5"];
    [arriveTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(endAddressLable.mas_left);
        make.top.equalTo(endAddressLable.mas_bottom).offset(15);
    }];
    self.arriveTimeLable = arriveTimeLable;
}

#pragma mark - 画曲线
- (UIImage *)drawLineByImageView:(UIImageView *)imageView
{
    UIGraphicsBeginImageContext(imageView.frame.size);   //开始画线 划线的frame
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    //设置线条终点形状
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    // 5是每个虚线的长度  1是高度
    CGFloat lengths[] = {9,6};
    CGContextRef line = UIGraphicsGetCurrentContext();
    // 设置颜色
    CGContextSetStrokeColorWithColor(line, [WLTools stringToColor:@"#d8d9dd"].CGColor);
    
    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(line, 0.0, 2.0);    //开始画线
    CGContextAddLineToPoint(line, ScreenWidth - 10, 2.0);
    CGContextStrokePath(line);
    // UIGraphicsGetImageFromCurrentImageContext()返回的就是image
    return UIGraphicsGetImageFromCurrentImageContext();
}




@end
