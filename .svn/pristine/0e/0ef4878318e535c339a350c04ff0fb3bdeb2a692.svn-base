//
//  WL_Mine_Setting_AboutWeiDing_ViewController.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/14.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Mine_Setting_AboutWeiDing_ViewController.h"
#import "WL_Mine_Setting_AboutWeiDing_View.h"
#import "WL_Mine_Setting_AboutWeiDing_Cell.h"

@interface WL_Mine_Setting_AboutWeiDing_ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, copy)NSString *appStoreVersion;

//@property (nonatomic, strong) UIButton * TestingNewVersionBtn;

@end

@implementation WL_Mine_Setting_AboutWeiDing_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.设置Nav内容
    [self setupNavToAboutWeiDing];
    //2.获取App在AppStore上的版本号
    //[self getVersionToAppStore];
    //2.设置内容
    [self setupContentViewToAboutWeiDing];
    

}

#pragma mark - 设置Nav内容
- (void)setupNavToAboutWeiDing
{
    self.titleItem.title = @"关于微叮";
}

#pragma mark - 设置内容
static NSString *const cellId = @"AboutWeiDingCell";
-(void)setupContentViewToAboutWeiDing
{
    //设置控制器的View的背景颜色
    self.view.backgroundColor = BgViewColor;
    WL_Mine_Setting_AboutWeiDing_View *aboutWeiDingView = [[WL_Mine_Setting_AboutWeiDing_View alloc] init];
    //添加到父控件
    [self.view addSubview:aboutWeiDingView];
    //设置属性
    aboutWeiDingView.backgroundColor = BgViewColor;
    //添加约束
    [aboutWeiDingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(@65);
        make.height.equalTo(@220);
    }];
    
//    // 检测版本按钮
//    _TestingNewVersionBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 2) - ScaleW(70), ScaleH(250), ScaleW(140), ScaleH(40))];
//    [_TestingNewVersionBtn setTitle:@"检测新版本" forState:UIControlStateNormal];
//    [_TestingNewVersionBtn setTitleColor:[WLTools stringToColor:@"#00cc99"] forState:UIControlStateNormal];
//    [_TestingNewVersionBtn setBackgroundColor:[UIColor whiteColor]];
//    _TestingNewVersionBtn.layer.borderColor = [WLTools stringToColor:@"#00cc99"].CGColor;
//    _TestingNewVersionBtn.layer.borderWidth = 1;
//    _TestingNewVersionBtn.layer.cornerRadius = 20;
//    [self.view addSubview:_TestingNewVersionBtn];
    
//    //内容TableView
//    UITableView *contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
//    //添加到父控件
//    [self.view addSubview:contentTableView];
//   //添加约束
//    [contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(aboutWeiDingView.mas_bottom);
//        make.left.equalTo(self.view.mas_left);
//        make.right.equalTo(self.view.mas_right);
//        make.bottom.equalTo(self.view.mas_bottom);
//    }];
//    //设置tableView的代理和数据源为控制器
//    contentTableView.delegate = self;
//    contentTableView.dataSource = self;
//    //设置tableView的属性
//    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    contentTableView.backgroundColor = BgViewColor;
//    contentTableView.scrollEnabled = NO;
//    //注册cell
//    [contentTableView registerClass:[WL_Mine_Setting_AboutWeiDing_Cell class] forCellReuseIdentifier:cellId];
    
    
    UILabel *copyRight = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenHeight - 180, ScreenWidth, 60)];
    copyRight.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    copyRight.text = @"Copyright © 2014-2016\n深圳微叮科技有限公司";
    copyRight.numberOfLines = 0;
    copyRight.textAlignment = NSTextAlignmentCenter;
    copyRight.font = WLFontSize(14);
    [self.view addSubview:copyRight];

 
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WL_Mine_Setting_AboutWeiDing_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (indexPath.row == 0)
    {
        cell.titleLable.text = @"版本更新";
        cell.tipLable.text = @"已是最新版本";
        //获取AppStore上的版本号
        if ([self.appStoreVersion isEqualToString:AppVersion])
        {
            cell.tipLable.text = @"已是最新版本";
            cell.userInteractionEnabled = NO;
        }
        else
        {
            cell.tipLable.text = @"发现新版本";
            cell.userInteractionEnabled = YES;
        }
        
        
        
        
        
        cell.lineView.hidden = NO;
    }
    if (indexPath.row == 1)
    {
        cell.titleLable.text = @"功能介绍";
    }
    return cell;
}

#pragma mark - 获取AppStore上的App版本号
- (void)getVersionToAppStore
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@", WeiLvAppID];
    manager.requestSerializer.timeoutInterval = 30;
    [manager POST:urlStr parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *array = responseObject[@"results"];
        NSDictionary *dict = [array lastObject];
        
        self.appStoreVersion = dict[@"version"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    

}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1)
    {
        //跳转功能介绍页面/引导页
    }
}



@end
