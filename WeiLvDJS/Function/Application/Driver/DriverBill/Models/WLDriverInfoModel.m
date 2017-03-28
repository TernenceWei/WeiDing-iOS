//
//  WLDriverInfoModel.m
//  WeiLvDJS
//
//  Created by hsliang on 2016/12/29.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLDriverInfoModel.h"
#import "NSDictionary+DefaultValue.h"

@implementation WLDriverInfoModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.this_id         = [dict objectForKey:@"id" defaultValue:@"0"];
    self.user_id         = [dict objectForKey:@"user_id" defaultValue:@"0"];
    self.company_id      = [dict objectForKey:@"company_id" defaultValue:@"0"];
    self.name            = [dict objectForKey:@"name" defaultValue:@"0"];
    self.birthday        = [dict objectForKey:@"birthday" defaultValue:@"0"];
    self.gender          = [[dict objectForKey:@"gender" defaultValue:@""] integerValue];
    self.mobile          = [dict objectForKey:@"mobile" defaultValue:@"0"];
    self.province_id     = [dict objectForKey:@"province_id" defaultValue:@"0"];
    self.city_id         = [dict objectForKey:@"city_id" defaultValue:@"0"];
    self.address         = [dict objectForKey:@"address" defaultValue:@"0"];
    self.id_card         = [dict objectForKey:@"id_card" defaultValue:@"0"];
    self.driving_license = [dict objectForKey:@"driving_license" defaultValue:@"0"];
    self.body_name       = [dict objectForKey:@"body_name" defaultValue:@"0"];
    self.memo            = [dict objectForKey:@"memo" defaultValue:@"0"];
    self.auditor_id      = [dict objectForKey:@"auditor_id" defaultValue:@"0"];
    self.audit_status    = [dict objectForKey:@"audit_status" defaultValue:@"0"];
    self.audit_at        = [dict objectForKey:@"audit_at" defaultValue:@"0"];
    self.audit_memo      = [dict objectForKey:@"audit_memo" defaultValue:@"0"];
    self.is_disabled     = [dict objectForKey:@"is_disabled" defaultValue:@"0"];
    self.created_at      = [dict objectForKey:@"created_at" defaultValue:@"0"];
    self.updated_at      = [dict objectForKey:@"updated_at" defaultValue:@"0"];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self == [super init]) {
        self.this_id = [aDecoder decodeObjectForKey:@"id"];
        self.user_id = [aDecoder decodeObjectForKey:@"user_id"];
        self.company_id = [aDecoder decodeObjectForKey:@"company_id"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.birthday = [aDecoder decodeObjectForKey:@"birthday"];
        self.gender = [[aDecoder decodeObjectForKey:@"gender"] integerValue];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.province_id = [aDecoder decodeObjectForKey:@"province_id"];
        self.city_id = [aDecoder decodeObjectForKey:@"city_id"];
        self.address = [aDecoder decodeObjectForKey:@"address"];
        self.id_card = [aDecoder decodeObjectForKey:@"id_card"];
        self.driving_license = [aDecoder decodeObjectForKey:@"driving_license"];
        self.body_name = [aDecoder decodeObjectForKey:@"body_name"];
        self.memo = [aDecoder decodeObjectForKey:@"memo"];
        self.auditor_id = [aDecoder decodeObjectForKey:@"auditor_id"];
        self.audit_status = [aDecoder decodeObjectForKey:@"audit_status"];
        self.audit_at = [aDecoder decodeObjectForKey:@"audit_at"];
        self.audit_memo = [aDecoder decodeObjectForKey:@"audit_memo"];
        self.is_disabled = [aDecoder decodeObjectForKey:@"is_disabled"];
        self.created_at = [aDecoder decodeObjectForKey:@"created_at"];
        self.updated_at = [aDecoder decodeObjectForKey:@"updated_at"];
        
        
        self.IDFrontImg = [aDecoder decodeObjectForKey:@"IDFrontImg"];
        self.IDBackImg = [aDecoder decodeObjectForKey:@"IDBackImg"];
        self.cardIDFrontImg = [aDecoder decodeObjectForKey:@"cardIDFrontImg"];
        self.cardIDBackImg = [aDecoder decodeObjectForKey:@"cardIDBackImg"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.this_id forKey:@"id"];
    [aCoder encodeObject:self.user_id forKey:@"user_id"];
    [aCoder encodeObject:self.company_id forKey:@"company_id"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.birthday forKey:@"birthday"];
    [aCoder encodeObject:[NSNumber numberWithInteger:self.gender] forKey:@"gender"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.province_id forKey:@"province_id"];
    [aCoder encodeObject:self.city_id forKey:@"city_id"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.id_card forKey:@"id_card"];
    [aCoder encodeObject:self.driving_license forKey:@"driving_license"];
    [aCoder encodeObject:self.body_name forKey:@"body_name"];
    [aCoder encodeObject:self.memo forKey:@"memo"];
    [aCoder encodeObject:self.auditor_id forKey:@"auditor_id"];
    [aCoder encodeObject:self.audit_status forKey:@"audit_status"];
    [aCoder encodeObject:self.audit_at forKey:@"audit_at"];
    [aCoder encodeObject:self.audit_memo forKey:@"audit_memo"];
    [aCoder encodeObject:self.is_disabled forKey:@"is_disabled"];
    [aCoder encodeObject:self.created_at forKey:@"created_at"];
    [aCoder encodeObject:self.updated_at forKey:@"updated_at"];
    
    [aCoder encodeObject:self.IDFrontImg forKey:@"IDFrontImg"];
    [aCoder encodeObject:self.IDBackImg forKey:@"IDBackImg"];
    [aCoder encodeObject:self.cardIDFrontImg forKey:@"cardIDFrontImg"];
    [aCoder encodeObject:self.cardIDBackImg forKey:@"cardIDBackImg"];
}

- (WLDriverInfoModel *)description
{
    return self;
}

@end

@implementation WLDriverInfoImgModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.this_Id         = [dict objectForKey:@"id" defaultValue:@"0"];
    self.file_type       = [[dict objectForKey:@"file_type" defaultValue:@"0"] floatValue];
    self.base_url        = [dict objectForKey:@"base_url" defaultValue:@"0"];
    self.path            = [dict objectForKey:@"path" defaultValue:@"0"];
    self.name            = [dict objectForKey:@"name" defaultValue:@"0"];
    
    return self;
}

@end

@implementation WLDriverInfoDataModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.opt_status    = [dict objectForKey:@"opt_status" defaultValue:@"0"];
    self.province      = [dict objectForKey:@"province" defaultValue:@"0"];
    self.city          = [dict objectForKey:@"city" defaultValue:@"0"];
    
    self.InfoDic       = [dict objectForKey:@"driver_info" defaultValue:@"0"];
    
    NSArray *ImgArray = [dict objectForKey:@"imgs" defaultValue:[NSArray array]];
    NSMutableArray *objectTrendArray = [NSMutableArray array];
    if ([ImgArray isKindOfClass:[NSArray class]]) {
        
        for (NSDictionary *dict in ImgArray) {
            WLDriverInfoImgModel *object = [[WLDriverInfoImgModel alloc] initWithDict:dict];
            [objectTrendArray addObject:object];
        }
        self.ImgArray = [objectTrendArray copy];
    }
    
    return self;
}

@end
