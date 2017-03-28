//
//  WL_AddressBook_MyAddressBook_Linkman_ViewController.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/16.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_MyAddressBook_Linkman_ViewController.h"

#import "WL_AddressBook_MyAddressBook_Linkman_View.h"

@interface WL_AddressBook_MyAddressBook_Linkman_ViewController ()

@end

@implementation WL_AddressBook_MyAddressBook_Linkman_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置内容
    [self setupContentViewToMyLinMan];
}

#pragma mark - 设置内容
- (void)setupContentViewToMyLinMan
{
    //1.背景颜色
    self.view.backgroundColor = [WLTools stringToColor:@"#f7f7f8"];
    self.title = @"详细资料";
    //2.添加一个View
    WL_AddressBook_MyAddressBook_Linkman_View *myLinkmanView = [[WL_AddressBook_MyAddressBook_Linkman_View alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 106) withName:self.name withMobile:self.phoneNum];
    myLinkmanView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    [self.view addSubview:myLinkmanView];
    
    //3.打电话按钮
    UIButton *callButton = [[UIButton alloc] init];
    [self.view addSubview:callButton];
    [callButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(myLinkmanView.mas_bottom).offset(26);
        make.height.equalTo(@40);
        make.width.equalTo(@150);
    }];
    [callButton setTitle:@"打电话" forState:UIControlStateNormal];
    [callButton setTitleColor:[WLTools stringToColor:@"#ffffff"] forState:UIControlStateNormal];
    [callButton.titleLabel setFont:WLFontSize(20)];
    [callButton setBackgroundColor:[WLTools stringToColor:@"#879ffa"]];
    [callButton addTarget:self action:@selector(callToRelation) forControlEvents:UIControlEventTouchUpInside];
    callButton.layer.cornerRadius = 20.0f;
    callButton.layer.masksToBounds = YES;
}

#pragma mark - 打电话方法
- (void)callToRelation
{
    NSString *telPhoneStr = [NSString stringWithFormat:@"tel:%@", self.phoneNum];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telPhoneStr]];
}



@end
