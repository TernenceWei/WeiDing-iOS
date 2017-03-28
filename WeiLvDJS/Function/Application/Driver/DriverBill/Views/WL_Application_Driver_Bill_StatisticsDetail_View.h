//
//  WL_Application_Driver_Bill_StatisticsDetail_View.h
//  WeiLvDJS
//
//  Created by 张继伟 on 16/10/9.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseView.h"

@interface WL_Application_Driver_Bill_StatisticsDetail_View : WL_BaseView
/** 已收款项Lable */
@property(nonatomic, weak) UILabel *moneyReceiptLable;

/** 剩余款额Lable */
@property(nonatomic, weak) UILabel *uncollectedLable;

/** 回款率Lable */
@property(nonatomic, weak) UILabel *receivableRatioLable;
@end
