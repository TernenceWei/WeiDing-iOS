//
//  WLChargeUpObject.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WLChargeUpObject : NSObject
@property (nonatomic, copy)   NSString *resourceID;
@property (nonatomic, copy)   NSString *checklistID;
@property (nonatomic, copy)   NSString *groupID;

@property (nonatomic, copy)   NSString *actualPrice;//实际总价
@property (nonatomic, copy)   NSString *remark;

@property (nonatomic, copy)   NSString *whichDate;//入住日期
@property (nonatomic, copy)   NSString *actualPerson;//实际人数
@property (nonatomic, strong) NSArray *priceList;

@property (nonatomic, strong) UIImage *image1;
@property (nonatomic, strong) UIImage *image2;
@property (nonatomic, strong) UIImage *image3;
@property (nonatomic, strong) UIImage *image4;
@property (nonatomic, strong) UIImage *image5;

@property (nonatomic, strong) NSArray *uploadImgArray;

@end
