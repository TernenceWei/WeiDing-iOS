//
//  WL_AddressBook_Organization_Staff_Cell.h
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WL_AddressBook_Organization_Staff_Model;
@class WL_AddressBook_Organization_Search_Staff_Model;

@interface WL_AddressBook_Organization_Staff_Cell : UITableViewCell

@property(nonatomic, weak) UIView *lineView;

@property(nonatomic, strong) WL_AddressBook_Organization_Staff_Model *staffModel;

@property(nonatomic, strong) WL_AddressBook_Organization_Search_Staff_Model *searchModel;

@property(nonatomic, weak) UILabel *nameLable;

@end
