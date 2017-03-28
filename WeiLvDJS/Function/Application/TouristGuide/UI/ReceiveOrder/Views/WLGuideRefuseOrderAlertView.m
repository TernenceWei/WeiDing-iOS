//
//  WLGuideRefuseOrderAlertView.m
//  WeiLvDJS
//
//  Created by whw on 16/11/1.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLGuideRefuseOrderAlertView.h"

@implementation WLGuideRefuseOrderAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //添加子控件
        [self setupContentViewToRefuseOrderAlertView];
    }
    return self;
}

- (void)setupContentViewToRefuseOrderAlertView
{
    UITableView *refuseReasonTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    //添加到父控件
    [self addSubview:refuseReasonTableView];
    //添加约束
    [refuseReasonTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(111 * AUTO_IPHONE6_HEIGHT_667);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@(300 * AUTO_IPHONE6_WIDTH_375));
        make.height.equalTo(@(462));
    }];
    
    refuseReasonTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    refuseReasonTableView.scrollEnabled = NO;
    self.refuseReasonTableView = refuseReasonTableView;
    //设置弹框TableView的头视图
    UILabel *refuseReasonLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, refuseReasonTableView.width,  90 * AUTO_IPHONE6_HEIGHT_667)];
    //设置头视图的属性
    refuseReasonLable.textAlignment = NSTextAlignmentCenter;
    refuseReasonLable.font = WLFontSize(20);
    refuseReasonLable.text = @"请选择您的拒绝理由";
    refuseReasonLable.textColor = [WLTools stringToColor:@"#ffffff"];
    refuseReasonLable.backgroundColor = [WLTools stringToColor:@"#878fff"];
    //设置为头视图
    refuseReasonTableView.tableHeaderView = refuseReasonLable;
    //创建包含两个按钮的View来作为TableView的footerView
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300 * AUTO_IPHONE6_WIDTH_375, 52)];
    //添加两个按钮到tableFooterView中去
    UIButton *cancleButton = [[UIButton alloc] init];
    [tableFooterView addSubview:cancleButton];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:[WLTools stringToColor:@"#b5b5b5"] forState:UIControlStateNormal];
    cancleButton.titleLabel.font = WLFontSize(16);
    
    [cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tableFooterView.mas_left);
        make.top.equalTo(tableFooterView.mas_top);
        make.bottom.equalTo(tableFooterView.mas_bottom);
        make.width.equalTo(@(150 * AUTO_IPHONE6_WIDTH_375));
    }];
    self.cancleButton = cancleButton;
    UIButton *refuseButton = [[UIButton alloc] init];
    self.refuseButton = refuseButton;
    [tableFooterView addSubview:refuseButton];
    [refuseButton setTitle:@"确认拒绝" forState:UIControlStateNormal];
    [refuseButton setTitleColor:[WLTools stringToColor:@"#4877e7"] forState:UIControlStateNormal];
    refuseButton.titleLabel.font = WLFontSize(16);
    
    [refuseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cancleButton.mas_right);
        make.top.equalTo(tableFooterView.mas_top);
        make.bottom.equalTo(tableFooterView.mas_bottom);
        make.width.equalTo(@(150 * AUTO_IPHONE6_WIDTH_375));
    }];
    
    refuseReasonTableView.tableFooterView = tableFooterView;
}



@end
