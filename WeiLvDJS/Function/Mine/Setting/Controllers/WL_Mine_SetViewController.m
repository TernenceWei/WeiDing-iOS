//
//  WL_Mine_SetViewController.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/7.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Mine_SetViewController.h"
#import "WL_Mine_SetViewController_Cell.h"
#import "WL_Login_ViewController.h"
#import "WL_BaseNavigationViewController.h"

#import "WL_Mine_Setting_AboutWeiDing_ViewController.h"

#import "WL_Register_ViewController.h"
#import "JPUSHService.h"

@interface WL_Mine_SetViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>


@property(nonatomic,strong)UITableView *tableView;

@end

@implementation WL_Mine_SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor =BgViewColor;
    self.titleItem.title =@"设置";
    
    [self.view addSubview:self.tableView];
}

-(UITableView *)tableView
{
    
    if (_tableView==nil) {
        
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 65, ScreenWidth, ScreenHeight-NavHeight) style:UITableViewStylePlain];
        
        _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
        
        _tableView.delegate =self;
       
        _tableView.dataSource =self;
        
        _tableView.backgroundColor = BgViewColor;
       
    }
    return _tableView;

}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 15;
    }
    else if (section == 1)
    {
        return 15;
    }
    else
    {
        return 135;
    }
    
    return 15;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *v =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
    
    v.backgroundColor =[UIColor clearColor];
    
    return v;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    if (section == 0) {
        
        return 2;
        
    }else if (section == 1){
        
        return 1;
    }
    else if (section == 2){
        
        return 1;
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    if (indexPath.section == 2) {
        
        UITableViewCell *cell =[[UITableViewCell alloc]init];
        
        UIButton *loginOut =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        
        [loginOut setTitle:@"退出登录" forState:UIControlStateNormal];
        
        [loginOut setTitleColor:[WLTools stringToColor:@"#00cc99"] forState:UIControlStateNormal];
        
        [loginOut addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
        
        [cell addSubview:loginOut];
        
        return cell;
        
    }
    
    
    
    static NSString *cellID= @"cell";
   
    WL_Mine_SetViewController_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell==nil) {
        
      cell = [[WL_Mine_SetViewController_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
    }
    if (indexPath.section==0 &&indexPath.row==0) {
        
        cell.nameLabel.text =@"修改登录密码";
    }
    
    if (indexPath.section==0 &&indexPath.row ==1) {
        cell.nameLabel.text =@"更换手机号";
    }
    if (indexPath.section==1 &&indexPath.row ==0) {
        cell.nameLabel.text =@"关于微叮";
    }

    return cell;
}

#pragma mark - 计算缓存大小方法
- (NSString *)getCacheSize
{
    //换算为M
    //获取SD 字节大小
    double sdSize = [[SDImageCache sharedImageCache] getSize];
    //获取自定义的缓存
    NSString *myCachePath = [NSHomeDirectory() stringByAppendingFormat:@"/Library/Caches/MyCaches"];
    //遍历 文件夹 得到一个枚举器
    NSDirectoryEnumerator * enumerator = [[NSFileManager defaultManager] enumeratorAtPath:myCachePath];
    double mySize = 0;
    for (NSString *fileName in enumerator) {
        //获取文件的路径
        NSString *filePath = [myCachePath stringByAppendingPathComponent:fileName];
        //文件属性
        NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        //统计大小
        mySize += dict.fileSize;
    }
    //1M = 1024k = 1024*1024Byte
    double totalSize = (mySize + sdSize) / 1024 / 1024;//转化为M
    NSString *str;
    if (totalSize >= 1.0) {
        str=[NSString stringWithFormat:@"%0.2fM",totalSize];
        
    }else if (totalSize < 1.0){
        if (totalSize == 0.0) {
            str = @"";
        }else if (totalSize > 0.0){
            str=[NSString stringWithFormat:@"%0.2fk",(mySize + sdSize) / 1024];
        }
    }
    return str;
    
}


#pragma mark - 点击cell调用方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击账户与安全
    if (indexPath.section == 0)
    {
        WL_Register_ViewController *registerVc = [[WL_Register_ViewController alloc] init];
        
        if (indexPath.row == 0)
        {
            //修改登录密码
            registerVc.verificationStatus = WL_ResetPassword;
        }
        else if (indexPath.row == 1)
        {
            //更换手机号
            registerVc.verificationStatus = WL_ChangePhoneNum;
        }
        [self.navigationController pushViewController:registerVc animated:YES];
    }
    if (indexPath.section == 1) {
        WL_Mine_Setting_AboutWeiDing_ViewController *nextVC = [[WL_Mine_Setting_AboutWeiDing_ViewController alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

#pragma mark - 清除缓存选择的弹框
- (void)popUpBoxToCache
{
    NSString *cacheSize = [self getCacheSize];
    if (cacheSize.length == 0)
    {
        NSString *message = [NSString stringWithFormat:@"暂时没有缓存内容"];
        //弹出提示框
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        NSString *message = [NSString stringWithFormat:@"确定要清除%@缓存么?清除后无网络的情况下无法查看为您缓存的内容", cacheSize];
        //弹出提示框
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *clearAction = [UIAlertAction actionWithTitle:@"清除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //清除缓存
            [self clearCache];
            [self.tableView reloadData];
        }];
        [alert addAction:cancelAction];
        [alert addAction:clearAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
}

#pragma mark - 清除缓存功能
- (void)clearCache
{
    //清理内存中的图片缓存
    [[SDImageCache sharedImageCache] clearMemory];
    
    //清除磁盘上的图片缓存
    [[SDImageCache sharedImageCache] clearDisk];
    
    //删除自己的缓存文件夹
    NSString *myCachePath = [NSHomeDirectory() stringByAppendingFormat:@"/Library/Caches/MyCaches"];
    
    //删除
    [[NSFileManager defaultManager] removeItemAtPath:myCachePath error:nil];
}

//退出登录
-(void)loginOut
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定要退出登录吗？"
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定", nil];
    [alert show];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        
    }else if (buttonIndex==1)
    {
        [[AppManager sharedInstance] stopJPushService];
        [WLNetworkTool clearUserInfo];
       
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CarBookingSavedUserInfo"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        
//        [WLKeychainTool deleteKeychainValue:@"user_mobile"];
//        [WLKeychainTool deleteKeychainValue:@"access_token"];
//        
//        [WLKeychainTool deleteKeychainValue:@"CompanyID"];
//        
//        NSArray * arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString * fileName = [arr.firstObject stringByAppendingPathComponent:@"archiverModel"];
//        //删除归档文件
//        NSFileManager *defaultManager = [NSFileManager defaultManager];
//        if ([defaultManager isDeletableFileAtPath:fileName]) {
//            [defaultManager removeItemAtPath:fileName error:nil];
//        }
//        
//        //[JPUSHService NSRemovedPersistentStoresKey];
//        
//        WL_Login_ViewController *loginVC = [[WL_Login_ViewController alloc] init];
//        
//        WL_BaseNavigationViewController *_navi = [[WL_BaseNavigationViewController alloc] initWithRootViewController:loginVC];
//        
//        [ShareApplicationDelegate window].rootViewController = _navi;

        
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
