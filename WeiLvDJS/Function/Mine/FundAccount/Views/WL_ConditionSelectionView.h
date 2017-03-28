//
//  WL_ConditionSelectionView.h
//  WeiLvDJS
//
//  Created by jyc on 16/9/18.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseView.h"

@interface WL_ConditionSelectionView : WL_BaseView

@property(nonatomic,copy)void(^confirmButtonClick)(UIButton * button);

@property(nonatomic,copy)void (^tapBlock)();

@end
