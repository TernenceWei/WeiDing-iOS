//
//  WLApplicationAuthenticationTipCell.m
//  WeiLvDJS
//
//  Created by whw on 17/2/13.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLApplicationAuthenticationTipCell.h"

static NSString *identifier = @"AuthenticationTipCell";
@implementation WLApplicationAuthenticationTipCell

#pragma mark - 重写构造方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置子控件
        [self setupUI];
        //设置cell点击不变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    }
    return self;
}
- (void)setupUI
{
    UIImageView *tipImageView = [[UIImageView alloc]init];
    UILabel *statusLabel = [[UILabel alloc]init];
    UILabel *lineLabel = [[UILabel alloc]init];

    statusLabel.font = [UIFont WLFontOfSize:14];
    statusLabel.textColor = Color2;
    lineLabel.backgroundColor = Color4;
    
    [self addSubview:tipImageView];
    [self addSubview:statusLabel];
    [self addSubview:lineLabel];
    
    [tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(ScaleH(15));
        make.centerX.equalTo(self);
    }];
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipImageView.mas_bottom).offset(ScaleH(10));
        make.centerX.equalTo(self);
    }];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.offset(0.8);
    }];
    self.statusLabel = statusLabel;
    self.tipImageView = tipImageView;
}
+ (instancetype)cellForTableView:(UITableView *)tableView
{
    WLApplicationAuthenticationTipCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[WLApplicationAuthenticationTipCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
@end
