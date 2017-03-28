//
//  WL_Application_Driver_Bill_CompanyScale_View.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/10/9.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_Bill_CompanyScale_View.h"
#import "LXMPieView.h"

@implementation WL_Application_Driver_Bill_CompanyScale_View

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //添加子控件
        [self setupChildViewToCompanyScaleView];
    }
    return self;
}

- (void)setupChildViewToCompanyScaleView
{
    //间隔View
    UIView *intervalView = [[UIView alloc] init];
    //添加到父控件
    [self addSubview:intervalView];
    //添加约束
    [intervalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@(1 * AUTO_IPHONE6_HEIGHT_667));
    }];
    //设置属性
    intervalView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    
    //白色的View
    UIView *bottomView = [[UIView alloc] init];
    //添加到父控件
    [self addSubview:bottomView];
    //添加约束
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(intervalView.mas_bottom);
        make.left.equalTo(intervalView.mas_left);
        make.right.equalTo(intervalView.mas_right);
        make.height.equalTo(@(180 * AUTO_IPHONE6_HEIGHT_667));
    }];
    //设置属性
    bottomView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    
    UILabel *lineLabel3 = [[UILabel alloc] init];
    lineLabel3.frame = CGRectMake(0, 0, ScreenWidth, ScaleH(10));
    lineLabel3.backgroundColor = [WLTools stringToColor:@"#f2f2f2"];
    [bottomView addSubview:lineLabel3];
    
    //在白色的View上添加子控件
    UILabel *titleLable = [[UILabel alloc] init];
    [bottomView addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(10);
        make.top.equalTo(bottomView.mas_top).offset(18);
    }];
    //设置属性
    titleLable.text = @"各车队占比";
    titleLable.textAlignment = NSTextAlignmentLeft;
    titleLable.font = [UIFont WLFontOfSize:15];//WLFontSize(14);
    titleLable.textColor = WLColor(47, 47, 47, 1);
    
    UILabel *lineLabel2 = [[UILabel alloc] init];
    lineLabel2.frame = CGRectMake(0, ScaleH(40), ScreenWidth, ScaleH(0.5));
    lineLabel2.backgroundColor = [WLTools stringToColor:@"#e4e4e4"];
    [bottomView addSubview:lineLabel2];
    
    //添加车队列表的TableView
    UITableView *companysTableView = [[UITableView alloc] init];
    //添加到父控件
    [bottomView addSubview:companysTableView];
    //设置tableView的约束
    [companysTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_top).offset(41 * AUTO_IPHONE6_HEIGHT_667);
        make.right.equalTo(bottomView.mas_right).offset(-15 * AUTO_IPHONE6_WIDTH_375);
        make.bottom.equalTo(bottomView.mas_bottom).offset(-23 * AUTO_IPHONE6_HEIGHT_667);
        make.left.equalTo(bottomView.mas_left).offset(182 * AUTO_IPHONE6_WIDTH_375);
    }];
    companysTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    companysTableView.showsVerticalScrollIndicator = NO;
    companysTableView.showsHorizontalScrollIndicator = NO;
    self.companysTableView = companysTableView;
    
    
    
}

@end
