//
//  WL_TransferRecordCell.h
//  WeiLvDJS
//
//  Created by jyc on 16/10/14.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WL_TradeRecord_Model.h"

@interface WL_TransferRecordCell : UITableViewCell

@property(nonatomic,strong)UILabel *typeLabel;

@property(nonatomic,strong)UILabel *dateLabel;

@property(nonatomic,strong)UILabel *numberLabel;

@property(nonatomic,strong)UILabel *statusLabel;

@property(nonatomic,strong)UILabel *line;

@property(nonatomic,strong)UILabel *groupLabel;

@property(nonatomic,strong)WL_TradeRecord_Model *model;

@end
