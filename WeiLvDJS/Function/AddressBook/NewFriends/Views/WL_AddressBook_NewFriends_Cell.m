//
//  WL_AddressBook_NewFriends_Cell.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/15.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_NewFriends_Cell.h"
#import "WL_AddressBook_NewFriends_NotReg_Model.h"

@interface WL_AddressBook_NewFriends_Cell ()

/** 头像imageView */
@property(nonatomic, weak) UIImageView *iconImageView;

/** 名称lable */
@property(nonatomic, weak) UILabel *nameLable;

/** 电话号码lable */
@property(nonatomic, weak) UILabel *phoneLable;


@end

@implementation WL_AddressBook_NewFriends_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupContentViewToNewFriendsCell];
        //设置点击不变灰
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupContentViewToNewFriendsCell
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
    nameLable.text = @"呵呵了";
    
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
    //电话号码Lable
    UILabel *phoneLable = [[UILabel alloc] init];
    [self.contentView addSubview:phoneLable];
    [phoneLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(65);
        make.top.equalTo(nameLable.mas_bottom).offset(10);
    }];
    phoneLable.font = WLFontSize(14);
    phoneLable.textColor = [WLTools stringToColor:@"#868686"];
    phoneLable.text = @"18807620012";
    self.phoneLable = phoneLable;
    
    //右侧是否通过添加好友按钮
    UIButton *addButton = [[UIButton alloc] init];
    [self.contentView addSubview:addButton];
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-12.5);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.equalTo(@31);
        make.width.equalTo(@56);
    }];
    [addButton setTitle:@"添加" forState:UIControlStateNormal];
    [addButton setTitleColor:[WLTools stringToColor:@"#4499ff"] forState:UIControlStateNormal];
    addButton.titleLabel.font = WLFontSize(15);
    [addButton setBackgroundColor:[WLTools stringToColor:@"#ffffff"]];
    addButton.layer.cornerRadius = 15.5f;
    addButton.layer.masksToBounds = YES;
    addButton.layer.borderWidth = 0.5f;
    addButton.layer.borderColor = [WLTools stringToColor:@"#4499ff"].CGColor;
    self.addButton = addButton;
    
    
}

- (void)setNotRegModel:(WL_AddressBook_NewFriends_NotReg_Model *)notRegModel
{
    _notRegModel = notRegModel;
    self.nameLable.text = notRegModel.user_name;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:notRegModel.photo] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
    self.phoneLable.text = notRegModel.user_mobile;
    
}

@end
