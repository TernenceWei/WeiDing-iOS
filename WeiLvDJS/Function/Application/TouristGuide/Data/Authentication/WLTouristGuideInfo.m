//
//  WLTouristGuideInfo.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/9.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLTouristGuideInfo.h"
#import "NSDictionary+DefaultValue.h"
#import "WLPriceListObject.h"

@implementation WLTouristFileObject

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.fileID            = [dict objectForKey:@"file_manager_id" defaultValue:@"0"];
    self.fileUrl           = [dict objectForKey:@"file_url" defaultValue:@"0"];
    self.smallFileUrl      = [dict objectForKey:@"file_small_url" defaultValue:@"0"];
    
    return self;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    WLTouristFileObject *object = [[[self class] allocWithZone:zone] init];
    object.fileID = self.fileID;
    object.fileUrl = self.fileUrl;
    object.smallFileUrl = self.smallFileUrl;
    return object;

}

@end

@implementation WLTouristGuideInfo
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    NSDictionary *guideInfo = [dict objectForKey:@"guideInfo"];
    
    self.guideID             = [guideInfo objectForKey:@"guide_id" defaultValue:@"0"];
    self.guideName           = [guideInfo objectForKey:@"guide_name" defaultValue:@"0"];
    self.sex                 = [[guideInfo objectForKey:@"sex" defaultValue:@"0"] integerValue];
    self.birthday            = [guideInfo objectForKey:@"birthday" defaultValue:@"0"];
    self.mobileNO            = [guideInfo objectForKey:@"mobile" defaultValue:@"0"];
    self.IDNO                = [guideInfo objectForKey:@"id_card" defaultValue:@"0"];
    self.cardNO              = [guideInfo objectForKey:@"guide_card" defaultValue:@"0"] ;
    self.level               = [[guideInfo objectForKey:@"level" defaultValue:@"0"] integerValue];
    self.language            = [guideInfo objectForKey:@"language" defaultValue:@"0"];
    self.workYears           = [[guideInfo objectForKey:@"work_years" defaultValue:@"0"] integerValue];
    self.remark              = [guideInfo objectForKey:@"remark" defaultValue:@"0"];
    self.provinceID          = [guideInfo objectForKey:@"province_id" defaultValue:@"0"];
    self.cityID              = [guideInfo objectForKey:@"city_id" defaultValue:@"0"];
    self.areaID              = [guideInfo objectForKey:@"area_id" defaultValue:@"0"];
    self.province            = [guideInfo objectForKey:@"province" defaultValue:@"0"];
    self.city                = [guideInfo objectForKey:@"city" defaultValue:@"0"];
    self.area                = [guideInfo objectForKey:@"area" defaultValue:@"0"];
    self.address             = [guideInfo objectForKey:@"address" defaultValue:@"0"];
    self.type                = [guideInfo objectForKey:@"type" defaultValue:@"0"];
    self.isRunning           = [[dict objectForKey:@"is_running" defaultValue:@"0"] boolValue];
    NSArray *dictArray0 = [dict objectForKey:@"idCardImg"];
    NSMutableArray *objectArray0 = [NSMutableArray array];
    for (NSDictionary *dict in dictArray0) {
        WLTouristFileObject *object = [[WLTouristFileObject alloc] initWithDict:dict];
        [objectArray0 addObject:object];
    }
    self.IDCardImg = [objectArray0 copy];
    
    NSArray *dictArray1 = [dict objectForKey:@"guideImg"];
    NSMutableArray *objectArray1 = [NSMutableArray array];
    for (NSDictionary *dict in dictArray1) {
        WLTouristFileObject *object = [[WLTouristFileObject alloc] initWithDict:dict];
        [objectArray1 addObject:object];
    }
    self.guideCardImg = [objectArray1 copy];
    
    NSArray *dictArray = [dict objectForKey:@"priceList"];
    NSMutableArray *objectArray = [NSMutableArray array];
    for (NSDictionary *dict in dictArray) {
        WLPriceListObject *object = [[WLPriceListObject alloc] initWithDict:dict];
        [objectArray addObject:object];
    }
    self.priceList = [objectArray copy];
    
    return self;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    WLTouristGuideInfo *object = [[[self class] allocWithZone:zone] init];
    object.guideID = self.guideID;
    object.guideName = self.guideName;
    object.birthday = self.birthday;
    object.sex = self.sex;
    object.mobileNO = self.mobileNO;
    object.province = self.province;
    object.city = self.city;
    object.area = self.area;
    object.IDNO = self.IDNO;
    object.address = self.address;
    object.level = self.level;
    object.cardNO = self.cardNO;
    object.workYears = self.workYears;
    object.language = self.language;
    object.remark = self.remark;
    
    object.priceList = self.priceList;
    object.IDCardImg = self.IDCardImg;
    object.guideCardImg = self.guideCardImg;
    object.IDFrontImg = self.IDFrontImg;
    object.IDBackImg = self.IDBackImg;
    object.cardIDFrontImg = self.cardIDFrontImg;
    object.cardIDBackImg = self.cardIDBackImg;
    object.delFileID = self.delFileID;
    object.delPriceID = self.delPriceID;
    return object;
}

- (NSMutableDictionary *)getDict
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (self.guideID != nil) {//新建的时候没有guideID,编辑的时候有
        [dict setObject:self.guideID forKey:@"guide_id"];
    }
    [dict setObject:self.guideName forKey:@"guide_name"];
    [dict setObject:[NSString stringWithFormat:@"%ld",self.sex] forKey:@"sex"];
    [dict setObject:self.birthday forKey:@"birthday"];
    [dict setObject:self.mobileNO forKey:@"mobile"];
    [dict setObject:self.province forKey:@"province_id"];
    [dict setObject:self.city forKey:@"city_id"];
    [dict setObject:self.area forKey:@"area_id"];
    [dict setObject:self.IDNO forKey:@"id_card"];
    [dict setObject:self.address forKey:@"address"];
    [dict setObject:[NSString stringWithFormat:@"%ld",self.level] forKey:@"level"];
    [dict setObject:self.cardNO forKey:@"guide_card"];
    [dict setObject:[NSString stringWithFormat:@"%ld",self.workYears] forKey:@"work_years"];
    [dict setObject:self.language forKey:@"language"];
    [dict setObject:self.remark forKey:@"remark"];
    
    NSMutableArray *dictArray = [NSMutableArray array];
    for (WLPriceListObject *object in self.priceList) {
        
        [dictArray addObject:[self getPriceString:object]];
    }
    [dict setObject:[dictArray copy] forKey:@"pricelist"];
    return dict;
    
}

- (NSString *)getPriceString:(WLPriceListObject *)object
{
    if (object.priceID == nil) {
        object.priceID = @"";
    }
    NSString *string = [object.priceID stringByAppendingString:@"|"];
    string = [[string stringByAppendingString:object.priceName] stringByAppendingString:@"|"];
    string = [[string stringByAppendingString:object.price] stringByAppendingString:@"|"];
    string = [string stringByAppendingString:object.unit];
    return string;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self == [super init]) {
        self.guideID = [aDecoder decodeObjectForKey:@"guideID"];
        self.guideName = [aDecoder decodeObjectForKey:@"guideName"];
        self.birthday = [aDecoder decodeObjectForKey:@"birthday"];
        self.sex = [[aDecoder decodeObjectForKey:@"sex"] integerValue];
        self.mobileNO = [aDecoder decodeObjectForKey:@"mobileNO"];
        self.province = [aDecoder decodeObjectForKey:@"province"];
        self.city = [aDecoder decodeObjectForKey:@"city"];
        self.area = [aDecoder decodeObjectForKey:@"area"];
        self.IDNO = [aDecoder decodeObjectForKey:@"IDNO"];
        self.address = [aDecoder decodeObjectForKey:@"address"];
        self.level = [[aDecoder decodeObjectForKey:@"level"] integerValue];
        self.cardNO = [aDecoder decodeObjectForKey:@"cardNO"];
        self.workYears = [[aDecoder decodeObjectForKey:@"workYears"] integerValue];
        self.language = [aDecoder decodeObjectForKey:@"language"];
        self.remark = [aDecoder decodeObjectForKey:@"remark"];
        self.isRunning = [aDecoder decodeObjectForKey:@"isRunning"];
        
        self.priceList = [aDecoder decodeObjectForKey:@"priceList"];
        
        self.IDFrontImg = [aDecoder decodeObjectForKey:@"IDFrontImg"];
        self.IDBackImg = [aDecoder decodeObjectForKey:@"IDBackImg"];
        self.cardIDFrontImg = [aDecoder decodeObjectForKey:@"cardIDFrontImg"];
        self.cardIDBackImg = [aDecoder decodeObjectForKey:@"cardIDBackImg"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.guideID forKey:@"guideID"];
    [aCoder encodeObject:self.guideName forKey:@"guideName"];
    [aCoder encodeObject:self.birthday forKey:@"birthday"];
    [aCoder encodeObject:[NSNumber numberWithInteger:self.sex] forKey:@"sex"];
    [aCoder encodeObject:self.mobileNO forKey:@"mobileNO"];
    [aCoder encodeObject:self.province forKey:@"province"];
    [aCoder encodeObject:self.city forKey:@"city"];
    [aCoder encodeObject:self.area forKey:@"area"];
    [aCoder encodeObject:self.IDNO forKey:@"IDNO"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:[NSNumber numberWithInteger:self.level] forKey:@"level"];
    [aCoder encodeObject:self.cardNO forKey:@"cardNO"];
    [aCoder encodeObject:[NSNumber numberWithInteger:self.workYears] forKey:@"workYears"];
    [aCoder encodeObject:self.language forKey:@"language"];
    [aCoder encodeObject:self.remark forKey:@"remark"];
    [aCoder encodeObject:[NSNumber numberWithBool:self.isRunning] forKey:@"isRunning"];
    
    [aCoder encodeObject:self.priceList forKey:@"priceList"];
    
    [aCoder encodeObject:self.IDFrontImg forKey:@"IDFrontImg"];
    [aCoder encodeObject:self.IDBackImg forKey:@"IDBackImg"];
    [aCoder encodeObject:self.cardIDFrontImg forKey:@"cardIDFrontImg"];
    [aCoder encodeObject:self.cardIDBackImg forKey:@"cardIDBackImg"];
}

- (WLTouristGuideInfo *)description
{
    return self;
}

@end
