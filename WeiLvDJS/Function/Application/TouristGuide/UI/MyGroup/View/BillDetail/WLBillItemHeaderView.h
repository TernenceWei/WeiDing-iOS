//
//  WLBillItemHeaderView.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLBillItemHeaderView : UIView
- (instancetype)initWithFrame:(CGRect)frame
                    leftTitle:(NSString *)leftTitle
                   rightTitle:(NSAttributedString *)rightTitle
                   foldAction:(void(^)(BOOL isFold))action
                     selected:(BOOL)selected;
@end
