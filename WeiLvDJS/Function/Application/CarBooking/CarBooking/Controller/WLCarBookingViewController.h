//
//  WLCarBookingViewController.h
//  WeiLvDJS
//
//  Created by ternence on 2017/1/19.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseViewController.h"
#import "WLCarBookingOrderDetailObject.h"

@interface WLCarBookingViewController : WL_BaseViewController

@property (nonatomic, strong) NSString *companyID;
@property (nonatomic, strong) WLCarBookingOrderDetailObject *fillObject;


@end
