//
//  WLChargeUpHeader.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLChargeUpShopObject.h"

@interface WLChargeUpHeader : UIView
- (instancetype)initWithFrame:(CGRect)frame
                 selectAction:(void(^)(WLChargeUpRoleObject *guideInfo))selectionAction;

@property (nonatomic, strong) NSArray *roleArray;
@end
