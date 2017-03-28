//
//  WL_PrivateDetail_Model.h
//  WeiLvDJS
//
//  Created by jyc on 2016/11/10.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"

@interface WL_userInfo_Model : WL_BaseModel

@property(nonatomic,copy)NSString *photo;
@property(nonatomic,copy)NSString *real_name;
@property(nonatomic,copy)NSString *user_name;


@end

@interface WL_authorInfo_Model : WL_BaseModel

@property(nonatomic,copy)NSString *author_id;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *create_date;
@property(nonatomic,copy)NSString *letter_private_id;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,strong)WL_userInfo_Model *userInfo;

@end


@interface WL_PrivateDetail_Model : WL_BaseModel

@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *create_date;
@property(nonatomic,copy)NSString *creator_id;
@property(nonatomic,copy)NSString *last_reply_date;
@property(nonatomic,copy)NSString *letter_private_id;
@property(nonatomic,strong)NSMutableArray *reply;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,strong)WL_userInfo_Model *userInfo;

@end






