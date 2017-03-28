//
//  WL_AddressBook_NewFriend_Model.h
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/15.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"
@class WL_AddressBook_NewFriend_Company_Model;

@interface WL_AddressBook_NewFriend_Model : WL_BaseModel

/** 头像 */
@property(nonatomic, copy) NSString *adver;
/** 创建日期 */
@property(nonatomic, copy) NSString *create_date;
/** 邀请方的id */
@property(nonatomic, copy) NSString *from_user_id;
/** 邀请方的电话 */
@property(nonatomic, copy) NSString *from_user_mobile;
/** is_delete */
@property(nonatomic, copy) NSString *is_delete;
/** 申请记录的唯一标示 */
@property(nonatomic, copy) NSString *message_id;
/** 申请内容 */
@property(nonatomic, copy) NSString *msg_content;
/** 1 添加好友消息 ，2 申请加群消息,3 平台消息 */
@property(nonatomic, copy) NSString *msg_type;
/** relation_id */
@property(nonatomic, copy) NSString *relation_id;
/** 状态// 0 未读|未认证，1 已读|已认证 */
@property(nonatomic, copy) NSString *status;
/** 受邀方的ID */
@property(nonatomic, copy) NSString *to_object_id;

/** 受邀方的电话号码 */
@property(nonatomic, copy) NSString *to_object_mobile;
/** update_date */
@property(nonatomic, copy) NSString *update_date;
/**请求方的user_id */
@property(nonatomic, copy) NSString *user_id;
/** 邀请方的昵称 */
@property(nonatomic, copy) NSString *user_name;
/** 公司信息 */
@property(nonatomic, strong) WL_AddressBook_NewFriend_Company_Model *companyInfo;

/** 是否同组织 */
@property(nonatomic, weak) NSString *isCompany;
@end
