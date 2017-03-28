//
//  WL_Application_Driver_BillList_Cell.h
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/4.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLDriverBillListObject.h"

@interface WL_Application_Driver_BillList_Cell : UITableViewCell

/** 待付款金额Lable */
@property(nonatomic, weak)UILabel *nonPayLable;
/** 待付款标题Lable */
@property(nonatomic, weak)UILabel *nonPayTitleLable;

// tableView
+ (WL_Application_Driver_BillList_Cell *)cellCreateTableView:(UITableView *)tableView;

- (void)setCellModel:(WLDriverBillItemObject *)daModel stauts:(NSInteger)status;

@end
