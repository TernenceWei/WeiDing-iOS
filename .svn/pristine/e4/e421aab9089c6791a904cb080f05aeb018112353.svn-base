//
//  WL_Mine_personInfo_userInfoModel.m
//  WeiLvDJS
//
//  Created by liuxin on 16/9/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Mine_personInfo_userInfoModel.h"
#import "NSDictionary+DefaultValue.h"

@implementation WL_Mine_personInfo_userInfoModel

- (instancetype)initWithDict:(NSDictionary *)dic
{
    self = [super init];

    //[self setValuesForKeysWithDictionary:dic];
    self.avatar         = [dic objectForKey:@"avatar" defaultValue:@"0"];
    self.note           = [dic objectForKey:@"note" defaultValue:@"0"];
    self.nickname       = [dic objectForKey:@"nickname" defaultValue:@"0"];
    self.username       = [dic objectForKey:@"username" defaultValue:@"0"];
    self.email          = [dic objectForKey:@"email" defaultValue:@"0"];
    self.gender         = [[dic objectForKey:@"gender" defaultValue:@"0"] integerValue];
    self.country    = [dic objectForKey:@"country" defaultValue:@"0"];
    self.province    = [dic objectForKey:@"province" defaultValue:@"0"];
    self.city    = [dic objectForKey:@"city" defaultValue:@"0"];
    self.area    = [dic objectForKey:@"area" defaultValue:@"0"];
    
    NSArray *ImgArray = [dic objectForKey:@"my_company" defaultValue:[NSArray array]];
    NSMutableArray *objectTrendArray = [NSMutableArray array];
    if ([ImgArray isKindOfClass:[NSArray class]]) {
        
        for (NSDictionary *dict in ImgArray) {
            WL_Mine_personInfo_CompanyInfoModel *object = [[WL_Mine_personInfo_CompanyInfoModel alloc] initWithDict:dict];
            [objectTrendArray addObject:object];
        }
        self.companyArray = [objectTrendArray copy];
    }

    return self;
}

@end


@implementation WL_Mine_personInfo_CompanyInfoModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.company_name         = [dict objectForKey:@"company_name" defaultValue:@"0"];
    self.position_name        = [dict objectForKey:@"position_name" defaultValue:@"0"];
    self.mobile               = [dict objectForKey:@"mobile" defaultValue:@"0"];
    self.department_name      = [dict objectForKey:@"department_name" defaultValue:@"0"];
    self.staff_name           = [dict objectForKey:@"staff_name" defaultValue:@"0"];
    self.logo_base_url      = [dict objectForKey:@"logo_base_url" defaultValue:@"0"];
    self.logonail_path           = [dict objectForKey:@"logonail_path" defaultValue:@"0"];
    
    return self;
}

@end
