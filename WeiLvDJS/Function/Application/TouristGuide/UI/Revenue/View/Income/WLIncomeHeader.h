//
//  WLIncomeHeader.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLIncomeHeader : UIView
- (instancetype)initWithFrame:(CGRect)frame
                    textArray:(NSArray *)textArray
                   foldAction:(void(^)(BOOL isFold))action
                     selected:(BOOL)selected;
@end
