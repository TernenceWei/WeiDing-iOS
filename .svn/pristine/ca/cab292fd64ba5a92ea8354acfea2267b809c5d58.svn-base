//
//  WL_AddressBook_MyFriends_Cell.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/12.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_MyFriends_Cell.h"
#import "WL_AddressBook_MyFriend_Model.h"
#import "WL_AddressBook_SearchResult_Contact_Model.h"

@interface WL_AddressBook_MyFriends_Cell ()
/** 头像 */
@property(nonatomic, weak) UIImageView *iconImageView;

/** 电话 */
@property(nonatomic, weak) UILabel *phoneLable;



@end

@implementation WL_AddressBook_MyFriends_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置子控件
        [self setupContentViewToMyFriendsCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

#pragma mark - 设置子控件
- (void)setupContentViewToMyFriendsCell
{
    //1,添加头像
    UIImageView *iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(12.5);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.and.width.equalTo(@42);
    }];
    iconImageView.layer.cornerRadius = 21.0;
    iconImageView.layer.masksToBounds = YES;
    self.iconImageView = iconImageView;
    
    //2.姓名
    UILabel *nameLable = [[UILabel alloc] init];
    [self.contentView addSubview:nameLable];
    [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageView.mas_right).offset(17);
        make.top.equalTo(self.contentView.mas_top).offset(12);
        make.height.equalTo(@20);
    }];
    nameLable.font = WLFontSize(16);
    nameLable.textColor = [WLTools stringToColor:@"#2f2f2f"];
    self.nameLable = nameLable;
    
    //3,电话
    UILabel *phoneLable = [[UILabel alloc] init];
    [self.contentView addSubview:phoneLable];
    [phoneLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageView.mas_right).offset(17);
        make.top.equalTo(nameLable.mas_bottom).offset(11);
    }];
    phoneLable.font = WLFontSize(13);
    phoneLable.textColor = [WLTools stringToColor:@"#868686"];
    self.phoneLable = phoneLable;
    
    //4.分隔线
    UIView *lineView = [[UIView alloc] init];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(72);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@1);
    }];
    lineView.backgroundColor = [WLTools stringToColor:@"#f1f1f1"];
    self.lineView = lineView;
}

- (void)setMyFriendModel:(WL_AddressBook_MyFriend_Model *)myFriendModel
{
    _myFriendModel = myFriendModel;
    //头像
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:myFriendModel.img] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
    //名称
    self.nameLable.text = myFriendModel.title;
    //电话号码
    self.phoneLable.text = myFriendModel.user_mobile;
    
    
}

- (void)setSearchMyFriendModel:(WL_AddressBook_SearchResult_Contact_Model *)searchMyFriendModel
{
    _searchMyFriendModel = searchMyFriendModel;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:searchMyFriendModel.photo] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
    self.nameLable.text = searchMyFriendModel.name;
    
}





@end
