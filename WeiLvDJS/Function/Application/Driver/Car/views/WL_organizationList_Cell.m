//
//  WL_organizationList_Cell.m
//  WeiLvDJS
//
//  Created by zhaoxiao on 16/9/9.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  应用首页下拉 公司列表cell

#import "WL_organizationList_Cell.h"

#import "WL_Copmany_Model.h"

@interface WL_organizationList_Cell ()
/** 左侧的公司/组织Logo图片 */
@property(nonatomic, weak)UIImageView *logoImageView;



@end

@implementation WL_organizationList_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置cell中的子控件
        [self setupChildViewToOrganizationListCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

/** 设置公司/组织列表的cell的子控件 */
#pragma mark - 设置公司/组织列表的cell的子控件
- (void)setupChildViewToOrganizationListCell
{
    //左侧的公司/组织Logo图片
    UIImageView *logoImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:logoImageView];
    //添加Logo图片的约束
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView).offset(ScaleW(15));
        make.height.offset(ScaleH(34));
        make.width.offset(ScaleW(34));
    }];
    self.logoImageView = logoImageView;
    self.logoImageView.image = [UIImage imageNamed:@"gongsitouxiang"];
    
    
    
    //设置公司/组织名称
    UILabel *organizationNameLable = [[UILabel alloc] init];
    [self.contentView addSubview:organizationNameLable];
    //添加公司/组织名称控件的约束
    self.organizationNameLable = organizationNameLable;
    //设置公司/组织名称控件的属性
    self.organizationNameLable.font = WLFontSize(15);
    [self.organizationNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.logoImageView.mas_centerY);
        make.left.equalTo(self.logoImageView.mas_right).offset(12);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
//        make.height.equalTo(@18);
    }];
    //设置底部的lineView
    UIView *lineView = [[UIView alloc] init];
    [self.contentView addSubview:lineView];
    //设置属性
    lineView.backgroundColor = [WLTools stringToColor:@"#929292"];
    lineView.alpha = 0.5;
    //添加约束
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(logoImageView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    self.lineView = lineView;
}

- (void)setCompany:(WL_Copmany_Model *)company
{
    _company = company;
    
    NSURL *url = [NSURL URLWithString:company.logo_url];
    
    [self.logoImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"gongsitouxiang"]];
    
    self.organizationNameLable.text = company.company_name;

    [self.organizationNameLable layoutIfNeeded];
}

@end
