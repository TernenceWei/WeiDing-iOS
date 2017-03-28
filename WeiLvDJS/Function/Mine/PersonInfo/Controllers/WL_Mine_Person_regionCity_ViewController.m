//
//  WL_Mine_Person_regionCity_ViewController.m
//  WeiLvDJS
//
//  Created by liuxin on 16/9/14.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//
//选择市区
#import "WL_Mine_Person_regionCity_ViewController.h"
#import "WL_cityId_model.h"
#import "WL_Mine_Person_Country_ViewController.h" //xuazn

#import "WL_Application_Driver_addCar_viewController.h"//车辆信息
@interface WL_Mine_Person_regionCity_ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *cityArray;

@property(nonatomic,strong)UITableView *CityTableView;

@end

@implementation WL_Mine_Person_regionCity_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatCityTitle];
    [self loadCityDateFromServer];
    // Do any additional setup after loading the view.
}

-(UITableView *)CityTableView
{
    if (_CityTableView == nil) {
        CGFloat height ;
        if (IsiPhone4||IsiPhone5) {
            height = 45;
        }
        else
        {
            height = 50;
        }
        _CityTableView = [[UITableView alloc] init];
        _CityTableView.frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight-64);
        _CityTableView.dataSource = self;
        _CityTableView.delegate = self;
        _CityTableView.rowHeight = height;
        [_CityTableView setShowsVerticalScrollIndicator:NO];
        _CityTableView.backgroundColor = BgViewColor;
        _CityTableView.tableHeaderView = [UIView new];
        _CityTableView.tableHeaderView = [UIView new];
        [self.view addSubview:_CityTableView];
    }
    return _CityTableView;
}
-(NSMutableArray *)cityArray
{
    if (_cityArray == nil) {
        _cityArray = [[NSMutableArray alloc] init];
    }
    return _cityArray;
}

-(void)creatCityTitle
{
    self.titleItem.title = @"选择地区";
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark---tableDelegate
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
        return self.cityArray.count;
        
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
        
        //判断上次选择的地区，如果没有选择则默认为河南
        if (![WLTools judgeString:self.didCity]) {
            cell.textLabel.text = @"郑州";
            self.cityName = @"郑州";
            self.didCity = @"149";
            
        }
        else
        {
            BOOL isDId = NO;
            for (WL_cityId_model *model in self.cityArray) {
                if ([self.didCity isEqualToString:model.region_id]) {
                    cell.textLabel.text = model.region_name;
                    self.cityName = model.region_name;
                    self.didCity = model.region_id;
                    isDId = YES;
                    break;
                }
            }
            if (!isDId) {
                cell.textLabel.text = @"郑州";
                self.cityName = @"郑州";
                self.didCity = @"149";
                
            }
        }
        //以上是省的选择
        
        
        cell.detailTextLabel.text = @"已选地区";
        cell.detailTextLabel.font = WLFontSize(14);
         cell.textLabel.textColor = [UIColor grayColor];
        return cell;
        
    }
    else
    {
        static NSString *cellIndentfiter1 = @"cellIndentfiter1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentfiter1];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentfiter1];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            if ([self.personInfo isEqualToString:@"Car"]) {
                
            }
            else
            {
                UIImageView *imageView = [[UIImageView alloc] init];
                imageView.frame = CGRectMake(ScreenWidth-20, cell.height/2-9, 11, 18);
                imageView.image = [UIImage imageNamed:@"arrow"];
                [cell addSubview:imageView];
            }
            
            //            UIImageView *imageView = [[UIImageView alloc] init];
            //            imageView.frame = CGRectMake(ScreenWidth-20, cell.height/2-9, 11, 18);
            //            imageView.image = [UIImage imageNamed:@"arrow"];
            //            [cell addSubview:imageView];
            
        }
        
        
        
        WL_cityId_model *model =[self.cityArray objectAtIndex:indexPath.row];
         cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.text = model.region_name;
        cell.textLabel.font = WLFontSize(14);
        
        return cell;
        
    }
    return nil;
}

-(void)loadCityDateFromServer
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
                                 @"region_id":self.didProvoce
                                 
                                 };
    // NSString *url = @"http://dev.nawanr.com/api/PersonCenter/regionsList";
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
                [weakSelf.cityArray addObject:model];
                
            }
            [weakSelf.CityTableView reloadData];
        }
        
    } Failure:^(NSError *error) {
        [weakSelf hidHud];
        
        
    }];
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isFrist) {
        if (indexPath.section==0) {
            
            if ([self.personInfo isEqualToString:@"Car"]) {
                WL_cityId_model *model = [WL_cityId_model new];
                model.region_id = self.didCity;
                model.region_name = self.cityName;
                [self backToCarInformationVC:model isStr:NO];
            }
            else
            {
                WL_Mine_Person_Country_ViewController *CountryVC =[[WL_Mine_Person_Country_ViewController alloc] init];
                CountryVC.city_ID =  self.didCity;
                CountryVC.city_name = self.cityName;
                CountryVC.proviceId = self.didProvoce;
                CountryVC.proviceName = self.proviceName;
                CountryVC.isFrist = NO;
                CountryVC.personInfo = self.personInfo;
                [self.navigationController pushViewController:CountryVC animated:YES];
            }
        }
        else
        {
            WL_cityId_model *model = [self.cityArray objectAtIndex:indexPath.row];
            
            
            if ([self.personInfo isEqualToString:@"Car"]) {
                [self backToCarInformationVC:model isStr:YES];
            }
            else
            {
                WL_Mine_Person_Country_ViewController *CountryVC =[[WL_Mine_Person_Country_ViewController alloc] init];
                CountryVC.city_ID =  model.region_id;
                CountryVC.city_name = model.region_name;
                CountryVC.proviceId = self.didProvoce;
                CountryVC.proviceName = self.proviceName;
                CountryVC.isFrist = NO;
                CountryVC.personInfo = self.personInfo;
                [self.navigationController pushViewController:CountryVC animated:YES];
                
            }
        }
    }
    else
    {
        WL_cityId_model *model = [self.cityArray objectAtIndex:indexPath.row];
        
        if ([self.personInfo isEqualToString:@"Car"]) {
            [self backToCarInformationVC:model isStr:YES];
        }
        else
        {
            WL_Mine_Person_Country_ViewController *CountryVC =[[WL_Mine_Person_Country_ViewController alloc] init];
            CountryVC.city_ID =  model.region_id;
            CountryVC.city_name = model.region_name;
            CountryVC.proviceId = self.didProvoce;
            CountryVC.proviceName = self.proviceName;
            CountryVC.isFrist = NO;
            CountryVC.personInfo = self.personInfo;
            [self.navigationController pushViewController:CountryVC animated:YES];
        }
    }
}
-(void)backToCarInformationVC:(WL_cityId_model *)model isStr:(BOOL)IsBack
{
    //个人资料
    //创建通知
    NSString *addStr = [NSString stringWithFormat:@"%@-%@",self.proviceName,model.region_name];
    NSDictionary *dictBack = @{@"proviceID":self.didProvoce,@"cityID":model.region_id,@"proviceName":self.proviceName,@"cityName":model.region_name,@"address":addStr};
    NSNotification *notification = [NSNotification notificationWithName:@"backCarInformationCity" object:nil userInfo:dictBack];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
    for (WL_BaseViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[WL_Application_Driver_addCar_viewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    
}
#pragma mark-----点击事件
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
