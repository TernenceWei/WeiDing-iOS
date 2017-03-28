//
//  WLUITool.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/21.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLUITool.h"

@implementation WLUITool
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

+ (CGSize)attributedSizeWithString:(NSString *)string constrainedToSize:(CGSize)size
{
    if (string == nil) {
        string = @"";
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    CGSize newSize = [attributedString boundingRectWithSize:CGSizeMake(size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    return newSize;
}

+ (UIViewController*)getTopViewController{
    UIViewController* activityViewController = nil;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if(window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows)
        {
            if(tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    NSArray *viewsArray = [window subviews];
    if([viewsArray count] > 0)
    {
        UIView *frontView = [viewsArray objectAtIndex:0];
        
        id nextResponder = [frontView nextResponder];
        
        if([nextResponder isKindOfClass:[UIViewController class]])
        {
            activityViewController = nextResponder;
        }
        else
        {
            activityViewController = window.rootViewController;
        }
    }
    
    return activityViewController;
}

+ (NSString *)timeIntervalWithTimeString:(NSString *)timeString
{
    
    return [self timeIntervalWithTimeString:timeString formatter:@"yyyy-MM-dd"];
}

+ (NSString *)timeIntervalWithTimeString:(NSString *)timeString formatter:(NSString *)formatterString
{
    return [KDateManager timeIntervalWithTimeString:timeString formatter:formatterString];
}


+ (NSString *)timeStringWithTimeInterval:(NSUInteger)timeInterval
{
    return [self timeStringWithTimeInterval:timeInterval formatter:@"yyyy-MM-dd"];

}

+ (NSString *)timeStringWithTimeInterval:(NSUInteger)timeInterval formatter:(NSString *)formatterString
{

    return  [KDateManager getDateStringWithTimeString:[NSString stringWithFormat:@"%zd",timeInterval] andFormatter:formatterString];
   

}
@end
