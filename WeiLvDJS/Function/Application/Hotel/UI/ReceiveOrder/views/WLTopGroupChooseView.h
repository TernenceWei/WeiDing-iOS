//
//  WLTopGroupChooseView.h
//  WeiLvDJS
//
//  Created by hsliang on 2016/11/15.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLTopGroupChooseView : UIView

- (instancetype)initWithFrame:(CGRect)frame textArray:(NSArray *)textArray selectAction:(void(^)(NSUInteger index))selectAction;

@end
