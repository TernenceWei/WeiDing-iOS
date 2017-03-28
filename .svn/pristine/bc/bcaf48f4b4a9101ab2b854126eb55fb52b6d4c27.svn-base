//
//  WL_AddressBook_CompanyMessage_Cell.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/10.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_CompanyMessage_Cell.h"
#import "WL_AddressBook_LinkMan_Company_Model.h"
#import "WL_AddressBook_LinkMan_Department_Model.h"

@interface WL_AddressBook_CompanyMessage_Cell ()
/** 1.左侧公司Logo图标 */
@property(nonatomic, weak) UIImageView *iconImageView;
/** 2.公司名称Lable */
@property(nonatomic, weak) UILabel *companyNameLable;

@end

@implementation WL_AddressBook_CompanyMessage_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupChildViewToCompanyMessageCell];
    }
    return self;
}

- (void)setupChildViewToCompanyMessageCell
{
    //1.左侧公司Logo图标
    UIImageView *iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.and.height.equalTo(@30);
    }];
    iconImageView.layer.cornerRadius = 15.0f;
    iconImageView.layer.masksToBounds = YES;
    self.iconImageView = iconImageView;
    iconImageView.image = [UIImage imageNamed:@"DJS_Logo"];
    
    //2 公司名称Lable
    UILabel *companyNameLable = [[UILabel alloc] init];
    [self.contentView addSubview:companyNameLable];
    [companyNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(iconImageView.mas_centerY);
        make.left.equalTo(iconImageView.mas_right).offset(11);
        make.height.equalTo(@18);
    }];
    companyNameLable.font = WLFontSize(14);
    companyNameLable.textColor = [WLTools stringToColor:@"#2f2f2f"];
    self.companyNameLable = companyNameLable;
    
    //3.右侧指示器
    UIImageView *indicatorImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:indicatorImageView];
    [indicatorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-17);
        make.width.equalTo(@10);
        make.height.equalTo(@17);
    }];
    indicatorImageView.image = [UIImage imageNamed:@"arrow"];
    
    //4.底部分隔线
    UIView *lineView = [[UIView alloc] init];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(14);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@0.5);
    }];
    lineView.backgroundColor = [WLTools stringToColor:@"#d4d4d4"];
    self.lineView = lineView;
}

- (void)setCompanyModel:(WL_AddressBook_LinkMan_Company_Model *)companyModel
{
    _companyModel = companyModel;
    //公司名称
    self.companyNameLable.text = companyModel.company_name;
    
    self.company_id = companyModel.company_id;
}

- (void)setDepartmentModel:(WL_AddressBook_LinkMan_Department_Model *)departmentModel
{
    _departmentModel = departmentModel;
    //公司logo
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:departmentModel.company_logo] placeholderImage:[UIImage imageNamed:@"DJS_Logo"]];
    
 
}

@end
