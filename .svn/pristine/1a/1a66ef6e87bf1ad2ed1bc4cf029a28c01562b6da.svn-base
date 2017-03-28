//
//  WLWriteOffViewController.m
//  WeiLvDJS
//
//  Created by hsliang on 2017/1/5.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLWriteOffViewController.h"
#import "WLNetworkWriteOffHandler.h"
#import "WLResultWriteOffViewController.h"

#import "WLOneCardViewController.h"

@interface WLWriteOffViewController ()

@property (nonatomic, strong) UITextField * inputNO;

@end

@implementation WLWriteOffViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BgViewColor;
    
    [self setTitle];
    [self setUI];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)setTitle
{
    self.titleItem.title = @"电子码";
}

- (void)setUI
{
    UIView * inputView = [[UIView alloc] initWithFrame:CGRectMake(ScaleW(10), ScaleH(84), ScreenWidth - ScaleW(20), ScaleH(150))];
    inputView.backgroundColor = [UIColor whiteColor];
    inputView.layer.borderColor = [WLTools stringToColor:@"#e4e4e4"].CGColor;
    inputView.layer.borderWidth = 2;
    inputView.layer.cornerRadius = 4;
    [self.view addSubview:inputView];
    
    UILabel * howNOLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScaleW(20), ScaleH(20), ScaleW(200), ScaleH(20))];
    howNOLabel.text = @"输入15位电子码";
    howNOLabel.font = [UIFont WLFontOfSize:13.0];
    howNOLabel.textAlignment = NSTextAlignmentLeft;
    [inputView addSubview:howNOLabel];
    
    _inputNO = [[UITextField alloc] initWithFrame:CGRectMake(howNOLabel.frame.origin.x, howNOLabel.frame.origin.y + howNOLabel.frame.size.height + ScaleH(25), ScaleW(200), ScaleH(25))];
    _inputNO.placeholder = @"输入电子码";
    _inputNO.text = @"";//@"13266606663";
    _inputNO.font = [UIFont WLFontOfSize:18.0];
    [inputView addSubview:_inputNO];
    
    UIButton * sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(inputView.frame.origin.x, inputView.frame.origin.y + inputView.frame.size.height + ScaleH(20), inputView.frame.size.width, ScaleH(50))];
    sureBtn.backgroundColor = [WLTools stringToColor:@"#00cc99"];
    sureBtn.layer.cornerRadius = 25;
    [sureBtn setTitle:@"核验" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
}

- (void)sureBtnClick
{
    if (_inputNO.text.length != 0) {
        [self setNet];
        [_inputNO resignFirstResponder];
    }
    else
    {
        [[WL_TipAlert_View sharedAlert] createTip:@"请输入电子码"];
    }
}

- (void)setNet
{
    [WLNetworkWriteOffHandler writeOffWithCode:_inputNO.text resultBlock:^(WLResponseType responseType, WLWriteOffObject *WLWriteOffObjectmodel, WLWriteOffObjectBuyUser *WLWriteOffObjectBuyUsermodel, NSString * message) {
        if (responseType == WLResponseTypeSuccess) {
            if ([WLWriteOffObjectmodel.is_passed_card isEqual:@"0"])
            {
                if (responseType == WLResponseTypeSuccess) {
                    WLResultWriteOffViewController * nextVC = [[WLResultWriteOffViewController alloc] init];
                    nextVC.resultStr = @"核销成功";
                    nextVC.model = WLWriteOffObjectmodel;
                    [self.navigationController pushViewController:nextVC animated:YES];
                }
            }
            if ([WLWriteOffObjectmodel.is_passed_card isEqual:@"1"]) {
                WLOneCardViewController * nextVC = [[WLOneCardViewController alloc] init];
                nextVC.model = WLWriteOffObjectmodel;
                nextVC.model2 = WLWriteOffObjectBuyUsermodel;
                [self.navigationController pushViewController:nextVC animated:YES];
            }
            
        }
        if (responseType == WLResponseType1) {
            WLResultWriteOffViewController * nextVC = [[WLResultWriteOffViewController alloc] init];
            nextVC.resultStr = @"已核销";
            nextVC.model = nil;
            [self.navigationController pushViewController:nextVC animated:YES];
        }
        if (responseType == WLResponseType2) {
            WLResultWriteOffViewController * nextVC = [[WLResultWriteOffViewController alloc] init];
            nextVC.resultStr = @"无法识别";
            nextVC.model = nil;
            [self.navigationController pushViewController:nextVC animated:YES];
        }
    }];
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
