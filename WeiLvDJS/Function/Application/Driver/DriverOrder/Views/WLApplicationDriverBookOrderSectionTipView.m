//
//  WLApplicationDriverBookOrderSectionTipView.m
//  WeiLvDJS
//
//  Created by whw on 17/2/12.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLApplicationDriverBookOrderSectionTipView.h"

@interface WLApplicationDriverBookOrderSectionTipView ()
@property (nonatomic, weak) UILabel *statusLabel;
@end
@implementation WLApplicationDriverBookOrderSectionTipView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [WLTools stringToColor:@"#ffffff"];
        [self setupUI];
    }
    return self;
}
- (void)setupUI
{
    UIImageView *tipImageView = [[UIImageView alloc]init];
    UILabel *statusLabel = [[UILabel alloc]init];
    UILabel *lineLabel = [[UILabel alloc]init];
    
    tipImageView.image = [UIImage imageNamed:@"shixiaotubiao"];
    statusLabel.font = [UIFont WLFontOfSize:20];
    statusLabel.textColor = [WLTools stringToColor:@"#ff0000"];
    lineLabel.backgroundColor = Color4;
    
    [self addSubview:tipImageView];
    [self addSubview:statusLabel];
    [self addSubview:lineLabel];
    
    [tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(ScaleH(20));
        make.centerX.equalTo(self);
    }];
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipImageView.mas_bottom).offset(ScaleH(15));
        make.centerX.equalTo(self);
    }];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.offset(0.8);
    }];
    self.statusLabel = statusLabel;
    
}

- (void)setBookStatus:(WLBookOrderStatus)bookStatus
{
    _bookStatus = bookStatus;
    switch (bookStatus) {
        case WLFailureOrderStatusOverTime:
            self.statusLabel.text = @"报价超时!";
            break;
        case WLFailureOrderStatusQuotedCanceled:
        case WLFailureOrderStatusUnquotedCanceled:
            self.statusLabel.text = @"客户已取消!";
            break;
        case WLFailureOrderStatusUnquoted:
        case WLFailureOrderStatusQuoted:
            self.statusLabel.text = @"竞价失败!";
            break;
        default:
            break;
    }
}
@end
