//
//  WL_Mine_personInfo_Authentication_ViewController.m
//  WeiLvDJS
//
//  Created by liuxin on 16/9/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Mine_personInfo_Authentication_ViewController.h"

#import "WL_MangerWord_ViewController.h"

#import "WL_SetPayPassWord_ViewController.h"

@interface WL_Mine_personInfo_Authentication_ViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UIView *begenView;
@property(nonatomic,strong)UIView *sussedView;
@property(nonatomic,strong)UITextField *nameInput;
@property(nonatomic,strong)UITextField *IDnumberInput;
@property(nonatomic,strong)UILabel *sussedLabel;
@property(nonatomic, strong)WL_TipAlert_View *Alert;
@end

@implementation WL_Mine_personInfo_Authentication_ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //创建弹出框
    [self creatPersonAlertView];
    [self creatAuthenticationTitle];
    if ([self.isValue isEqualToString:@"1"]) {
        //实名认证成功界面
        [self creatSussView];
    }
    else
    {
    //实名认证
    [self creatStartView];
    }
   
   
    // Do any additional setup after loading the view.
}
#pragma mark-----开始实名认证的界面
-(void)creatStartView
{
    CGFloat height = 0;
    if (IsiPhone4||IsiPhone5) {
        height = 44.0;
    }
    else
    {
        height = 50.0;
    }
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(0, 0, ScreenWidth, height*2);
    [self.begenView addSubview:view];
    //真实姓名
    UILabel *labelName = [[UILabel alloc] init];
    labelName.frame = CGRectMake(15, height/4, 100, height/2);
    labelName.textAlignment = NSTextAlignmentLeft;
    
    labelName.textColor =BlackColor;
    labelName.font =WLFontSize(16);
    labelName.text = @"真实姓名";
    [view addSubview:labelName];
    //身份证号
    UILabel *IdNumber = [[UILabel alloc] init];
    IdNumber.frame = CGRectMake(15, height/4+height, 100, height/2);
    IdNumber.textAlignment = NSTextAlignmentLeft;
    IdNumber.textColor =BlackColor;
    IdNumber.font =WLFontSize(16);
    
    IdNumber.text = @"身份证号";
    [view addSubview:IdNumber];
    //横线
    UILabel *line = [[UILabel alloc] init];
    line.frame = CGRectMake(15, height-0.5, ScreenWidth-15, 0.5);
    line.backgroundColor = bordColor;
    [view addSubview:line];
    //姓名输入框
    _nameInput = [[UITextField alloc] init];
    _nameInput.frame = CGRectMake(105, 5, ScreenWidth-115, height-10);
    _nameInput.placeholder = @"请输入您的真实姓名";
    _nameInput.delegate= self;
    _nameInput.clearButtonMode = UITextFieldViewModeAlways;
    _nameInput.font = WLFontSize(14);
    _nameInput.textColor =BlackColor;
    _nameInput.backgroundColor = [UIColor whiteColor];
    [view addSubview:_nameInput];
    //身份证号码输入框
    _IDnumberInput = [[UITextField alloc] init];
    _IDnumberInput.frame = CGRectMake(105,height+5, ScreenWidth-115,height-10);
    _IDnumberInput.placeholder = @"请输入您的身份证号";
    _IDnumberInput.delegate = self;
    _IDnumberInput.clearButtonMode = UITextFieldViewModeAlways;
    _IDnumberInput.font = WLFontSize(14);
    
    _IDnumberInput.textColor = BlackColor;
    _IDnumberInput.backgroundColor = [UIColor whiteColor];
    [view addSubview:_IDnumberInput];
    //认证按钮
    UIButton *btnStart = [UIButton buttonWithType:UIButtonTypeSystem];
    btnStart.frame = CGRectMake(50, height*3, ScreenWidth-100, height);
    btnStart.backgroundColor = WLColor(140, 157, 244, 1);
    [btnStart addTarget:self action:@selector(startBtn:) forControlEvents:UIControlEventTouchUpInside];
    btnStart.tag = 201;
    [btnStart setTitle:@"立即认证" forState:UIControlStateNormal];
    [btnStart setTintColor:[UIColor whiteColor]];
    btnStart.layer.cornerRadius = 5;
    btnStart.layer.masksToBounds = YES;
    [self.begenView addSubview:btnStart];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyBorod)];
    [self.begenView addGestureRecognizer:tap];
}
#pragma mark-----实名认证的背景视图
-(UIView *)begenView
{
    if (_begenView == nil) {
        _begenView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _begenView.backgroundColor = BgViewColor;
        [self.view addSubview:_begenView];
    }
    return _begenView;
}
-(UIView *)sussedView
{
    if (_sussedView == nil) {
        _sussedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _sussedView.backgroundColor = BgViewColor;
        [self.view addSubview:_sussedView];
    }
   // _sussedView.hidden = YES;
    return _sussedView;
}
-(void)creatSussView
{
    CGFloat height,headImageHeight;
    if (IsiPhone4||IsiPhone5) {
        height = 44.0;
        headImageHeight = 80;
    }
    else
    {
        height = 50.0;
        headImageHeight = 100;
    }

    //认证成功的头像
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(ScreenWidth/2-50, headImageHeight, 120, 120);
   
    imageView.image =[UIImage imageNamed:@"WLPersonInfoBig"];
    [self.sussedView addSubview:imageView];
    //成功提示语
    _sussedLabel = [[UILabel alloc] init];
    _sussedLabel.frame = CGRectMake(0, headImageHeight+120+30, ScreenWidth, 30);
    _sussedLabel.textAlignment = NSTextAlignmentCenter;
    _sussedLabel.text = @"恭喜你, 个人实名认证成功";
    _sussedLabel.textColor = [UIColor grayColor];
    _sussedLabel.font = WLFontSize(14);
    [self.sussedView addSubview:_sussedLabel];
    //设置支付密码
    UIButton  *btnSet = [UIButton buttonWithType:UIButtonTypeSystem];
    btnSet.frame = CGRectMake(50, headImageHeight+180+30, ScreenWidth-100, height);
    btnSet.backgroundColor = WLColor(140, 157, 244, 1);
    [btnSet setTintColor:[UIColor whiteColor]];
    btnSet.tag = 202;
    [btnSet setTitle:@"设置支付密码" forState:UIControlStateNormal];
    [btnSet addTarget:self action:@selector(startBtn:) forControlEvents:UIControlEventTouchUpInside];
    btnSet.layer.masksToBounds = YES;
    btnSet.layer.cornerRadius = 5;
    [self.sussedView addSubview:btnSet];
}
#pragma mark------实名认证成功后的界面视图
-(void)creatAuthenticationTitle
{
   self.title = @"实名认证";
    self.view.backgroundColor = BgViewColor;
}
#pragma mark----点击认证按钮
-(void)startBtn:(UIButton *)btn
{
    if (btn.tag == 201) {
        //立即认证
        if (_nameInput.text.length==0) {
            [self.Alert createTip:@"请输入姓名"];
            return;
        }
        else if (_IDnumberInput.text.length == 0)
        {
            [self.Alert createTip:@"请输入身份证号"];
            return;
        }
        else if (![RegexTools validateIDCardNumber:_IDnumberInput.text])
        {
            [self.Alert createTip:@"身份证号输入有误"];
            return;
        }
        else{
            //输入合法后的界面
            [self VerificationToServer];
        }
    }
    else
    {
        //设置支付密码
        [self checkPayPassWord];
    }
}
- (void)didReceiveMemoryWarning {
   
    [super didReceiveMemoryWarning];
   
    // Dispose of any resources that can be recreated.
}
#pragma mark----创建弹出框
-(void)creatPersonAlertView
{
    self.Alert = [WL_TipAlert_View sharedAlert];
}
-(void)VerificationToServer
{
    [self.nameInput resignFirstResponder];
    [self.IDnumberInput resignFirstResponder];
    NSString *user_id = @"0";
    if ([WLUserTools getUserMobile]) {
        user_id= [WLUserTools getUserId];
    }
    //用户密码
    NSString *User_password = @"";
    if ([WLUserTools getUserPassword]) {
        User_password = [WLUserTools getUserPassword];
    }
    NSString *pass = [MyRSA encryptString:User_password publicKey:RSAKey];
   
    NSDictionary *dictParamt = @{
                                 @"user_id":user_id,
                                 @"user_password":pass,
                                 @"user_name":_nameInput.text,
                                 @"user_member":_IDnumberInput.text
                                 
                                 };
   
    __weak typeof(self)weakSelf = self;
    [self showHud];
    [[WLHttpManager shareManager] requestWithURL:PersonInfoUserValidateUrl RequestType:RequestTypePost Parameters:dictParamt Success:^(id responseObject) {
        [weakSelf hidHud];
        NSDictionary *dict = (NSDictionary *)responseObject;
        if ([dict[@"result"] integerValue]==1) {
            self.begenView.hidden  = YES;
            self.sussedView.hidden = NO;
  
        }else
        {
            [self.Alert createTip:responseObject[@"msg"]];
        }
        //self.begenView.hidden  = YES;
        //self.sussedView.hidden = NO;

        WlLog(@"+++++%@",responseObject);
     
    } Failure:^(NSError *error) {
        [weakSelf hidHud];
        [self.Alert createTip:@"认证失败"];
       
    }];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark----收键盘
-(void)hiddenKeyBorod
{
    [_IDnumberInput resignFirstResponder];
    [_nameInput resignFirstResponder];
}

#pragma mark ----  检查是否设置了支付密码
-(void)checkPayPassWord
{
    
    NSString *user_id = [WLUserTools getUserId];
    
    NSString *user_PassWord= [WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:user_PassWord publicKey:RSAKey];
    
    NSDictionary *dict = @{@"user_id":user_id,@"user_password":encryptStr};
    
    WS(weakSelf);
    
    [weakSelf showHud];
    
    [[WLHttpManager shareManager]requestWithURL:CheckPassWordUrl RequestType:RequestTypePost Parameters:dict Success:^(id responseObject) {
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([network_Model.result isEqualToString:@"1"]) {
            
            [weakSelf hidHud];
            
            WL_MangerWord_ViewController *VC =[[WL_MangerWord_ViewController alloc]init];
            
            [self.navigationController pushViewController:VC animated:YES];
            
        }else
        {
            [weakSelf hidHud];
        
            WL_SetPayPassWord_ViewController *VC =[[WL_SetPayPassWord_ViewController alloc]init];
            
            [self.navigationController pushViewController:VC animated:YES];
        
        }
    } Failure:^(NSError *error) {
        
        [weakSelf hidHud];
        
    }];
    
}


@end
