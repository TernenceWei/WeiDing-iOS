//
//  WL_Application_Driver_ Jockey_ViewController.h
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/18.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  [应用] --> [司机] --> [司机] 控制器

#import "WL_BaseViewController.h"

@interface WL_Application_Driver_Jockey_ViewController : WL_BaseViewController
@property(nonatomic,copy)NSString *comPany_id;
@property(nonatomic,assign) WLDriverStatus driverStatus;
@end
