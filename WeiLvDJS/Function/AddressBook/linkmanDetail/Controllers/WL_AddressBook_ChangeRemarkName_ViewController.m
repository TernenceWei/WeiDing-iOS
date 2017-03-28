//
//  WL_AddressBook_ChangeRemarkName_ViewController.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/11.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  修改备注名主控制器

#import "WL_AddressBook_ChangeRemarkName_ViewController.h"

#import "WL_AddressBook_ChangeRemarkName_Field.h"

@interface WL_AddressBook_ChangeRemarkName_ViewController ()
/** 备注名输入框 */
@property(nonatomic, weak) WL_AddressBook_ChangeRemarkName_Field *remarkNameFiled;

/** 备注名称 */
@property(nonatomic, copy) NSString *remarkName;

/** 网络请求时需要用到的弹框 */
@property(nonatomic, strong)WL_TipAlert_View *alert;

@end

@implementation WL_AddressBook_ChangeRemarkName_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置UI
    [self setupChildViewToChangeRemarkName];
    //注册弹框
    [self creatTipAlertView];
}


#pragma mark - 注册弹框
- (void)creatTipAlertView
{
    self.alert = [WL_TipAlert_View sharedAlert];
    
}

- (void)setupChildViewToChangeRemarkName
{
    self.title = @"修改备注名";
    self.view.backgroundColor = [WLTools stringToColor:@"#f7f7f7"];
    [self setNavigationLeftTitle:@"取消" fontSize:16 titleColor:[UIColor whiteColor] isEnable:YES];
    [self setNavigationRightTitle:@"保存" fontSize:16 titleColor:[UIColor whiteColor] isEnable:YES];
    
    //设置内容在view上
    UIView *backgroundView = [[UIView alloc] init];
    [self.view addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).offset(12);
        make.height.equalTo(@46);
    }];
    backgroundView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    
    WL_AddressBook_ChangeRemarkName_Field *remarkNameFiled = [[WL_AddressBook_ChangeRemarkName_Field alloc] init];
    [self.view addSubview:remarkNameFiled];
    [remarkNameFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(14);
        make.right.equalTo(self.view.mas_right).offset(-14);
        make.top.equalTo(self.view.mas_top).offset(12);
        make.height.equalTo(@46);
    }];
    self.remarkNameFiled = remarkNameFiled;
    remarkNameFiled.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    [remarkNameFiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    remarkNameFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    
  
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""] || textField.text == nil) {
        self.remarkNameFiled.placeholderLable.hidden = NO;
    }
    else
    {
        self.remarkNameFiled.placeholderLable.hidden = YES;
        self.remarkName = self.remarkNameFiled.text;
    }
}

- (void)NavigationLeftEvent
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)NavigationRightEvent
{
    if ([self.remarkName isEqualToString:@""]||self.remarkName == nil)
    {
        [self.alert createTip:@"备注名不能为空!"];

    }
    else if (self.remarkName.length > 10)
    {
        [self.alert createTip:@"备注名不能超过10个字符!"];
    }
    else
    {
        [self sendRequestToChangeRemarkName];
    }
   
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.remarkNameFiled resignFirstResponder];
}

- (void)sendRequestToChangeRemarkName
{
    //Url
    NSString *urlStr = ChangeRemarkNameUrl;
    
    //请求参数
    //用户id
    NSString *userId = [WLUserTools getUserId];
    //用户密码
    NSString *password = [WLUserTools getUserPassword];
//    RSA加密
    NSString *rsaPassword = [MyRSA encryptString:password publicKey:RSAKey];
    //被查看者id
    NSString *view_id = self.view_id;
    NSString *remark_name = self.remarkName;
    NSDictionary *params = @{
                             @"user_id" : userId,
                             @"user_password" : rsaPassword,
                             @"view_id" : view_id,
                             @"remark_name" :remark_name
                             };
    
    //显示隐藏的菊花
    [self showHud];

    [[WLHttpManager shareManager] requestWithURL:urlStr RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
        
        WL_Network_Model *baseModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (![baseModel.result isEqualToString:@"1"]) {
            [self hidHud];
            [self.alert createTip:baseModel.msg];
            return;
        }
        [self.alert createTip:@"修改备注名称成功"];
        [self.navigationController popViewControllerAnimated:YES];
        [self hidHud];
    } Failure:^(NSError *error) {
        [self hidHud];
        if (error.code == -1009)
        {
            [self.alert createTip:@"似乎已断开与互联网的连接"];
        }
        else
        {
            [self.alert createTip:@"服务器错误,请稍后重试"];
        }
    }];
}

- (void)dealloc
{
    [self.alert removeFromSuperview];
}



@end
