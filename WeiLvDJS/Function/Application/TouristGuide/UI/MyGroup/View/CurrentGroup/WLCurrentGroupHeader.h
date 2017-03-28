//
//  WLCurrentGroupHeader.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/14.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLTouristGroupHeader.h"

@interface WLCurrentGroupHeader : UIView
- (instancetype)initWithType:(TouristItemType)type
                  foldAction:(void(^)(BOOL isFold))action
                    selected:(BOOL)selected;
@end
