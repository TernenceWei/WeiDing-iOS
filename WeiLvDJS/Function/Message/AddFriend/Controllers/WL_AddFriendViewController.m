//
//  WL_AddFriendViewController.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/1.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddFriendViewController.h"

#import "WL_AddFriendViewController_Cell.h"

#import "WL_AddFriendByPhone_ViewController.h"
@interface WL_AddFriendViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray *tittleArray;
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation WL_AddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title =@"添加好友";
    self.view.backgroundColor = BgViewColor;
    

    [self initData];
    [self initUI];
    

    [self.view addSubview:self.tableView];
}
- (void)initData
{
    self.tittleArray =[NSArray arrayWithObjects:@"我的二维码",@"扫一扫加好友",@"手机通讯录",@"手机号码添加", nil];
    
}
-(UITableView *)tableView
{
    
    if (_tableView==nil) {
       
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, ScreenWidth, 200) style:UITableViewStylePlain];
        
        _tableView.dataSource =self;
        
        _tableView.delegate = self;
        
        _tableView.scrollEnabled = NO;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.backgroundColor =[UIColor whiteColor];
        
        _tableView.tableFooterView =[UIView new];
    }
   
    return _tableView;
    
}


-(void)initUI
{
    UILabel *topLabel =[UILabel new];
    [self.view addSubview:topLabel];
    topLabel.text = @"   更多人脉,更多商机";
    topLabel.font =WLFontSize(17);
    topLabel.textColor = WLColor(154, 154, 155, 1);
    
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.top.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(50);
        
    }];
    
    
}

#pragma  mark --- tableViewdelegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return  4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    
    WL_AddFriendViewController_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
   
    if (cell == nil)
    {
        cell =[[WL_AddFriendViewController_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        //单元格的选择风格，选择时单元格不出现蓝条UITableViewCellStyleDefault
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.row == 3) {
    
        cell.line.hidden =YES;
    }
    
    NSString *text = self.tittleArray[indexPath.row];
    cell.nameLabel.text = text;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (indexPath.row ==3) {
        
        WL_AddFriendByPhone_ViewController *VC =[[WL_AddFriendByPhone_ViewController alloc]init];
        
        [self.navigationController pushViewController:VC  animated:YES];
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
