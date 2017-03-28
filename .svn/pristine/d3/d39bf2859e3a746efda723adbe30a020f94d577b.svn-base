//
//  WL_AddressBook_HeaderView.m
//  WeiLvDJS
//
//  Created by zhaoxiao on 16/9/2.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_HeaderView.h"
#import "WL_AddressBook_AccessView.h"


@implementation WL_AddressBook_HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //添加子控件
        [self setupChildViewToAddressBookHeader];
        
        self.backgroundColor = [WLTools stringToColor:@"#ffffff"];
        
    }
    return self;
}

#pragma mark - 添加子控件
- (void)setupChildViewToAddressBookHeader
{
    //添加头部搜索框
    [self setupTopSearchViewToAddressBookHeader];
    
    //添加搜索框中间部分
    [self setupBottomToAddressBookHeader];
    
}

#pragma mark - 添加头部搜索框

- (void)setupTopSearchViewToAddressBookHeader
{
    //头部搜索框SearchView
    UIView *searchView = [[UIView alloc] init];
    searchView.layer.cornerRadius = 5.0;
    searchView.layer.masksToBounds = YES;
    searchView.layer.borderColor = [WLTools stringToColor:@"#eeeff3"].CGColor;
    searchView.layer.borderWidth = 0.5f;
    searchView.backgroundColor = [WLTools stringToColor:@"#eeeff3"];
    [self addSubview:searchView];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(13);
        make.right.equalTo(self.mas_right).offset(-13);
        make.top.equalTo(self.mas_top).offset(9);
        make.height.equalTo(@29);
    }];
    //搜索框内的文字和图片
    UIButton *searchButton = [[UIButton alloc] init];
    [searchButton setTitle:@"搜索人或企业" forState:UIControlStateNormal];
    [searchButton setTitleColor:[WLTools stringToColor:@"#b0b7c1"] forState:UIControlStateNormal];
    [searchButton.titleLabel setFont:WLFontSize(14)];
    [searchButton setImage:[UIImage imageNamed:@"AddressBook_search"] forState:UIControlStateNormal];
    [self addSubview:searchButton];
    [searchButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 7, 0, 0)];
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(searchView.mas_centerX);
        make.centerY.equalTo(searchView.mas_centerY);
        make.height.equalTo(searchView.mas_height).offset(-2);
        make.width.equalTo(searchView.mas_width).offset(-5);
    }];
    self.searchButton = searchButton;
    
}

#pragma mark - 添加搜索框下的按钮

- (void)setupBottomToAddressBookHeader
{
    UIView *bottomView = [[UIView alloc] init];
    [self addSubview:bottomView];
    bottomView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    //添加约束
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchButton.mas_bottom).offset(9);
        make.height.equalTo(@107);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    
    //1.进入手机通讯录按钮
    WL_AddressBook_AccessView *mobileAddressView = [[WL_AddressBook_AccessView alloc] init];
    [bottomView addSubview:mobileAddressView];
    [mobileAddressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left);
        make.top.equalTo(bottomView.mas_top);
        make.bottom.equalTo(bottomView.mas_bottom);
        make.width.equalTo(@(ScreenWidth / 3));
    }];
    self.mobileAddressView = mobileAddressView;
    mobileAddressView.iconTitleLable.text = @"手机通讯录";
    mobileAddressView.iconImageView.image = [UIImage imageNamed:@"MobileMessage"];

    
    //2.进入微叮好友界面按钮
    WL_AddressBook_AccessView *enterFriendsView = [[WL_AddressBook_AccessView alloc] init];
    [bottomView addSubview:enterFriendsView];
    [enterFriendsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mobileAddressView.mas_right);
        make.top.equalTo(bottomView.mas_top);
        make.bottom.equalTo(bottomView.mas_bottom);
        make.width.equalTo(@(ScreenWidth / 3));
    }];
    self.enterFriendsView = enterFriendsView;
    enterFriendsView.iconTitleLable.text = @"微叮好友";
    enterFriendsView.iconImageView.image = [UIImage imageNamed:@"WeiDingFriends"];
    
    //3. 进入商家号列表界面按钮
    WL_AddressBook_AccessView *enterMerchantView = [[WL_AddressBook_AccessView alloc] init];
    [bottomView addSubview:enterMerchantView];
    [enterMerchantView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(enterFriendsView.mas_right);
        make.top.equalTo(bottomView.mas_top);
        make.bottom.equalTo(bottomView.mas_bottom);
        make.width.equalTo(@(ScreenWidth / 3));
    }];
    self.enterMerchantView = enterMerchantView;
    enterMerchantView.iconTitleLable.text = @"关注企业";
    enterMerchantView.iconImageView.image = [UIImage imageNamed:@"enterprise"];
   
}

- (void) enterMobileAddressVc
{
    
}





@end
