//
//  WL_Application_Driver_OrderDetailSectionHeadView.m
//  WeiLvDJS
//
//  Created by whw on 16/12/25.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_OrderDetailSectionHeadView.h"

@implementation WL_Application_Driver_OrderDetailSectionHeadView

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
    UIImageView *iconImage = [[UIImageView alloc]init];
    UILabel *listLabel = [[UILabel alloc]init];
    UILabel *lineLabel = [[UILabel alloc]init];
    UILabel *priceLabel = [[UILabel alloc]init];
    
    listLabel.textColor = [WLTools stringToColor:@"#333333"];
    listLabel.font = [UIFont WLFontOfSize:15];
    priceLabel.textColor = [WLTools stringToColor:@"#333333"];
    priceLabel.font = [UIFont WLFontOfSize:13];
    lineLabel.backgroundColor = Color4;
    
    [self addSubview:iconImage];
    [self addSubview:listLabel];
    [self addSubview:lineLabel];
    [self addSubview:priceLabel];
    
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(ScaleW(12));
    }];
    
    [listLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(iconImage.mas_right).offset(ScaleW(10));
    }];
    
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-ScaleW(10));
    }];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.offset(0.8);
    }];
    
    self.iconImage = iconImage;
    self.listLabel = listLabel;
    self.priceLabel = priceLabel;
}
@end
