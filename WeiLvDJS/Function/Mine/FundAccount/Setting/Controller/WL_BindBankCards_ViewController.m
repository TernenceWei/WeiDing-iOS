//
//  WL_BindBankCards_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BindBankCards_ViewController.h"
#import "WL_BankCardsList_View.h"
#import "WL_BankCardsList_ViewController.h"
#import "WLNetworkAccountHandler.h"
#import "STPickerArea.h"
#import "WLBindCardObject.h"
#import "WLFundAccountObject.h"

@interface WL_BindBankCards_ViewController ()<STPickerAreaDelegate>
{
    UILabel *_bankLabel;
    UILabel *_cityLabel;
    UITextField *_bankTextField;
    UITextField *_subbranchTextField;
    UIButton *_confirmButton;
    NSArray *_placeholderArray;
    dispatch_group_t group;
}
@property (nonatomic, strong) NSMutableArray *bankArray;
@property (nonatomic, strong) NSMutableArray *cityArray;
@property (nonatomic, strong) NSString *cityID;
@property (nonatomic, strong) WLBindCardObject *bankInfo;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSString *IDCard;

@end

@implementation WL_BindBankCards_ViewController
- (NSMutableArray *)bankArray
{
    if (!_bankArray) {
        _bankArray = [NSMutableArray array];
    }
    return _bankArray;
}

- (NSMutableArray *)cityArray
{
    if (!_cityArray) {
        _cityArray = [NSMutableArray array];
    }
    return _cityArray;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.titleItem.title = @"绑定银行卡";
    
    WS(weakSelf);
    group=dispatch_group_create();
    dispatch_queue_t queue=dispatch_get_global_queue(0, 0);
    [weakSelf showHud];
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        [weakSelf loadData];
    });
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        [weakSelf loadCitys];
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        [weakSelf hidHud];
        [weakSelf initUI];
        
    });
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
}

-(void)initUI{
    
    _placeholderArray = @[@"点击选择银行", @"点击选择开户城市",@"请输入银行支行",@"请输入银行卡卡号"];
    CGFloat height = ScaleH(50);
    
    UIView *topView =[[UIView alloc] initWithFrame:CGRectMake(0,65 + ScaleH(15), ScreenWidth, height*2)];
    topView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:topView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, topView.bottom + ScaleH(15), ScreenWidth, height*4)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    NSArray *textArray = @[@"真实姓名",@"身份证号",@"选择银行",@"开户城市",@"银行支行",@"银行账号"];
    for (int i = 0;  i < 6; i++) {
        
        UILabel *label = [UILabel labelWithText:textArray[i] textColor:Color2 fontSize:15];
        CGFloat beginY = height * i;
        if (i < 2) {
            [topView addSubview:label];
        }else{
            [bottomView addSubview:label];
            beginY = height * (i - 2);
        }
        label.frame = CGRectMake(ScaleW(20), beginY, ScaleW(100), height);
        
    }
    
    //分割线
    for (int i = 0;  i < 8; i++) {
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = bordColor;
        CGFloat beginX = ScaleW(20);
        CGFloat beginY = height * i - 1;
        CGFloat width = ScreenWidth - beginX;
        if (i < 3) {
            [topView addSubview:line];
        }else{
            [bottomView addSubview:line];
            beginY = height * (i - 3) - 1;
        }
        if (i == 0 || i == 2 || i == 3 || i == 7) {
            beginX = 0;
            width = ScreenWidth;
        }
        line.frame = CGRectMake(beginX, beginY, width, 1);
        
    }

    CGFloat rightX = ScaleW(150);
    CGFloat rightWidth = ScreenWidth - rightX;
    //姓名和身份证号
    NSString *realName=[self.realName stringByReplacingCharactersInRange:NSMakeRange(0, self.realName.length-1) withString:@"*"];
    NSString *idCard =[self.IDCard stringByReplacingCharactersInRange:NSMakeRange(3, 11) withString:@"*****"];
    NSArray *topText = @[CHECKNIL(realName), CHECKNIL(idCard)];
    
    for (int i = 0;  i < 2; i++) {
        UILabel *label = [UILabel labelWithText:topText[i] textColor:Color3 fontSize:15];
        label.frame = CGRectMake(rightX, height * i, rightX, height);
        [topView addSubview:label];
        
    }

    for (int i = 0;  i < 2; i++) {
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(rightX, height * i + 1, rightWidth, height - 2)];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.tag = i;
        [bottomView addSubview:bgView];
        
        UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectAction:)];
        [bgView addGestureRecognizer:tapAction];
        
        UILabel *label = [UILabel labelWithText:_placeholderArray[i] textColor:Color3 fontSize:14];
        label.frame = CGRectMake(rightX, height * i + 5, rightX, height - 10);
        [bottomView addSubview:label];
        
        UIImageView *arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(bottomView.width-19, (height-15)/2 + height * i, 9, 15)];
        arrowView.image = [UIImage imageNamed:@"arrow"];
        if (self.bankInfo == nil) {
            [bottomView addSubview:arrowView];
        }
        
        
        if (i == 0) {
            _bankLabel = label;
        }else{
            _cityLabel = label;
        }
        
    }

    //给键盘 添加 setInputAccessoryView 可以点击完成 让键盘退出
    UIToolbar * accessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,40)];
    [accessoryView setBarStyle:UIBarStyleDefault];
    accessoryView.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    NSArray * buttonsArray = @[btnSpace,doneButton];
    [accessoryView setItems:buttonsArray];
    
    _subbranchTextField =[[UITextField alloc]initWithFrame:CGRectMake(rightX, height * 2 + 5, rightWidth, height - 10)];
    _subbranchTextField.placeholder = _placeholderArray[2];
    _subbranchTextField.font = [UIFont WSFontOfSize:15];
    _subbranchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_subbranchTextField setInputAccessoryView:topView];
    _subbranchTextField.inputAccessoryView = accessoryView;
    [_subbranchTextField addTarget:self action:@selector(modifyConfirmBtnStatus) forControlEvents:UIControlEventEditingChanged];
    [bottomView addSubview:_subbranchTextField];
    
    _bankTextField =[[UITextField alloc]initWithFrame:CGRectMake(rightX, height * 3 + 5, rightWidth, height - 10)];
     _bankTextField.placeholder = _placeholderArray[3];
    _bankTextField.font = [UIFont WSFontOfSize:15];
    _bankTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _bankTextField.keyboardType = UIKeyboardTypeNumberPad;
    _bankTextField.inputAccessoryView = accessoryView;
    [_bankTextField addTarget:self action:@selector(modifyConfirmBtnStatus) forControlEvents:UIControlEventEditingChanged];
    [bottomView addSubview:_bankTextField];
   
    UIButton *confirmButton = [[UIButton alloc]initWithFrame:CGRectMake((ScreenWidth-ScaleW(250)) / 2, bottomView.bottom+ScaleH(38), ScaleW(250), ScaleH(45))];
    confirmButton.enabled = NO;
    [self.view addSubview:confirmButton];
    
    if (self.bankInfo) {
        _bankLabel.text = self.bankInfo.bank_name;
        _bankLabel.textColor = Color2;
        _cityLabel.text = self.bankInfo.city_name;
        _cityLabel.textColor = Color2;
        _subbranchTextField.text = self.bankInfo.branch_name;
        _bankTextField.text = self.bankInfo.bank_number;
        
        [confirmButton setImage:[UIImage imageNamed:@"BindingBankCard"] forState:UIControlStateNormal];
        confirmButton.frame = CGRectMake((ScreenWidth-ScaleW(32)) / 2, bottomView.bottom+ScaleH(38), ScaleW(32), ScaleW(33));
        _subbranchTextField.userInteractionEnabled = NO;
        _bankTextField.userInteractionEnabled = NO;
        
        UILabel *label = [UILabel labelWithText:@"绑定成功" textColor:Color3 fontSize:14];
        label.frame = CGRectMake(0, confirmButton.bottom + 8, ScreenWidth, 20);
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
        
    }else{
        
        [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
        [confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
        confirmButton.layer.cornerRadius = ScaleH(22.5);
        confirmButton.layer.masksToBounds = YES;
        [confirmButton setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateDisabled];
        [confirmButton setBackgroundImage:[UIImage imageWithColor:Color1] forState:UIControlStateNormal];
        [confirmButton setTitleColor:HEXCOLOR(0xeaeaea) forState:UIControlStateDisabled];
        [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        confirmButton.layer.borderWidth = 1.0;
        confirmButton.layer.borderColor = HEXCOLOR(0xeaeaea).CGColor;
        
    }
    _confirmButton = confirmButton;
}

- (void)selectAction:(UITapGestureRecognizer *)gesture
{
    if (self.bankInfo) {
        return;
    }
    NSUInteger tag = gesture.view.tag;
    if (tag == 0) {//选择银行
        
        [self.view endEditing:YES];
        WS(weakSelf);
        WL_BankCardsList_View *listView =[[WL_BankCardsList_View alloc]init];
        listView.nameArray = self.bankArray;
        listView.cellDidBlock = ^(NSString *bankName){
            
            _bankLabel.text = bankName;
            _bankLabel.textColor = Color2;
            [weakSelf modifyConfirmBtnStatus];
        };
        [[UIApplication sharedApplication].keyWindow addSubview:listView];
        
    }else{//选择城市
        STPickerArea *pickerArea = [[STPickerArea alloc] initWithArray:self.cityArray];
        [pickerArea setDelegate:self];
        [pickerArea setContentMode:STPickerContentModeBottom];
        [pickerArea show];

    }

}

- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area provinceID:(nonnull NSString *)provinceID cityID:(nonnull NSString *)cityID areaID:(nonnull NSString *)areaID
{
    NSString *text = [NSString stringWithFormat:@"%@%@%@", province, city, area];
    _cityLabel.text = text;
    _cityLabel.textColor = Color2;
    self.cityID = cityID;

}

- (void)loadData{
    WS(weakSelf);
    [WLNetworkAccountHandler requestBindBankInfoWithResultBlock:^(WLResponseType responseType, id data, NSString *message) {
        
        if (responseType == WLResponseTypeSuccess) {
            weakSelf.bankInfo = data;
        }else{
            weakSelf.bankInfo = nil;
        }
        
    }];
    [WLNetworkAccountHandler requestBankListWithResultBlock:^(WLResponseType responseType, id data, NSString *message) {
        dispatch_group_leave(group);
        if (responseType == WLResponseTypeSuccess) {
            weakSelf.bankArray = data;
        }
    }];
    

    [WLNetworkAccountHandler requestFundAccountWithResultBlock:^(WLResponseType responseType, id data, NSString *message) {
        
        if (responseType == WLResponseTypeSuccess) {
            WLFundAccountObject *object = data;
            weakSelf.realName = object.real_name;
            weakSelf.IDCard = object.id_card;
            
        }else{
            [[WL_TipAlert_View sharedAlert] createTip:message];
        }
    }];
        
    
}

- (void)loadCitys
{
    WS(weakSelf);
    [WLNetworkAccountHandler requestCityListWithDataBlock:^(WLResponseType responseType, id data, NSString *message) {
        dispatch_group_leave(group);
        if (responseType == WLResponseTypeSuccess) {
            weakSelf.cityArray = data;
        }
    }];
}

#pragma mark -- 确认按钮
-(void)confirmButtonClick
{
    [self.view endEditing:YES];
    if ([_bankLabel.text isEqualToString:_placeholderArray[0]]) {
        [[WL_TipAlert_View sharedAlert]createTip:@"请选择银行卡"];
        return;
    }
    if ([_cityLabel.text isEqualToString:_placeholderArray[1]]) {
        [[WL_TipAlert_View sharedAlert]createTip:@"请选择开户城市"];
        return;
    }
    if (_subbranchTextField.text.length==0) {
        [[WL_TipAlert_View sharedAlert]createTip:@"请输入银行支行"];
        return;
    }
    if (_bankTextField.text.length==0) {
        [[WL_TipAlert_View sharedAlert]createTip:@"请输入银行卡号"];
        return;
    }
    
    if (_bankTextField.text.length<16||_bankTextField.text.length>19) {
        [[WL_TipAlert_View sharedAlert]createTip:@"请输入16-19位的银行卡号"];
        return;
    }

    WS(weakSelf);
    NSString *bank_name = _bankLabel.text;
    NSString *bank_branch = _subbranchTextField.text ? _subbranchTextField.text : @"";
    NSString *bank_num = _bankTextField.text;
    [WLNetworkAccountHandler bindBankCardWithBankName:bank_name
                                       branchBankName:bank_branch
                                             bankCard:bank_num
                                               cityID:self.cityID
                                       operationBlock:^(WLResponseType responseType, BOOL result, NSString *message) {
                                           
                                           if (responseType == WLResponseTypeSuccess) {
                                               if (result) {

                                                   [[WL_TipAlert_View sharedAlert] createTip:@"银行卡绑定成功"];
                                                   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                       [weakSelf.navigationController popViewControllerAnimated:YES];
                                                   });
                                               }else{
                                                   [[WL_TipAlert_View sharedAlert]createTip:message];
                                               }
                                           }else{
                                              [[WL_TipAlert_View sharedAlert] createTip:@"银行卡绑定失败"];
                                           }
                                           
                                       }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)dismissKeyBoard
{
     [self.view endEditing:YES];
}

- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)modifyConfirmBtnStatus
{
    if (![_bankLabel.text isEqualToString:_placeholderArray[0]] && ![_cityLabel.text isEqualToString:_placeholderArray[1]] && _bankTextField.text.length != 0 && _subbranchTextField.text.length != 0) {
        _confirmButton.enabled = YES;
    }else{
        _confirmButton.enabled = NO;
    }
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = self.view.frame;
    frame.origin.y = - ScaleH(40);
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = frame;
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = frame;
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
