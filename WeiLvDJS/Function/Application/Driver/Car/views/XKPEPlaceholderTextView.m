//
//  XKPEPlaceholderTextView.m
//  PestatePatient
//
//  Created by YJunxiao on 15/11/27.
//  Copyright © 2015年 xikang. All rights reserved.
//

#import "XKPEPlaceholderTextView.h"

#define kPLACEHOLDER_FRAME(frame)   CGRectMake(8.0f, 8.0f, (frame).size.width - 16.0f, (frame).size.height-16.0)
#define kPLACEHOLDER_COLOR   [UIColor colorWithWhite:0.702f alpha:1.0f]

@interface XKPEPlaceholderTextView ()

@property (nonatomic, assign) BOOL shouldDrawPlaceholder;

- (void)_initialize;
- (void)_updateShouldDrawPlaceholder;
- (void)_textChanged:(NSNotification *)notification;
@end


@implementation XKPEPlaceholderTextView


@synthesize shouldDrawPlaceholder = _shouldDrawPlaceholder;

@synthesize placeholder = _placeholder;
@synthesize placeholderColor = _placeholderColor;

- (void)setText:(NSString *)string {
    [super setText:string];
    [self _updateShouldDrawPlaceholder];
}


- (void)setPlaceholder:(NSString *)string {
    if ([string isEqual:_placeholder]) {
        return;
    }
    
    _placeholder = string;
    
    
    [self _updateShouldDrawPlaceholder];
}


#pragma mark - NSObject

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}


#pragma mark - UIView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self _initialize];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self _initialize];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (_shouldDrawPlaceholder) {
        [_placeholderColor set];
        [_placeholder drawInRect:kPLACEHOLDER_FRAME(self.frame) withAttributes:@{NSFontAttributeName:self.font,NSForegroundColorAttributeName:_placeholderColor}
         ];//对字体的一些属性设置
    }
}

#pragma mark - Private

- (void)_initialize {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_textChanged:) name:UITextViewTextDidChangeNotification object:self];
    
    self.placeholderColor = kPLACEHOLDER_COLOR;
    _shouldDrawPlaceholder = NO;
}


- (void)_updateShouldDrawPlaceholder {
    BOOL prev = _shouldDrawPlaceholder;
    _shouldDrawPlaceholder = self.placeholder && self.placeholderColor && self.text.length == 0;
    
    if (prev != _shouldDrawPlaceholder) {
        [self setNeedsDisplay];
    }
}


- (void)_textChanged:(NSNotification *)notificaiton {
    [self _updateShouldDrawPlaceholder];
}

@end
