//
//  WLTouristStatisticsController.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLTouristStatisticsController.h"
#import "WLIncomeStatisticsTopView.h"
#import "WLIncomeStatisticsCenterView.h"
#import "WLIncomeStatisticsBottomView.h"
#import "WLNetworkManager.h"

@interface WLTouristStatisticsController ()
@property (nonatomic, strong) WLIncomeStatisticsCenterView *centerView;
@end

@implementation WLTouristStatisticsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收入统计";
    self.view.backgroundColor =  HEXCOLOR(0xeff1fe);
    [self loadData];
}


- (void)loadData{
    
    [WLNetworkManager requestMyIncomeStatisticsWithResult:^(BOOL success, WLIncomeStatisInfo *info) {
        if (success && info != nil) {
            
            WLIncomeStatisticsTopView *topView = [[WLIncomeStatisticsTopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(100)) text:[NSString stringWithFormat:@"%@",info.totalIncome]];
            [self.view addSubview:topView];
            
            if (info.companyList.count) {
                WLIncomeStatisticsCenterView *centerView = [[WLIncomeStatisticsCenterView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame) + ScaleH(10), ScreenWidth, ScaleH(190)) objectArray:info.companyList];
                [self.view addSubview:centerView];
                self.centerView = centerView;
            }
            
            if (info.billList.count) {
                NSMutableArray *xArray = [NSMutableArray array];
                NSMutableArray *yArray = [NSMutableArray array];
                for (WLIncomeMonthInfo *month in info.billList) {
                    [xArray addObject:[self getMonthTextWithMonthString:month.month]];
                    [yArray addObject:month.income];
                }
                WLIncomeStatisticsBottomView *bottomView = [[WLIncomeStatisticsBottomView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.centerView.frame) + ScaleH(10), ScreenWidth, ScaleH(310)) xData:xArray yData:yArray];
                [self.view addSubview:bottomView];
            }
            
        }else{
            WL_NoData_View *view = [[WL_NoData_View alloc] initWithFrame:self.view.bounds andRefreshBlock:nil];
            view.type = WLNetworkTypeNOData;
            [self.view addSubview:view];
        }
    }];
}

- (NSString *)getMonthTextWithMonthString:(NSString *)monthString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSDate *date = [dateFormatter dateFromString:monthString];

    NSDateComponents *dateComps = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:date];
    NSInteger month = [dateComps month];
    return [NSString stringWithFormat:@"%ld",month];
}

@end
