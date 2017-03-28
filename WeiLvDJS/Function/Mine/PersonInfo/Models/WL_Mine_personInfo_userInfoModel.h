//
//  WL_Mine_personInfo_userInfoModel.h
//  WeiLvDJS
//
//  Created by liuxin on 16/9/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WL_Mine_personInfo_userInfoModel : NSObject
@property (nonatomic,copy)NSString *avatar;
@property (nonatomic,assign) NSInteger gender;
@property (nonatomic,copy)NSString *note;
@property (nonatomic,copy)NSString *nickname;
@property (nonatomic,copy)NSString *username;
@property (nonatomic,copy)NSString *email;
@property (nonatomic,copy)NSString *country;
@property (nonatomic,copy)NSString *province;
@property (nonatomic,copy)NSString *city;
@property (nonatomic,copy)NSString *area;

@property (nonatomic, strong) NSArray *companyArray;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

@interface WL_Mine_personInfo_CompanyInfoModel : NSObject
@property (nonatomic,copy)NSString *company_name;
@property (nonatomic,copy)NSString *position_name;
@property (nonatomic,copy)NSString *mobile;
@property (nonatomic,copy)NSString *department_name;
@property (nonatomic,copy)NSString *staff_name;
@property (nonatomic,copy)NSString *logo_base_url;
@property (nonatomic,copy)NSString *logonail_path;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
