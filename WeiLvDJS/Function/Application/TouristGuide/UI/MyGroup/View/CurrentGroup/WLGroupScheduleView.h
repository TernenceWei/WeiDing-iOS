//
//  WLGroupScheduleView.h
//  WeiLvDJS
//
//  Created by ternence on 16/9/30.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLChargeUpSummaryInfo.h"
#import "WLCurrentGroupInfo.h"

@interface WLGroupScheduleView : UIView
- (instancetype)initWithFrame:(CGRect)frame
                selectedIndex:(NSUInteger)index
                      offsetX:(CGFloat)offsetX
                 scrollAction:(void(^)(CGFloat offsetX))scrollAction;

- (void)setSummaryInfo:(WLChargeUpSummaryInfo *)summaryInfo;
- (void)setNoticeMessage:(NSString *)message;

- (void)setBillDetailClickBlock:(void(^)())block;
- (void)setMessageClickBlock:(void(^)(NSInteger index))block;
- (void)setScheduleSelectBlock:(void(^)(NSInteger index))block;
@end
