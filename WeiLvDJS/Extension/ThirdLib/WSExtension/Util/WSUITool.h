//
//  WSUITool.h
//  Tools
//
//  Created by ternence on 16/11/20.
//  Copyright © 2016年 ternence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WSUITool : NSObject
+ (CGSize)sizeWithString:(NSString *)title font:(UIFont *)font;
+ (CGSize)sizeWithString:(NSString *)title font:(UIFont *)font constrainedToSize:(CGSize)size;



@end
