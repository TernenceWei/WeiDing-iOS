//
//  WLGuideLineViewController.m
//  WeiLvDJS
//
//  Created by whw on 16/11/2.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLGuideLineViewController.h"
#import "WLGuideLineTableViewCell.h"
#import "WLNetworkManager.h"
#import "WLGuideOrdelDetailViewController.h"


@interface WLGuideLineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic, strong)NSArray *array;

@end

@implementation WLGuideLineViewController

-(NSArray *)array{
    if (_array == nil) {
        _array = [NSArray array];
    }
    return _array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"路线详情";
;
    [self creatView];
    [self loadData];
}

-(void)creatView{
    self.tableView = [[UITableView alloc] init];
    self.tableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = HEXCOLOR(0xffffff);
    [self.view addSubview:self.tableView];
    
}

-(void)loadData {
    [WLNetworkManager requestLineInfoWithGroupID:self.orderInfo.groupListID result:^(BOOL success, NSArray *lineArray) {
        if(success){
            self.array = lineArray;
            
            [self.tableView reloadData];
        }
    }];
}

#pragma mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"ID";
    WLGuideLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WLGuideLineTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = [NSString stringWithFormat:@"第%ld天",(indexPath.row+1)];
    
    CGSize titleSize = [_array[indexPath.row] boundingRectWithSize:CGSizeMake(233, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    [cell setDataModel:_array[indexPath.row] dayrow:[NSString stringWithFormat:@"%ld",(long)indexPath.row] height:titleSize];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGSize titleSize = [_array[indexPath.row] boundingRectWithSize:CGSizeMake(310, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    if (titleSize.height > 50) {
        return ScaleH(30) + titleSize.height;
    }
    else
        
    return ScaleH(50) + titleSize.height;
}
@end
