//
//  UIView+WS.m
//  WSExtension
//
//  Created by ternence on 16/11/21.
//  Copyright © 2016年 ternence. All rights reserved.
//

#import "UIView+WS.h"

@implementation UIView (WS)
- (void)setOriginX:(CGFloat)originX
{
    CGRect frame = self.frame;
    frame.origin.x = originX;
    self.frame = frame;
}

- (CGFloat)originX
{
    return self.frame.origin.x;
}

- (void)setOriginY:(CGFloat)originY
{
    CGRect frame = self.frame;
    frame.origin.y = originY;
    self.frame = frame;
}

- (CGFloat)originY
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (CGFloat)maxX
{
    return self.originX + self.width;
}


- (CGFloat)maxY
{
    return self.originY + self.height;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (CGPoint)topLeft
{
    return CGPointMake(self.originX, self.originY);
}

- (CGPoint)topRight
{
    return CGPointMake(self.maxX, self.originY);
}

- (CGPoint)bottomLeft
{
    return CGPointMake(self.originX, self.maxY);
}

- (CGPoint)bottomRight
{
    return CGPointMake(self.maxX, self.maxY);
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (UIView *)findFirstResponder
{
    if (self.isFirstResponder) {
        
        return self;
        
    }
    for (UIView *subView in self.subviews) {
        
        UIView *responder = [subView findFirstResponder];
        
        if (responder) {
            
            return  responder;
            
        }
    }
    return nil;
}
@end
