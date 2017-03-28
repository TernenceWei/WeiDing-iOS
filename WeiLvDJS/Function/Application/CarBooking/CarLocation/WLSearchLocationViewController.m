//
//  WLSearchLocationViewController.m
//  WeiLvDJS
//
//  Created by hsliang on 2017/2/15.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLSearchLocationViewController.h"
#import "WLCarLocationListViewController.h"
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface WLSearchLocationViewController ()<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate,BMKSuggestionSearchDelegate,CLLocationManagerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UIButton *cityBtn;
@property (nonatomic, strong) UITextField *addressField;

@property (nonatomic, strong) BMKSuggestionSearch * zaixianSearch; // 在线检索

@end

@implementation WLSearchLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigationBar];
    [self setupUI];
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    //[self selectCityBtnClick];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    _zaixianSearch.delegate = nil;
}

- (void)setupNavigationBar
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    self.cityBtn = [UIButton buttonWithTitle:[NSString stringWithFormat:@"%@ ▼",_cityName] titleColor:[WLTools stringToColor:@"#00cc99"] font:[UIFont WLFontOfSize:15] target:self action:@selector(selectCityBtnClick)];
    self.cityBtn.frame = CGRectMake(ScaleW(10), 20, ScaleW(80), 44);
    [topView addSubview:self.cityBtn];
    
    self.addressField = [[UITextField alloc]initWithFrame:CGRectMake(self.cityBtn.right + 8, 20, ScreenWidth - ScaleW(110), 44)];
    self.addressField.placeholder = @"请输入地点";
    self.addressField.font = [UIFont WLFontOfSize:15];
    //self.addressField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.addressField.returnKeyType = UIReturnKeyDone;
    self.addressField.textColor = Color2;
    self.addressField.delegate = self;
    [self.addressField addTarget:self action:@selector(textFieldTextDidChange) forControlEvents:UIControlEventEditingChanged];
    [topView addSubview:self.addressField];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelBtn.frame = CGRectMake(ScreenWidth - ScaleW(50), 20, ScaleW(40), 44);
    [cancelBtn addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTintColor:[WLTools stringToColor:@"#4977e7"]];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:Color1 forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont WLFontOfSize:15];
    [topView addSubview:cancelBtn];
}

- (void)setupUI
{
    self.view.backgroundColor = bordColor;
    //    if (self.dataArray.count == 0) {
    //        return;
    //    }
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(ScaleW(12), ScaleW(12) + 64, ScreenWidth - ScaleW(24), ScreenHeight - 64 - ScaleW(12))];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.layer.cornerRadius = 4;
    self.tableView.layer.masksToBounds = YES;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)textFieldTextDidChange
{
    NSString *inputString = self.addressField.text;
    
    //初始化检索对象
    _zaixianSearch =[[BMKSuggestionSearch alloc]init];
    _zaixianSearch.delegate = self;
    BMKSuggestionSearchOption* option = [[BMKSuggestionSearchOption alloc] init];
    option.cityname = _cityName;
    option.keyword  = inputString;
    BOOL flag = [_zaixianSearch suggestionSearch:option];
    
    if(flag)
    {
        NSLog(@"ZAIXIAN建议检索发送成功");
    }
    else
    {
        NSLog(@"建议检索发送失败");
    }
    
    
    if ([inputString isEqualToString:@""]) {
        //[self.searchArray removeAllObjects];
        [self.tableView reloadData];
        return;
    }
}

//实现Delegate处理回调结果
- (void)onGetSuggestionResult:(BMKSuggestionSearch*)searcher result:(BMKSuggestionResult*)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        //WlLog(@"在线检索回调==%@",result);
        [_dataArray removeAllObjects];
        for (NSString * showStr in result.keyList) {
            [_dataArray addObject:showStr];
            [self.tableView reloadData];
        }
    }
    else {
        //NSLog(@"抱歉，未找到结果");
    }
}

- (void)selectCityBtnClick
{
    WLCarLocationListViewController * nextVC = [[WLCarLocationListViewController alloc] init];
    nextVC.company_id = _company_id;
    nextVC.cityArr = _cityArr;
    nextVC.cityItemName = _cityNameDW;
    [self.navigationController pushViewController:nextVC animated:YES];
    [nextVC wCClickAction:^(WLCityItem *item) {
        _cityName = item.cityName;
        [_cityBtn setTitle:[NSString stringWithFormat:@"%@ ▼",item.cityName] forState:UIControlStateNormal];
    }];
    //[self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"identifier1"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier1"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"dinweiImg"];
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleH(45);
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (self.searchArray.count) {
//        return UITableViewCellEditingStyleNone;
//    }
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataArray removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    self.onAddressBlock(self.dataArray[indexPath.row],_cityName);
    self.addressField.text = self.dataArray[indexPath.row];
    [self finishInput];
}

#pragma  mark delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.returnKeyType == UIReturnKeyDone) {
        
//        if (self.addressField.text.length && self.provinceID && self.cityID) {
//            [self.view endEditing:YES];
//            [self finishInput];
//            return YES;
//        }else{
//            return NO;
//        }
        [_addressField resignFirstResponder];
    }
    return YES;
    
}

- (void)finishInput
{
    [self cancelButtonClick];
}

- (void)cancelButtonClick
{
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:NO];
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
