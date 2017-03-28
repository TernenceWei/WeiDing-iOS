//
//  WLCityItem.h
//  WeiLvDJS
//
//  Created by ternence on 2017/1/5.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLCityItem : NSObject
@property (nonatomic,copy) NSString *provinceID;
@property (nonatomic,copy) NSString *cityID;
@property (nonatomic,copy) NSString *cityName;
@property (nonatomic,strong) NSArray *cityItems;
- (instancetype)initWithDict:(NSDictionary *)dict type:(NSString *)type;
@end
