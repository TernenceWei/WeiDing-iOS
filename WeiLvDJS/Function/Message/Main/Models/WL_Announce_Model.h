//
//  WL_Announce_Model.h
//  WeiLvDJS
//
//  Created by jyc on 2016/11/19.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"

@interface WL_Announce_Model : WL_BaseModel

@property (nonatomic,copy) NSString *company_name;
@property (nonatomic,copy) NSString *create_date;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *notice_id;
@property(nonatomic,copy)NSString *cover_url;

@end
