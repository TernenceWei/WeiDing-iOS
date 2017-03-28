//
//  WLApplicationGuideShowPriceViewController.m
//  WeiLvDJS
//
//  Created by whw on 16/10/18.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLApplicationGuideShowPriceViewController.h"
#import "WLApplicationGuideShowPriceTableViewCell.h"

@interface WLApplicationGuideShowPriceViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)NSMutableArray *leftArray;

@property(nonatomic, strong)NSMutableArray *midArray;

@end

@implementation WLApplicationGuideShowPriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNav];
    [self setUpTableView];
}


-(NSMutableArray *)leftArray{
    if (_leftArray == nil) {
        _leftArray = [[NSMutableArray alloc] initWithObjects:@"类型",@"单价",nil];
    }
    return _leftArray;
}



- (void)setUpNav{
    self.view.backgroundColor = BgViewColor;
    self.title = @"自定义报价";
    [self setNavigationRightTitle:@"报价方式" fontSize:14 titleColor:[UIColor whiteColor] isEnable:YES];
}

-(void)setUpTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.leftArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"ID";
    WLApplicationGuideShowPriceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WLApplicationGuideShowPriceTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.leftLabel.text = self.leftArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
