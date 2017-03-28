//
//  WLCarBookingPriceCell.m
//  WeiLvDJS
//
//  Created by ternence on 2017/1/19.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLCarBookingPriceCell.h"

#define cellIdentifier @"WLCarBookingPriceCell"

@interface WLCarBookingPriceCell ()<UITextFieldDelegate>

@property (nonatomic, copy) void(^onClickAction)();
@property (nonatomic, strong) UIButton *seatBtn;
@property (nonatomic, strong) UITextField *seatField;
@property (nonatomic, strong) NSArray *placeHoldArray;

@end

@implementation WLCarBookingPriceCell
+ (WLCarBookingPriceCell *)cellWithTableView:(UITableView*)tableView
                                 clickAction:(void (^)())clickAction
                              placeHoldArray:(NSArray *)placeHoldArray{
    
    WLCarBookingPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLCarBookingPriceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.onClickAction = clickAction;
    cell.placeHoldArray = placeHoldArray;
    [cell setupUI];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.exclusiveTouch = YES;
        self.multipleTouchEnabled = NO;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI
{
    for (UIView *subview in self.contentView.subviews) {
        [subview removeFromSuperview];
    }
    
    NSArray *pointArray = @[@"bookingCar_seat"];
    for (int i = 0; i < 1; i++) {
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.image = [UIImage imageNamed:pointArray[i]];
        iconView.frame = CGRectMake(ScaleW(20), ScaleH(45) * i + (ScaleH(45) - 17) / 2, 17, 17);
        [self.contentView addSubview:iconView];
    }
    
    CGFloat buttonX = ScaleW(45);
    CGFloat buttonH = ScaleH(45);
    
//    UIButton *seatBtn = [UIButton buttonWithTitle:@"需要几个座位" titleColor:Color3 font:[UIFont WLFontOfSize:15] target:self action:@selector(buttonClick:)];
//    seatBtn.frame = CGRectMake(buttonX, 0, ScreenWidth - buttonX, buttonH);
//    seatBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [self.contentView addSubview:seatBtn];
//    _seatBtn = seatBtn;
    
    UIToolbar * accessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,40)];
    [accessoryView setBarStyle:UIBarStyleDefault];
    accessoryView.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    NSArray * buttonsArray = @[btnSpace,doneButton];
    [accessoryView setItems:buttonsArray];
    
    self.seatField = [[UITextField alloc]initWithFrame:CGRectMake(buttonX, 0, ScreenWidth - buttonX - ScaleW(35), buttonH)];
    self.seatField.placeholder = @"需要几个座位";
    self.seatField.font = [UIFont WLFontOfSize:15];
    self.seatField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.seatField.keyboardType = UIKeyboardTypeNumberPad;
    self.seatField.textColor = Color2;
    self.seatField.delegate = self;
    self.seatField.inputAccessoryView = accessoryView;
//    [self.seatField addTarget:self action:@selector(textFieldTextDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:self.seatField];
    if (self.placeHoldArray.count) {
        self.seatField.text = self.placeHoldArray[0];
    }
    
    UIButton *actionBtn = [[UIButton alloc] init];
    [actionBtn setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    actionBtn.frame = CGRectMake(ScreenWidth - ScaleW(20), 0, ScaleW(8), ScaleH(45));
//    [self.contentView addSubview:actionBtn];
    

//
//    self.priceField = [[UITextField alloc]initWithFrame:CGRectMake(buttonX, buttonH, ScreenWidth -  buttonX, buttonH)];
//    self.priceField.placeholder=@"请输入金额";
//    self.priceField.font = [UIFont WLFontOfSize:15];
//    self.priceField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    self.priceField.returnKeyType = UIReturnKeyDone;
//    self.priceField.keyboardType = UIKeyboardTypeDecimalPad;
//    self.priceField.textColor = Color2;
//    self.priceField.inputAccessoryView = accessoryView;
//    [self.contentView addSubview:self.priceField];
//    
//    if (self.placeHoldArray.count) {
//        NSString *firstTitle = [self.placeHoldArray firstObject];
//        NSString *secondTitle = self.placeHoldArray[1];
//        if (![firstTitle isEqualToString:@"需要几个座"]) {
//            [self setSeatCount:firstTitle.integerValue];
//        }
//        if (![secondTitle isEqualToString:@"请输入金额"]) {
//            self.priceField.text = secondTitle;
//        }
//    }
 
}

-(void)dismissKeyBoard
{
    self.onFinishInput(self.seatField.text);
    [self endEditing:YES];
}

//- (void)buttonClick:(UIButton * )button
//{
//    self.onClickAction();
//}

- (void)setSeatCount:(NSUInteger)count
{
//    [self.seatBtn setTitle:[NSString stringWithFormat:@"需%zd座", count] forState:UIControlStateNormal];
//    [self.seatBtn setTitleColor:Color2 forState:UIControlStateNormal];
    
    self.seatField.text = [NSString stringWithFormat:@"需%zd座", count];
}


- (void)resetSeatCount
{
//    [self.seatBtn setTitle:@"需要几个座位" forState:UIControlStateNormal];
//    [self.seatBtn setTitleColor:Color3 forState:UIControlStateNormal];
    
    self.seatField.text = nil;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.onFinishInput(self.seatField.text);
    [self endEditing:YES];
}
@end
