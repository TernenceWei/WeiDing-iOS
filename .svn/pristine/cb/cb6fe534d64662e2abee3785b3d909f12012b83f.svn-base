//
//  WLCarBookingHeaderView.h
//  WeiLvDJS
//
//  Created by ternence on 2017/1/19.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLCarBookingHeaderView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                 selectAction:(void(^)(NSUInteger index))selectAction;

- (void)selectItem:(NSUInteger)index;


@end


@interface WLCarBookingItemView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                    imageName:(NSString *)imageName
                        title:(NSString *)title
                 selectAction:(void(^)(NSUInteger index, WLCarBookingItemView *view))selectAction;

@property (nonatomic, assign) BOOL selected;
@end
