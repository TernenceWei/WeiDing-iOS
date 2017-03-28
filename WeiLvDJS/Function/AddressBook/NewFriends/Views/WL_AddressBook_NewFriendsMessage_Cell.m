//
//  WL_AddressBook_NewFriendsMessage_Cell.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/15.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_NewFriendsMessage_Cell.h"

#import "WL_AddressBook_NewFriend_Model.h"

#import "WL_AddressBook_NewFriend_Company_Model.h"

@interface WL_AddressBook_NewFriendsMessage_Cell ()
/** 头像imageView */
@property(nonatomic, weak) UIImageView *iconImageView;

/** 名称lable */
@property(nonatomic, weak) UILabel *nameLable;

/** 内容lable */
@property(nonatomic, weak) UILabel *contentLable;

/** 公司名称lable */
@property(nonatomic, weak) UILabel *companyNameLable;
/** 已添加lable */
@property(nonatomic, weak) UILabel *addLable;


@end

@implementation WL_AddressBook_NewFriendsMessage_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //添加子控件
        [self setupContentViewToNewFriendsMessageCell];
        //设置点击不变灰
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

#pragma mark - 添加子控件
- (void)setupContentViewToNewFriendsMessageCell
{
    //1.左侧头像
    UIImageView *iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(14.5);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.and.height.equalTo(@40);
    }];
    iconImageView.layer.cornerRadius = 20.0f;
    iconImageView.layer.masksToBounds = YES;
    self.iconImageView = iconImageView;
    
    //2.名称Lable;
    UILabel *nameLable = [[UILabel alloc] init];
    [self.contentView addSubview:nameLable];
    [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(65);
        make.top.equalTo(self.contentView.mas_top).offset(14);
        make.height.equalTo(@18);
    }];
    nameLable.font = WLFontSize(15);
    nameLable.textColor = [WLTools stringToColor:@"#2f2f2f"];
    self.nameLable = nameLable;
    
    //3.好友请求内容Lable
    UILabel *contentLable = [[UILabel alloc] init];
    [self.contentView addSubview:contentLable];
    [contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(65);
        make.top.equalTo(self.contentView.mas_top).offset(38);
        make.height.equalTo(@18);
    }];
    contentLable.font = WLFontSize(14);
    contentLable.textColor = [WLTools stringToColor:@"#868686"];
    self.contentLable = contentLable;
    
    //4.公司名称imageView
    UIImageView *companyIconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CompanyIcon"]];
    [self.contentView addSubview:companyIconImageView];
    [companyIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(65);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-13);
    }];
    self.companyIconImageView = companyIconImageView;
    
    //5.公司名称Lable
    UILabel *companyNameLable = [[UILabel alloc] init];
    [self.contentView addSubview:companyNameLable];
    [companyNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(83);
        make.centerY.equalTo(companyIconImageView.mas_centerY);
        make.height.equalTo(@18);
    }];
    companyNameLable.font = WLFontSize(14);
    companyNameLable.textColor = contentLable.textColor;
    self.companyNameLable = companyNameLable;
    
    //底部分隔线
    UIView *lineView = [[UIView alloc] init];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(13);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@0.5);
    }];
    lineView.backgroundColor = [WLTools stringToColor:@"#d8d9dd"];
    self.lineView = lineView;
    
    //右侧是否通过添加好友按钮
    UIButton *addButton = [[UIButton alloc] init];
    [self.contentView addSubview:addButton];
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-12.5);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.equalTo(@31);
        make.width.equalTo(@56);
    }];
    [addButton setTitle:@"通过" forState:UIControlStateNormal];
    [addButton setTitleColor:[WLTools stringToColor:@"#4499ff"] forState:UIControlStateNormal];
    addButton.titleLabel.font = WLFontSize(15);
    [addButton setBackgroundColor:[WLTools stringToColor:@"#ffffff"]];
    addButton.layer.cornerRadius = 15.5f;
    addButton.layer.masksToBounds = YES;
    addButton.layer.borderWidth = 0.5f;
    addButton.layer.borderColor = [WLTools stringToColor:@"#4499ff"].CGColor;
    self.addButton = addButton;
    
    
    //已添加的Lable
    UILabel *addLable = [[UILabel alloc] init];
    [self.contentView addSubview:addLable];
    [addLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-12.5);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    addLable.font = WLFontSize(15);
    addLable.text = @"已添加";
    addLable.textColor = [WLTools stringToColor:@"#868686"];
    self.addLable = addLable;
    addButton.hidden = YES;
    addLable.hidden = YES;
  
}

- (void)setFriendModel:(WL_AddressBook_NewFriend_Model *)friendModel
{
    _friendModel = friendModel;
    //头像
    
//    self.iconImageView.image = [UIImage imageNamed:friendModel.adver];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:friendModel.adver] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
    //名称
    self.nameLable.text = friendModel.user_name;
    //附言
    self.contentLable.text = friendModel.msg_content;
    
    //公司组织
    if ([friendModel.status isEqualToString:@"1"])  //已读|已认证|已添加
    {
        self.addLable.hidden = NO;
        self.addButton.hidden = YES;
    }
    else        //未读,未添加
    {
        self.addLable.hidden = YES;
        self.addButton.hidden = NO;
    }
    
}

- (void)setCompanyModel:(WL_AddressBook_NewFriend_Company_Model *)companyModel
{
    _companyModel = companyModel;
    if (companyModel.company_name == nil) {
        self.companyNameLable.text = @"";
    }
    else
    {
        self.companyNameLable.text = companyModel.company_name;
    }
    
}

@end
