//
//  WLBindCardObject.h
//  WeiLvDJS
//
//  Created by ternence on 2017/1/17.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLBindCardObject : NSObject


@property (nonatomic,copy) NSString *bank_name;
@property (nonatomic,copy) NSString *bank_number;
@property (nonatomic,copy) NSString *branch_name;
@property (nonatomic,copy) NSString *city_name;
@property (nonatomic,copy) NSString *id_card;
@property (nonatomic,copy) NSString *real_name;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
