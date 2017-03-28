//
//  WL_SearchFriend_Cell.h
//  WeiLvDJS
//
//  Created by jyc on 2016/11/25.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WL_Friendlist_Model.h"
#import "WL_MessageList_Model.h"
@interface WL_SearchFriend_Cell : UITableViewCell

@property(nonatomic,strong)UIImageView *logoImageView;

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UILabel *line;

//@property(nonatomic,strong)WL_Friendlist_Model *model;
@property (nonatomic, strong) WL_MessageList_itemsModel *model;


@end
