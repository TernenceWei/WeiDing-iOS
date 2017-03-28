//
//  WLDriverReceiptBottomView.m
//  WeiLvDJS
//
//  Created by ternence on 2016/12/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLDriverReceiptBottomView.h"

@interface WLDriverReceiptBottomView ()

@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) UITextField *moneyField;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, weak) UILabel *moneyNoticeLabel;
@property (nonatomic, weak) UILabel *renmingbiLabel;
@property (nonatomic, copy) void(^onConfirmAction)(NSString *moneyString,BOOL isPaid);

@end

@implementation WLDriverReceiptBottomView
- (NSMutableArray *)buttonArray
{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (instancetype)initWithFrame:(CGRect)frame confirmAction:(void(^)(NSString *moneyString,BOOL isPaid))confirmAction
{
    self = [super initWithFrame:frame];
    if (self) {
        self.onConfirmAction = confirmAction;
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.backgroundColor = HEXCOLOR(0xf2f2f2);
    CGFloat margin = ScaleW(12);
    
    UILabel *titleLabel = [UILabel labelWithText:@"当前支付"
                                       textColor:Color3
                                        fontSize:13];
    titleLabel.frame = CGRectMake(margin, 0, ScreenWidth, ScaleH(33));
    [self addSubview:titleLabel];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, ScaleH(33), ScreenWidth, ScaleH(75))];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    
    NSArray *buttonArray = @[@"客户已支付",@"客户未支付"];
    for (int i = 0; i < 2; i++) {
        UIButton *notPayBtn = [UIButton buttonWithTitle:buttonArray[i]
                                             titleColor:[UIColor whiteColor]
                                                   font:[UIFont WLFontOfSize:15]
                                                 target:self
                                                 action:@selector(payBtnClick:)
                               ];
        notPayBtn.adjustsImageWhenHighlighted = NO;
        notPayBtn.frame = CGRectMake(ScaleW(16) + (ScaleW(177) * i), ScaleH(15), ScaleW(167), ScaleH(44));
        [notPayBtn setBackgroundImage:[UIImage imageWithColor:Color1] forState:UIControlStateSelected];
        [notPayBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [notPayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [notPayBtn setTitleColor:Color1 forState:UIControlStateNormal];
        notPayBtn.layer.cornerRadius = 6;
        notPayBtn.layer.masksToBounds = YES;
        notPayBtn.layer.borderColor = Color1.CGColor;
        notPayBtn.layer.borderWidth = 1.0;
        notPayBtn.tag = i;
        [bgView addSubview:notPayBtn];
        notPayBtn.selected = (i == 0);
        [self.buttonArray addObject:notPayBtn];
        
    }
    self.selectedBtn = self.buttonArray[0];
    
    UIView *moneyView = [[UIView alloc] initWithFrame:CGRectMake(ScaleW(16), bgView.bottom + ScaleH(15), ScreenWidth - ScaleW(32), ScaleH(138))];
    moneyView.backgroundColor = [UIColor whiteColor];
    moneyView.layer.cornerRadius = 8;
    moneyView.layer.masksToBounds = YES;
    [self addSubview:moneyView];
    
    UILabel *moneyNoticeLabel = [UILabel labelWithText:@"请输入客户已支付的金额"
                                  textColor:Color2
                                   fontSize:14];
    moneyNoticeLabel.frame = CGRectMake(ScaleW(22), ScaleH(20), moneyView.width, ScaleH(30));
    [moneyView addSubview:moneyNoticeLabel];
    
    UILabel *renmingbiLabel = [UILabel labelWithText:@"¥"
                                             textColor:Color2
                                              fontSize:14];
    renmingbiLabel.frame = CGRectMake(ScaleW(22), moneyNoticeLabel.bottom + ScaleH(25), ScaleW(20), ScaleH(30));
    [moneyView addSubview:renmingbiLabel];

    self.moneyNoticeLabel = moneyNoticeLabel;
    self.renmingbiLabel = renmingbiLabel;
    
    
    UIToolbar * accessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,30)];
    [accessoryView setBarStyle:UIBarStyleDefault];
    accessoryView.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishBtnDidClicked)];
    NSArray * buttonsArray = @[btnSpace,doneButton];
    [accessoryView setItems:buttonsArray];
    
    self.moneyField =[[UITextField alloc]initWithFrame:CGRectMake(renmingbiLabel.right, moneyNoticeLabel.bottom , moneyView.width, ScaleH(80))];
    self.moneyField.font = [UIFont WSFontOfSize:30];
    self.moneyField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.moneyField.keyboardType = UIKeyboardTypeDecimalPad;
//    self.moneyField.inputAccessoryView = accessoryView;
    [self.moneyField addTarget:self action:@selector(moneyFieldTextChange) forControlEvents:UIControlEventEditingChanged];
    [moneyView addSubview:self.moneyField];
    
    UIButton *confirmBtn = [UIButton buttonWithTitle:@"确定"
                                         titleColor:Color1
                                               font:[UIFont WLFontOfSize:15]
                                             target:self
                                             action:@selector(confirmBtnClick)];
    confirmBtn.frame = CGRectMake(ScaleW(16), moneyView.bottom + ScaleH(15), ScreenWidth - ScaleW(32), ScaleH(45));
    
    confirmBtn.layer.cornerRadius = ScaleH(22.5);
    confirmBtn.layer.masksToBounds = YES;
    [confirmBtn setBackgroundImage:[UIImage imageWithColor:Color4] forState:UIControlStateDisabled];
    [confirmBtn setBackgroundImage:[UIImage imageWithColor:Color1] forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmBtn.layer.borderWidth = 1.0;
    confirmBtn.layer.borderColor = HEXCOLOR(0xeaeaea).CGColor;
    confirmBtn.enabled = NO;
    confirmBtn.adjustsImageWhenHighlighted = NO;
    [self addSubview:confirmBtn];
    self.confirmBtn = confirmBtn;
    
    UILabel *noticeLabel = [UILabel labelWithText:@"重要提示："
                                             textColor:Color3
                                              fontSize:15];
    noticeLabel.font = [UIFont WLFontOfBoldSize:14];
    noticeLabel.frame = CGRectMake(ScaleW(12), confirmBtn.bottom + ScaleH(25), moneyView.width, ScaleH(20));
    [self addSubview:noticeLabel];
    
    UILabel *itemLabel = [UILabel labelWithText:@"剩余待支付金额均会由车调中心进行支付。"
                                        textColor:Color3
                                         fontSize:14];
    CGSize size = [WLUITool sizeWithString:itemLabel.text font:itemLabel.font constrainedToSize:CGSizeMake(ScreenWidth - ScaleW(24), MAXFLOAT)];
    itemLabel.frame = CGRectMake(ScaleW(12), noticeLabel.bottom, ScreenWidth - ScaleW(24), size.height);
    [self addSubview:itemLabel];
    
}

- (void)payBtnClick:(UIButton *)button
{
   
    if (self.selectedBtn == button) {
        return;
    }
    if ([button.currentTitle isEqualToString:@"客户已支付"]) {
        self.moneyNoticeLabel.textColor = Color2;
        self.renmingbiLabel.textColor = Color2;
        self.moneyField.enabled = YES;
        self.confirmBtn.enabled = NO;
    }else
    {
        self.moneyNoticeLabel.textColor = Color3;
        self.renmingbiLabel.textColor = Color3;
        [self.moneyField endEditing:YES];
        self.moneyField.enabled = NO;
        self.confirmBtn.enabled = YES;
    }
    self.selectedBtn.selected = NO;
    button.selected = YES;
    self.selectedBtn = button;
    
}

- (void)moneyFieldTextChange
{
    if (self.moneyField.text.length>=1&&[[self.moneyField.text substringToIndex:1] isEqualToString:@"."]) {
        self.moneyField.text = @"";
    }
    if (self.moneyField.text.length>=1&&[[self.moneyField.text substringToIndex:1] isEqualToString:@"0"]) {
        if ([self.moneyField.text intValue]>=1) {
            self.moneyField.text =[NSString stringWithFormat:@"%d",[self.moneyField.text intValue]];
        }else if ([self.moneyField.text isEqualToString:@"00"]){
            self.moneyField.text =[NSString stringWithFormat:@"%d",[self.moneyField.text intValue]];
        }
    }
    
    if ([self.moneyField.text rangeOfString:@"."].location!=NSNotFound) {
        NSInteger index =[self.moneyField.text rangeOfString:@"."].location;
        NSString *str=[self.moneyField.text substringFromIndex:index+1];
        if (self.moneyField.text.length>index+1) {
            NSString *originString = [self.moneyField.text substringWithRange:NSMakeRange(index+1, 1)];
            if ([originString isEqualToString:@"."]) {
                self.moneyField.text = [self.moneyField.text substringToIndex:index+1];
            }
        }
        if (str.length>=2) {
            self.moneyField.text= [self.moneyField.text substringToIndex:index+3];
        }
    }
    if (self.moneyField.text.length>12) {
        self.moneyField.text=[self.moneyField.text substringToIndex:12];
    }
    self.confirmBtn.enabled = (self.moneyField.text.length != 0 && [self.moneyField.text floatValue] >= 0.001);
}

- (void)confirmBtnClick
{
    WS(weakSelf);
    BOOL result = self.selectedBtn.tag == 0?YES:NO;
    if (result) {
       
        if (self.onConfirmAction) {
            self.onConfirmAction(weakSelf.moneyField.text,YES);
        }
    }else
    {
        
        if (self.onConfirmAction) {
            self.onConfirmAction(nil,NO);
        }
    }
    
    
}

- (void)finishBtnDidClicked
{
    [self.moneyField endEditing:YES];
}
@end
