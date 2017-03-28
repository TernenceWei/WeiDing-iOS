//
//  WL_Application_Driver_Bill_BillList_Cell.h
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/20.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WL_Application_Driver_Bill_Model;

@interface WL_Application_Driver_Bill_Settlement_Cell : UITableViewCell

/** 订单信息 */
@property(nonatomic, strong)WL_Application_Driver_Bill_Model *billModel;

@end
