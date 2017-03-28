//
//  WL_Mine_personInfo_regionViewController.m
//  WeiLvDJS
//
//  Created by liuxin on 16/9/14.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//
//选择省
#import "WL_Mine_personInfo_regionViewController.h"
#import "WL_cityId_model.h"
#import "WL_Mine_Person_regionCity_ViewController.h"
@interface WL_Mine_personInfo_regionViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *cityArray1;
@property(nonatomic,strong)NSString *proviceName;
@property(nonatomic,strong)UITableView *proviceTableView;

@end

@implementation WL_Mine_personInfo_regionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatRegionTitle];
    
    [self loadDateFromServer];
}

-(void)creatRegionTitle
{
    self.titleItem.title = @"选择地区";
    self.view.backgroundColor = BgViewColor;
}

-(UITableView *)proviceTableView
{
    if (_proviceTableView == nil) {
        CGFloat height ;
        if (IsiPhone4||IsiPhone5) {
            height = 45;
        }
        else
        {
            height = 50;
        }
        _proviceTableView = [[UITableView alloc] init];
        _proviceTableView.frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight-64);
        _proviceTableView.dataSource = self;
        _proviceTableView.delegate = self;
        _proviceTableView.rowHeight = height;
        [_proviceTableView setShowsVerticalScrollIndicator:NO];
        _proviceTableView.backgroundColor = BgViewColor;
        _proviceTableView.tableHeaderView = [UIView new];
        [self.view addSubview:_proviceTableView];
    }
    return _proviceTableView;
}

-(NSMutableArray *)cityArray1
{
    if (_cityArray1 == nil) {
        _cityArray1 = [[NSMutableArray alloc] init];
    }
    return _cityArray1;
}

#pragma mark----tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return self.cityArray1.count;
        
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0) {
//        static NSString *cellIndentfiter0 = @"cellIndentfiter0";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentfiter0];
//        if (cell == nil) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentfiter0];
//            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
//            
//        }
//        
//        //判断上次选择的地区，如果没有选择则默认为河南
//        if (![WLTools judgeString:self.proviceId]) {
//            cell.textLabel.text = @"河南";
//            self.proviceId = @"11";
//            self.proviceName = @"河南";
//            
//        }
//        else
    
//            BOOL isDId = NO;
//            for (WL_cityId_model *model in self.cityArray1) {
//                if ([self.proviceId isEqualToString:model.region_id]) {
//                    cell.textLabel.text = model.region_name;
//                    self.proviceName = model.region_name;
//                    isDId = YES;
//                    break;
//                }
//            }
//            if (!isDId) {
//                cell.textLabel.text = @"河南";
//                self.proviceName = @"河南";
//                self.proviceId = @"11";
//                
//            }
//        }
//        //以上是省的选择
//        
//         cell.textLabel.textColor = [UIColor grayColor];
//        cell.detailTextLabel.text = @"已选地区";
//        cell.detailTextLabel.font = WLFontSize(14);
//        return cell;
//        
//    }
//    else
    //{
        static NSString *cellIndentfiter1 = @"cellIndentfiter1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentfiter1];
    CGFloat height ;
    if (IsiPhone4||IsiPhone5) {
        height = 45;
    }
    else
    {
        height = 50;
    }

    if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentfiter1];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.frame = CGRectMake(ScreenWidth-20, height/2-9, 11, 18);
            imageView.image = [UIImage imageNamed:@"arrow"];
            [cell addSubview:imageView];
            
            
        }
        
        
        
        WL_cityId_model *model =[self.cityArray1 objectAtIndex:indexPath.row];
         cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.text = model.region_name;
        cell.textLabel.font = WLFontSize(14);
        
        return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    WL_cityId_model *model = [self.cityArray1 objectAtIndex:indexPath.row];
    WL_Mine_Person_regionCity_ViewController *VC2 = [[WL_Mine_Person_regionCity_ViewController alloc] init];
    VC2.isFrist = NO;
    VC2.didProvoce = model.region_id;
    VC2.didCity = @"";
    VC2.proviceName = model.region_name;
    VC2.personInfo = self.personInfo;
    [self.navigationController pushViewController:VC2 animated:YES];
    

}

-(void)loadDateFromServer
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
                [weakSelf.cityArray1 addObject:model];
                
            }
            [weakSelf.proviceTableView reloadData];
        }
        
    } Failure:^(NSError *error) {
        [weakSelf hidHud];
        
    }];
    
    
}

@end
