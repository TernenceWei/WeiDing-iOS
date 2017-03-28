//
//  WLApplicationNODataView.m
//  WeiLvDJS
//
//  Created by whw on 17/1/10.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLApplicationNODataView.h"



@implementation WLApplicationNODataView

- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [WLTools stringToColor:@"#ffffff"];
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    UILabel *tipLabel = [[UILabel alloc]init];
    UILabel *subtitle = [[UILabel alloc]init];
    
    tipLabel.textColor = Color2;
    tipLabel.font = [UIFont WLFontOfSize:17];
    tipLabel.text = @"您尚未加入任何企业";
    
    subtitle.textColor = Color3;
    subtitle.text = @"请联系您要加入的组织或耐心等待";
    subtitle.font = [UIFont WLFontOfSize:14];
    
    [self addSubview:tipLabel];
    [self addSubview:subtitle];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [subtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX .equalTo(self);
        make.top.equalTo(tipLabel.mas_bottom).offset(ScaleH(14));
    }];
}
@end
