//
//  WLCarBookingEditInfoController.h
//  WeiLvDJS
//
//  Created by ternence on 2017/1/19.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLCarBookingEditInfoController : WL_BaseViewController

- (void)setSaveAction:(void(^)(NSString *firstTitle, NSString *secondTitle))saveAction
               remark:(BOOL)remark;

- (void)setOriginalName:(NSString *)name phone:(NSString *)phone;

@end
