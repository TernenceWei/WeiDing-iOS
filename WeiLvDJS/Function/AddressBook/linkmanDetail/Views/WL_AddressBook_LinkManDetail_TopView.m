//
//  WL_AddressBook_LinkMainDetail_TopView.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/9.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_LinkManDetail_TopView.h"
#import "WL_AddressBook_LinkMan_Information_Model.h"

@interface WL_AddressBook_LinkManDetail_TopView ()

/** 头像imageView */
@property(nonatomic, weak) UIImageView *iconImageView;
/** 头像imageLable */
@property(nonatomic, weak) UILabel *iconImageLable;
/** 姓名Lable */
@property(nonatomic, weak) UILabel *nameLable;
/** 昵称Lable */
@property(nonatomic, weak) UILabel *nicknameLable;
/** 性别imageView */
@property(nonatomic, weak) UIImageView *sexImageView;
/** 电话号码Lable */
@property(nonatomic, weak) UILabel *phoneLable;
/** 所在地Lable */
@property(nonatomic, weak) UILabel *addressLable;


@end

@implementation WL_AddressBook_LinkManDetail_TopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupChildViewToLinkManDetailTopView];
        self.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    }
    return self;
}

- (void)setupChildViewToLinkManDetailTopView
{
    //1. 左侧的头像
    UIImageView *iconImageView = [[UIImageView alloc] init];
    [self addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(15);
        make.left.equalTo(self.mas_left).offset(15);
        make.height.and.width.equalTo(@42);
    }];
    iconImageView.layer.cornerRadius = 21.0f;
    iconImageView.layer.masksToBounds = YES;
    self.iconImageView = iconImageView;
    //1.1在头像imageView中添加一个Lable
    UILabel *iconImageLable = [[UILabel alloc] init];
    [iconImageView addSubview:iconImageLable];
    [iconImageLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageView.mas_left);
        make.right.equalTo(iconImageView.mas_right);
        make.top.equalTo(iconImageView.mas_top);
        make.bottom.equalTo(iconImageView.mas_bottom);
    }];
    iconImageLable.font = WLFontSize(13);
    iconImageLable.textAlignment = NSTextAlignmentCenter;
    iconImageLable.textColor = [WLTools stringToColor:@"#ffffff"];
    iconImageLable.backgroundColor = [WLTools stringToColor:@"#ff0000"];
    self.iconImageLable = iconImageLable;
    self.iconImageLable.hidden = YES;
    //姓名Lable
    UILabel *nameLable = [[UILabel alloc] init];
    [self addSubview:nameLable];
    [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageView.mas_right).offset(12);
        make.top.equalTo(self.mas_top).offset(20);
        make.height.equalTo(@18);
    }];
    nameLable.textColor = [WLTools stringToColor:@"#2f2f2f"];
    nameLable.font = WLFontSize(14);
    self.nameLable = nameLable;
    //昵称Lable
    UILabel *nicknameLable = [[UILabel alloc] init];
    [self addSubview:nicknameLable];
    [nicknameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLable.mas_right).offset(9);
        make.bottom.equalTo(nameLable.mas_bottom);
        make.height.equalTo(@14);
    }];
    nicknameLable.font = WLFontSize(10);
    nicknameLable.textColor = [WLTools stringToColor:@"#868686"];
    self.nicknameLable = nicknameLable;
    //性别图片
    UIImageView *sexImageView = [[UIImageView alloc] init];
    [self addSubview:sexImageView];
    [sexImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nicknameLable.mas_right).offset(8);
        make.centerY.equalTo(nameLable.mas_centerY);
    }];
    self.sexImageView =sexImageView;
    
    //电话号码Lable
    UILabel *phoneLable = [[UILabel alloc] init];
    [self addSubview:phoneLable];
    [phoneLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLable.mas_left);
        make.top.equalTo(nameLable.mas_bottom).offset(25);
        
    }];
    phoneLable.font = WLFontSize(10);
    phoneLable.textColor = [WLTools stringToColor:@"#4778e7"];
    self.phoneLable = phoneLable;
    //省市
    UILabel *addressLable = [[UILabel alloc] init];
    [self addSubview:addressLable];
    [addressLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneLable.mas_left);
        make.top.equalTo(phoneLable.mas_bottom).offset(13);
        make.height.equalTo(@14);
    }];
    
    addressLable.font = WLFontSize(12);
    addressLable.textColor = [WLTools stringToColor:@"#2f2f2f"];
    self.addressLable = addressLable;
    
    //添加好友按钮
    UIButton *addFriendsButton = [[UIButton alloc] init];
    [self addSubview:addFriendsButton];
    [addFriendsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-16);
        make.bottom.equalTo(self.mas_bottom).offset(-16);
        make.height.equalTo(@30);
        make.width.equalTo(@90);
    }];
    [addFriendsButton setTitle:@"加好友" forState:UIControlStateNormal];
    addFriendsButton.layer.cornerRadius = 15.0;
    addFriendsButton.layer.masksToBounds = YES;
    addFriendsButton.backgroundColor = [WLTools stringToColor:@"#feae64"];
    [addFriendsButton setTitleColor:[WLTools stringToColor:@"#ffffff"] forState:UIControlStateNormal];
    addFriendsButton.titleLabel.font = WLFontSize(13);
    addFriendsButton.hidden = YES;
    self.addFriendsButton = addFriendsButton;
}

- (void)setInformationModel:(WL_AddressBook_LinkMan_Information_Model *)informationModel
{
    _informationModel = informationModel;
    
    if ([informationModel.remarkName isEqualToString:@""])
    {
        //姓名
        self.nameLable.text = informationModel.user_name;
        self.nicknameLable.hidden = YES;
        
    }
    else
    {
        //姓名
        self.nameLable.text = informationModel.remarkName;
        self.nicknameLable.hidden = NO;
        self.nicknameLable.text = [NSString stringWithFormat:@"(%@)", informationModel.user_name];
    }
    
    //头像
    if ([informationModel.photo isEqualToString:@""])   //没有返回头像信息
    {
        self.iconImageLable.hidden = NO;
        if (self.nameLable.text.length > 2) //姓名字符串长度大于2
        {
            self.iconImageLable.text = [self.nameLable.text substringFromIndex:self.nameLable.text.length - 2];
        }
        else     //姓名字符串长度小于等于2
        {
            self.iconImageLable.text = self.nameLable.text;
        }
        
    }
    else    //返回的有头像url
    {
        self.iconImageLable.hidden = YES;
        NSURL *iconUrl = [NSURL URLWithString:informationModel.photo];
        [self.iconImageView sd_setImageWithURL:iconUrl placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
    }
    
    //电话号码
    self.phoneLable.text = informationModel.user_mobile;
    //地址
    self.addressLable.text = informationModel.address;
    //性别
    if ([informationModel.sex isEqualToString:@"0"])    //女
    {
        self.sexImageView.image = [UIImage imageNamed:@"Women"];
    }
    else
    {
        self.sexImageView.image = [UIImage imageNamed:@"Man"];
    }
    
    //判断是否为好友
    if ([informationModel.isFriend isEqualToString:@"1"])
    {
        self.addFriendsButton.hidden = YES;
    }
    else
    {
        self.addFriendsButton.hidden = NO;
    }
    
    
    
}

@end
