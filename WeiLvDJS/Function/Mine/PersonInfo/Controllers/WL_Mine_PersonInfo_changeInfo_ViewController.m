//
//  WL_Mine_PersonInfo_changeInfo_ViewController.m
//  WeiLvDJS
//
//  Created by liuxin on 16/9/12.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Mine_PersonInfo_changeInfo_ViewController.h"

@interface WL_Mine_PersonInfo_changeInfo_ViewController ()<UITextFieldDelegate,UITextViewDelegate>
@property(nonatomic,strong)UITextField *inputText;
@property (nonatomic, strong) UITextView * inputTextView;

@property(nonatomic,strong)WL_TipAlert_View *WarnAlert;
@end

@implementation WL_Mine_PersonInfo_changeInfo_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatPersonAlertView];
    [self creatPersonTitle];//初始化
    [self creatTextInputView];//创建输入框
    // Do any additional setup after loading the view.
}

#pragma mark----创建弹出框
-(void)creatPersonAlertView
{
    self.WarnAlert = [WL_TipAlert_View sharedAlert];
}
-(void)creatPersonTitle
{
    self.view.backgroundColor = BgViewColor;
    
    self.titleItem.title = [NSString stringWithFormat:@"%@",self.title];
    self.titleItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(personUpdate)];
    
    NSMutableDictionary *PersonAttrs = [NSMutableDictionary dictionary];
    PersonAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    PersonAttrs[NSForegroundColorAttributeName] = [WLTools stringToColor:@"#00cc99"];
    [self.titleItem.rightBarButtonItem setTitleTextAttributes:PersonAttrs forState:UIControlStateNormal];
    
}
-(void)creatTextInputView
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
    
    backView.backgroundColor = [UIColor whiteColor];
    backView.userInteractionEnabled = YES;
    [self.view addSubview:backView];
    
    if ([self.title isEqualToString:@"个性签名"]) {
        backView.frame = CGRectMake(0, 74, ScreenWidth, 200);
        _inputTextView = [[UITextView alloc] init];
        _inputTextView.frame = CGRectMake(0, 0, ScreenWidth, ScaleH(200));
        _inputTextView.delegate = self;
        //_inputTextView.returnKeyType = UIReturnKeyDone;
        //_inputTextView = [NSString stringWithFormat:@"请输入您的%@",self.title];//@"请输入您的昵称";
        _inputTextView.font = WLFontSize(17);
        _inputTextView.text = self.PersonStr;
        [backView addSubview:_inputTextView];
    }
    else
    {
        backView.frame = CGRectMake(0, 74, ScreenWidth, 50);
        _inputText = [[UITextField alloc] init];
        _inputText.frame = CGRectMake(10, 5, ScreenWidth-10, 40);
        _inputText.delegate = self;
        _inputText.returnKeyType = UIReturnKeyDone;
        _inputText.clearButtonMode = UITextFieldViewModeAlways;
        _inputText.placeholder = [NSString stringWithFormat:@"请输入您的%@",self.title];//@"请输入您的昵称";
        _inputText.font = WLFontSize(17);
        _inputText.text = self.PersonStr;
        [backView addSubview:_inputText];
    }
}

#pragma mark-----保存按钮
-(void)personUpdate
{
    NSString * sendStr = [[NSString alloc] init];
    if ([self.title isEqualToString:@"个性签名"]) {
        sendStr = _inputTextView.text;
        if (_inputTextView.text.length==0) {
            [self.WarnAlert createTip:[NSString stringWithFormat:@"%@不能为空",self.title]];//@"昵称不能为空"];
            return;
        }
    }
    else if (_inputText.text.length==0) {
        [self.WarnAlert createTip:[NSString stringWithFormat:@"%@不能为空",self.title]];//@"昵称不能为空"];
        return;
    }
    else
    {
        sendStr = _inputText.text;
    }
    [self changeInfo];
//    if ([self.delegate respondsToSelector:@selector(changeBack_infor:Str:index:)]) {
//        [self.delegate changeBack_infor:self Str:sendStr index:self.path];
//        [self.navigationController popViewControllerAnimated:YES];
//    }
}

//#pragma mark----右侧保存信息按钮
//-(void)NavigationRightEvent
//{
//    [self personUpdate];
//}

- (void)changeInfo
{
    NSString * sendStr = [[NSString alloc] init];
    BOOL isemail;
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    if ([self.title isEqualToString:@"个性签名"])
    {
        isemail = NO;
        sendStr = _inputTextView.text;
        params[@"note"] = [NSString stringWithFormat:@"%@",_inputTextView.text];
    }
    else if ([self.title isEqualToString:@"昵称"])
    {
        isemail = NO;
        sendStr = _inputText.text;
        params[@"nickname"] = [NSString stringWithFormat:@"%@",_inputText.text];
    }
    else if ([self.title isEqualToString:@"邮箱"])
    {
        if (![RegexTools judgeEmail:_inputText.text]) {
            [[WL_TipAlert_View sharedAlert] createTip:@"邮箱格式不正确"];
            return;
        }
        isemail = YES;
        sendStr = _inputText.text;
        params[@"email"] = [NSString stringWithFormat:@"%@",_inputText.text];
    }
    
    [[WLNetworkDriverHandler sharedInstance] requestChangePersonalInfoWith:params iSEmail:isemail ResultBlock:^(BOOL success, NSString *message) {
        if (success) {
            if ([self.delegate respondsToSelector:@selector(changeBack_infor:Str:index:)]) {
                [self.delegate changeBack_infor:self Str:sendStr index:self.path];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        else
        {
            [[WL_TipAlert_View sharedAlert] createTip:@"网络请求失败,请稍后重试"];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_inputText resignFirstResponder];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
