//
//  WL_AddressBook_SearchResult_Company_Model.h
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/23.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"

@interface WL_AddressBook_SearchResult_Company_Model : WL_BaseModel

/**
 id = 3;
 name = xiaoming123456;
 photo = "http://dev.nawanr.com/uploads/company/logo/20161114/582955bc18ada.jpg";
 type = 1;
 */
/** company_id */
@property(nonatomic, copy) NSString *ID;

/** 公司名 */
@property(nonatomic, copy) NSString *name;

/** 公司logo */
@property(nonatomic, copy) NSString *photo;

/** type */
@property(nonatomic, copy) NSString *type;



@end
