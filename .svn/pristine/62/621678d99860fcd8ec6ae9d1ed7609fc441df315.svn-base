//
//  WLDriverInfoModel.h
//  WeiLvDJS
//
//  Created by hsliang on 2016/12/29.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLDriverInfoModel : NSObject<NSCoding>

@property (nonatomic,copy) NSString *this_id;
@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *company_id;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *birthday;
@property (nonatomic,assign) NSInteger  gender;
@property (nonatomic,copy) NSString *mobile;
@property (nonatomic,copy) NSString *province_id;
@property (nonatomic,copy) NSString *city_id;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *id_card;
@property (nonatomic,copy) NSString *driving_license;
@property (nonatomic,copy) NSString *body_name;
@property (nonatomic,copy) NSString *memo;
@property (nonatomic,copy) NSString *auditor_id;
@property (nonatomic,copy) NSString *audit_status;
@property (nonatomic,copy) NSString *audit_at;
@property (nonatomic,copy) NSString *audit_memo;
@property (nonatomic,copy) NSString *is_disabled;
@property (nonatomic,copy) NSString *created_at;
@property (nonatomic,copy) NSString *updated_at;

@property (nonatomic, strong) UIImage *IDFrontImg;
@property (nonatomic, strong) UIImage *IDBackImg;
@property (nonatomic, strong) UIImage *cardIDFrontImg;
@property (nonatomic, strong) UIImage *cardIDBackImg;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end

@interface WLDriverInfoImgModel : NSObject

@property (nonatomic,copy) NSString *this_Id;
@property (nonatomic,assign) CGFloat file_type;
@property (nonatomic,copy) NSString *base_url;
@property (nonatomic,copy) NSString *path;
@property (nonatomic,copy) NSString *name;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end

@interface WLDriverInfoDataModel : NSObject

@property (nonatomic,copy) NSString *opt_status;
@property (nonatomic,copy) NSString *province;
@property (nonatomic,copy) NSString *city;

@property (nonatomic, strong) NSDictionary *InfoDic;
@property (nonatomic, strong) NSArray *ImgArray;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
