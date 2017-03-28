//
//  WL_UserInfo_Model.h
//  WeiLvDJS
//
//  Created by zhaoxiao on 16/9/1.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"

@interface WL_UserInfo_Model : WL_BaseModel

/** 会员 id */
@property(nonatomic, copy) NSString *user_id;

/** 用户名 */
@property(nonatomic, copy) NSString *user_name;

/** 真实姓名 */
@property(nonatomic, copy) NSString *real_name;

/** 身份证号 */
@property(nonatomic, copy) NSString *id_card;

/** 用户电话 */
@property(nonatomic, copy) NSString *user_mobile;

/** 性别 0：女 1：男 2：未知 */
@property(nonatomic, copy) NSString *sex;

/** 用户头像 */
@property(nonatomic, copy) NSString *photo;

/** 融云 token */
@property(nonatomic ,copy) NSString *ry_token;

/** 融云 token有效期 */
@property(nonatomic ,copy) NSString *ry_token_expires;

/** 用户类型 */
@property(nonatomic ,copy) NSString *user_type;

/** 职位名称 */
@property(nonatomic ,copy) NSString *position_name;

/** 实名认证 */
@property(nonatomic ,copy) NSString *is_validata;


@end
