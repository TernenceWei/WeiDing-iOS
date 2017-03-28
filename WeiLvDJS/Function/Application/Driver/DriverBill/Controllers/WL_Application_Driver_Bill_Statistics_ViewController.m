//
//  WL_Application_Driver_Bill_Statistics_ViewController.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/10/9.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_Bill_Statistics_ViewController.h"
//总金额View
#import "WL_Application_Driver_Bill_Statistics_TopView.h"
//金额分类详情View
#import "WL_Application_Driver_Bill_StatisticsDetail_View.h"
//车队比例View
#import "WL_Application_Driver_Bill_CompanyScale_View.h"
//车队列表cell
#import "WL_Application_Driver_Bill_Companys_Cell.h"
//底部的折线图View
#import "WL_Application_Driver_Bill_StatisticsBottom_View.h"

#import "WL_Application_Driver_Bill_Statistics_Model.h"
#import "WL_Application_Driver_Bill_Statistics_Bill_Model.h"
#import "WL_Application_Driver_Bill_Statistics_Price_Model.h"
#import "WL_Application_Driver_Bill_Statistics_Company_Model.h"
#import "WL_Application_Driver_Bill_Statistics_lineChartView.h"
#import "LXMPieView.h"
#import "WL_Warning_Window.h"

#import "WLNetworkDriverHandler.h"

//-----------------折线图
#import "SJLineChart.h"

@interface WL_Application_Driver_Bill_Statistics_ViewController ()<UITableViewDelegate, UITableViewDataSource>

/** 车队列表的TableView */
@property(nonatomic, weak) UITableView *companysTableView;
/** 头部View */
@property(nonatomic, weak) WL_Application_Driver_Bill_Statistics_TopView *topView;
/** 收入详情View */
@property(nonatomic, weak) WL_Application_Driver_Bill_StatisticsDetail_View *detailView;
/** 各车队所占比例View */
@property(nonatomic, weak) WL_Application_Driver_Bill_CompanyScale_View *companyScaleView;
/** 底部View */
@property(nonatomic, weak)  WL_Application_Driver_Bill_StatisticsBottom_View *statisticsBottomView;
/** 折线图的底部View */
//@property(nonatomic, weak)WL_Application_Driver_Bill_Statistics_lineChartView *bottomView;
/** 弹框View */
@property(nonatomic, strong)WL_TipAlert_View *alert;
/** data模型 */
@property(nonatomic, strong) WLDriverBillStatisticsObject * dataModel;  //新的


/** 收益趋势模型数组 */
@property(nonatomic, strong) NSMutableArray *bills;
/** 收益月份数组 */
@property(nonatomic, strong) NSMutableArray *months;
/** 每月收益数组 */
@property(nonatomic, strong) NSMutableArray *amounts;
/** 收益年份数组 */
@property(nonatomic, strong) NSMutableArray *years;
/** 各车队收入所占比例数组 */
@property(nonatomic, strong) NSMutableArray *companyScales;
/** 各车队对应颜色数组 */
@property(nonatomic, strong) NSMutableArray *companyColor;
/** 各月总收入点View数组 */
@property(nonatomic, strong) NSMutableArray *pointViews;
///** 整体收入状况模型 */
//@property(nonatomic, strong) WL_Application_Driver_Bill_Statistics_Price_Model *price;

//内容底层的ScrollView
@property(nonatomic, weak)UIScrollView *contentScrollView;

@property(nonatomic, strong)WL_Warning_Window *warningAlert;

/** 无网络的View */
@property (nonatomic, strong) WL_NoData_View *noDataView;

@property (nonatomic, strong) SJLineChart *lineChart; // 折线图

@end

@implementation WL_Application_Driver_Bill_Statistics_ViewController
//cellId
static NSString *const cellId = @"cellId";

#pragma mark - LAZY


- (WL_Warning_Window *)warningAlert
{
    if (!_warningAlert) {
        _warningAlert = [[WL_Warning_Window alloc] init];
        [_warningAlert setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    }
    
    
    return _warningAlert;
}

- (NSMutableArray *)bills
{
    if (!_bills) {
        _bills = [NSMutableArray array];
    }
    return _bills;
}

- (NSMutableArray *)companyScales
{
    if (!_companyScales) {
        _companyScales = [NSMutableArray array];
    }
    return _companyScales;
}

- (NSMutableArray *)companyColor
{
    if (!_companyColor) {
        _companyColor = [NSMutableArray array];
    }
    return _companyColor;
}

- (NSMutableArray *)months
{
    if (!_months) {
        _months = [NSMutableArray array];
    }
    return _months;
}

- (NSMutableArray *)years
{
    if (!_years) {
        _years = [NSMutableArray array];
    }
    return _years;
}

- (NSMutableArray *)amounts
{
    if (!_amounts) {
        _amounts = [NSMutableArray array];
    }
    return _amounts;
}

- (NSMutableArray *)pointViews
{
    if (!_pointViews) {
        _pointViews = [NSMutableArray array];
    }
    return _pointViews;
}

- (WL_NoData_View *)noDataView
{
    if (_noDataView == nil) {
        
                WS(weakSelf);
        
        _noDataView = [[WL_NoData_View alloc] initWithFrame:self.view.frame andRefreshBlock:^{
            
            [weakSelf sendRequestToBillStatistics];
        }];
        [self.view addSubview:_noDataView];
        
        _noDataView.hidden = YES;
    }
    
    return _noDataView;
}


#pragma makr - 设置无数据提示的显示、隐藏及类型
- (void)hideNoData:(BOOL)hidden andType:(WLNetworkType)type {
    
    self.noDataView.hidden = hidden;
    
    if (!hidden) {
        
        self.noDataView.type = type;
        
    }
}


#pragma mark - 读进内存调用方法
- (void)viewDidLoad
{
    [super viewDidLoad];
   
    //设置内容View
    [self setupContentViewToBillStatistics];
    //发送网络请求
    [self sendRequestToBillStatistics];
    //注册弹框
    [self creatTipAlertView];
     [self.view addSubview:self.noDataView];
}



#pragma mark - 注册弹框
- (void)creatTipAlertView
{
    self.alert = [WL_TipAlert_View sharedAlert];
}

#pragma mark - 设置内容View
- (void)setupContentViewToBillStatistics
{
    
    self.view.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    //内容底层的ScrollView
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    //添加到父控件
    [self.view addSubview:contentScrollView];
    //添加约束
    [contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    //设置属性
    contentScrollView.showsVerticalScrollIndicator = NO;
    contentScrollView.contentSize = CGSizeMake(ScreenWidth, 600 * AUTO_IPHONE6_HEIGHT_667);
    contentScrollView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    [contentScrollView layoutIfNeeded];
    contentScrollView.hidden = YES;
//    //0.1底部View
    UIView *view = [[UIView alloc] init];
    [contentScrollView addSubview:view];
    self.contentScrollView = contentScrollView;
    //添加约束
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(contentScrollView.mas_bottom).offset(-500);
        make.height.equalTo(@(600 * AUTO_IPHONE6_HEIGHT_667));
    }];
    //添加属性
    view.backgroundColor = [WLTools stringToColor:@"#4778e7"];
//
    
    //1.0头部View
    WL_Application_Driver_Bill_Statistics_TopView *topView = [[WL_Application_Driver_Bill_Statistics_TopView alloc] init];
    //添加到父控件
    [contentScrollView addSubview:topView];
    //添加约束
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentScrollView.mas_top);
        make.right.equalTo(self.view.mas_right);
        make.left.equalTo(self.view.mas_left);
        make.height.equalTo(@(180 * AUTO_IPHONE6_HEIGHT_667));
    }];
    self.topView = topView;
    topView.backgroundColor = [UIColor whiteColor];//[WLTools stringToColor:@"#4778e7"];
    
    
    
    //1.2 公司所占详情View
    WL_Application_Driver_Bill_CompanyScale_View *companyScaleView = [[WL_Application_Driver_Bill_CompanyScale_View alloc] init];
//    [contentScrollView addSubview:companyScaleView];
    //添加约束
//    [companyScaleView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(topView.mas_bottom);
//        make.left.equalTo(self.view.mas_left);
//        make.right.equalTo(self.view.mas_right);
//        make.height.equalTo(@(191 * AUTO_IPHONE6_HEIGHT_667));
//    }];
    //设置属性
    self.companysTableView = companyScaleView.companysTableView;
    self.companysTableView.delegate = self;
    self.companysTableView.dataSource = self;
    [self.companysTableView registerClass:[WL_Application_Driver_Bill_Companys_Cell class] forCellReuseIdentifier:cellId];
    self.companyScaleView = companyScaleView;
    
    
    //1.3添加底部的View
    WL_Application_Driver_Bill_StatisticsBottom_View *statisticsBottomView = [[WL_Application_Driver_Bill_StatisticsBottom_View alloc] init];
    [contentScrollView addSubview:statisticsBottomView];

    //添加约束
    [statisticsBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(topView.mas_bottom);
        make.height.equalTo(@(258 * AUTO_IPHONE6_HEIGHT_667));
    }];
    self.statisticsBottomView = statisticsBottomView;
    
    // 初始化折线图
    _lineChart = [[SJLineChart alloc] initWithFrame:CGRectMake(10, ScaleH(55), [UIScreen mainScreen].bounds.size.width - 20, 200)];
    [self.statisticsBottomView addSubview:_lineChart];
}

#pragma mark - 发送网络请求
- (void)sendRequestToBillStatistics
{
    [[WLNetworkDriverHandler sharedInstance] requestDriverBillStatisticsWithDataBlock:^(WLResponseType responseType, id data, NSString *message) {
        self.noDataView.hidden = NO;
        [self setNavigationRightImg:@"tshi01Img"];
        
        if (responseType == WLResponseTypeSuccess) {
            
            self.noDataView.hidden = YES;
            
            _dataModel = data;
            
            //        if ([_dataModel.totalPrice isEqualToString:@"0"] || _dataModel.totalPrice == nil) {
            //            [self hideNoData:NO andType:WLNetworkTypeNOData];
            //            return;
            //        }
            
            self.noDataView.hidden = YES;
            self.contentScrollView.hidden = NO;
            NSMutableArray *colorArr = [NSMutableArray array];
            [colorArr addObject:[WLTools stringToColor:@"#2ddfa3"]];
            [colorArr addObject:[WLTools stringToColor:@"#5c80c9"]];
            [colorArr addObject:[WLTools stringToColor:@"#97c931"]];
            [colorArr addObject:[WLTools stringToColor:@"#fed650"]];
            [colorArr addObject:[WLTools stringToColor:@"#f78925"]];
            [colorArr addObject:[WLTools stringToColor:@"#01c255"]];
            [colorArr addObject:[WLTools stringToColor:@"#5633c4"]];
            [colorArr addObject:[WLTools stringToColor:@"#d144ff"]];
            [colorArr addObject:[WLTools stringToColor:@"#fe3c5a"]];
            [colorArr addObject:[WLTools stringToColor:@"#fe7254"]];
            
            for (int i = 0; i < _dataModel.proportionArray.count; i++) {
                WLDriverBillStatisticsProportionObject *companyModel = _dataModel.proportionArray[i];
                
                [self.companyScales addObject:companyModel.percent];
                [self.companyColor addObject:colorArr[i]];
            }
            
            //        for (WL_Application_Driver_Bill_Statistics_Company_Model *companyModel in self.companys)
            //        {
            //            //将各个车队所占比例添加到各车队所占比例数组中
            //            [self.companyScales addObject:companyModel.percent];
            //            //将随机色添加到颜色数组中
            //
            //            UIColor *companyColor = WLColor(arc4random_uniform(255.0), arc4random_uniform(255.0), arc4random_uniform(255.0), 1);
            //            [self.companyColor addObject:companyColor];
            //
            //        }
            
            //为内容View各控件赋值
            [self assignmentToContentView];
            
            NSInteger isSix = 0;
            NSString *month = [[NSString alloc] init];
            if (_dataModel.trendArray.count != 0) {
                WLDriverBillStatisticsTrendObject *monthModel  = _dataModel.trendArray[_dataModel.trendArray.count - 1];
                month = [NSString stringWithFormat:@"%zd", [monthModel.month integerValue]];
                
                isSix = [monthModel.month integerValue];
            }
            else
            {
                NSDate *nowDate = [NSDate date];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSDateComponents *dateComps = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:nowDate];
                NSInteger monthh = [dateComps month];
                isSix = monthh;
                
                month = [NSString stringWithFormat:@"%zd", monthh];
            }
            
            if (isSix < 6)
            {
                
                NSInteger howbegin = 12 - (5 - isSix);
                
                for (NSInteger ij = howbegin; ij < 13; ij ++)
                {
                    [self.years addObject:@{@"item":[NSString stringWithFormat:@"%ld月",(long)ij],@"count":@0}];
                }
                
                for (NSInteger j = 1; j < isSix; j ++)
                {
                    [self.years addObject:@{@"item":[NSString stringWithFormat:@"%ld月",(long)j],@"count":@0}];
                }
            }
            else
            {
                for (NSInteger j = 1; j <= isSix; j ++)
                {
                    [self.years addObject:@{@"item":[NSString stringWithFormat:@"%ld月",(long)j],@"count":@0}];
                }
            }
            [self.years addObject:@{@"item":[NSString stringWithFormat:@"%@月",month],@"count":@0}];
            
            // 修改值
            for (NSInteger i = 0; i < _dataModel.trendArray.count; i ++)
            {
                WLDriverBillStatisticsTrendObject *monthModel  = _dataModel.trendArray[i];
                
                for (NSInteger j = 0; j < self.years.count; j ++) {
                    NSDictionary * dicData = self.years[j];
                    NSString * subStr = dicData[@"item"];
                    subStr = [subStr substringToIndex:subStr.length - 1];
                    
                    if ([subStr isEqualToString:[NSString stringWithFormat:@"%zd", [monthModel.month integerValue]]]) {
                        [self.years replaceObjectAtIndex:j withObject:@{@"item":[NSString stringWithFormat:@"%@月",subStr],@"count":monthModel.price}];
                    }
                }
            }
            
            // 设置折线图属性
            _lineChart.title = [NSString stringWithFormat:@"%@年",_dataModel.year]; // 折线图名称
            _lineChart.maxValue = 30000;   // 最大值
            _lineChart.yMarkTitles = @[@"0",@"1万",@"2万",@"3万"]; // Y轴刻度标签
            
            [_lineChart setXMarkTitlesAndValues:self.years titleKey:@"item" valueKey:@"count"]; // X轴刻度标签及相应的值
            
            _lineChart.xScaleMarkLEN = 60; // 可以不设，会根据视图的宽度自适应,设置后如果折线图的宽度大于视图宽度，折线图可以滑动
            
            //设置完数据等属性后绘图折线图
            [_lineChart mapping];
            
            [self.companysTableView reloadData];
            
        }
        else if (responseType == WLResponseTypeNoNetwork) {
            [self.alert createTip:message];
        }
        else if (responseType == WLResponseTypeServerError) {
            [self.alert createTip:message];
        }
        //隐藏菊花
        [self hidHud];
    }];
}

#pragma mark - 右边提示点击方法
- (void)NavigationRightEvent
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.warningAlert];
    
    self.warningAlert.tipString = @"目前仅统计已结算完成的订单。";
    self.warningAlert.buttonTittle = @"好的";
}

#pragma mark - 给内容View赋值
- (void)assignmentToContentView
{
    //总额
    if (_dataModel.totalPrice == nil) {
        self.topView.totalIncomeLable.text = @"0.00";
    }else{
        self.topView.totalIncomeLable.text = [NSString stringWithFormat:@"%.2f",[_dataModel.totalPrice doubleValue]];
    }
    
    //添加圆环
    NSMutableArray *modelArray = [NSMutableArray array];
    
    NSArray *valueArray =self.companyScales;
    
    NSArray *colorArray = self.companyColor;
    
    for (int i = 0 ; i <valueArray.count ; i++)
    {
        LXMPieModel *model = [[LXMPieModel alloc] initWithColor:colorArray[i] value:[valueArray[i] floatValue] text:nil];
        [modelArray addObject:model];
    }
    LXMPieView *pieView = [[LXMPieView alloc] initWithFrame:CGRectMake(34 * AUTO_IPHONE6_WIDTH_375, 45, 115 * AUTO_IPHONE6_HEIGHT_667, 115 * AUTO_IPHONE6_HEIGHT_667) values:modelArray];
    [self.companyScaleView addSubview:pieView];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataModel.proportionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WL_Application_Driver_Bill_Companys_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.companyModel = _dataModel.proportionArray[indexPath.row];
    cell.colorView.backgroundColor = self.companyColor[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 26.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 26.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [self.alert removeFromSuperview];
}

@end
