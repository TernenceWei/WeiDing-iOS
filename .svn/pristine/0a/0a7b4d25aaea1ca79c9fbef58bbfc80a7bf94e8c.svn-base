//
//  MJExtensionConfig.m
//  WeiLv
//
//  Created by James on 16/5/12.
//  Copyright © 2016年 WeiLv Technology. All rights reserved.
//

#import "MJExtensionConfig.h"
@implementation MJExtensionConfig
/**
 *  这个方法会在MJExtensionConfig加载进内存时调用一次
 */
+ (void)load
{
#pragma mark 如果使用NSObject来调用这些方法，代表所有继承自NSObject的类都会生效
#pragma mark NSObject中的ID属性对应着字典中的id
    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID" : @"id",@"leave_amount_new":@"new_leave_amount",@"other": @"#"
                 };
    }];
}
@end
