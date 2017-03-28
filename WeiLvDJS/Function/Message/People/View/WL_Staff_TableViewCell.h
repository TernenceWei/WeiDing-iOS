//
//  WL_Staff_TableViewCell.h
//  WeiLvDJS
//
//  Created by jyc on 2016/11/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  组织架构下面 具体某个人的cell

#import <UIKit/UIKit.h>

#import "WL_StaffModel.h"

@interface WL_Staff_TableViewCell : UITableViewCell

@property(nonatomic,strong)UIButton *selectImageView;

@property(nonatomic,strong)UIImageView *logoImageView;

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UILabel *positionLabel;

@property(nonatomic,strong)UILabel *line;

@property(nonatomic,strong)NSIndexPath *path;

@property(nonatomic,copy)void (^buttonSelectBlock)(NSIndexPath *indexPath,UIButton *button);

@property(nonatomic,strong)WL_StaffModel *model;

@end
