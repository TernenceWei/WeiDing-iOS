//
//  WLApplicationAcceptOrderPeopleNumberController.m
//  WeiLvDJS
//
//  Created by whw on 17/2/23.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLApplicationAcceptOrderPeopleNumberController.h"

@interface WLApplicationAcceptOrderPeopleNumberController ()
@property (nonatomic, weak) UITextField *inputTextField;
@end

@implementation WLApplicationAcceptOrderPeopleNumberController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"接单人数";
    self.view.backgroundColor = Color4;
    [self setupUI];
}

- (void)setupUI
{
    [self setNavigationRightTitle:@"保存" fontSize:15 titleColor:[WLTools stringToColor:@"#00cc99"] isEnable:YES];
    
    UIView *peopleNumberView = [[UIView alloc]init];
    peopleNumberView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    [self.view addSubview:peopleNumberView];
    
    [peopleNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(ScaleH(20));
        make.left.right.equalTo(self.view);
        make.height.offset(44);
    }];
    
    UITextField *inputTextField = [[UITextField alloc]init];
    inputTextField.text = self.people;
    inputTextField.keyboardType = UIKeyboardTypeNumberPad;
    inputTextField.clearButtonMode = UITextFieldViewModeAlways;
    [peopleNumberView addSubview:inputTextField];
    
    [inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(peopleNumberView).offset(ScaleW(15));
        make.top.right.bottom.equalTo(peopleNumberView);
    }];
    [inputTextField becomeFirstResponder];
    self.inputTextField = inputTextField;
}

- (void)NavigationRightEvent
{
    WS(weakSelf);
    if (!(self.inputTextField.text.length > 0)) {
        if(self.peopleNumberBlock){ //为空默认车辆座位数
            self.peopleNumberBlock(weakSelf.seatCount);
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }else if(![WLRegularExpression ba_isAllNumber:self.inputTextField.text]){
        [[WL_TipAlert_View sharedAlert] createTip:@"请输入正确的格式"];
    }else if([self.inputTextField.text integerValue] > [self.seatCount integerValue]){
        [[WL_TipAlert_View sharedAlert] createTip:@"接单人数必须小于或等于您的车辆座位数"];
    }else if ([self.inputTextField.text integerValue] == 0) {
        [[WL_TipAlert_View sharedAlert] createTip:@"接单人数不能为0"];
    }
    else
    {
        
        if(self.peopleNumberBlock){
            self.peopleNumberBlock(weakSelf.inputTextField.text);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
@end
