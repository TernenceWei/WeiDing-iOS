//
//  UIFont+WS.m
//  WSExtension
//
//  Created by ternence on 16/11/21.
//  Copyright © 2016年 ternence. All rights reserved.
//

#import "UIFont+WS.h"
#import "WSCommonDefine.h"

@implementation UIFont (WS)
+ (UIFont *)WSFontOfSize:(float)fontSize
{
    static CGFloat rate = 0.0;
    if (fontSize > 18.0) {
        if (SCREEN_HEIGHT == 667.0) {//6
            rate = 1.10;
        }else if (SCREEN_HEIGHT == 736.0){//6p
            rate = 1.10;
        }else{
            rate = 1.00;
        }
    } else {
        rate = SCREEN_WIDTH / 320.0;
    }
    return [UIFont systemFontOfSize:fontSize * rate];
}

+ (UIFont *)WSFontOfBoldSize:(float)fontSize
{
    static CGFloat rate = 0.0;
    if (fontSize > 18.0) {
        if (SCREEN_HEIGHT == 667.0) {//6
            rate = 1.10;
        }else if (SCREEN_HEIGHT == 736.0){//6p
            rate = 1.10;
        }else{
            rate = 1.00;
        }
    } else {
        rate = SCREEN_WIDTH / 320.0;
    }
    return [UIFont boldSystemFontOfSize:fontSize * rate];
}
@end
