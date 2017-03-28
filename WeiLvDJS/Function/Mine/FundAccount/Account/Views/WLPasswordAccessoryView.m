//
//  WLPasswordAccessoryView.m
//  WeiLvDJS
//
//  Created by ternence on 2016/12/21.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLPasswordAccessoryView.h"

@interface WLPasswordAccessoryView ()
@property (nonatomic, strong) NSMutableArray *textFieldArray;
@property (nonatomic, copy) void (^onBackAction)();
@property (nonatomic, copy) void (^onFinishAction)(NSString *password);
@end

@implementation WLPasswordAccessoryView
- (NSMutableArray *)textFieldArray
{
    if (!_textFieldArray) {
        _textFieldArray = [NSMutableArray array];
    }
    return _textFieldArray;
}

- (instancetype)initWithFrame:(CGRect)frame
                   backAction:(void(^)())backAction
                 finishAction:(void(^)(NSString *password))finishAction
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.onBackAction = backAction;
        self.onFinishAction = finishAction;
        
        UIButton *backView = [[UIButton alloc] init];
        backView.frame = CGRectMake(ScaleW(10), 0, ScaleH(45), ScaleH(45));
        [backView setImage:[UIImage imageNamed:@"getbackImg"] forState:UIControlStateNormal];
        [backView addTarget:self action:@selector(backBtnDidClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backView];
        
        UILabel *titleLabel = [UILabel labelWithText:@"输入支付密码" textColor:Color2 fontSize:15];
        titleLabel.frame = CGRectMake(0, 0, ScreenWidth, ScaleH(45));
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, ScaleH(45), ScreenWidth, 1)];
        line.backgroundColor = bordColor;
        [self addSubview:line];
        
        CGFloat width = ScaleW(40);
        CGFloat height = ScaleH(45);
        CGFloat margin = ScaleW(8);
        CGFloat beginX = (ScreenWidth - width * 6 - margin * 5) / 2;
        for (int i = 0; i < 6; i++){
            
            UITextField *pwdTextField = [[UITextField alloc] init];
            pwdTextField.enabled = NO;
            pwdTextField.font = [UIFont systemFontOfSize:20];
            pwdTextField.textAlignment = NSTextAlignmentCenter;
            pwdTextField.secureTextEntry = YES;
            pwdTextField.userInteractionEnabled = NO;
            pwdTextField.keyboardType = UIKeyboardTypeNumberPad;
            pwdTextField.frame = CGRectMake(beginX + (width + margin) * i, ScaleH(80), width, height);
            pwdTextField.borderStyle = UITextBorderStyleRoundedRect;
            pwdTextField.layer.borderColor = Color1.CGColor;
            pwdTextField.layer.borderWidth = 1.0;
            pwdTextField.layer.cornerRadius = 4;
            pwdTextField.layer.masksToBounds = YES;
            [self addSubview:pwdTextField];
            [self.textFieldArray addObject:pwdTextField];

        }
        
    }
    return self;
}

- (void)backBtnDidClicked
{
    self.onBackAction();
}

- (void)inputPasswordWithPasswordString:(NSString *)password
{
    if (password.length > 6) {
        password = [password substringToIndex:6];
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
        self.onFinishAction(password);
    }
}

- (void)removeInput
{
    for (int i = 0; i < 6; i++){
        
        UITextField *pwdTextField= [self.textFieldArray objectAtIndex:i];
        pwdTextField.text = nil;
    }
}
@end
