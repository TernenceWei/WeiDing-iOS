//
//  WL_AddressBook_OrganizationDetail_Model.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/12.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_OrganizationDetail_Model.h"

@implementation WL_AddressBook_OrganizationDetail_Model
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"description_content": @"description"};
}

@end
