//
//  WLHotelPopView.h
//  WeiLvDJS
//
//  Created by ternence on 16/11/18.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLHotelPopView : UIView
@property (nonatomic, weak) UIViewController *parentVC;
/**
 弹框

 @param frame frame
 @param placeholder placeholder
 @param submmitAction 点击事件
 @return
 */
- (instancetype)initWithFrame:(CGRect)frame
                  placeholder:(NSString *)placeholder
                submmitAction:(void(^)(NSString *remark))submmitAction;
@end
