//
//  WL_MyFriendList_Cell.h
//  WeiLvDJS
//
//  Created by jyc on 2016/11/14.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WL_AddressBook_MyFriend_Model.h"

#import "WL_SearchResultModel.h"

@interface WL_MyFriendList_Cell : UITableViewCell

@property(nonatomic,strong)UIButton *selectImageView;

@property(nonatomic,strong)UIImageView *logoImageView;

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UILabel *telPhone;

@property(nonatomic,strong)UILabel *line;

@property(nonatomic,strong)NSIndexPath *path;

@property(nonatomic,copy)void (^buttonSelectBlock)(NSIndexPath *indexPath,UIButton *button);

@property(nonatomic,strong)WL_AddressBook_MyFriend_Model *model;

@property(nonatomic,strong)WL_SearchResultModel *searchResult;

@end
