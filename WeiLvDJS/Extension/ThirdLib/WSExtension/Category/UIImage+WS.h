//
//  UIImage+WS.h
//  WSExtension
//
//  Created by ternence on 16/11/21.
//  Copyright © 2016年 ternence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WS)
+ (UIImage *)resizeImage:(UIImage*)originalImage withScale:(float)scale;

+ (UIImage *)imageWithUIView:(UIView *)view;

- (UIImage *)cropWithRect:(CGRect)rect;

- (UIImage *)getSquareImageWithSizeLength:(CGFloat)sideLength;

+ (UIImage *)imageWithColor:(UIColor *)color;
@end
