//
//  WL_AddressBook_topContact_Cell.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/10/27.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_topContact_Cell.h"
#import "WL_TopContact_Model.h"

@interface WL_AddressBook_topContact_Cell ()
/** 左侧头像图标 */
@property(nonatomic, weak) UIImageView *iconImageView;

/** 左侧头像字体 */
@property(nonatomic, weak) UILabel *iconImageLable;
/** 中间姓名Lable  */
@property(nonatomic, weak) UILabel *nameLable;
/** 右侧Lable */
@property(nonatomic, weak) UILabel *relationLable;
@end

@implementation WL_AddressBook_topContact_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setupContentViewToTopContactCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

#pragma 设置子控件
- (void)setupContentViewToTopContactCell
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
    
    UILabel *iconImageLable = [[UILabel alloc] init];
    [iconImageView addSubview:iconImageLable];
    [iconImageLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_left);
        make.right.equalTo(self.iconImageView.mas_right);
        make.top.equalTo(self.iconImageView.mas_top);
        make.bottom.equalTo(self.iconImageView.mas_bottom);
    }];
    
    iconImageLable.textAlignment = NSTextAlignmentCenter;
    iconImageLable.font = WLFontSize(13);
    iconImageLable.hidden = YES;
    iconImageLable.textColor = [WLTools stringToColor:@"#ffffff"];
    self.iconImageLable = iconImageLable;
//    self.iconImageLable.backgroundColor = [WLTools stringToColor:@"#ff0000"];
    
    
    
    //2. 添加中间联系人姓名
    UILabel *nameLable = [[UILabel alloc] init];
    [self.contentView addSubview:nameLable];
    [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageView.mas_right).offset(12);
        make.centerY.equalTo(iconImageView.mas_centerY);
        make.height.equalTo(@16);
    }];
    nameLable.font = WLFontSize(14);
    nameLable.textColor = [WLTools stringToColor:@"#2f2f2f"];
    nameLable.textAlignment = NSTextAlignmentLeft;
    self.nameLable = nameLable;
    
    //3.右侧Lable
    UILabel *relationLable = [[UILabel alloc] init];
    [self addSubview:relationLable];
    [relationLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-21);
        make.centerY.equalTo(nameLable.mas_centerY);

    }];
    relationLable.font = WLFontSize(13);
    relationLable.textColor = [WLTools stringToColor:@"#868686"];
    relationLable.textAlignment = NSTextAlignmentLeft;
    self.relationLable = relationLable;
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
    
    self.iconImageView.image = [UIImage imageNamed:@"Driver_04"];
    self.nameLable.text = @"阿发";

}

- (void)setTopContact:(WL_TopContact_Model *)topContact
{
    _topContact = topContact;

    self.nameLable.text = topContact.user_name;
    
    NSString *fullName = topContact.user_name;
    self.view_id = topContact.user_id;
    self.isCompany = topContact.isCompany;
    
    if ([topContact.photo isEqualToString:@""] || topContact.photo == nil)
    {
        self.iconImageLable.hidden = NO;
        if (fullName.length <= 2)
        {
            self.iconImageLable.text = fullName;
        }
        else
        {
            self.iconImageLable.text = [fullName substringFromIndex:(fullName.length - 2)];
        }
    }
    else
    {
        self.iconImageLable.hidden = YES;
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:topContact.photo] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
    }
    
    if ([topContact.isFriend isEqualToString:@"1"] && [topContact.isCompany isEqualToString:@"1"])
    {
        self.relationLable.text = @"好友 同组织";
    }
    else if ([topContact.isFriend isEqualToString:@"1"] && [topContact.isCompany isEqualToString:@"0"])
    {
        self.relationLable.text = @"好友";
    }
    else if ([topContact.isFriend isEqualToString:@"0"] && [topContact.isCompany isEqualToString:@"0"])
    {
        self.relationLable.text = @"";
    }
    else if ([topContact.isFriend isEqualToString:@"0"] && [topContact.isCompany isEqualToString:@"1"])
    {
        self.relationLable.text = @"同组织";
    }
    
    
    
}

@end
