//
//  PassWordTextView.m
//  TextFieldTest
//
//  Created by Tpphha on 15/12/16.
//  Copyright © 2015年 Tpphha. All rights reserved.
//

#import "TPPasswordTextView.h"

@interface TPPasswordTextView ()<UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;
@end
@implementation TPPasswordTextView

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray arrayWithCapacity:self.elementCount];
    }
    return _dataSource;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UITextField *textField = [[UITextField alloc] initWithFrame:self.bounds];
        textField.hidden = YES;
        textField.delegate =self;
       
        textField.keyboardType = UIKeyboardTypeNumberPad;
       
        textField.secureTextEntry = YES;
        
        [textField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:textField];
        self.textField = textField;
    }
    return self;
}

- (void)setElementCount:(NSUInteger)elementCount {
    
    _elementCount = elementCount;
    for (int i = 0; i < self.elementCount; i++)
    {
        UITextField *pwdTextField = [[UITextField alloc] init];
        
        pwdTextField.layer.borderColor = [UIColor grayColor].CGColor;
        
        pwdTextField.enabled = NO;
        
        pwdTextField.font =[UIFont systemFontOfSize:20];
        pwdTextField.textAlignment = NSTextAlignmentCenter;//居中
        pwdTextField.secureTextEntry = YES;//设置密码模式
        pwdTextField.layer.borderWidth = 0.5;
        
        pwdTextField.userInteractionEnabled = NO;
        pwdTextField.keyboardType = UIKeyboardTypeNumberPad;
        [self insertSubview:pwdTextField belowSubview:self.textField];
        [self.dataSource addObject:pwdTextField];
    }
}

- (void)setElementColor:(UIColor *)elementColor {
    _elementColor = elementColor;
    for (NSUInteger i = 0; i < self.dataSource.count; i++) {
        UITextField *pwdTextField = [_dataSource objectAtIndex:i];
        pwdTextField.layer.borderColor = self.elementColor.CGColor;
    }
}


- (void)setElementMargin:(NSUInteger)elementMargin {
    _elementMargin = elementMargin;
    [self setNeedsLayout];
}

- (void)clearText {
    self.textField.text = nil;
    [self textChange:self.textField];
}

#pragma mark - 文本框内容改变
- (void)textChange:(UITextField *)textField {
    NSString *password = textField.text;
    if (password.length > self.elementCount) {
        
        
        textField.text = [textField.text substringToIndex:6];
    }
    
    for (int i = 0; i < _dataSource.count; i++)
    {
        UITextField *pwdTextField= [_dataSource objectAtIndex:i];
        if (i < password.length) {
            NSString *pwd = [password substringWithRange:NSMakeRange(i, 1)];
            pwdTextField.text = pwd;
        } else {
            pwdTextField.text = nil;
        }
        
    }
    
    if (password.length == _dataSource.count)
    {
        
    
     !self.passwordBlock ? : self.passwordBlock(self.textField.text);
     
        
    }

}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = (self.bounds.size.width - (self.elementCount - 1) * self.elementMargin) / self.elementCount-1;
    CGFloat h = self.bounds.size.height;
    for (NSUInteger i = 0; i < self.dataSource.count; i++) {
        UITextField *pwdTextField = [_dataSource objectAtIndex:i];
       
        x = i * (w + self.elementMargin-0.5);
        
        pwdTextField.frame = CGRectMake(x, y, w, h);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.textField becomeFirstResponder];
}

- (void)beginToInputPassword
{
    [self.textField becomeFirstResponder];
}

@end
