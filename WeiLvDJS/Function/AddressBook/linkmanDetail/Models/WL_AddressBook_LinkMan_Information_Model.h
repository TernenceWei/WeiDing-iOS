//
//  WL_AddressBook_LinkMan_Information_Model.h
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/10.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"

@interface WL_AddressBook_LinkMan_Information_Model : WL_BaseModel
/** 地区 */
@property(nonatomic, copy) NSString *address;
/**  */
@property(nonatomic, copy) NSString *area_id;
/** 生日 */
@property(nonatomic, copy) NSString *birthday;
/**  */
@property(nonatomic, copy) NSString *create_date;
/**  */
@property(nonatomic, copy) NSString *email;
/**  */
@property(nonatomic, copy) NSString *id_card;
/** 是否好友 */
@property(nonatomic, copy) NSString *isFriend;
/**  */
@property(nonatomic, copy) NSString *is_protect;
/** 是否认证 */
@property(nonatomic, copy) NSString *is_validate;
/** 用户头像 */
@property(nonatomic, copy) NSString *photo;
/**  */
@property(nonatomic, copy) NSString *province_id;
/**  */
@property(nonatomic, copy) NSString *qrcode;
/** 真实姓名 */
@property(nonatomic, copy) NSString *real_name;
/** 备注名称 */
@property(nonatomic, copy) NSString *remarkName;
/**  */
@property(nonatomic, copy) NSString *ry_token;
/**  */
@property(nonatomic, copy) NSString *ry_token_expires;
/** 性别 */
@property(nonatomic, copy) NSString *sex;
/**  */
@property(nonatomic, copy) NSString *sso;
/**  */
@property(nonatomic, copy) NSString *status;
/**  */
@property(nonatomic, copy) NSString *update_date;
/** 用户id */
@property(nonatomic, copy) NSString *user_id;
/** 电话 */
@property(nonatomic, copy) NSString *user_mobile;
/** 昵称 */
@property(nonatomic, copy) NSString *user_name;
/**  */
@property(nonatomic, copy) NSString *user_salt;
/**  */
@property(nonatomic, copy) NSString *user_type;
/**  */
@property(nonatomic, copy) NSString *city_id;


@end
