//
//  WL_Mine_CapitalCell.h
//  WeiLvDJS
//
//  Created by jyc on 16/9/7.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  个人中心首页 - 第一分区的cell

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ClickType)
{
    ClickTypeBalance,//余额点击
    ClickTypeAward//奖励点击
};



@interface WL_MineViewController_CapitalCell : UITableViewCell

@property(nonatomic,strong)UILabel *balanceLabel;

@property(nonatomic,strong)UILabel *awardLabel;

@property(nonatomic,copy)void (^buttonClickBlock)(ClickType type);

@end
