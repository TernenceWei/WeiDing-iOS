//
//  WL_AddressBook_OrganizationDetail_Cell.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/12.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_OrganizationDetail_Cell.h"

#import "WL_AddressBook_OrganizationDetail_Model.h"

@interface WL_AddressBook_OrganizationDetail_Cell ()

/** 标题Lable */
@property(nonatomic, weak) UILabel *titleLable;
/** 内容Lable */
@property(nonatomic, weak) UILabel *contentLable;
/** 内容Lable */
@property(nonatomic, weak) UIView *lineView;

@end

@implementation WL_AddressBook_OrganizationDetail_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupContentViewToOrganizationDetailCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

#pragma mark - 设置UI布局
- (void)setupContentViewToOrganizationDetailCell
{
    //标题Lable
    UILabel *titleLable = [[UILabel alloc] init];
    [self.contentView addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.top.equalTo(self.contentView.mas_top).offset(18);
    }];
    titleLable.font = WLFontSize(15);
    titleLable.textColor = [WLTools stringToColor:@"#2f2f2f"];
    self.titleLable = titleLable;
    
 
    //分隔线
    UIView *lineView = [[UIView alloc] init];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.top.equalTo(self.contentView.mas_top).offset(50);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(@0.5);
    }];
    lineView.backgroundColor = [WLTools stringToColor:@"#d4d4d4"];
    self.lineView = lineView;

    
    
    
    
    //内容Lable
    UILabel *contentLable = [[UILabel alloc] init];
    [self.contentView addSubview:contentLable];
    [contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(21);
        make.top.equalTo(lineView.mas_bottom).offset(19);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
    }];
    contentLable.font = WLFontSize(13);
    contentLable.textColor = [WLTools stringToColor:@"#2f2f2f"];
    contentLable.numberOfLines = 0;
    
    
    self.contentLable = contentLable;
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 11;
        frame.origin.y += 11;
    [super setFrame:frame];
}

- (void)setDetailModel:(WL_AddressBook_OrganizationDetail_Model *)detailModel
{
    _detailModel = detailModel;
    self.titleLable.text = @"企业介绍";
    if (detailModel.description_content == nil) {
        self.contentLable.text  = @"暂无简介";
    }
    else
    {
        self.contentLable.text = detailModel.description_content;
    }
     NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.contentLable.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.contentLable.text length])];
    self.contentLable.attributedText = attributedString;
    [self.contentLable sizeToFit];
    
    detailModel.cellHeight = self.contentLable.y + self.contentLable.height + 19 + 11;
    
}

- (void)setDetailTwoModel:(WL_AddressBook_OrganizationDetail_Model *)detailTwoModel
{
    _detailTwoModel = detailTwoModel;
    
    //添加标签个数
    for (int i = 0; i < self.appNames.count; i++) {
        UILabel *markLable = [[UILabel alloc] init];
        [self.contentView addSubview:markLable];
        [markLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@19);
            make.width.equalTo(@47);
            make.bottom.equalTo(self.lineView.mas_top).offset(-15.5);
            make.right.equalTo(self.contentView.mas_right).offset(-(17 + i * 52));
        }];
        markLable.textColor = [WLTools stringToColor:@"#ffffff"];
        markLable.font = WLFontSize(13);
        markLable.textAlignment = NSTextAlignmentCenter;
        markLable.text = self.appNames[i];
        if ([markLable.text isEqualToString:@"地接社"])
        {
            markLable.backgroundColor = [WLTools stringToColor:@"#6496e0"];
        }
        else if ([markLable.text isEqualToString:@"酒店"])
        {
            markLable.backgroundColor = [WLTools stringToColor:@"#c96dfe"];
        }
        else if ([markLable.text isEqualToString:@"车队"])
        {
            markLable.backgroundColor = [WLTools stringToColor:@"#fe9443"];
        }
        else
        {
            markLable.backgroundColor = [WLTools stringToColor:@"#ff0000"];
        }
    }
    
    
    self.titleLable.text = @"企业业务";
    if (detailTwoModel.business == nil) {
        self.contentLable.text  = @"暂无简介";
    }
    else
    {
        self.contentLable.text = detailTwoModel.business;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.contentLable.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.contentLable.text length])];
    self.contentLable.attributedText = attributedString;
    [self.contentLable sizeToFit];
    detailTwoModel.cellHeight = self.contentLable.y + self.contentLable.height + 19 + 11;
    
    
    
    
}


@end
