//
//  WLApplicationDriverAcceptOrderSettingController.h
//  WeiLvDJS
//
//  Created by whw on 17/2/23.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseViewController.h"

@interface WLApplicationDriverAcceptOrderSettingController : WL_BaseViewController
@property (nonatomic, copy) void(^settingCallBack)(BOOL isAccept,NSString *leastPeople);/**< 设置的回调 */
@end
