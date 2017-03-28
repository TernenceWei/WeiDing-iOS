//
//  WL_AddressBook_OrganizationDetail_FooterView.h
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/12.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseView.h"
@class WL_AddressBook_OrganizationDetail_Model;
@interface WL_AddressBook_OrganizationDetail_FooterView : WL_BaseView
@property(nonatomic, weak) UIButton *attentionButton;

@property(nonatomic, strong) WL_AddressBook_OrganizationDetail_Model * detailModel;
@end
