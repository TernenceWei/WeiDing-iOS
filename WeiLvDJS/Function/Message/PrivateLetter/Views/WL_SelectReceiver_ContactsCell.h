//
//  WL_SelectReceiver_ContactsCell.h
//  WeiLvDJS
//
//  Created by jyc on 2016/11/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WL_UsuallyContactsList_Model.h"



@interface WL_SelectReceiver_ContactsCell : UITableViewCell

@property(nonatomic,strong)UIButton *selectImageView;

@property(nonatomic,strong)UIImageView *logoImageView;

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UILabel *detailLabel;

@property(nonatomic,strong)NSIndexPath *path;

@property(nonatomic,strong)UILabel *line;

@property(nonatomic,copy)void (^buttonSelectBlock)(NSIndexPath *indexPath,UIButton *button);


@property(nonatomic,strong)WL_UsuallyContactsList_Model *model;

-(void)selectTapClick:(UIButton *)button;

@end
