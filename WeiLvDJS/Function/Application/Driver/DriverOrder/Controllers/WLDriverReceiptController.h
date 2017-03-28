//
//  WLDriverReceiptController.h
//  WeiLvDJS
//
//  Created by ternence on 2016/12/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WL_BaseViewController.h"

typedef NS_ENUM(NSInteger, WLFromController){
    /**接单控制器 */
    WLFromAcceptController         = 10,
    /**< 订单详情控制器 */
    WLFromDetailController
};

@interface WLDriverReceiptController : WL_BaseViewController
/**< 订单金额 */
@property (nonatomic, copy) NSString *orderPrice;
@property (nonatomic, copy) NSString *orderID;
@property (nonatomic, assign) WLFromController fromControllerType;
@end
