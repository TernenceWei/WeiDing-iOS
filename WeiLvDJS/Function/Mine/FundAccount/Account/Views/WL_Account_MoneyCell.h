//
//  WL_Account_MoneyCell.h
//  WeiLvDJS
//
//  Created by jyc on 16/9/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ClickType)
{
    ClickTypeBalance,//余额点击
    
    ClickTypeFrozen_amount,
    
    ClickTypeAward//奖励点击
};

@interface WL_Account_MoneyCell : UITableViewCell

@property(nonatomic,strong)UILabel *balanceLabel;//余额

@property(nonatomic,strong)UILabel *frozen_amount;//冻结

@property(nonatomic,strong)UILabel *awardLabel;//奖励

@property(nonatomic,copy)void (^buttonClickBlock)(ClickType type);

@end
