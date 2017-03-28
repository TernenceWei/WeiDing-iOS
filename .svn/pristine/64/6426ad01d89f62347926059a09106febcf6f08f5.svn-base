//
//  WL_Application_CarListInformation_TableViewCell.h
//  WeiLvDJS
//
//  Created by liuxin on 16/9/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WL_Application_carListInformation_model.h"
typedef void(^btnTitleTapClick)();
typedef void(^ViewTitleTapClick)();
@interface WL_Application_CarListInformation_TableViewCell : UITableViewCell
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,strong)UIImageView *photoImageView;//车辆图片
@property(nonatomic,strong)UIView *view;//公司名称的背景view
@property(nonatomic,strong)UILabel *labelTitleName;//车辆牌子等信息
@property(nonatomic,strong)UIImageView *UIImageViewTitle;

@property(nonatomic,copy)btnTitleTapClick BtnBlock;
@property(nonatomic,copy)ViewTitleTapClick ViewTitleBlock;

-(void)setModel:(WL_Application_carListInformation_model *)model;
@end
