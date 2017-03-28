//
//  WL_AddressBook_SearchResult_Contact_Model.h
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/21.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"

@interface WL_AddressBook_SearchResult_Contact_Model : WL_BaseModel
/** 好友id */
@property(nonatomic, copy) NSString *ID;

/** 好友昵称 */
@property(nonatomic, copy) NSString *name;

/** 好友头像 */
@property(nonatomic, copy) NSString *photo;

/** type*/
@property(nonatomic, copy) NSString *type;
/** 是否同组织 */
@property(nonatomic, copy) NSString *isCompany;
/** 好友电话号码 */
@property(nonatomic, copy) NSString *mobile;

@end
