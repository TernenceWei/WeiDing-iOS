//
//  WLDriverReceiptBottomView.h
//  WeiLvDJS
//
//  Created by ternence on 2016/12/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLDriverReceiptBottomView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                confirmAction:(void(^)(NSString *moneyString,BOOL isPaid))confirmAction;
@end
