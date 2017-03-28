//
//  WL_Application_Driver_AcceptOrderTipView.m
//  WeiLvDJS
//
//  Created by whw on 16/12/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_AcceptOrderTipView.h"

@implementation WL_Application_Driver_AcceptOrderTipView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [WLTools stringToColor:@"#ffffff"];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI
{
    UILabel *tipLabel = [[UILabel alloc]init];
    UILabel *detailLabel = [[UILabel alloc]init];
    UIButton *notButton = [[UIButton alloc]init];
    UIButton *yesButton = [[UIButton alloc]init];
    
    tipLabel.text = @"提示";
    tipLabel.textColor = [WLTools stringToColor:@"#333333"];
    tipLabel.font = [UIFont WLFontOfBoldSize:17];
    
    detailLabel.text = @"该订单需要在 \"10月12日 - 深圳\"出发,是否确认接单?";
    detailLabel.numberOfLines = 0;
    detailLabel.textColor = [WLTools stringToColor:@"#333333"];
    detailLabel.font = [UIFont WLFontOfSize:17];
    
    [notButton setTitle:@"否" forState:UIControlStateNormal];
    [notButton setTitleColor:[WLTools stringToColor:@"#333333"] forState:UIControlStateNormal];
    notButton.titleLabel.font = [UIFont WLFontOfBoldSize:17];
    notButton.layer.borderColor = [WLTools stringToColor:@"#e4e4e4"].CGColor;
    notButton.layer.borderWidth = 1;
    [notButton addTarget:self action:@selector(didClickIsAcceptButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [yesButton setTitle:@"接单" forState:UIControlStateNormal];
    [yesButton setTitleColor:[WLTools stringToColor:@"#00cc99"] forState:UIControlStateNormal];
    yesButton.titleLabel.font = [UIFont WLFontOfBoldSize:17];
    yesButton.layer.borderColor = [WLTools stringToColor:@"#e4e4e4"].CGColor;
    yesButton.layer.borderWidth = 1;
    [yesButton addTarget:self action:@selector(didClickIsAcceptButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:tipLabel];
    [self addSubview:detailLabel];
    [self addSubview:notButton];
    [self addSubview:yesButton];
    
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(ScaleH(20));
    }];
    
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipLabel.mas_bottom).offset(ScaleH(20));
        make.left.equalTo(self).offset(ScaleH(20));
        make.right.equalTo(self).offset(-ScaleH(20));
    }];
    
    [notButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    [yesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        make.left.equalTo(notButton.mas_right);
        make.width.equalTo(notButton);
    }];
    
    
    
}

- (void)didClickIsAcceptButton:(UIButton *)button
{
    if (self.seletedCallBack)
    {
        if ([button.currentTitle isEqualToString:@"否"])
        {
            self.seletedCallBack(NO);
        }else if ([button.currentTitle isEqualToString:@"接单"])
        {
            self.seletedCallBack(YES);
        }
    }
}
@end
