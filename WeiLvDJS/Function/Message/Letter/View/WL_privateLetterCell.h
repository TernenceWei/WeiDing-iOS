//
//  WL_privateLetterCell.h
//  WeiLvDJS
//
//  Created by jyc on 2016/11/10.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WL_privateLetter_Model.h"
@interface WL_privateLetterCell : UITableViewCell

@property(nonatomic,strong)UIImageView *portrait;

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UILabel *dateLabel;

@property(nonatomic,strong)UILabel *detailLabel;

@property(nonatomic,strong)UIImageView *message;

@property(nonatomic,strong)UILabel *messageNum;

@property(nonatomic,strong)WL_privateLetter_Model *model;

+(CGFloat)heightWithModel:(WL_privateLetter_Model *)model;

@end
