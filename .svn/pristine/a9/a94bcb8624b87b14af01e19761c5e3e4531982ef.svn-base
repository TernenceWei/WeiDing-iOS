//
//  WL_Mine_Setting_AboutWeiDing_Cell.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/14.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Mine_Setting_AboutWeiDing_Cell.h"

@implementation WL_Mine_Setting_AboutWeiDing_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //设置内容
        [self setupContentViewToCell];
        //设置cell点击不变灰
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


#pragma mark - 设置cell中的内容
- (void)setupContentViewToCell
{
    //左侧的Lable
    UILabel *titleLable = [[UILabel alloc] init];
    //添加到父控件
    [self.contentView addSubview:titleLable];
    //设置属性
    titleLable.textColor = WLColor(47, 47, 47, 1);
    titleLable.font = WLFontSize(15);
    titleLable.textAlignment = NSTextAlignmentLeft;
    
    //添加约束
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(13);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    self.titleLable = titleLable;
    
    //右侧指示器
    UIImageView *sliderImageView = [[UIImageView alloc] init];
    
    [self.contentView addSubview:sliderImageView];
    sliderImageView.image = [UIImage imageNamed:@"arrow"];
    [sliderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-13);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.equalTo(@16);
        make.width.equalTo(@9);
    }];
    
    
    //右侧提示Lable
    UILabel *tipLable = [[UILabel alloc] init];
    //将提示Lable添加到父控件
    [self.contentView addSubview:tipLable];
    //设置属性
    tipLable.textColor = WLColor(176, 183, 193, 1);
    tipLable.font = WLFontSize(14);
    //添加约束
    [tipLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(sliderImageView.mas_left).offset(-12);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    self.tipLable = tipLable;
    
    //设置底部分隔线
    UIView *lineView = [[UIView alloc] init];
    //添加到父控件
    [self.contentView addSubview:lineView];
    //设置属性
    lineView.backgroundColor = [WLTools stringToColor:@"#d8d9dd"];
    //设置约束
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(12);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(@1);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    self.lineView = lineView;
    lineView.hidden = YES;
}

@end
