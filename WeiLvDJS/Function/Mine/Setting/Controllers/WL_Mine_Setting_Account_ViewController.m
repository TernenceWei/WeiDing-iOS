//
//  WL_Mine_Setting_Account_ViewController.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/12.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//




/*** 没在用了**/

#import "WL_Mine_Setting_Account_ViewController.h"
#import "WL_Mine_Setting_Account_Cell.h"

#import "WL_Mine_Setting_Account_Defend_ViewController.h"

#import "WL_Mine_Setting_Account_ChangePhone_ViewController.h"

#import "WL_Mine_Setting_Account_ChangePassword_ViewController.h"

@interface WL_Mine_Setting_Account_ViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation WL_Mine_Setting_Account_ViewController

- (void)viewWillAppear:(BOOL)animated
{
    //[super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

//- (void)viewDidDisappear:(BOOL)animated
//{
//    self.navigationController.navigationBar.hidden = NO;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置Nav
    [self setNav];
    //设置账户与安全内容
    [self setupContentWithAccount];
}

#pragma mark - 设置账户与安全界面的Nav
- (void)setNav
{
    UINavigationBar* navbar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [self.view addSubview:navbar];
    UINavigationItem *titleItem = [[UINavigationItem alloc] initWithTitle:@"账户与安全"];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"getbackImg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(backBtnClick)];
    titleItem.leftBarButtonItem = leftButton;
    navbar.items = @[titleItem];
    
    UILabel * navLine = [[UILabel alloc] initWithFrame:CGRectMake(0, navbar.frame.size.height - ScaleH(0.5), navbar.frame.size.width, ScaleH(0.5))];
    navLine.backgroundColor = [WLTools stringToColor:@"#b2b2b2"];
    [navbar addSubview:navLine];
}

- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 设置账户与安全的内容
static NSString *const cellId = @"accountCellId";
- (void)setupContentWithAccount
{
    //设置View的背景颜色
    self.view.backgroundColor = BgViewColor;
    //设置账户安全内容列表
    UITableView *accountList = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:accountList];
    accountList.backgroundColor = BgViewColor;
    accountList.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置控制器为代理和数据源
    accountList.delegate = self;
    accountList.dataSource = self;
    //注册cell
    [accountList registerClass:[WL_Mine_Setting_Account_Cell class] forCellReuseIdentifier:cellId];
    
}

#pragma mark - UITableViewDataSource
/** 返回tableView的组数 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
/** 返回tableView每组的行数 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else if (section == 1)
    {
        return 2;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WL_Mine_Setting_Account_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            cell.titleLable.text = @"账号保护";
            cell.promptButton.hidden = NO;
        }
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            cell.titleLable.text = @"更换手机号";
            cell.line.hidden = NO;
        }
        else if (indexPath.row == 1)
        {
            cell.titleLable.text = @"修改登录密码";
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //第0组第0个
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
//            WL_Mine_Setting_Account_Defend_ViewController *defend = [[WL_Mine_Setting_Account_Defend_ViewController alloc] init];
//            [self.navigationController pushViewController:defend animated:YES];
        }
        
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            //更换手机号
            WL_Mine_Setting_Account_ChangePhone_ViewController *changePhoneVc = [[WL_Mine_Setting_Account_ChangePhone_ViewController alloc] init];
            [self.navigationController pushViewController:changePhoneVc animated:YES];
        }
        else if (indexPath.row == 1)
        {
            //修改登录密码
            WL_Mine_Setting_Account_ChangePassword_ViewController *changePasswordVC = [[WL_Mine_Setting_Account_ChangePassword_ViewController alloc] init];
            [self.navigationController pushViewController:changePasswordVC animated:YES];
        }
    }
    
}





@end
