//
//  WLCarBookingAddCostView.m
//  WeiLvDJS
//
//  Created by ternence on 2017/1/20.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLCarBookingAddCostView.h"

@interface WLCarBookingAddCostView ()

@property (nonatomic, strong) UITextField *priceField;
@property (nonatomic, copy) void(^onFinishAction)(BOOL cancel, NSString *newPrice);
@property (nonatomic, strong) UIButton *confrimBtn;
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation WLCarBookingAddCostView

- (instancetype)initWithFrame:(CGRect)frame
                  originPrice:(NSString *)price
                 finishAction:(void (^)(BOOL, NSString *))finishAction
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.onFinishAction = finishAction;
        
        UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
        bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self addSubview:bgView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction)];
        [bgView addGestureRecognizer:tapGesture];
        
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - ScaleH(200), ScreenWidth, ScaleH(200))];
        bottomView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bottomView];
        self.bottomView = bottomView;
        
        //取消按钮
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        cancelBtn.frame = CGRectMake(5, 0, 50, 35);
        [cancelBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.tag = 501;
        [cancelBtn setTintColor:[WLTools stringToColor:@"#4977e7"]];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:Color1 forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont WLFontOfSize:15];
        [bottomView addSubview:cancelBtn];
        
        //确定按钮
        UIButton *confrimBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        confrimBtn.frame = CGRectMake(ScreenWidth-55, 0, 50, 35);
        [confrimBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        confrimBtn.tag = 502;
        [confrimBtn setTintColor:[WLTools stringToColor:@"#4977e7"]];
        [confrimBtn setTitle:@"确定" forState:UIControlStateNormal];
        [confrimBtn setTitleColor:Color1 forState:UIControlStateNormal];
        [confrimBtn setTitleColor:Color3 forState:UIControlStateDisabled];
        confrimBtn.titleLabel.font = [UIFont WLFontOfSize:15];
        confrimBtn.enabled = NO;
        [bottomView addSubview:confrimBtn];
        self.confrimBtn = confrimBtn;
        
        UILabel *renminLabel = [UILabel labelWithText:@"¥" textColor:Color2 fontSize:14];
        renminLabel.frame = CGRectMake(ScaleW(100), ScaleH(100), ScaleW(10), ScaleH(40));
        [bottomView addSubview:renminLabel];
        
        self.priceField = [[UITextField alloc]initWithFrame:CGRectMake(renminLabel.right, renminLabel.top, ScaleW(150), ScaleH(40))];
        self.priceField.placeholder=@"请输入加价金额";
        self.priceField.font = [UIFont WLFontOfSize:15];
        self.priceField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.priceField.returnKeyType = UIReturnKeyDone;
        self.priceField.keyboardType = UIKeyboardTypeDecimalPad;
        self.priceField.textColor = Color2;
        [self.priceField addTarget:self action:@selector(textFieldTextDidChange) forControlEvents:UIControlEventEditingChanged];
        [bottomView addSubview:self.priceField];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(ScaleW(90), self.priceField.bottom, ScaleW(300), 1)];
        line.backgroundColor = bordColor;
        [bottomView addSubview:line];
        
        UILabel *originLabel = [UILabel labelWithText:[NSString stringWithFormat:@"加价前:%@",price] textColor:Color3 fontSize:14];
        originLabel.frame = CGRectMake(0, line.bottom, ScreenWidth - ScaleW(40), ScaleH(40));
        originLabel.textAlignment = NSTextAlignmentRight;
        [bottomView addSubview:originLabel];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        [self.priceField becomeFirstResponder];
    }
    return self;
}

- (void)tapGestureAction
{
    self.onFinishAction(YES, nil);
}

- (void)buttonClick:(UIButton *)button
{
    if (button.tag == 501) {
        self.onFinishAction(YES, nil);
    }else{
        self.onFinishAction(NO, self.priceField.text);
    }
    
}

- (void)textFieldTextDidChange
{
    self.confrimBtn.enabled = self.priceField.text.length;
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.bottomView.transform = CGAffineTransformMakeTranslation(0, -216);
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    [UIView animateWithDuration:duration animations:^{
        self.bottomView.transform = CGAffineTransformIdentity;
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
