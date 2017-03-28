//
//  WL_ContactIndex_View.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/8.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_ContactIndex_View.h"

@interface WL_ContactIndex_View ()<UITableViewDelegate, UITableViewDataSource>
//tableView
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation WL_ContactIndex_View

#pragma mark ----LazyLoad

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 18;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_tableView];
        
    }
    return _tableView;
}

- (void)setDataSource:(NSArray *)dataSource
{
    
    if (dataSource != _dataSource) {
        _dataSource = dataSource;
        
        [self setUpView];
    }
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setUpView
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(self.mas_width);
        make.center.equalTo(self);
        make.height.equalTo(@(20*self.dataSource.count));
        
    }];
    
    [self.tableView reloadData];
}

#pragma mark
#pragma mark -----tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.font = WLFontSize(13);
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.textColor = [WLTools stringToColor:@"#60b5f6"];
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (self.SelectIndex) {
        self.SelectIndex(indexPath.row);
    }
    
    
}


@end
