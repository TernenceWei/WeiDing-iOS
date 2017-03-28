//
//  WL_UsuallyContactsList_Model.h
//  WeiLvDJS
//
//  Created by jyc on 2016/11/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"

@interface WL_UsuallyContactsList_Model : WL_BaseModel

@property(nonatomic,copy)NSString *isCompany;

@property(nonatomic,copy)NSString *isFriend;

@property(nonatomic,copy)NSString *photo;

@property(nonatomic,copy)NSString *real_name;

@property(nonatomic,copy)NSString *user_id;

@property(nonatomic,copy)NSString *user_mobile;

@property(nonatomic,copy)NSString *user_name;

@end
//{
//    isCompany = 0;
//    isFriend = 1;
//    photo = "http://dev.nawanr.com/uploads/app/userAdver/thumb/20161014/20161014113039.jpg";
//    "real_name" = xiaoming;
//    "user_id" = 9;
//    "user_mobile" = 18770008349;
//    "user_name" = 18770008349;
//},
