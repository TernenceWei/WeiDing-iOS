//
//  WLTouristGuideInfo.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/9.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLTouristFileObject : NSObject<NSMutableCopying>
@property (nonatomic, copy)   NSString *fileID;
@property (nonatomic, copy)   NSString *fileUrl;
@property (nonatomic, copy)   NSString *smallFileUrl;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end


@interface WLTouristGuideInfo : NSObject<NSMutableCopying,NSCoding>
@property (nonatomic, copy)   NSString *guideID;
@property (nonatomic, copy)   NSString *guideName;
@property (nonatomic, copy)   NSString *birthday;
@property (nonatomic, assign) NSUInteger sex;
@property (nonatomic, copy)   NSString *mobileNO;
@property (nonatomic, copy)   NSString *province;
@property (nonatomic, copy)   NSString *city;
@property (nonatomic, copy)   NSString *area;
@property (nonatomic, copy)   NSString *provinceID;
@property (nonatomic, copy)   NSString *cityID;
@property (nonatomic, copy)   NSString *areaID;
@property (nonatomic, copy)   NSString *IDNO;
@property (nonatomic, copy)   NSString *address;
@property (nonatomic, assign) NSUInteger level;  //导游级别//1=初级，2=中级，3=高级
@property (nonatomic, copy)   NSString *cardNO;
@property (nonatomic, assign) NSUInteger workYears;
@property (nonatomic, copy)   NSString *language;
@property (nonatomic, copy)   NSString *remark;
@property (nonatomic, copy)   NSString *type;

@property (nonatomic, strong) NSMutableArray *priceList;/*WLPriceListObject*/
@property (nonatomic, strong) NSArray *IDCardImg;/*WLTouristFileObject*/
@property (nonatomic, strong) NSArray *guideCardImg;/*WLTouristFileObject*/
@property (nonatomic, assign) BOOL isRunning;

//用于上传导游信息时携带数据
@property (nonatomic, strong) UIImage *IDFrontImg;
@property (nonatomic, strong) UIImage *IDBackImg;
@property (nonatomic, strong) UIImage *cardIDFrontImg;
@property (nonatomic, strong) UIImage *cardIDBackImg;
@property (nonatomic, strong) NSString *delFileID;//用于删除图片时使用
@property (nonatomic, strong) NSString *delPriceID;//用于删除报价时使用
- (instancetype)initWithDict:(NSDictionary*)dict;
- (NSMutableDictionary *)getDict;
@end
