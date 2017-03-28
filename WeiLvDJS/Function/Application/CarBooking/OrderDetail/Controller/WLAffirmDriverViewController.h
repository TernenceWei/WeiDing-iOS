//
//  WLAffirmDriverViewController.h
//  WeiLvDJS
//
//  Created by hsliang on 2017/2/27.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseViewController.h"
#import "WLCarBookingDriverObject.h"

@interface WLAffirmDriverViewController : WL_BaseViewController

@property (nonatomic, strong) NSString *orderID;
@property (nonatomic, assign) NSInteger remainTime;
@property (nonatomic, strong) WLCarBookingDriverObject *driverobject;

@end
