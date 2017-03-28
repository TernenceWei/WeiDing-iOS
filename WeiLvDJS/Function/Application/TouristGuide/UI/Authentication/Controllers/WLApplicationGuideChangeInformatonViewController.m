//
//  WLApplicationGuideChangeInformatonViewController.m
//  WeiLvDJS
//
//  Created by whw on 16/10/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLApplicationGuideChangeInformatonViewController.h"

@interface WLApplicationGuideChangeInformatonViewController ()<UITextFieldDelegate>
@property(nonatomic, strong)UITextField *textInput;

@property(nonatomic, strong)WL_TipAlert_View *alertView;

@end

@implementation WLApplicationGuideChangeInformatonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatTitle];
    [self creatAlerView];
    [self creatInputView];
    
}

-(void)creatTitle{
    self.view.backgroundColor = BgViewColor;
    [self setNavigationRightTitle:@"保存" fontSize:14 titleColor:[UIColor whiteColor] isEnable:YES];
}

//创建弹出框
-(void)creatAlerView{
    self.alertView = [WL_TipAlert_View sharedAlert];
}

//创建输入框
-(void)creatInputView{
    CGFloat height = 0;
    if (IsiPhone4 || IsiPhone5) {
        height = 45;
    }
    else
    {
        height = 50;
    }
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(0, 10, ScreenWidth, height);
    [self.view addSubview:view];
    
    _textInput = [[UITextField alloc] init];
    _textInput.frame = CGRectMake(10, 0, ScreenWidth - 10, height);
    _textInput.delegate = self;
    _textInput.clearButtonMode = UITextFieldViewModeAlways;//model
    _textInput.placeholder = self.senderStr;
    _textInput.text = self.infoStr;
    _textInput.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textInput.font = [UIFont systemFontOfSize:15];
    [view addSubview:_textInput];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    [self.textInput addGestureRecognizer:tap];
}

//右侧点击事件
-(void)NavigationRightEvent{
    [self.textInput resignFirstResponder];
    
    switch (self.indexPath.section) {
            WlLog(@"点击姓名时的indexPath是%@",self.indexPath);
        case 0:
        {
            switch (self.indexPath.row) {
                case 0:
                    if (self.textInput.text.length == 0) {
                        [self.alertView createTip:@"姓名不能为空"];
                        return;
                    }
                    else if(self.textInput.text.length > 10){
                        [self.alertView createTip:@"您输入的姓名过长"];
                        return;
                    }
                    break;
                case 3:
                    if (_textInput.text.length == 0) {
                        [self.alertView createTip:@"联系电话不能为空"];
                        return;
                    }
                    else if (![RegexTools isMobileNumber:_textInput.text]){
                        [self.alertView createTip:@"电话格式不正确"];
                        return;
                    }
                    break;
                case 5:
                    if (_textInput.text.length == 0) {
                        [self.alertView createTip:@"地址不能为空"];
                        return;
                    }
                    break;
                case 6:
                    //身份证号码
                    if (_textInput.text.length == 0) {
                        [self.alertView createTip:@"身份证号码不能为空"];
                        return;
                    }
                    else if (![RegexTools validateIDCardNumber:_textInput.text]){
                        [self.alertView createTip:@"身份证格式不正确"];
                        return;
                    }
                    
                default:
                    break;
            }
        }
            break;
            case 1:
        {
            //导游证编号
            if (_textInput.text.length==0) {
                [self.alertView createTip:@"导游证编号不能为空"];
                return;
            }
        }
            
        default:
            break;
    }
    WlLog(@"点击保存按钮");
    //回调
    if ([self.delegate respondsToSelector:@selector(changeGuideInformation:str:index:)]) {
        WlLog(@"%@-------------",_textInput);
        [self.delegate changeGuideInformation:self str:_textInput.text index:self.indexPath];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(void)navigationLeftEvent{
    [self.textInput resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)hideKeyboard{
    [self.textInput resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
