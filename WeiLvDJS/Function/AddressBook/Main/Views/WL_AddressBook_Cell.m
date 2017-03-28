//
//  WL_AddressBook_Cell.m
//  WeiLvDJS
//
//  Created by zhaoxiao on 16/9/2.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_Cell.h"
#import "WL_Copmany_Model.h"

@interface WL_AddressBook_Cell ()
/** 左侧头像图标 */
@property(nonatomic, weak) UIImageView *iconImageView;
/** 中间组织名称(姓名)Lable */
@property(nonatomic, weak) UILabel *organizationNameLable;
/** 中间组织架构标签(职务)Lable */
@property(nonatomic, weak)  UILabel *organizationTitleLable;


@end

@implementation WL_AddressBook_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupChildViewToAddressBookCell];
    }
    return self;
}

- (void)setupChildViewToAddressBookCell
{
    //1. 添加左侧的头像图标
    UIImageView *iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:iconImageView];
    iconImageView.layer.cornerRadius = 20.5f;
    iconImageView.layer.masksToBounds = YES;
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(9);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.equalTo(@41);
        make.width.equalTo(@41);
    }];
    self.iconImageView = iconImageView;
    
    //2. 添加中间组织名称
    UILabel *organizationNameLable = [[UILabel alloc] init];
    [self.contentView addSubview:organizationNameLable];
    [organizationNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageView.mas_right).offset(12);
        make.top.equalTo(self.contentView.mas_top).offset(18);
        make.right.equalTo(self.contentView.mas_right).offset(-52);
        make.height.equalTo(@18);
    }];
    organizationNameLable.font = WLFontSize(14);
    organizationNameLable.textColor = [WLTools stringToColor:@"#2f2f2f"];
    organizationNameLable.textAlignment = NSTextAlignmentLeft;
//    organizationNameLable.text = @"郑州微旅旅行社有限公司";
    self.organizationNameLable = organizationNameLable;
    
    //3. 添加中间组织架构标签Lable
    UILabel *organizationTitleLable = [[UILabel alloc] init];
    [self.contentView addSubview:organizationTitleLable];
    [organizationTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(organizationNameLable.mas_left);
        make.right.equalTo(organizationNameLable.mas_right);
        make.top.equalTo(organizationNameLable.mas_bottom).offset(10);
//        make.height.equalTo(@18);
    }];
    organizationTitleLable.font = WLFontSize(14);
    organizationTitleLable.textColor = [WLTools stringToColor:@"#868686"];
    organizationTitleLable.textAlignment = NSTextAlignmentLeft;
    organizationTitleLable.text = @"组织架构";
    self.organizationTitleLable = organizationNameLable;
    
    //4,底部分隔线
    UIView *lineView = [[UIView alloc] init];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(9);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(@0.5);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    lineView.backgroundColor = [WLTools stringToColor:@"#d8d9dd"];
    self.lineView = lineView;
    
    //5.箭头ImageView
    UIImageView *arrorImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:arrorImageView];
    [arrorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-21);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    arrorImageView.image = [UIImage imageNamed:@"arrow"];
    
    self.iconImageView.image = [UIImage imageNamed:@"MobileMessage"];
    self.organizationNameLable.text = @"南阳车队有限公司";
    
 
}

- (void)setCompany:(WL_Copmany_Model *)company
{
    _company = company;
    
    self.organizationNameLable.text = company.company_name;
    
    NSURL *url = [NSURL URLWithString:company.logo_url];
    [self.iconImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
}


@end
