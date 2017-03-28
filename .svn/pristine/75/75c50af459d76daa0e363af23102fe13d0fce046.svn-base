//
//  WL_Application_Driver_Bill_Statistics_lineChartView.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/10/11.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_Bill_Statistics_lineChartView.h"

@interface WL_Application_Driver_Bill_Statistics_lineChartView ()

@property(nonatomic, strong) NSMutableArray *points;


@end

@implementation WL_Application_Driver_Bill_Statistics_lineChartView

- (NSMutableArray *)months
{
    if (!_months) {
        _months = [NSMutableArray array];
    }
    return _months;
}

- (NSMutableArray *)years
{
    if (!_years) {
        _years = [NSMutableArray array];
    }
    return _years;
}
- (NSMutableArray *)amounts
{
    if (!_amounts) {
        _amounts = [NSMutableArray array];
    }
    return _amounts;
}

- (NSMutableArray *)pointViews
{
    if (!_pointViews) {
        _pointViews = [NSMutableArray array];
    }
    return _pointViews;
}

- (NSMutableArray *)points
{
    if (!_points) {
        _points = [NSMutableArray array];
    }
    return _points;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    if (self.months == nil || self.months.count <= 0 || self.years == nil || self.years.count <= 0 || self.amounts == nil || self.amounts.count <= 0)
    {
        return;
    }
    //添加折线图
    //年份Lable
    UILabel *yearLable = [[UILabel alloc] init];
    [self addSubview:yearLable];
    //添加约束
    [yearLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15 * AUTO_IPHONE6_WIDTH_375);
        make.top.equalTo(self.mas_top).offset(244 * AUTO_IPHONE6_HEIGHT_667 - 6);
    }];
    yearLable.textColor = WLColor(111, 115, 120, 1);
    yearLable.font = WLFontSize(12);
    //取出最小年份
//    NSInteger min = [[self.years valueForKeyPath:@"@min.intValue"] integerValue];
    yearLable.text = @"2017";//[NSString stringWithFormat:@"%zd年", min];
    yearLable.backgroundColor = [UIColor redColor];
    //取出最大每月收益
    NSInteger maxAmount = [[self.amounts valueForKeyPath:@"@max.intValue"] integerValue];
    
    WlLog(@"%zd", maxAmount);
    NSInteger maxAmountToLable;
    if (maxAmount % 10000 == 0)
    {
        maxAmountToLable = maxAmount / 10000;
    }
    else
    {
        maxAmountToLable = maxAmount / 10000 + 1;
    }
    //分隔线间隔
    CGFloat interval = 228 / (maxAmountToLable + 1) * AUTO_IPHONE6_HEIGHT_667;
    //月份Lable
    for (int month = 0; month < self.months.count; month++)
    {
        UILabel *monthLable = [[UILabel alloc] init];
        monthLable.font = WLFontSize(11);
        monthLable.textColor = WLColor(111, 115, 120, 1);
        monthLable.textAlignment = NSTextAlignmentLeft;
        monthLable.text = [NSString stringWithFormat:@"%@月", self.months[month]];
        [self addSubview:monthLable];
        monthLable.width = [WLTools getStringWidth:monthLable.text fontSize:11];
        CGFloat monthLableX =  81 * AUTO_IPHONE6_WIDTH_375 + (monthLable.width  + 22) * month * AUTO_IPHONE6_WIDTH_375;
        CGFloat monthLableY = 244 * AUTO_IPHONE6_HEIGHT_667;
        monthLable.x = monthLableX;
        monthLable.y = monthLableY;
        monthLable.bounds = CGRectMake(monthLableX, monthLableY, monthLable.width, 12);
        //第一个Lable的位置
        if (month == 0)
        {
            NSString *startX = [NSString stringWithFormat:@"%f", monthLable.centerX];
            [self.points addObject:startX];
        }
        
        //如果是最后一个Lable
        if (self.months.count - month == 1)
        {
            //将这个Lable的centerX添加到数组中作为结束点的centerX
            NSString *endX = [NSString stringWithFormat:@"%f", monthLable.centerX];
            [self.points addObject:endX];
        }
        //添加点
        UIView *pointView = [[UIView alloc] init];
        [self addSubview:pointView];
        //获取每个月份的钱数
        WlLog(@"%@", self.amounts[month]);
        float amount = [self.amounts[month] floatValue];
        CGFloat amountStr = amount / 10000;
        WlLog(@"%f", amountStr);
        pointView.translatesAutoresizingMaskIntoConstraints = NO;
        //添加约束
        pointView.height = 8;
        pointView.width = 8;
        pointView.centerX = monthLable.centerX;
        if (IsiPhone4 || IsiPhone5)
        {
            pointView.centerY = monthLable.centerY - amountStr * interval - 11.5 * AUTO_IPHONE6_HEIGHT_667;
        }
        else
        {
            pointView.centerY = monthLable.centerY - amountStr * interval - 15 * AUTO_IPHONE6_HEIGHT_667;
        }

        //设置属性
        pointView.layer.cornerRadius = 4.0f;
        pointView.layer.masksToBounds = YES;
        pointView.backgroundColor = [WLTools stringToColor:@"#09d2e3"];
        NSString *pointViewX = [NSString stringWithFormat:@"%f", pointView.centerX];
        [self.pointViews addObject:pointViewX];
        NSString *pointViewY = [NSString stringWithFormat:@"%f", pointView.centerY];
        //将点View添加到数组中去
        [self.pointViews addObject:pointViewY];
 
    }
    

    //分隔线
    //循环添加分隔线
    for (int i = 0; i < maxAmountToLable + 1; i++)
    {
        UIView *lineView = [[UIView alloc] init];
        [self addSubview:lineView];
        //添加约束
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(73 * AUTO_IPHONE6_WIDTH_375);
            make.right.equalTo(self.mas_right).offset(-27 * AUTO_IPHONE6_WIDTH_375);
            make.top.equalTo(self.mas_top).offset(interval * (i + 1));
            make.height.equalTo(@0.5);
        }];
        [lineView layoutIfNeeded];
        //设置属性
        lineView.backgroundColor = [WLTools stringToColor:@"#b5bfb3"];
        
        //添加分隔线标题Lable
        UILabel *lineTitleLable = [[UILabel alloc] init];
        [self addSubview:lineTitleLable];
        //添加约束
        [lineTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(19 * AUTO_IPHONE6_WIDTH_375);
            make.centerY.equalTo(lineView.mas_centerY);
            make.height.equalTo(@11);
        }];
        lineTitleLable.x = 19 * AUTO_IPHONE6_WIDTH_375;
        
        [lineTitleLable layoutIfNeeded];
        [lineTitleLable sizeToFit];
        //设置属性
        lineTitleLable.textColor = WLColor(255, 74, 18, 1);
        lineTitleLable.font = WLFontSize(11);
        lineTitleLable.text = [NSString stringWithFormat:@"¥ %zd万",(maxAmountToLable - i)];
        if (maxAmountToLable - i == 0)
        {
            
            NSString *startY = [NSString stringWithFormat:@"%f", 228.0 * AUTO_IPHONE6_HEIGHT_667];
            [self.points addObject:startY];
            [self.points insertObject:startY atIndex:1];
            lineTitleLable.hidden = YES;
            
        }
        else
        {
            lineTitleLable.hidden = NO;
        }
        
        
        
    }
    
    
    // 1. 绘制阴影
    CGContextRef context = UIGraphicsGetCurrentContext();

    
    CGFloat X = [self.pointViews[0] floatValue];
    CGFloat Y = [self.pointViews[1] floatValue];
    CGContextMoveToPoint(context, X, Y);
    
    for (int i = 0; i < self.pointViews.count - 2; i+=2)
    {
        CGContextAddLineToPoint(context, [self.pointViews[i + 2] floatValue], [self.pointViews[i + 3] floatValue]);
        
    }
    
    
    CGContextAddLineToPoint(context, [self.points[2] floatValue], [self.points[3] floatValue]);
    CGContextAddLineToPoint(context, [self.points[0] floatValue], [self.points[1] floatValue]);
    [[WLTools stringToColor:@"#acecf0"] setFill];
    CGContextFillPath(context);
    
    
    //2.绘制折线
    // 1. 取得图形上下文对象
    CGContextRef context2 = UIGraphicsGetCurrentContext();
    
    
    CGFloat X2 = [self.pointViews[0] floatValue];
    CGFloat Y2 = [self.pointViews[1] floatValue];
    CGContextMoveToPoint(context2, X2, Y2);
    
    for (int i = 0; i < self.pointViews.count - 2; i+=2)
    {
        CGContextAddLineToPoint(context2, [self.pointViews[i + 2] floatValue], [self.pointViews[i + 3] floatValue]);
        
    }
    
    [[WLTools stringToColor:@"#09d2e3"] setStroke];
    [[WLTools stringToColor:@"#acecf0"] setFill];
    
    CGContextSetLineWidth(context2, 2.0f); // 线的宽度
    CGContextStrokePath(context2);
    
  
}

@end
