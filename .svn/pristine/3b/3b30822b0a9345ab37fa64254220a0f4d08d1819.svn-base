//
//  WL_AddressBook_LinkManDetail_BottomView.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/10.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_LinkManDetail_BottomView.h"

@implementation WL_AddressBook_LinkManDetail_BottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupChildViewToLinkManDetailBottomView];
    }
    return self;
}

- (void)setupChildViewToLinkManDetailBottomView
{
    //1.添加左侧的按钮
    UIButton *telPhoneButton = [[UIButton alloc] init];
    [self addSubview:telPhoneButton];
    [telPhoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(50);
        make.width.equalTo(@150);
        make.height.equalTo(@40);
        make.left.equalTo(self.mas_left).offset((ScreenWidth - 300) / 3);
    }];
    telPhoneButton.layer.cornerRadius = 20.0;
    telPhoneButton.layer.masksToBounds = YES;
    [telPhoneButton setBackgroundColor:[WLTools stringToColor:@"#879ffa"]];
    [telPhoneButton setTitle:@"打电话" forState:UIControlStateNormal];
    [telPhoneButton setTitleColor:[WLTools stringToColor:@"#ffffff"] forState:UIControlStateNormal];
    telPhoneButton.titleLabel.font = WLFontSize(19);
    self.telPhoneButton = telPhoneButton;
    //2 右侧发私信按钮
    UIButton *sendMessageButton = [[UIButton alloc] init];
    [self addSubview:sendMessageButton];
    [sendMessageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(50);
        make.width.equalTo(@150);
        make.height.equalTo(@40);
        make.right.equalTo(self.mas_right).offset(-(ScreenWidth - 300) / 3);
    }];
    sendMessageButton.layer.cornerRadius = 20.0;
    sendMessageButton.layer.masksToBounds = YES;
    [sendMessageButton setBackgroundColor:[WLTools stringToColor:@"#69c95e"]];
    [sendMessageButton setTitle:@"发私信" forState:UIControlStateNormal];
    [sendMessageButton setTitleColor:[WLTools stringToColor:@"#ffffff"] forState:UIControlStateNormal];
    sendMessageButton.titleLabel.font = WLFontSize(19);
    self.sendMessageButton =sendMessageButton;
    
}

@end
