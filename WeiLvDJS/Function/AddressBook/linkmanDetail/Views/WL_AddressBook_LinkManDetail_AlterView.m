//
//  WL_AddressBook_LinkManDetail_AlterView.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/10.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_LinkManDetail_AlterView.h"

@implementation WL_AddressBook_LinkManDetail_AlterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [WLTools stringToColor:@"#ffffff"];
        [self setupChildViewToLinkManDetailAlertView];
    }
    return self;
}

- (void)setupChildViewToLinkManDetailAlertView
{

    //取消绑定好友按钮
    UIButton *cancelFriendsButton = [[UIButton alloc] init];
    [self addSubview:cancelFriendsButton];
    [cancelFriendsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.height.equalTo(@60);
    }];
    [cancelFriendsButton setTitle:@"取消绑定好友" forState:UIControlStateNormal];
    [cancelFriendsButton setTitleColor:[WLTools stringToColor:@"#2f2f2f"] forState:UIControlStateNormal];
    cancelFriendsButton.titleLabel.font = WLFontSize(16);
    [self addLineToButton:cancelFriendsButton];
    self.cancelFriendsButton = cancelFriendsButton;
    //取消绑定好友按钮
    UIButton *remarkNameButton = [[UIButton alloc] init];
    [self addSubview:remarkNameButton];
    [remarkNameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cancelFriendsButton.mas_left);
        make.right.equalTo(cancelFriendsButton.mas_right);
        make.top.equalTo(cancelFriendsButton.mas_bottom);
        make.height.equalTo(@60);
    }];
    [remarkNameButton setTitle:@"设置备注名称" forState:UIControlStateNormal];
    [remarkNameButton setTitleColor:[WLTools stringToColor:@"#2f2f2f"] forState:UIControlStateNormal];
    remarkNameButton.titleLabel.font = WLFontSize(16);
    [self addLineToButton:remarkNameButton];
    self.remarkNameButton = remarkNameButton;
    //取消按钮
    UIButton *cancleButton = [[UIButton alloc] init];
    [self addSubview:cancleButton];
    [cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(remarkNameButton.mas_left);
        make.right.equalTo(remarkNameButton.mas_right);
        make.top.equalTo(remarkNameButton.mas_bottom);
        make.height.equalTo(@60);
    }];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:[WLTools stringToColor:@"#2f2f2f"] forState:UIControlStateNormal];
    cancleButton.titleLabel.font = WLFontSize(16);
    [self addLineToButton:cancleButton];
    self.cancleButton = cancleButton;

}

- (void)addLineToButton:(UIButton *)button
{
    UIView *lineView = [[UIView alloc] init];
    [button addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button.mas_left);
        make.right.equalTo(button.mas_right);
        make.bottom.equalTo(button.mas_bottom);
        make.height.equalTo(@0.5);
    }];
    lineView.backgroundColor = [WLTools stringToColor:@"#868686"];
}



@end
