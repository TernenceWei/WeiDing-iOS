//
//  WLPaymentCodeView.m
//  WeiLvDJS
//
//  Created by ternence on 2016/12/20.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLPaymentCodeView.h"

@interface WLPaymentCodeView ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSMutableArray *textFieldArray;
@property (nonatomic, copy) void(^onPasswordBlock)(NSString *password, BOOL isFirstInput);
@property (nonatomic, assign) BOOL isFirstInput;

@end

@implementation WLPaymentCodeView
- (instancetype)initWithFrame:(CGRect)frame passwordBlock:(void (^)(NSString *, BOOL isFirstInput))passwordBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        self.onPasswordBlock = passwordBlock;
        [self setupUI];
    }
    return self;
}

- (NSMutableArray *)textFieldArray
{
    if (!_textFieldArray) {
        _textFieldArray = [NSMutableArray array];
    }
    return _textFieldArray;
}

- (void)setupUI{
    
    self.isFirstInput = YES;
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, 100, 40)];
    self.textField .font =WLFontSize(14);
    self.textField .textColor = BlackColor;
    self.textField .delegate =self;
    self.textField .placeholder =@"请输入6位字符";
    self.textField .clearButtonMode =UITextFieldViewModeWhileEditing;
    self.textField.hidden = YES;
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    [self.textField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:self.textField];
    
    CGFloat width = ScaleW(30);
    CGFloat margin = ScaleW(15);
    CGFloat height = ScaleH(40);
    CGFloat beginX = (ScreenWidth - width * 6 - margin * 5) / 2;
    for (int i = 0; i < 6; i++){
        
        UITextField *pwdTextField = [[UITextField alloc] init];
        pwdTextField.enabled = NO;
        pwdTextField.font =[UIFont systemFontOfSize:20];
        pwdTextField.textAlignment = NSTextAlignmentCenter;
        pwdTextField.secureTextEntry = YES;
        pwdTextField.userInteractionEnabled = NO;
        pwdTextField.keyboardType = UIKeyboardTypeNumberPad;
        pwdTextField.frame = CGRectMake(beginX + (width + margin) * i, 0, width, height);
        pwdTextField.borderStyle = UITextBorderStyleNone;
        [self addSubview:pwdTextField];
        [self.textFieldArray addObject:pwdTextField];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(beginX + (width + margin) * i, height, width, 1)
                        ];
        line.backgroundColor = Color1;
        [self addSubview:line];
    }
}

- (void)beginToInput
{
   [self.textField becomeFirstResponder];
}

- (void)textChange:(UITextField *)textField {
    
    NSString *password = textField.text;
    if (password.length > 6) {
        textField.text = [textField.text substringToIndex:6];
    }
    
    for (int i = 0; i < 6; i++){
        
        UITextField *pwdTextField= [self.textFieldArray objectAtIndex:i];
        if (i < password.length) {
            NSString *pwd = [password substringWithRange:NSMakeRange(i, 1)];
            pwdTextField.text = pwd;
        } else {
            pwdTextField.text = nil;
        }
        
    }
    
    if (password.length == 6){
        self.onPasswordBlock(self.textField.text, self.isFirstInput);
    }
}

- (void)clearInputWithResetFlag:(BOOL)resetFlag
{
    self.textField.text = nil;
    self.isFirstInput = resetFlag;
    for (int i = 0; i < 6; i++){
        
        UITextField *pwdTextField= [self.textFieldArray objectAtIndex:i];
        pwdTextField.text = nil;
        
    }
}
@end
