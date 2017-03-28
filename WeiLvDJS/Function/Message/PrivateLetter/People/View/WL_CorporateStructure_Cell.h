//
//  WL_CorporateStructure_Cell.h
//  WeiLvDJS
//
//  Created by jyc on 2016/11/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  公司组织架构的cell

#import <UIKit/UIKit.h>

#import "WL_DepartmentModel.h"

@interface WL_CorporateStructure_Cell : UITableViewCell

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UILabel *rightLabel;

@property(nonatomic,strong)UIImageView *arrows;

@property(nonatomic,strong)UILabel *line;

@property(nonatomic,strong)WL_DepartmentModel *model;

@end
