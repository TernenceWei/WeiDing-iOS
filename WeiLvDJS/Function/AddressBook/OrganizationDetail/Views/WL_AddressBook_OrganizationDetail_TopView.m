//
//  WL_AddressBook_OrganizationDetail_TopView.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/12.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_OrganizationDetail_TopView.h"

#import "WL_AddressBook_OrganizationDetail_Model.h"

@interface WL_AddressBook_OrganizationDetail_TopView ()
/** Logo */
@property(nonatomic, weak) UIImageView *iconImageView;
/** 组织名称 */
@property(nonatomic, weak) UILabel *nameLable;
/** 认证状态ImageView */
@property(nonatomic, weak) UIImageView *auditStatusImageView;
/** 联系电话Lable */
@property(nonatomic, weak) UILabel *customerPhoneLable;
/** 企业地址 */
@property(nonatomic, weak) UILabel *addressLable;
@end

@implementation WL_AddressBook_OrganizationDetail_TopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置子控件
        [self setupContentViewToOrganizationDetailTopView];
    }
    return self;
}

#pragma mark - 设置子控件
- (void)setupContentViewToOrganizationDetailTopView
{
    //1.左侧企业Logo
    UIImageView *iconImageView = [[UIImageView alloc] init];
    [self addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(14);
        make.left.equalTo(self.mas_left).offset(15);
        make.height.and.width.equalTo(@42);
    }];
    iconImageView.layer.cornerRadius = 21.0f;
    iconImageView.layer.masksToBounds = YES;
    self.iconImageView = iconImageView;
    
    //公司名Lable
    UILabel *nameLable = [[UILabel alloc] init];
    [self addSubview:nameLable];
    [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageView.mas_right).offset(12);
        make.top.equalTo(self.mas_top).offset(19);
        make.height.equalTo(@18);
    }];
    nameLable.font = WLFontSize(14);
    nameLable.textColor = [WLTools stringToColor:@"#2f2f2f"];
    self.nameLable = nameLable;
    
    //认证状态
    UIImageView *auditStatusImageView = [[UIImageView alloc] init];
    [self addSubview:auditStatusImageView];
    [auditStatusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLable.mas_right).offset(9);
        make.centerY.equalTo(nameLable.mas_centerY);
    }];
    self.auditStatusImageView = auditStatusImageView;
    
    //电话号码
    UILabel *customerPhoneLable = [[UILabel alloc] init];
    [self addSubview:customerPhoneLable];
    [customerPhoneLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLable.mas_left);
        make.top.equalTo(self.mas_top).offset(57);
    }];
    customerPhoneLable.textColor = [WLTools stringToColor:@"#4778e7"];
    customerPhoneLable.font = WLFontSize(11);
    self.customerPhoneLable = customerPhoneLable;
    
    //地址
    UILabel *addressLable = [[UILabel alloc] init];
    [self addSubview:addressLable];
    [addressLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLable.mas_left);
        make.top.equalTo(self.mas_top).offset(80);
    }];
    addressLable.font = WLFontSize(12);
    addressLable.textColor = [WLTools stringToColor:@"#2f2f2f"];
    
    self.addressLable = addressLable;
    
}

- (void)setDetailModel:(WL_AddressBook_OrganizationDetail_Model *)detailModel
{
    _detailModel = detailModel;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:detailModel.company_logo] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
    self.nameLable.text = detailModel.company_name;
    self.customerPhoneLable.text = detailModel.customer_phone;
    self.addressLable.text = detailModel.address;
    if ([detailModel.audit_status isEqualToString:@"0"])
    {
        self.auditStatusImageView.image = [UIImage imageNamed:@"CompanyNoAttestation"];
    }
    else if ([detailModel.audit_status isEqualToString:@"1"])
    {
        self.auditStatusImageView.image = [UIImage imageNamed:@""];
    }
    else if ([detailModel.audit_status isEqualToString:@"2"])
    {
        self.auditStatusImageView.image = [UIImage imageNamed:@"CompanyAttestation"];
    }
    else if ([detailModel.audit_status isEqualToString:@"3"])
    {
        self.auditStatusImageView.image = [UIImage imageNamed:@""];
    }
    
    
}
@end
