//
//  WL_AddressBook_AttentionCompany_Cell.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/9.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_AttentionCompany_Cell.h"
#import "WL_AddressBook_FollowCompanys_Model.h"
#import "WL_AddressBook_Company_Model.h"
#import "WL_AddressBook_SearchResult_Company_Model.h"
@interface WL_AddressBook_AttentionCompany_Cell ()

/** 左侧公司Logo */
@property(nonatomic, weak) UIImageView *logoImageView;




@end

@implementation WL_AddressBook_AttentionCompany_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupContentViewToAttentionCompanyCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

#pragma mark - ContentView
- (void)setupContentViewToAttentionCompanyCell
{
    //1.左侧公司Logo
    UIImageView *logoImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(14);
        make.height.equalTo(@40);
        make.width.equalTo(@40);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    logoImageView.layer.cornerRadius = 20.0f;
    logoImageView.layer.masksToBounds = YES;
    self.logoImageView = logoImageView;
    
    //中间公司名称Lable
    UILabel *companyNameLable = [[UILabel alloc] init];
    [self.contentView addSubview:companyNameLable];
    [companyNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(logoImageView.mas_right).offset(18);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.equalTo(@18);
    }];
    companyNameLable.font = WLFontSize(15);
    companyNameLable.textColor = [WLTools stringToColor:@"#2f2f2f"];
    self.companyNameLable = companyNameLable;
    
    
    //底部分隔线
    UIView *lineView = [[UIView alloc] init];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(14);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@0.5);
    }];
    lineView.backgroundColor = [WLTools stringToColor:@"#d8d9dd"];
    self.lineView = lineView;
    
}

- (void)setFollowCompanyModel:(WL_AddressBook_FollowCompanys_Model *)followCompanyModel
{
    _followCompanyModel = followCompanyModel;
    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:followCompanyModel.company_logo] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
    self.companyNameLable.text = followCompanyModel.company_name;
  
}

- (void)setCompanyModel:(WL_AddressBook_Company_Model *)companyModel
{
    _companyModel = companyModel;
    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:companyModel.img] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
    self.companyNameLable.text = companyModel.title;
}

- (void)setSearchCompanyModel:(WL_AddressBook_SearchResult_Company_Model *)searchCompanyModel
{
    _searchCompanyModel = searchCompanyModel;
    self.companyNameLable.text = searchCompanyModel.name;
    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:searchCompanyModel.photo] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];

}

@end
