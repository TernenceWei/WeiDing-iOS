//
//  WL_Application_Driver_changeCarInformation_ViewController.m
//  WeiLvDJS
//
//  Created by liuxin on 16/9/24.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_changeCarInformation_ViewController.h"

@interface WL_Application_Driver_changeCarInformation_ViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *inputTextField;
@property(nonatomic,strong)WL_TipAlert_View *inputTextWarn;//弹出提示框
@end

@implementation WL_Application_Driver_changeCarInformation_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle];
    [self creatInputText];
    // Do any additional setup after loading the view.
}
-(void)setTitle
{
    self.view.backgroundColor = BgViewColor;
    [self setNavigationRightTitle:@"保存" fontSize:14 titleColor:[WLTools stringToColor:@"#00cc99"] isEnable:YES];
}
-(void)creatInputText
{
    CGFloat height;
    if (IsiPhone4||IsiPhone5) {
        height = 45;
    }
    else
    {
        height = 50;
    }
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 15, ScreenWidth, height);
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    //创建输入框
    self.inputTextField = [[UITextField alloc] init];
    self.inputTextField.frame = CGRectMake(15, 0, ScreenWidth-30, height);

    self.inputTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.inputTextField.delegate = self;
    self.inputTextField.text = self.bringStr;
    
    if (self.indexPath.section == 1) {
         self.inputTextField.keyboardType = self.indexPath.row == 1?UIKeyboardTypeNumberPad:UIKeyboardTypeDefault;
        if (self.indexPath.row == 0) {
            self.inputTextField.placeholder = @"请输入车辆品牌,例:宇通(必填)";
        }else if (self.indexPath.row == 1)
        {
            self.inputTextField.placeholder = @"请输入车辆类型,例:1:大巴 2:商务车 3:其它";
        }else if (self.indexPath.row == 2)
        {
            self.inputTextField.placeholder = @"请输入车辆座位号";
        }
        else if (self.indexPath.row == 3)
        {
            self.inputTextField.placeholder = @"请输入车牌号码";
        }
    }else if (self.indexPath.section == 3)
    {
        if (self.indexPath.row == 0) {
            self.inputTextField.placeholder = @"请输入公司名称";
        }
    }else if (self.indexPath.section == 4){
        UILabel *unitLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScaleW(60), ScaleH(40))];
        unitLabel.font = [UIFont WLFontOfSize:15];
        unitLabel.textColor = Color2;
        unitLabel.textAlignment = NSTextAlignmentRight;
        self.inputTextField.rightView = unitLabel;
        self.inputTextField.rightViewMode = UITextFieldViewModeAlways;
        if (self.indexPath.row == 0) {
            unitLabel.text = @"元/天";
        }else if(self.indexPath.row == 1)
        {
            unitLabel.text = @"元/公里";
        }
        self.inputTextField.keyboardType = UIKeyboardTypeNumberPad;
        self.inputTextField.placeholder = @"请输入价格";
    }
    
    //self.inputTextField.textColor = [WLTools stringToColor:@"#2f2f2f"];
    //[self.inputTextField setValue:[WLTools stringToColor:@"#868686"] forKeyPath:@"_placeholderLabel.textColor"]; //脑残粉
    [view addSubview:self.inputTextField];
}
-(void)NavigationRightEvent
{
    WlLog(@"右侧保存按钮被点击");
    if (self.inputTextField.text.length==0) {
       
        switch (self.indexPath.row) {
            case 0:
            {
                if(self.indexPath.section == 3)
                {
                [self.inputTextWarn createTip:@"请输入公司名称"];
                }else if(self.indexPath.section == 1)
                {
                [self.inputTextWarn createTip:@"请输入车辆品牌"];
                }else if(self.indexPath.section == 4)
                {
                 [self.inputTextWarn createTip:@"请输入价格"];
                }
                return;
            }
                break;
            case 1:
            {
                if(self.indexPath.section == 4){
                [self.inputTextWarn createTip:@"请输入价格"];
                return;
                }
                
            }
            case 2:
            {
                 [self.inputTextWarn createTip:@"请输入车辆座位数"];
                return;
                
            }
                break;
            case 3:
            {
               [self.inputTextWarn createTip:@"请输入车牌号码"];
                return;
            }
                break;
            default:
                break;
        }
    }
    else{
        if (self.indexPath.row == 2) {
            if (![WLRegularExpression ba_isAllNumber:self.inputTextField.text]) {
                [self.inputTextWarn createTip:@"座位数必须为纯数字!"];
                return;
            }
        }else if(self.indexPath.row == 3)
        {
            if (![WLRegularExpression ba_isValidateCarNumber:self.inputTextField.text]) {
                [self.inputTextWarn createTip:@"请输入正确的车牌号码!"];
                return;
            }
        }else if(self.indexPath.section == 4)
        {
            if (![WLRegularExpression ba_isAllNumber:self.inputTextField.text]) {
                [self.inputTextWarn createTip:@"价格只能输入整数!"];
                return;
            }
            if(self.inputTextField.text.length >5)
            {
                [self.inputTextWarn createTip:@"价格只能输入5位数字!"];
                return;
            }
        }
        
    }

    if ([self.delegate respondsToSelector:@selector(changeCarInforMation:Str:index:)]) {
        [self.delegate changeCarInforMation:self Str:_inputTextField.text index:self.indexPath];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.inputTextField resignFirstResponder];
}
#pragma mark---创建弹出框
-(WL_TipAlert_View *)inputTextWarn
{
    if (_inputTextWarn == nil) {
        _inputTextWarn = [[WL_TipAlert_View alloc] init];
    }
    return _inputTextWarn;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (self.indexPath.row==0) {
        
        if ([string isEqualToString:@""]) {
            
            return YES;
        }
        
        
        if (textField.text.length>=15) {
            
            return NO;
        }
        
    }else if (self.indexPath.row==1) {
//        if ([string isEqualToString:@"."]) {
//          [self.inputTextWarn createTip:@"输入的必须为整数"];
//            return NO;
//        }
    }
    else
    {
        return YES;
    }
    return YES;
}

@end
