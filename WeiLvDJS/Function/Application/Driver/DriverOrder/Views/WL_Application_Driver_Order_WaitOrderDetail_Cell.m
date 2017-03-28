//
//  WL_Application_Driver_Order_WaitOrderDetail_Cell.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_Order_WaitOrderDetail_Cell.h"
#import "WL_Application_Driver_OrderDetail_Model.h"

@implementation WL_Application_Driver_Order_WaitOrderDetail_Cell

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
    UILabel *myTitleLable = [[UILabel alloc] init];
    //添加到父控件
    [self.contentView addSubview:myTitleLable];
    //设置属性
    myTitleLable.textColor = [WLTools stringToColor:@"#2F2F2F"];
    myTitleLable.textAlignment = NSTextAlignmentLeft;
    self.myTitleLable.preferredMaxLayoutWidth = ScreenWidth - 24;
    myTitleLable.numberOfLines = 0;
    myTitleLable.font = WLFontSize(14);
    //添加约束
    [myTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(12.5);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    self.myTitleLable = myTitleLable;
    
    
    //内容Lable
    UILabel *contentLable = [[UILabel alloc] init];
    //添加到父控件
    [self.contentView addSubview:contentLable];
    //设置属性
    contentLable.textAlignment = NSTextAlignmentRight;
    contentLable.textColor = [WLTools stringToColor:@"#868686"];
    contentLable.font = WLFontSize(14);
    //添加约束
    [contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-12.5);
        make.centerY.equalTo(myTitleLable.mas_centerY);
        make.height.mas_equalTo(50);
    }];
    self.contentLable = contentLable;
    
    //添加一个指示器imageView
    UIImageView *indicatorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
    [self.contentView addSubview:indicatorImageView];
    //添加约束
    [indicatorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-12.5);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.equalTo(@16);
        make.width.equalTo(@9);
    }];
    
    //添加一个提示button
    UIButton *promptButton = [[UIButton alloc] init];
    [self.contentView addSubview:promptButton];
    
    [promptButton setImage:[UIImage imageNamed:@"warning"] forState:UIControlStateNormal];
    
    //添加约束
    [promptButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-7.5);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    promptButton.hidden = YES;
    self.promptButton = promptButton;
    

    indicatorImageView.hidden = YES;
    self.indicatorImageView = indicatorImageView;
    //添加一个已付金额Lable
    UILabel *receiptLable = [[UILabel alloc] init];
    [self.contentView addSubview:receiptLable];
    [receiptLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-25);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    receiptLable.hidden = YES;
    self.receiptLable = receiptLable;


    //待支付标题lable
    UILabel *waitPayTitelLable = [[UILabel alloc] init];
    [self.contentView addSubview:waitPayTitelLable];
    waitPayTitelLable.hidden = YES;
    waitPayTitelLable.text = @"待支付";
    waitPayTitelLable.font = WLFontSize(14);
    waitPayTitelLable.textColor = [WLTools stringToColor:@"#b5b5b5"];
    [waitPayTitelLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-25);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
    }];
    self.waitPayTitelLable = waitPayTitelLable;
    
    //待支付lable
    UILabel *waitPayLable = [[UILabel alloc] init];
    [self.contentView addSubview:waitPayLable];
    waitPayLable.hidden = YES;
    [waitPayLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-25);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-37);
    }];
    self.waitPayLable = waitPayLable;
    
    UIView *lineView = [[UIView alloc] init];
    [self.contentView addSubview:lineView];
    //设置背景颜色
    lineView.backgroundColor = [WLTools stringToColor:@"#d8d9dd"];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(myTitleLable.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@0.5);
    }];
    self.lineView = lineView;
    
    
    
    
    
    
    
    
    
}

- (void)setOrderDetail:(WL_Application_Driver_OrderDetail_Model *)orderDetail
{
    _orderDetail = orderDetail;
    self.myTitleLable.text = orderDetail.remark;
    [self.myTitleLable sizeToFit];
    self.myTitleLable.preferredMaxLayoutWidth = ScreenWidth - 24;
    [self.myTitleLable layoutIfNeeded];
    
    [self layoutIfNeeded];
    orderDetail.cellHeight = self.myTitleLable.height + 40;
}



@end
