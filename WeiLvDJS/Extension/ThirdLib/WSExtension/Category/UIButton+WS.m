//
//  UIButton+WS.m
//  WSExtension
//
//  Created by ternence on 16/11/21.
//  Copyright © 2016年 ternence. All rights reserved.
//

#import "UIButton+WS.h"

@implementation UIButton (WS)
+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font target:(id)target action:(SEL)action
{
    return [UIButton buttonWithTitle:title titleColor:titleColor font:font imageName:nil backgroundImageName:nil target:target action:action];
}

+ (instancetype)buttonWithImageName:(NSString *)imageName target:(id)target action:(SEL)action
{
    return [UIButton buttonWithTitle:nil titleColor:nil font:nil imageName:imageName backgroundImageName:nil target:self action:action];
}

+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font imageName:(NSString *)imageName target:(id)target action:(SEL)action
{
    return [UIButton buttonWithTitle:title titleColor:titleColor font:font imageName:imageName backgroundImageName:nil target:target action:action];
}

+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font backgroundImageName:(NSString *)backgroundImageName target:(id)target action:(SEL)action
{
    return [UIButton buttonWithTitle:title titleColor:titleColor font:font imageName:nil backgroundImageName:backgroundImageName target:target action:action];
}

+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font imageName:(NSString *)imageName backgroundImageName:(NSString *)backgroundImageName target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];

    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = font;

    if (imageName != nil) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        NSString *highlighted = [NSString stringWithFormat:@"%@_highlighted", imageName];
        [button setImage:[UIImage imageNamed:highlighted] forState:UIControlStateHighlighted];
    }
    
    if (backgroundImageName != nil) {
        [button setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal];
        NSString *backHighlighted = [NSString stringWithFormat:@"%@_highlighted", backgroundImageName];
        [button setBackgroundImage:[UIImage imageNamed:backHighlighted] forState:UIControlStateHighlighted];
    }

    if (action != nil) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return button;

}


@end
