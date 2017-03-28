//
//  WLApplicationCarChoiceViewController.m
//  WeiLvDJS
//
//  Created by whw on 17/1/10.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLApplicationCarChoiceViewController.h"

@interface WLApplicationCarChoiceViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *titleArr;//数据源

@end

@implementation WLApplicationCarChoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"车辆类型";
    [self setupUI];
}

- (void)setupUI
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
    tableView.backgroundColor = Color6;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CarChoiceCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.titleArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WS(weakSelf);
    if (self.carChoiceBlock) {
        self.carChoiceBlock(weakSelf.titleArr[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (NSArray *)titleArr
{
    if (!_titleArr) {
        _titleArr = @[ @"大巴",@"商务车",];
    }
    return _titleArr;
}
@end
