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
@interface WL_BindBankCards_ViewController ()

{
    UILabel *selectCardsDetail;
    
    UITextField *bankTextField;
    
    UITextField *subbranchTextField;
}
@property(nonatomic,strong)WL_BankCardsList_View *cardList;

@end

@implementation WL_BindBankCards_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = BgViewColor;
    self.navigationItem.title =@"绑定银行卡";
    
    [self initUI];
}

-(void)initUI

{
    
    UIView *backGroundWhiteView =[UIView new];
    
    [backGroundWhiteView setFrame:CGRectMake(0, 0, ScreenWidth, 45*4)];
    
    backGroundWhiteView.backgroundColor =[UIColor whiteColor];
    
    [self.view addSubview:backGroundWhiteView];
    
    
    UILabel *cardholder =[UILabel new];
    
    [cardholder setFrame:CGRectMake(10, 0, 70, 45)];
    
    cardholder.textColor = BlackColor;
    
    cardholder.font =WLFontSize(16);
    
    cardholder.text =@"持卡人";
    
    [backGroundWhiteView addSubview:cardholder];
    
    NSString *real_name =[WLUserTools getRealName];
    
    NSString *str=[real_name stringByReplacingCharactersInRange:NSMakeRange(0, real_name.length-1) withString:@"*"];
    
    NSString *id_card = [WLUserTools getIdCard];
    
    NSString *str2 =[id_card stringByReplacingCharactersInRange:NSMakeRange(3, 11) withString:@"*****"];
    
    NSString *str3 =[NSString stringWithFormat:@"%@(%@)",str,str2];
    
    UILabel *cardholderDetail =[WLTools allocLabel:str3 font:WLFontSize(14) textColor:[WLTools stringToColor:@"#6f7378"] frame:CGRectMake(ViewRight(cardholder)+40, 0, ScreenWidth-ViewRight(cardholder)-60, 45) textAlignment:NSTextAlignmentLeft];
    
    [backGroundWhiteView addSubview:cardholderDetail];
    
    UILabel *line1= [[UILabel alloc]initWithFrame:CGRectMake(10, 45, ScreenWidth-10, 0.5)];
    line1.backgroundColor =bordColor;
    
    [backGroundWhiteView addSubview:line1];
    
    UILabel *selectCards =[WLTools allocLabel:@"选择银行" font:WLFontSize(16) textColor:BlackColor frame:CGRectMake(10, 45, 70, 45) textAlignment:NSTextAlignmentLeft];
    
    [backGroundWhiteView addSubview:selectCards];
    
    selectCardsDetail = [WLTools allocLabel:@"点击选择" font:WLFontSize(14) textColor:[WLTools stringToColor:@"#6f7378"] frame:CGRectMake(ViewX(cardholderDetail), ViewBelow(cardholderDetail), ViewWidth(cardholderDetail), 45) textAlignment:NSTextAlignmentLeft];
   
    [backGroundWhiteView addSubview:selectCardsDetail];
    
    UIButton *selectButton = [UIButton new];
    
    [selectButton setFrame:CGRectMake(ViewX(cardholderDetail), ViewBelow(cardholderDetail), ViewWidth(cardholderDetail), 45)];
    
    [selectButton addTarget:self action:@selector(selectButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [backGroundWhiteView addSubview:selectButton];
    
    
    UILabel *line2= [[UILabel alloc]initWithFrame:CGRectMake(10, ViewBelow(selectCardsDetail), ScreenWidth-10, 0.5)];
    line2.backgroundColor =bordColor;
    
    [backGroundWhiteView addSubview:line2];
    
    
    UILabel *subbranch =[WLTools allocLabel:@"支行信息" font:WLFontSize(16) textColor:BlackColor frame:CGRectMake(ViewX(cardholder), ViewBelow(selectCards), 70, 45) textAlignment:NSTextAlignmentLeft];
    [backGroundWhiteView addSubview:subbranch];
    
    CGFloat toolBarH=0;
    
    if (IsiPhone4)
    {
        
        toolBarH=33;
        
    }
    else if(IsiPhone5)
    {
        
        toolBarH=33;
        
    }
    else if (IsiPhone6)
    {
        
        toolBarH=35;
        
    }
    else if (IsiPhone6P)
    {
        
        toolBarH =42;
    }
    
    //给键盘 添加 setInputAccessoryView 可以点击完成 让键盘退出
    UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,toolBarH)];
    [topView setBarStyle:UIBarStyleDefault];
    
    topView.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    NSArray * buttonsArray = @[btnSpace,doneButton];
    
    [topView setItems:buttonsArray];
    
    subbranchTextField =[[UITextField alloc]initWithFrame:CGRectMake(ViewX(cardholderDetail), ViewBelow(selectCards), ViewWidth(cardholderDetail), 45)];
    subbranchTextField.placeholder = @"请出入支行信息";
    
    subbranchTextField.font =WLFontSize(14);
    subbranchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [subbranchTextField setInputAccessoryView:topView];
    
    [backGroundWhiteView addSubview:subbranchTextField];
    
    UILabel *line3= [[UILabel alloc]initWithFrame:CGRectMake(10, ViewBelow(subbranchTextField), ScreenWidth-10, 0.5)];
    line3.backgroundColor =bordColor;
    
    [backGroundWhiteView addSubview:line3];
    
    
    UILabel *bankNum =[WLTools allocLabel:@"银行卡号" font:WLFontSize(16) textColor:BlackColor frame:CGRectMake(ViewX(cardholder), ViewBelow(subbranch), 70, 45) textAlignment:NSTextAlignmentLeft];
    [backGroundWhiteView addSubview:bankNum];
    
    
    bankTextField =[[UITextField alloc]initWithFrame:CGRectMake(ViewX(cardholderDetail), ViewBelow(subbranch), ViewWidth(subbranchTextField), 45)];
     bankTextField.placeholder=@"请输入银行卡号";
    
    bankTextField.font =WLFontSize(14);
    bankTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [bankTextField setInputAccessoryView:topView];
    
    bankTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    [backGroundWhiteView addSubview:bankTextField];
    
    
    UIButton *confirmButton =[[UIButton alloc]initWithFrame:CGRectMake(45, ViewBelow(backGroundWhiteView)+45, ScreenWidth-90, 45)];
    
    [confirmButton setBackgroundColor:WLColor(140, 157, 244, 1)];
    
    [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    confirmButton.layer.cornerRadius = 3.0;
    [self.view addSubview:confirmButton];
    
    self.cardList =[[WL_BankCardsList_View alloc]init];
    
    WS(weakSelf);
    
    __weak UILabel *weakLabel = selectCardsDetail;
    
    self.cardList.cellDidBlock = ^(NSString *bankName)
    {
       
        weakSelf.cardList.hidden =YES;
        
        weakLabel.text = bankName;
        
        weakLabel.textColor = [WLTools stringToColor:@"#2f2f2f"];
    };
   
    self.cardList.hidden =YES;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.cardList];
    
}
#pragma mark -- 银行卡选择按钮
-(void)selectButtonClick
{
    
    [self.view endEditing:YES];

    self.cardList.hidden =NO;
    
}

#pragma mark -- 确认按钮
-(void)confirmButtonClick
{
    
   [self.view endEditing:YES];
    
    if ([selectCardsDetail.text isEqualToString:@"点击选择"]) {
        
        [[WL_TipAlert_View sharedAlert]createTip:@"请选择银行卡"];
        
        return;
        
    }
    
    if (bankTextField.text.length==0) {
        
        [[WL_TipAlert_View sharedAlert]createTip:@"请输入银行卡号"];
        
        return;
    }
    
    if (bankTextField.text.length<16||bankTextField.text.length>19) {
        
        [[WL_TipAlert_View sharedAlert]createTip:@"请输入16-19位的银行卡号"];
        
        return;
    }

    
    NSString *user_id = [WLUserTools getUserId];
    
    NSString *user_passWord =[WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:user_passWord publicKey:RSAKey];
    
   
    NSString *real_name = [WLUserTools getRealName];
    
    NSString *bank_name = selectCardsDetail.text;
    
    NSString *bank_branch = subbranchTextField.text ? subbranchTextField.text : @"";
    
    NSString *bank_num = bankTextField.text;
    
    
    NSDictionary *dict =@{@"user_id":user_id,@"user_password":encryptStr,@"real_name":real_name,@"bank_name":bank_name,@"bank_branch_name":bank_branch,@"bank_number":bank_num};
    
    
    [[WLHttpManager shareManager]requestWithURL:AddBankCardUrl RequestType:RequestTypePost Parameters:dict Success:^(id responseObject) {
      
        WlLog(@"%@",responseObject);
        
        if ([responseObject[@"result"] integerValue]==1)
        {
            
            WL_BankCardsList_ViewController *VC =[[WL_BankCardsList_ViewController alloc]init];
            
            [self.navigationController pushViewController:VC animated:YES];
            
        
            
        }else
        {
            [[WL_TipAlert_View sharedAlert]createTip:responseObject[@"msg"]];
        }
        
    } Failure:^(NSError *error) {
        
        [[WL_TipAlert_View sharedAlert]createTip:@"银行卡绑定失败"];
        
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
