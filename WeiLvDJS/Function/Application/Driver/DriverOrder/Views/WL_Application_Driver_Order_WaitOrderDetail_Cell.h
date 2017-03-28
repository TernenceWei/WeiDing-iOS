//
//  WL_Application_Driver_Order_WaitOrderDetail_Cell.h
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WL_Application_Driver_OrderDetail_Model;
@interface WL_Application_Driver_Order_WaitOrderDetail_Cell : UITableViewCell
/** 内容Lable */
@property(nonatomic, weak)UILabel *contentLable;
/** 标题Lable */
@property(nonatomic, weak)UILabel *myTitleLable;
/** 底部分隔线 */
@property(nonatomic, weak)UIView *lineView;
/** 指示器imageView */
@property(nonatomic, weak) UIImageView *indicatorImageView;
/** 已付金额Lable */
@property(nonatomic, weak) UILabel *receiptLable;
/** 提示button */
@property(nonatomic, weak) UIButton *promptButton;

/** 待支付标题 */
@property(nonatomic, weak) UILabel *waitPayTitelLable;
/** 待支付 */
@property(nonatomic, weak) UILabel *waitPayLable;



@property(nonatomic, strong)WL_Application_Driver_OrderDetail_Model *orderDetail;

@end
