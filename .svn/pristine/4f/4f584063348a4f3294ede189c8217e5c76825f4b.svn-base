//
//  WL_PayDetail_Cell.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/28.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_PayDetail_Cell.h"

@implementation WL_PayDetail_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //设置view的子控件
        [self setupContentViewToWaitOrderDetailCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

#pragma mark - 设置cell中的子控件
- (void)setupContentViewToWaitOrderDetailCell
{
    //标题Lable
    UILabel *titleLable = [[UILabel alloc] init];
    //添加到父控件
    [self.contentView addSubview:titleLable];
    //设置属性
    titleLable.textColor = [WLTools stringToColor:@"#2F2F2F"];
    titleLable.textAlignment = NSTextAlignmentLeft;
    self.titleLable.preferredMaxLayoutWidth = ScreenWidth - 24;
    titleLable.numberOfLines = 0;
    titleLable.font = WLFontSize(14);
    //添加约束
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(12.5);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    self.titleLable = titleLable;
    
    //添加一个指示器imageView
    UIImageView *indicatorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
    [self.contentView addSubview:indicatorImageView];
    //添加约束
    [indicatorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-12.5);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    indicatorImageView.hidden = YES;
    self.indicatorImageView = indicatorImageView;
    //添加一个已付金额Lable
    UILabel *receiptLable = [[UILabel alloc] init];
    
    receiptLable.font =WLFontSize(15);
    
    receiptLable.textColor =WLColor(233, 73, 30, 1);
    
    receiptLable.numberOfLines =2;
    
    receiptLable.textAlignment =NSTextAlignmentRight;
    
    [self.contentView addSubview:receiptLable];
    
    [receiptLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(indicatorImageView.mas_left).offset(-5);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
   
    self.receiptLable = receiptLable;
    
    
    UIButton *waringButton =[[UIButton alloc]init];
    
    [waringButton setBackgroundImage:[UIImage imageNamed:@"warning"] forState:UIControlStateNormal];
    
    [self.contentView addSubview:waringButton];
    
    [waringButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-8.5);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    self.warningButton =waringButton;
    
    self.warningButton.hidden=YES;

    
    UIView *lineView = [[UIView alloc] init];
    [self.contentView addSubview:lineView];
    //设置背景颜色
    lineView.backgroundColor = [WLTools stringToColor:@"#d8d9dd"];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLable.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@0.5);
    }];
    self.lineView = lineView;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
