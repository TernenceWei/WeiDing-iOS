//
//  WL_AddressBook_OrganizationDetail_FooterView.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/12.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_OrganizationDetail_FooterView.h"

#import "WL_AddressBook_OrganizationDetail_Model.h"

@implementation WL_AddressBook_OrganizationDetail_FooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置子控件
        [self setupContentViewToOrganizationDetailFooterView];
    }
    return self;
}

- (void)setupContentViewToOrganizationDetailFooterView
{
    //关注/取消关注按钮
    UIButton *attentionButton = [[UIButton alloc] init];
    [self addSubview:attentionButton];
    [attentionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.top.equalTo(self.mas_top).offset(50);
        make.height.equalTo(@45);
    }];
    attentionButton.layer.cornerRadius = 22.5;
    attentionButton.titleLabel.font = WLFontSize(18);
    [attentionButton setTitleColor:[WLTools stringToColor:@"#ffffff"] forState:UIControlStateNormal];
    [attentionButton setTitle:@"关注" forState:UIControlStateNormal];
    [attentionButton setTitle:@"已关注" forState:UIControlStateSelected];
    self.attentionButton = attentionButton;
}

- (void)setDetailModel:(WL_AddressBook_OrganizationDetail_Model *)detailModel
{
    _detailModel = detailModel;
    if ([detailModel.isFollow isEqualToString:@"1"])    //已关注
    {
        [self.attentionButton setBackgroundColor:[WLTools stringToColor:@"#4791ff"]];
        self.attentionButton.selected = YES;
    }
    else
    {
        [self.attentionButton setBackgroundColor:[WLTools stringToColor:@"#ff6f47"]];
        self.attentionButton.selected = NO;
    }
}

@end
