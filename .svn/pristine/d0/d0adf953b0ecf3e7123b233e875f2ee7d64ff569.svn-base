//
//  WLGuideRefuseOrderAlertViewCell.m
//  WeiLvDJS
//
//  Created by whw on 16/11/1.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLGuideRefuseOrderAlertViewCell.h"

@implementation WLGuideRefuseOrderAlertViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置子控件
        [self setupContentViewToRefuseOrderCell];
        //cell选中不变灰
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupContentViewToRefuseOrderCell
{
    //添加拒绝原因Lable
    UILabel *reasonLable = [[UILabel alloc] init];
    //添加到父控件
    [self.contentView addSubview:reasonLable];
    //设置属性
    reasonLable.textAlignment = NSTextAlignmentLeft;
    reasonLable.font = WLFontSize(15);
    reasonLable.textColor = [WLTools stringToColor:@"#4a586a"];
    //添加约束
    [reasonLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(13 * AUTO_IPHONE6_WIDTH_375);
        make.top.equalTo(self.contentView.mas_top).offset(13 * AUTO_IPHONE6_HEIGHT_667);
    }];
    //测试数据
    reasonLable.text = @"价格太低";
    self.reasonLable = reasonLable;
    //添加是否选中的Button
    UIButton *selectedButton = [[UIButton alloc] init];
    //添加到父控件
    [self.contentView addSubview:selectedButton];
    selectedButton.userInteractionEnabled = NO;
    //设置属性
    [selectedButton setImage:[UIImage imageNamed:@"Driver_Order_NoSelected"] forState:UIControlStateNormal];
    [selectedButton setImage:[UIImage imageNamed:@"Driver_Order_Selected"] forState:UIControlStateSelected];
    //添加约束
    [selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-13 * AUTO_IPHONE6_WIDTH_375);
        make.height.equalTo(@15);
        make.width.equalTo(@15);
        make.top.equalTo(@(13 * AUTO_IPHONE6_HEIGHT_667));
    }];
    self.selectedButton = selectedButton;
    
    //其他原因输入框
    UITextView *reasonTextView = [[UITextView alloc] init];
    [self.contentView addSubview:reasonTextView];
    //设置属性
    reasonTextView.backgroundColor = [WLTools stringToColor:@"#f1f2f6"];
    //添加约束
    [reasonTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(reasonLable.mas_bottom).offset(20 * AUTO_IPHONE6_HEIGHT_667);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.width.equalTo(@(275 * AUTO_IPHONE6_WIDTH_375));
        make.height.equalTo(@(37.5 * AUTO_IPHONE6_HEIGHT_667));
    }];
    
    //在输入框中添加占位文字Lable
    UILabel *placeholderLabel = [[UILabel alloc] init];
    [reasonTextView addSubview:placeholderLabel];
    placeholderLabel.text = @"填写其他原因";
    placeholderLabel.textColor = [WLTools stringToColor:@"#b0b7c1"];
    placeholderLabel.font = WLFontSize(15);
    //添加约束
    [placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(reasonTextView.mas_left).offset(10);
        make.top.equalTo(reasonTextView.mas_top).offset(10);
    }];
    self.placeholderLabel = placeholderLabel;
    self.reasonTextView = reasonTextView;
    self.reasonTextView.hidden = YES;
    //分隔线
    UIView *lineView = [[UIView alloc] init];
    //添加到父控件
    [self.contentView addSubview:lineView];
    //设置属性
    lineView.backgroundColor = [WLTools stringToColor:@"#d8d9dd"];
    //添加约束
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@0.5);
    }];
    
}


@end
