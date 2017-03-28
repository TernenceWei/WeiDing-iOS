//
//  WL_AddressBook_MyAddressBook_Cell.h
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/8.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WL_AddressBook_Content_Model;
@class WL_AddressBook_MyAddressBook_SearchContent_Model;
@interface WL_AddressBook_MyAddressBook_Cell : UITableViewCell
@property (nonatomic,strong) NSArray *phoneArray;

@property (nonatomic,assign) BOOL isSelected;

@property (nonatomic,strong) UIView *lineView;

@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) UILabel *phoneLabel;

- (void)configCellWithModel:(WL_AddressBook_Content_Model *) model;

@property (nonatomic,strong) WL_AddressBook_MyAddressBook_SearchContent_Model *searchContent;

- (void)changeSelectedState;

- (void)hideInfo;
@end
