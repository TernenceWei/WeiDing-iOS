//
//  WL_Announce_TableViewCell.h
//  WeiLvDJS
//
//  Created by jyc on 2016/11/19.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WL_Announce_Model.h"

@interface WL_Announce_TableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *photoImage;

@property(nonatomic,strong)UIImageView *timeImage;

@property(nonatomic,strong)UILabel *timeLabel;

@property(nonatomic,strong)UILabel *detailLabel;

@property(nonatomic,strong)NSDateFormatter *formatter1;

@property(nonatomic,strong)NSDateFormatter *formatter2;

@property(nonatomic,strong)WL_Announce_Model *model;

@end
