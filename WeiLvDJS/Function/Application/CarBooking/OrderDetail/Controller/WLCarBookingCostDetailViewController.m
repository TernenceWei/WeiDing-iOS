//
//  WLCarBookingCostDetailViewController.m
//  WeiLvDJS
//
//  Created by whw on 17/1/18.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLCarBookingCostDetailViewController.h"

@interface WLCarBookingCostDetailViewController ()

@property (nonatomic, strong) UITableView * MoneyTableView;

@end

@implementation WLCarBookingCostDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI
{
    self.title = @"费用明细";
    
    [self createUI];
}

#define thisColor [WLTools stringToColor:@"#b6b6b6"]

- (void)createUI
{
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    UILabel * leftline = [[UILabel alloc] initWithFrame:CGRectMake(ScaleW(10), ScaleH(40), ScaleW(130), ScaleH(0.5))];
    leftline.backgroundColor = thisColor;
    [backView addSubview:leftline];
    
    UILabel *addPriceRecord = [UILabel labelWithText:@"费用包含" textColor:thisColor fontSize:14];
    addPriceRecord.frame = CGRectMake(leftline.frame.origin.x + leftline.frame.size.width + ScaleW(10), leftline.frame.origin.y - ScaleH(10), ScaleW(80), ScaleH(20));
    addPriceRecord.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:addPriceRecord];
    
    UILabel * rightline = [[UILabel alloc] initWithFrame:CGRectMake(addPriceRecord.frame.origin.x + addPriceRecord.frame.size.width + ScaleW(10), leftline.frame.origin.y, leftline.frame.size.width, leftline.frame.size.height)];
    rightline.backgroundColor = thisColor;
    [backView addSubview:rightline];
    
    NSString * settingStr = _object.cost_memo;
    
    NSArray *arr = [settingStr componentsSeparatedByString:@","];
    
    NSArray * typeArr = [NSArray arrayWithObjects:@"小费",@"油费",@"过路费",@"停车费", nil];
    for (NSInteger i = 0; i < 4; i ++) {
        UIImageView * chooseImg = [[UIImageView alloc] initWithFrame:CGRectMake(((ScreenWidth - ScaleW(20))/4)/4 + ((ScreenWidth - ScaleW(20))/4)*i, addPriceRecord.frame.origin.y + addPriceRecord.frame.size.height + ScaleH(30), ScaleW(20), ScaleH(20))];
        [backView addSubview:chooseImg];
        
        NSString * sssI = [NSString stringWithFormat:@"%ld",i + 1];
        [arr containsObject:sssI]?[chooseImg setImage:[UIImage imageNamed:@"feiyongbaohan"]]:[chooseImg setImage:[UIImage imageNamed:@"feiyongbubaohan"]];
        
        UILabel * chooseLabel = [[UILabel alloc] initWithFrame:CGRectMake(chooseImg.frame.origin.x + chooseImg.frame.size.width + ScaleW(5), chooseImg.frame.origin.y, ScaleW(60), ScaleH(20))];
        chooseLabel.text = typeArr[i];
        chooseLabel.font = [UIFont systemFontOfSize:13.0];
        [backView addSubview:chooseLabel];

        [arr containsObject:sssI]?[chooseLabel setTextColor:[WLTools stringToColor:@"#333333"]]:[chooseLabel setTextColor:thisColor];
    }
    
    UILabel * middiumline = [[UILabel alloc] initWithFrame:CGRectMake(0, addPriceRecord.frame.origin.y + ScaleH(100), ScreenWidth, ScaleH(10))];
    middiumline.backgroundColor = [WLTools stringToColor:@"#f2f2f2"];
    [backView addSubview:middiumline];
    
    UILabel * moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScaleW(20), middiumline.frame.origin.y + ScaleH(40), ScreenWidth - ScaleW(40), ScaleH(30))];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.font = [UIFont systemFontOfSize:35.0];
    moneyLabel.text = [NSString stringWithFormat:@"￥%@",self.object.bid_price];
    [backView addSubview:moneyLabel];
    
    UILabel * drivermoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScaleW(20), moneyLabel.frame.origin.y + ScaleH(70), ScreenWidth - ScaleW(40), ScaleH(20))];
    drivermoneyLabel.textAlignment = NSTextAlignmentCenter;
    drivermoneyLabel.font = [UIFont systemFontOfSize:14.0];
    drivermoneyLabel.textColor = thisColor;
    drivermoneyLabel.text = [NSString stringWithFormat:@"司机报价：￥%@",self.object.bid_price];
    [backView addSubview:drivermoneyLabel];
}

@end
