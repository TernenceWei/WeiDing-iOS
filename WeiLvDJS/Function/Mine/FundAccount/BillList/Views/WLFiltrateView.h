//
//  WLFiltrateView.h
//  WeiLvDJS
//
//  Created by hsliang on 2016/12/29.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLFiltrateView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                    textArray:(NSArray *)textArray
                 selectAction:(void(^)(NSUInteger index))selectAction;

@end
