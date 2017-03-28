//
//  WL_Application_Driver_ChangeInformation_VC.m
//  WeiLvDJS
//
//  Created by liuxin on 16/9/19.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_ChangeInformation_VC.h"

@interface WL_Application_Driver_ChangeInformation_VC ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *textInput;
@property(nonatomic,strong)WL_TipAlert_View *CarAlertTitle;
@end

@implementation WL_Application_Driver_ChangeInformation_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatCarAlertTitle];//创建弹出框
    [self creatTitle];
    [self creatInputView];
    
}
#pragma mark----创建弹出框
-(void)creatCarAlertTitle
{
    self.CarAlertTitle = [WL_TipAlert_View sharedAlert];
}

#pragma mark----标题
-(void)creatTitle
{
    self.view.backgroundColor = BgViewColor;
    [self setNavigationRightTitle:@"保存" fontSize:14 titleColor:[WLTools stringToColor:@"#00cc99"] isEnable:YES];
}
#pragma mark----创建输入框
-(void)creatInputView
{
    CGFloat height;
    if (IsiPhone4||IsiPhone5)
    {
        height = 45;
    }
    else
    {
        height = 50;
    }

    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(0, 10, ScreenWidth, height);
    [self.view addSubview:view];
    _textInput = [[UITextField alloc] init];
    _textInput.frame = CGRectMake(15, 0, ScreenWidth-20, height);
    _textInput.delegate = self;
    _textInput.returnKeyType = UIReturnKeyDone;
    _textInput.clearButtonMode = UITextFieldViewModeAlways;
    
    if (self.indexPath.row==3) {
        
        _textInput.keyboardType = UIKeyboardTypeNumberPad;
        
    }else
    {
         _textInput.keyboardType = UIKeyboardTypeDefault;
    }
    _textInput.placeholder = self.sendStr;
    if ([self.infoStr isEqual:@"未填写"]) {
        //_textInput.text = @"";
    }
    else
    {
        _textInput.text = self.infoStr;
    }
    _textInput.font = WLFontSize(15);
    [view addSubview:_textInput];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyBore)];
    [self.view addGestureRecognizer:tap];
}
#pragma mark----右侧点击按钮
-(void)NavigationRightEvent
{
    [self.textInput resignFirstResponder];
    if (self.indexPath.section==1) {
        //第一列
        if (self.indexPath.row == 0) {
           //姓名
            if (_textInput.text.length==0) {
                [self.CarAlertTitle createTip:@"姓名不能为空"];
                return;
            }
            else if(_textInput.text.length>25)
            {
                [self.CarAlertTitle createTip:@"您输入的姓名过长"];
                return;
            }
        }
        else if (self.indexPath.row == 3)
        {
            //联系电话
            
            if (_textInput.text.length==0) {
                [self.CarAlertTitle createTip:@"联系电话不能为空"];
                return;
            }
            else if(![RegexTools isMobileNumber:_textInput.text])
            {
                [self.CarAlertTitle createTip:@"电话格式不正确"];
                return;
            }

        }
        else if (self.indexPath.row == 5)
        {
            if (_textInput.text.length==0) {
                [self.CarAlertTitle createTip:@"地址不能为空"];
                return;
            }
        }
        else if (self.indexPath.row == 6)
        {
            //身份证号码
            if (_textInput.text.length==0) {
                [self.CarAlertTitle createTip:@"身份证号码不能为空"];
                return;
            }
            else if(![RegexTools validateIDCardNumber:_textInput.text])
            {
                [self.CarAlertTitle createTip:@"身份证格式不正确"];
                return;
            }

        }
    }
    else if(self.indexPath.section == 2)
    {
        //驾照号码
        if (_textInput.text.length==0) {
            [self.CarAlertTitle createTip:@"驾照号码不能为空"];
            return;
        }
    }
    //WlLog(@"点击保存按钮");
    if ([self.delegate respondsToSelector:@selector(changeDriverInformation:Str:index:)]) {
        [self.delegate changeDriverInformation:self Str:_textInput.text index:self.indexPath];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)hiddenKeyBore
{
    [self.textInput resignFirstResponder];
}
-(void)NavigationLeftEvent
{
    [self.textInput resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

//判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
