//
//  WSUITool.m
//  Tools
//
//  Created by ternence on 16/11/20.
//  Copyright © 2016年 ternence. All rights reserved.
//

#import "WSUITool.h"

@implementation WSUITool
+ (CGSize)sizeWithString:(NSString*)title font:(UIFont*)font
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    return [title sizeWithAttributes:attrs];
}

+ (CGSize)sizeWithString:(NSString *)title font:(UIFont *)font constrainedToSize:(CGSize)size
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    return [title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
