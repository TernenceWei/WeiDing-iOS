//
//  WLLetterItemCell.h
//  WeiLvDJS
//
//  Created by ternence on 16/12/12.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WL_PrivateDetail_Model.h"

@interface WLLetterItemCell : UITableViewCell

@property(nonatomic,strong)UIImageView *portrait;

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UILabel *dateLabel;

@property(nonatomic,strong)UILabel *detailLabel;

@property(nonatomic,strong)WL_authorInfo_Model *model;

+(CGFloat)heightWithModel:(WL_authorInfo_Model *)model;
@end
