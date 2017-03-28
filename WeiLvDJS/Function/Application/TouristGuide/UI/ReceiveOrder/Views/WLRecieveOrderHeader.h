//
//  WLRecieveOrderHeader.h
//  WeiLvDJS
//
//  Created by whw on 16/10/25.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLTouristGroupHeader.h"

@interface WLRecieveOrderHeader : UIView
- (instancetype)initWithFrame:(CGRect)frame textArray:(NSArray *)textArray selectAction:(void(^)(NSUInteger index))selectAction;
@end
