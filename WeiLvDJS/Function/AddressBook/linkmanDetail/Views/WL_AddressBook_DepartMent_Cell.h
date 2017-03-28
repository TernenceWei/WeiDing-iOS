//
//  WL_AddressBook_DepartMent_Cell.h
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/10.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WL_AddressBook_LinkMan_Department_Model;
@class WL_AddressBook_LinkMan_Company_Model;
@interface WL_AddressBook_DepartMent_Cell : UITableViewCell
/**  标题Lable */
@property(nonatomic, weak) UILabel *titleLable;

/**  信息Lable */
@property(nonatomic, weak) UILabel *messageLable;

/** 底部分隔线 */
@property(nonatomic, weak) UIView *lineView;

/** 组织模型 */
@property(nonatomic, strong) WL_AddressBook_LinkMan_Department_Model *departmentModel;
/** 公司模型 */
@property(nonatomic, strong) WL_AddressBook_LinkMan_Company_Model *companyModel;


@end
