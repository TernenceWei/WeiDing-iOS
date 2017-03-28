//
//  WL_Mine_Person_Country_ViewController.m
//  WeiLvDJS
//
//  Created by liuxin on 16/9/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Mine_Person_Country_ViewController.h"
#import "WL_cityId_model.h"

#import "WL_Mine_PersonInfo_ViewController.h"
#import "WL_Application_Driver_Jockey_ViewController.h"//司机个人资料
#import "WL_Application_TourGuide_info_ViewController.h"//导游个人资料
#import "WL_BindBankCards_ViewController.h"

@interface WL_Mine_Person_Country_ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *countryArr;
@property(nonatomic,strong)UITableView *countryTableView;
@end

@implementation WL_Mine_Person_Country_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self creatCountryTitle];
    [self.view addSubview:self.countryTableView];
    [self loadDataCountryFromServer];
    // Do any additional setup after loading the view.
}

-(void)creatCountryTitle
{
    self.titleItem.title = @"选择地区";
    self.view.backgroundColor = BgViewColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UITableView *)countryTableView
{
    if (_countryTableView == nil) {
        CGFloat height ;
        if (IsiPhone4||IsiPhone5) {
            height = 45;
        }
        else
        {
            height = 50;
        }
        _countryTableView = [[UITableView alloc] init];
        _countryTableView.frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight-64);
        _countryTableView.dataSource = self;
        _countryTableView.delegate = self;
        _countryTableView.rowHeight = height;
        [_countryTableView setShowsVerticalScrollIndicator:NO];
        _countryTableView.backgroundColor = BgViewColor;
        _countryTableView.tableHeaderView = [UIView new];
    }
    return _countryTableView;
}
-(NSMutableArray *)countryArr
{
    if (_countryArr == nil) {
        _countryArr = [[NSMutableArray alloc] init];
    }
    return _countryArr;
}
#pragma mark----tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (!self.isFrist) {
        return 1;
    }
    else
    {
        return 2;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0&&self.isFrist) {
        return 1;
    }
    else
    {
        return self.countryArr.count;
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0&&self.isFrist) {
        static NSString *cellIndentfiter0 = @"cellIndentfiter0";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentfiter0];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentfiter0];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            
        }
        
        
       
        cell.detailTextLabel.text = @"已选地区";
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        return cell;
        
    }
    else
    {
        static NSString *cellIndentfiter1 = @"cellIndentfiter1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentfiter1];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentfiter1];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            
        }
        
        
        
        WL_cityId_model *model =[self.countryArr objectAtIndex:indexPath.row];
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.text = model.region_name;
        cell.textLabel.font = WLFontSize(14);
        
        return cell;
        
    }
    return nil;
}

-(void)loadDataCountryFromServer
{
    NSString *user_mobel = @"0";
    if ([WLUserTools getUserMobile]) {
        user_mobel = [WLUserTools getUserMobile];
    }
    //用户密码
    NSString *User_password = @"";
    if ([WLUserTools getUserPassword]) {
        User_password = [WLUserTools getUserPassword];
    }
    User_password = [MyRSA encryptString:User_password publicKey:RSAKey];
    NSDictionary *dictParamt = @{
                                 @"user_mobile":user_mobel,
                                 @"user_password":User_password,
                                 @"type":@"1",
                                 @"region_id":self.city_ID
                                 
                                 };
    //NSString *url = @"http://dev.nawanr.com/api/PersonCenter/regionsList";
    __weak typeof(self)weakSelf = self;
    [self showHud];
    [[WLHttpManager shareManager] requestWithURL:PersonInfoCityListUrl RequestType:RequestTypePost Parameters:dictParamt Success:^(id responseObject) {
        [weakSelf hidHud];
        NSDictionary *dataDict = (NSDictionary *)responseObject;
        if ([dataDict[@"result"]isEqualToNumber:[NSNumber numberWithInteger:1]] ) {
            NSArray *arr = dataDict[@"data"];
            
            for (NSDictionary *dict in arr) {
                WL_cityId_model *model = [[WL_cityId_model alloc] init];
                
                model.region_id = dict[@"region_id"];
                model.region_name = dict[@"region_name"];
                [weakSelf.countryArr addObject:model];
                
            }
            [weakSelf.countryTableView reloadData];
        }
        
    } Failure:^(NSError *error) {
        [weakSelf hidHud];
        
        
    }];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WL_cityId_model *model = [self.countryArr objectAtIndex:indexPath.row];
    
    if ([self.personInfo isEqualToString:@"Person"]) {
        //个人资料
        //创建通知
        NSString *addStr = [NSString stringWithFormat:@"%@-%@-%@",self.proviceName,self.city_name,model.region_name];
        NSDictionary *dictBack = @{@"proviceID":self.proviceId,@"cityID":self.city_ID,@"countryID":model.region_id,@"address":addStr};
        NSNotification *notification = [NSNotification notificationWithName:@"changeAddress" object:nil userInfo:dictBack];
        [[NSNotificationCenter defaultCenter]postNotification:notification];
        for (WL_BaseViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[WL_Mine_PersonInfo_ViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
        
    }
    else if([self.personInfo isEqualToString:@"Driver"])
    {
        //司机个人资料
        //创建通知
        NSString *addStr = [NSString stringWithFormat:@"%@-%@-%@",self.proviceName,self.city_name,model.region_name];
        NSDictionary *dictBack = @{@"proviceID":self.proviceId,@"cityID":self.city_ID,@"countryID":model.region_id,@"proviceName":self.proviceName,@"cityName":self.city_name,@"countyName":model.region_name,@"address":addStr};
        NSNotification *notification = [NSNotification notificationWithName:@"DriverChangeAddress" object:nil userInfo:dictBack];
        [[NSNotificationCenter defaultCenter]postNotification:notification];
        for (WL_BaseViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[WL_Application_Driver_Jockey_ViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
        
        
    }
    else if([self.personInfo isEqualToString:@"Guide"])
    {
        //导游个人资料
        //创建通知
        NSString *addStr = [NSString stringWithFormat:@"%@-%@-%@",self.proviceName,self.city_name,model.region_name];
        NSDictionary *dictBack = @{@"proviceID":self.proviceId,@"cityID":self.city_ID,@"countryID":model.region_id,@"proviceName":self.proviceName,@"cityName":self.city_name,@"countyName":model.region_name,@"address":addStr};
        NSNotification *notification = [NSNotification notificationWithName:@"GuideChangeAddress" object:nil userInfo:dictBack];
        
        [[NSNotificationCenter defaultCenter]postNotification:notification];
        for (WL_BaseViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[WL_Application_TourGuide_info_ViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
        
        
    }else if([self.personInfo isEqualToString:@"bindBank"])
    {
        //资金账户
        NSString *addStr = [NSString stringWithFormat:@"%@-%@-%@",self.proviceName,self.city_name,model.region_name];
        NSDictionary *dictBack = @{@"proviceID":self.proviceId,@"cityID":self.city_ID,@"countryID":model.region_id,@"proviceName":self.proviceName,@"cityName":self.city_name,@"countyName":model.region_name,@"address":addStr};
        NSNotification *notification = [NSNotification notificationWithName:@"bindBankAddressChangeNotification" object:nil userInfo:dictBack];

        [[NSNotificationCenter defaultCenter] postNotification:notification];
        for (WL_BaseViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[WL_BindBankCards_ViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
        
        
    }

}
/*ns
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
