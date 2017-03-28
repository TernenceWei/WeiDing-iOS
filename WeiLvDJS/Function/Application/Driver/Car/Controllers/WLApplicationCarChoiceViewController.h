//
//  WLApplicationCarChoiceViewController.h
//  WeiLvDJS
//
//  Created by whw on 17/1/10.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseViewController.h"

@interface WLApplicationCarChoiceViewController : WL_BaseViewController

@property (nonatomic, copy) void(^carChoiceBlock)(NSString *carType);
@end
