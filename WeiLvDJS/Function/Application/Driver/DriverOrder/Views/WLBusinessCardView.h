//
//  WLBusinessCardView.h
//  WeiLvDJS
//
//  Created by ternence on 2016/12/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLBusinessCardView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                    textArray:(NSArray *)textArray
              phoneCallAction:(void(^)(NSString *phoneNO))phoneCallAction
                 cancelAction:(void(^)())cancelAction;

@end
