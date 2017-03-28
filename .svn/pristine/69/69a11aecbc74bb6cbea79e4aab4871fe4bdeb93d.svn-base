//
//  WLResultWriteOffViewController.m
//  WeiLvDJS
//
//  Created by hsliang on 2017/1/5.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLResultWriteOffViewController.h"
#import "WLResultWriteOffTableViewCell.h"

@interface WLResultWriteOffViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UILabel * showResultLabel;
@property (nonatomic, strong) UITableView * resultTable;
@property (nonatomic, strong) NSMutableArray * dataArr;

@end

@implementation WLResultWriteOffViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BgViewColor;
    
    [self setUI];
}

- (void)setUI
{
    UIView * inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(250))];
    inputView.backgroundColor = [WLTools stringToColor:@"#00cc99"];
    [self.view addSubview:inputView];
    
    UIButton * blackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, ScaleH(20), ScaleW(50), ScaleH(50))];
    //blackBtn.backgroundColor = [UIColor redColor];
    [blackBtn addTarget:self action:@selector(blackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [inputView addSubview:blackBtn];
    
    UIImageView * backIMg = [[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(10), ScaleH(10), ScaleW(17), ScaleH(30))];
    [backIMg setImage:[UIImage imageNamed:@"returnImg"]];
    [blackBtn addSubview:backIMg];
    
    UILabel * thisTitle = [[UILabel alloc] initWithFrame:CGRectMake((inputView.frame.size.width / 2) - ScaleW(50), ScaleH(35), ScaleW(100), ScaleH(20))];
    thisTitle.text = @"核销结果";
    thisTitle.font = [UIFont WLFontOfSize:18.0];
    thisTitle.textAlignment = NSTextAlignmentCenter;
    thisTitle.textColor = [UIColor whiteColor];
    [inputView addSubview:thisTitle];
    
    _showResultLabel = [[UILabel alloc] initWithFrame:CGRectMake((inputView.frame.size.width / 2) - ScaleW(50), inputView.frame.size.height - ScaleH(50), ScaleW(100), ScaleH(20))];
    _showResultLabel.textColor = [UIColor whiteColor];
    _showResultLabel.text = _resultStr;//@"核销成功";
    _showResultLabel.textAlignment = NSTextAlignmentCenter;
    _showResultLabel.font = [UIFont WLFontOfSize:20.0];
    [inputView addSubview:_showResultLabel];
    
    UIImageView * resultImg = [[UIImageView alloc] initWithFrame:CGRectMake((inputView.frame.size.width / 2) - ScaleW(60), thisTitle.frame.origin.y + thisTitle.frame.size.height + ScaleH(20), ScaleW(135), ScaleH(115))];
    [inputView addSubview:resultImg];
    
    _resultTable = [[UITableView alloc] initWithFrame:CGRectZero];
    //不显示分割线
    _resultTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _resultTable.delegate = self;
    _resultTable.dataSource = self;
    [self.view addSubview:_resultTable];
    
    if ([_resultStr isEqual:@"核销成功"]) {
        [resultImg setImage:[UIImage imageNamed:@"successful"]];
        inputView.backgroundColor = [WLTools stringToColor:@"#6ad9c9"];
        _resultTable.frame = CGRectMake(0, inputView.frame.origin.y + inputView.frame.size.height + ScaleH(20), ScreenWidth, ScreenHeight - inputView.frame.origin.y - inputView.frame.size.height - ScaleH(20));
    }
    else if ([_resultStr isEqual:@"已核销"]) {
        [resultImg setImage:[UIImage imageNamed:@"yijin"]];
        inputView.backgroundColor = [WLTools stringToColor:@"#59cdee"];
        _resultTable.frame = CGRectMake(0, inputView.frame.origin.y + inputView.frame.size.height, ScreenWidth, ScreenHeight - inputView.frame.origin.y - inputView.frame.size.height);
    }
    else if ([_resultStr isEqual:@"无法识别"]) {
        [resultImg setImage:[UIImage imageNamed:@"wufshibie"]];
        inputView.backgroundColor = [WLTools stringToColor:@"#f99254"];
        _resultTable.frame = CGRectMake(0, inputView.frame.origin.y + inputView.frame.size.height, ScreenWidth, ScreenHeight - inputView.frame.origin.y - inputView.frame.size.height);
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_resultStr isEqual:@"核销成功"]) {
        return 1;
    }
    else
    {
        return 0;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     WLResultWriteOffTableViewCell *cell = [WLResultWriteOffTableViewCell cellCreateTableView:tableView];
    [cell setCellModel:_model];
    return cell;
}

- (void)blackBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
