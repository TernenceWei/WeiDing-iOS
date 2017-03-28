//
//  UIBarButtonItem+WS.m
//  WSExtension
//
//  Created by ternence on 16/11/21.
//  Copyright © 2016年 ternence. All rights reserved.
//

#import "UIBarButtonItem+WS.h"
#import "UIFont+WS.h"

@implementation UIBarButtonItem (WS)
/**
 *  只有图片
 */
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName target:(id)target action:(SEL)action {
    UIButton *button = [[UIButton alloc] init];
    // 设置按钮的背景图片
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    if (highlightedImageName) {
        [button setBackgroundImage: [UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    }
    button.adjustsImageWhenHighlighted = NO;
    //监听按钮的点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

/**
 *  只有文字
 */
+ (UIBarButtonItem *)itemWithName:(NSString *)Name font:(CGFloat)font target:target action:(SEL)action {
    
    UIButton *btn = [[UIButton alloc] init];
    btn.titleLabel.font = [UIFont WSFontOfSize:font];
    [btn setTitle:Name forState:UIControlStateNormal];
    [btn sizeToFit];
    //监听按钮的点击
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.adjustsImageWhenHighlighted = NO;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}


@end
