//
//  WL_MangerWord_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/14.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_MangerWord_ViewController.h"

#import "WL_MangerWord_Cell.h"

#import "WL_ChangePassWord_ViewController.h"

#import "WL_ResetPayPassword_ViewController.h"

#import "WL_ResetPasswordFromCode_ViewController.h"
@interface WL_MangerWord_ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray *nameArray;

@end

@implementation WL_MangerWord_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title =@"密码管理";
    
    self.view.backgroundColor =BgViewColor;
    
    [self initData];
    
    [self initUI];
}
-(void)initData
{
    self.nameArray =[NSArray arrayWithObjects:@"修改支付密码",@"忘记支付密码", nil];
}
-(void)initUI
{
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.tableView.scrollEnabled = NO;
    
    self.tableView.rowHeight= 50;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.tableFooterView =[UIView new];
    
    self.tableView.backgroundColor =[UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.nameArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID = @"reuseIdentifier";
    
    WL_MangerWord_Cell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell==nil) {
        
        cell =[[WL_MangerWord_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
   
    if (indexPath.row == 1) {
        
        cell.line.hidden =YES;
        
    }
    
    cell.nameLabel.text = self.nameArray [indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (indexPath.row ==0)
    {
        WL_ChangePassWord_ViewController *VC =[[WL_ChangePassWord_ViewController alloc]init];
        
        [self.navigationController pushViewController:VC animated:YES];
        
        
    }else if (indexPath.row ==1)
        
    {
        
        [self checkRealName];
        
    }
}

-(void)checkRealName
{
    
    NSString *user_id = [WLUserTools getUserId];
    
    NSString *user_PassWord= [WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:user_PassWord publicKey:RSAKey];
    
    NSDictionary *dict = @{@"user_id":user_id,@"user_password":encryptStr};
    
    WS(weakSelf);
    
    [weakSelf showHud];
    
    [[WLHttpManager shareManager]requestWithURL:CheckRealNameUrl RequestType:RequestTypePost Parameters:dict Success:^(id responseObject) {
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        [weakSelf hidHud];
        
        if ([network_Model.result isEqualToString:@"1"])
        {
        
        WL_ResetPayPassword_ViewController *VC =[[WL_ResetPayPassword_ViewController alloc]init];
                
        [self.navigationController pushViewController:VC animated:YES];
        
        }else
        {
            WL_ResetPasswordFromCode_ViewController *VC =[[WL_ResetPasswordFromCode_ViewController alloc]init];
            
            [self.navigationController pushViewController:VC animated:YES];
        }
        
    
    } Failure:^(NSError *error) {
        
        [weakSelf hidHud];
        
    }];
    

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
