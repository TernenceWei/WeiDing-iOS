//
//  WL_GuideTopView.m
//  WeiLvDJS
//
//  Created by whw on 16/10/20.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_GuideTopView.h"

@implementation WL_GuideTopView


-(void)setUpTopView{
    UIButton *closeBtn = [[UIButton alloc] init];
    [self addSubview:closeBtn];
    [closeBtn setImage:[UIImage imageNamed:@"Driver_Order_Close"] forState:UIControlStateNormal];
    //设置约束
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(12.5);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@13);
        make.height.equalTo(@13);
    }];
    self.closeBtn = closeBtn;
    
    //设置订单页面内容
    UILabel *remaindLabel = [[UILabel alloc] init];
    [self addSubview:remaindLabel];
    
    //设置属性
    remaindLabel.font = WLFontSize(14);
    remaindLabel.textColor = [WLTools stringToColor:@"#c4502c"];
    remaindLabel.numberOfLines = 0;
    
    //添加约束
    [remaindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(23);
        make.centerY.equalTo(closeBtn.mas_centerY);
        make.right.equalTo(closeBtn.mas_left).offset(-5);
    }];
    _remaindLabel = remaindLabel;
}

@end
