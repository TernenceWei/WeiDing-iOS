//
//  WLWriteOffDetailViewController.m
//  WeiLvDJS
//
//  Created by hsliang on 2017/1/5.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLWriteOffDetailViewController.h"
#import "WLdetailHeadView.h"
#import "WLNetworkWriteOffHandler.h"
#import "WLWriteOffDetailObject.h"

#import "WLDataHotelHandler.h"
#import "WLResultWriteOffViewController.h"

#import "WLOneCardViewController.h"

@interface WLWriteOffDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView * listTable;
@property (nonatomic, strong) NSMutableArray * dataArr;

@end

@implementation WLWriteOffDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BgViewColor;
    self.titleItem.title = @"核销记录";
    
    [self setUI];
    [self setNet];
}

- (void)setUI
{
    //_listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    _listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 30) style:UITableViewStyleGrouped];
    _listTable.dataSource = self;
    _listTable.delegate = self;
    [self.view addSubview:_listTable];
}

- (void)setNet
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate* date = [formatter dateFromString:_dataStr];
    
    NSTimeInterval HSLtimeStamp= [date timeIntervalSince1970];
    
    [WLNetworkWriteOffHandler requestWriteOffDetailWithDate:[NSString stringWithFormat:@"%ld",(long)HSLtimeStamp] nextUrl:nil resultBlock:^(BOOL success, NSArray *dataArray, NSString *nextUrl, NSString *message) {
        if (success) {
            _dataArr = [dataArray copy];
            [_listTable reloadData];
        }
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return _dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ScaleH(150);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //tableView每个分组的头部视图
    WLdetailHeadView * headView = [[WLdetailHeadView alloc] init];
    headView.titleLable.text = [NSString stringWithFormat:@"%@",_dataStr];
    headView.balanceLable.text = [NSString stringWithFormat:@"%@",_howStr];
    return headView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [_listTable dequeueReusableCellWithIdentifier:@"listCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"listCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//选中不变颜色
    WLWriteOffDetailObject *object = _dataArr[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",object.electronic_code];//@"600088866555";
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[WLDataHotelHandler TimeIntervalChangeWithhhmmssString:object.consuming_at]]];//@"18:25:49";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //显示菊花
    [self showHud];
    WLWriteOffDetailObject *object = _dataArr[indexPath.row];
    [WLNetworkWriteOffHandler requestWriteOffDetailgetGoWithDate:object.objectID resultBlock:^(BOOL success, WLWriteOffObject *dataArray, WLWriteOffObjectBuyUser *modelbusy, NSString *message) {
        //隐藏菊花
        [self hidHud];
        if (success) {
            if ([dataArray.is_passed_card isEqual:@"0"]) {
                WLResultWriteOffViewController * nextVC = [[WLResultWriteOffViewController alloc] init];
                nextVC.resultStr = @"核销成功";
                nextVC.model = dataArray;
                [self.navigationController pushViewController:nextVC animated:errSSLCertNotYetValid];
            }
            if ([dataArray.is_passed_card isEqual:@"1"]) {
                WLOneCardViewController * nextVC = [[WLOneCardViewController alloc] init];
                nextVC.model = dataArray;
                nextVC.model2 = modelbusy;
                [self.navigationController pushViewController:nextVC animated:errSSLCertNotYetValid];
            }
            
        }
    }];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
