//
//  WL_PrivateDetail_Cell.h
//  WeiLvDJS
//
//  Created by jyc on 2016/11/10.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WL_PrivateDetail_Model.h"

@interface WL_PrivateDetail_Cell : UITableViewCell

@property(nonatomic,strong)UIImageView *portrait;

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UILabel *dateLabel;

@property(nonatomic,strong)UILabel *detailLabel;

@property(nonatomic,strong)WL_authorInfo_Model *model;

+(CGFloat)heightWithModel:(WL_authorInfo_Model *)model;

@end
