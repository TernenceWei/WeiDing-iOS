//
//  UIFont+WL.m
//  WeiLvDJS
//
//  Created by ternence on 16/11/11.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "UIFont+WL.h"

@implementation UIFont (WL)
+ (UIFont *)WLFontOfSize:(float)fontSize
{
    static CGFloat rate = 0.0;
    if (fontSize > 18.0) {
        if (ScreenHeight == 667.0) {//6
            rate = 1.10;
        }else if (ScreenHeight == 736.0){//6p
            rate = 1.10;
        }else{
            rate = 1.00;
        }
    } else {
        rate = ScreenWidth / 320.0;
    }
    
    return [UIFont systemFontOfSize:fontSize * rate];
}

+ (UIFont *)WLFontOfBoldSize:(float)fontSize
{
    static CGFloat rate = 0.0;
    if (fontSize > 18.0) {
        if (ScreenHeight == 667.0) {//6
            rate = 1.10;
        }else if (ScreenHeight == 736.0){//6p
            rate = 1.10;
        }else{
            rate = 1.00;
        }
    } else {
        rate = ScreenWidth / 320.0;
    }
    
    return [UIFont boldSystemFontOfSize:fontSize * rate];
}
@end
