//
//  WL_CheckVersion.h
//  WeiLv
//
//  Created by James on 16/7/16.
//  Copyright © 2016年 WeiLv Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WL_CheckVersion : NSObject<UIAlertViewDelegate>

+ (void)showAlertWithAppStoreVersion:(NSString*)appStoreVersion;

+(void)checkVersion;

@end
