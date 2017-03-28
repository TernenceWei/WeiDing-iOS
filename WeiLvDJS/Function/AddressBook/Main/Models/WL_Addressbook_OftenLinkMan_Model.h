//
//  WL_Addressbook_ OftenLinkMan_Model.h
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/14.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"

@class WL_TopContact_Model;

@interface WL_Addressbook_OftenLinkMan_Model : WL_BaseModel

/** 常用联系人总个数 */
@property(nonatomic, copy) NSString *count;

/** 常用联系人列表 */
@property(nonatomic, strong) NSArray<WL_TopContact_Model *> *list;
@end
