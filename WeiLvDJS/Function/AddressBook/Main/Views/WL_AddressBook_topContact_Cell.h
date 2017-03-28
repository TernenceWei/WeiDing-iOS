//
//  WL_AddressBook_topContact_Cell.h
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/10/27.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WL_TopContact_Model;
@interface WL_AddressBook_topContact_Cell : UITableViewCell

/** Cell的底部分隔线View */
@property (nonatomic, weak) UIView *lineView;

/** cell绑定的联系人的id */
@property(nonatomic, copy) NSString *view_id;
/** cell绑定的是否同组织 */
@property(nonatomic, copy) NSString *isCompany;

@property(nonatomic, strong) WL_TopContact_Model *topContact;
@end
