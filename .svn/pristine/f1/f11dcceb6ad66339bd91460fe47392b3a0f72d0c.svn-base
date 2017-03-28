//
//  WLOneCardViewController.m
//  WeiLvDJS
//
//  Created by ternence on 2017/1/10.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLOneCardViewController.h"
#import "WLOneCardHeaderView.h"
#import "WLOneCardCell.h"

#import "WLDataHotelHandler.h"

@interface WLOneCardViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) BOOL isinvalid;

@end

@implementation WLOneCardViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupUI];
    //[self loadData];
}

- (void)setupUI
{
    //取出现在的时间
    NSDate *nowDate = [NSDate date];
    NSTimeInterval nowtimeStamp= [nowDate timeIntervalSince1970];

    if (([_model.used_end_day integerValue] - nowtimeStamp)>0) {
        _isinvalid = NO;
    }
    else
    {
        _isinvalid = YES;
    }
    
    self.dataArray = [NSMutableArray arrayWithObjects:@[@"产品名称", [NSString stringWithFormat:@"%@",_model.prduct_name]],
                                                      @[@"有效日期", [NSString stringWithFormat:@"%@~%@",[WLDataHotelHandler TimeIntervalChangeWithYMDString222:_model.used_day],[WLDataHotelHandler TimeIntervalChangeWithYMDString222:_model.used_end_day]]],
                                                      @[@"姓名", [NSString stringWithFormat:@"%@",_model2.real_name]],
                                                      @[@"手机号", [NSString stringWithFormat:@"%@",_model2.mobile]],
                                                      @[@"身份证号", [NSString stringWithFormat:@"%@",_model2.id_card]],
                                                      @[@"身份正面", [NSString stringWithFormat:@"%@",_model2.idcard_front_img]],
                                                      @[@"身份背面", [NSString stringWithFormat:@"%@",_model2.idcard_back_img]],nil];
    
    self.titleItem.title = @"一卡通核销结果";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, ScreenWidth, ScreenHeight - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = BgViewColor;
    [self.view addSubview:self.tableView];
    
    WLOneCardHeaderView *headerView = [[WLOneCardHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(227))];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.imgimg = _model.imgimg;
    self.tableView.tableHeaderView = headerView;

}


//- (void)loadData{
//    
//    __weak __typeof__(self) weakSelf = self;
//    
//    
//
//    
//}


#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    return 5;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLOneCardCell *cell = [WLOneCardCell cellWithTableView:tableView];
    if (indexPath.section == 0) {
        [cell setTextArray:self.dataArray[indexPath.row] isinvalid:_isinvalid IndexPath:indexPath];
    }else if (indexPath.section == 1){
        [cell setTextArray:self.dataArray[indexPath.row + 2] isinvalid:_isinvalid IndexPath:indexPath];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 3) {
        return ScaleH(220);
    }
    else if (indexPath.section == 1 && indexPath.row == 4)
    {
        return ScaleH(220);
    }
    return ScaleH(56);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *textArray = @[@"一卡通信息",@"持卡人信息"];
    UIView *view = [[UIView alloc] init];
    UILabel *label = [UILabel labelWithText:textArray[section] textColor:Color2 fontSize:14];
    label.frame = CGRectMake(ScaleW(12), 0, ScreenWidth, ScaleH(43));
    [view addSubview:label];
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ScaleH(43);
}

@end
