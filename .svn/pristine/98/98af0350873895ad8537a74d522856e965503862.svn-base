//
//  WL_AddressBook_SearchRecord_View.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/18.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_SearchRecord_View.h"

@implementation WL_AddressBook_SearchRecord_View

- (instancetype)initWithFrame:(CGRect)frame withArr:(NSMutableArray *)arr
{
    if (self = [super initWithFrame:frame]) {
        [self setupContentViewToSearchRecordWithArr:arr];
    }
    return self;
}

- (void)setupContentViewToSearchRecordWithArr:(NSMutableArray *)arr
{
    //1.标题View
    UIView *recordTitleView = [[UIView alloc] init];
    [self addSubview:recordTitleView];
    [recordTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.height.equalTo(@49.5);
    }];
    recordTitleView.backgroundColor = [WLTools stringToColor:@"#f7f7f8"];
    //1.1 标题View的标题Lable
    UILabel *recordTitleLable = [[UILabel alloc] init];
    [recordTitleView addSubview:recordTitleLable];
    [recordTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(recordTitleView.mas_left).offset(12.5);
        make.centerY.equalTo(recordTitleView.mas_centerY);
    }];
    recordTitleLable.text = @"最近搜索";
    recordTitleLable.font = WLFontSize(15);
    recordTitleLable.textColor = [WLTools stringToColor:@"#929fb1"];
    
    //1.2 标题View的关闭按钮
    UIButton *closeButton = [[UIButton alloc] init];
    [recordTitleView addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(recordTitleView.mas_right);
        make.centerY.equalTo(recordTitleView.mas_centerY);
        make.height.and.width.equalTo(@49.5);
    }];
    [closeButton setImage:[UIImage imageNamed:@"WL_AddressBook_SearchRecord_Close"] forState:UIControlStateNormal];
    self.closeButton = closeButton;
    
    
    
    
}

@end
