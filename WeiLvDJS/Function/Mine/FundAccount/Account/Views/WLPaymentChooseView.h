//
//  WLPaymentChooseView.h
//  WeiLvDJS
//
//  Created by ternence on 2017/1/16.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLPaymentChooseView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                  clickAction:(void(^)(NSUInteger index))clickAction
                 cancelAction:(void(^)())cancelAction;
@end
