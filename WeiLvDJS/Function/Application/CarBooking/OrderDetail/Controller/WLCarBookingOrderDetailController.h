//
//  WLCarBookingOrderDetailController.h
//  WeiLvDJS
//
//  Created by ternence on 2017/1/20.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseViewController.h"

@interface WLCarBookingOrderDetailController : WL_BaseViewController

@property (nonatomic, strong) NSString *orderID;
@property (nonatomic, assign) BOOL iSAffirm;
@property (nonatomic, assign) BOOL iSAddCost;

@end
