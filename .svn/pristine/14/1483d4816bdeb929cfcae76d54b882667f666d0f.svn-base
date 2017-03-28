//
//  UIImage+WS.m
//  WSExtension
//
//  Created by ternence on 16/11/21.
//  Copyright © 2016年 ternence. All rights reserved.
//

#import "UIImage+WS.h"

@implementation UIImage (WS)
+ (UIImage *)resizeImage:(UIImage*)originalImage withScale:(float)scale
{
    CGSize oldSize = originalImage.size;
    CGSize newSize = CGSizeMake(oldSize.width*scale, oldSize.height*scale);
    
    UIGraphicsBeginImageContext(newSize);
    [originalImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *targetImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return targetImage;
}

+ (UIImage *)imageWithUIView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)cropWithRect:(CGRect)rect{
    CGSize originalSize = self.size;
    CGFloat targetWidth = (rect.size.width+rect.origin.x)>originalSize.width?(originalSize.width-rect.origin.x):(rect.size.width);
    CGFloat targetHeight = (rect.size.height+rect.origin.y)>originalSize.height?(originalSize.height-rect.origin.y):(rect.size.height);
    
    if (targetWidth<=0 || targetHeight<=0) {
        return self;
    }
    UIGraphicsBeginImageContext(rect.size);
    [self drawInRect:CGRectMake(rect.origin.x, rect.origin.y, targetWidth, targetHeight)];
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [self drawAtPoint:CGPointMake(-rect.origin.x, -rect.origin.y)];
    UIImage *targetImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return targetImage;
}

- (UIImage *)getSquareImageWithSizeLength:(CGFloat)sideLength{
    CGSize originalSize = self.size;
    if (originalSize.width==0 || originalSize.height==0) {
        return self;
    }
    
    CGRect targetRect = CGRectZero;
    BOOL skipCrop = NO;
    CGFloat originalLenth = originalSize.width;
    if (originalSize.width>originalSize.height) {
        targetRect = CGRectMake((originalSize.width-originalSize.height)/2, 0, originalSize.height, originalSize.height);
        originalLenth = originalSize.height;
    } else if(originalSize.width<originalSize.height) {
        targetRect = CGRectMake(0, (originalSize.height-originalSize.width)/2, originalSize.width, originalSize.width);
    }else{
        skipCrop = YES;
    }
    
    UIImage *cropDoneImage = self;
    if (!skipCrop) {
        cropDoneImage = [self cropWithRect:targetRect];
    }
    
    return cropDoneImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
@end
