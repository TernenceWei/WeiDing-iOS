//
//  WL_organizationList_Cell.h
//  WeiLvDJS
//
//  Created by zhaoxiao on 16/9/9.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WL_Copmany_Model;

@interface WL_organizationList_Cell : UITableViewCell

/** 个人所属公司数据 */
@property(nonatomic, strong)WL_Copmany_Model *company;

/** 设置公司/组织名称 */
@property(nonatomic, weak)UILabel *organizationNameLable;

/** 设置底部的lineView分割线 */
@property(nonatomic, weak)UIView *lineView;

@end
