//
//  WL_AddressBook_AddFriend_ViewController.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/11.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  添加好友主控制器

#import "WL_AddressBook_AddFriend_ViewController.h"

#import "WL_AddressBook_ChangeRemarkName_Field.h"

@interface WL_AddressBook_AddFriend_ViewController ()
/** 验证信息Field */
@property(nonatomic, weak) WL_AddressBook_ChangeRemarkName_Field *verificationField;

/** 验证信息 */
@property(nonatomic, copy) NSString *verification;

/** 网络请求时需要用到的弹框 */
@property(nonatomic, strong)WL_TipAlert_View *alert;

@end

@implementation WL_AddressBook_AddFriend_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册弹框
    [self creatTipAlertView];
}


#pragma mark - 注册弹框
- (void)creatTipAlertView
{
    self.alert = [WL_TipAlert_View sharedAlert];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 设置UI
    [self setupChildViewToAddFriend];
}

#pragma mark - 设置UI
- (void)setupChildViewToAddFriend
{
    self.title = @"朋友验证";
    self.view.backgroundColor = [WLTools stringToColor:@"#f1f2f6"];
    [self setNavigationLeftTitle:@"取消" fontSize:16 titleColor:[UIColor whiteColor] isEnable:YES];
    [self setNavigationRightTitle:@"发送" fontSize:16 titleColor:[UIColor whiteColor] isEnable:YES];
    //设置内容
    [self setupContentViewToAddFriend];
}

#pragma mark - 设置页面内容
- (void)setupContentViewToAddFriend
{
    //1.添加一个Lable
    UILabel *promptLable = [[UILabel alloc] init];
    [self.view addSubview:promptLable];
    [promptLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left).offset(12);
        make.height.equalTo(@50);
    }];
    promptLable.font = WLFontSize(15);
    promptLable.textColor = [WLTools stringToColor:@"#b0b7c1"];
    promptLable.text = @"你需要发送验证申请，等待对方通过";
    
    //1 添加一个View
    UIView *backgroundView = [[UIView alloc] init];
    [self.view addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(promptLable.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@50);
    }];
    backgroundView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    
    WL_AddressBook_ChangeRemarkName_Field *verificationField = [[WL_AddressBook_ChangeRemarkName_Field alloc] init];
    [self.view addSubview:verificationField];
    [verificationField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(14);
        make.right.equalTo(self.view.mas_right).offset(-14);
        make.top.equalTo(backgroundView.mas_top);
        make.height.equalTo(@50);
    }];
    self.verificationField = verificationField;
    verificationField.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    [verificationField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    verificationField.placeholderLable.text = @"请输入验证申请信息";
    verificationField.placeholderLable.hidden = YES;
    verificationField.clearButtonMode = UITextFieldViewModeWhileEditing;
    verificationField.text = [NSString stringWithFormat:@"我是%@", self.real_name];
    
}

- (void)textFieldDidChange:(UITextField *)textField
{
    
    if ([textField.text isEqualToString:@""] || textField.text == nil) {
        self.verificationField.placeholderLable.hidden = NO;
    }
    else
    {
        self.verificationField.placeholderLable.hidden = YES;
        self.verification = self.verificationField.text;
    }
}


#pragma mark - 取消按钮点击方法
- (void)NavigationLeftEvent
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 发送按钮点击发送
- (void)NavigationRightEvent
{
    if (self.verificationField.text.length > 30)
    {
        [self.alert createTip:@"发送的申请信息不能大于30个字"];
    }
    else
    {
        [self sendRequestToAddFriend];
    }
    
    
}

- (void)sendRequestToAddFriend
{
    //请求地址
    NSString *urlStr = AddFriendUrl;
    //请求参数
    //参数
    NSString *user_id = [WLUserTools getUserId];
    NSString *password = [WLUserTools getUserPassword];
    NSString *rsaPassword = [MyRSA encryptString:password publicKey:RSAKey];
    NSString *my_mobile = self.user_mobile;
    NSString *friend_mobile = self.friend_mobile;
    NSString *type = @"1";
    
    NSString *content = self.verificationField.text;
    NSDictionary *params = @{
                             @"user_id" : user_id,
                             @"user_password" : rsaPassword,
                             @"my_mobile" : my_mobile,
                             @"friend_mobile" : friend_mobile,
                             @"type" : type,
                             @"content" : content
                             };
    [self showHud];
    [[WLHttpManager shareManager] requestWithURL:urlStr RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
        
        WL_Network_Model *baseModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (![baseModel.result isEqualToString:@"1"])
        {
            [self hidHud];
            [self.alert createTip:[NSString stringWithFormat:@"%@", baseModel.msg]];
            return;
        }
        
        
        [self hidHud];
        [self.alert createTip:[NSString stringWithFormat:@"%@", baseModel.msg]];
        [self.navigationController popViewControllerAnimated:YES];
        
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
