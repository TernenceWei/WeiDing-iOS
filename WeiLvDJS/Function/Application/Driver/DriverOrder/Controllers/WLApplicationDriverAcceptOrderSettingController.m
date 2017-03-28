//
//  WLApplicationDriverAcceptOrderSettingController.m
//  WeiLvDJS
//
//  Created by whw on 17/2/23.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLApplicationDriverAcceptOrderSettingController.h"
#import "WLApplicationAcceptOrderPeopleNumberController.h"
#import "WLApplicationCarInfoModel.h"
@interface WLApplicationDriverAcceptOrderSettingController ()
//@property (nonatomic, assign) BOOL isAccept;/**< 是否愿意接单 */
@property (nonatomic, copy) NSString *people;/**< 最少乘客 */
@property (nonatomic, weak) UISwitch *accepetSwitch;
@property (nonatomic, weak) UILabel *peopleLabel;
@property (nonatomic, weak) UIView *peopleNumberView;
@property (nonatomic, copy) NSString *car_id;/**< 车辆ID */
@property (nonatomic, copy) NSString *seatCount;/**< 默认车辆座位数 */
@end

@implementation WLApplicationDriverAcceptOrderSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"接单设置";
    self.view.backgroundColor = Color4;
    [self setupUI];
    [self loadCarInfomationFromServer];
}

- (void)setupUI
{
    UIView *accepetView = [[UIView alloc]init];
    UIView *peopleNumberView = [[UIView alloc]init];
    
    accepetView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    peopleNumberView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    
    [self.view addSubview:accepetView];
    [self.view addSubview:peopleNumberView];
    
    [accepetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(ScaleH(20));
        make.left.right.equalTo(self.view);
        make.height.offset(44);
    }];
    [peopleNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(accepetView.mas_bottom).offset(ScaleH(1));
        make.left.right.equalTo(self.view);
        make.height.offset(44);
    }];
    
    UILabel *accepetLabel = [[UILabel alloc]init];
    UISwitch *accepetSwitch = [[UISwitch alloc]init];
    accepetSwitch.on = YES;
    [accepetSwitch addTarget:self action:@selector(didChangeSwitch:) forControlEvents:UIControlEventValueChanged];
    accepetLabel.textColor = Color2;
    accepetLabel.font = [UIFont WLFontOfSize:14];
    accepetLabel.text = @"接单";
    
    [accepetView addSubview:accepetLabel];
    [accepetView addSubview:accepetSwitch];
    
    [accepetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(accepetView).offset(ScaleW(14));
        make.centerY.equalTo(accepetView);
    }];
    
    [accepetSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(accepetView.mas_right).offset(- ScaleW(14));
        make.centerY.equalTo(accepetView);
    }];
    
    
    UILabel *peopleNumberLabel = [[UILabel alloc]init];
    UILabel *peopleLabel = [[UILabel alloc]init];
    UIImageView *amountTipImageView = [[UIImageView alloc]init];
   
    
    peopleLabel.textColor = Color3;
    peopleLabel.font = [UIFont WLFontOfSize:14];
    peopleNumberLabel.textColor = Color2;
    peopleNumberLabel.font = [UIFont WLFontOfSize:14];
    peopleNumberLabel.text = @"接单最少乘客";
    amountTipImageView.image = [UIImage imageNamed:@"arrow"];
    UITapGestureRecognizer *amountTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapAmountTipImageView)];
    [peopleNumberView addGestureRecognizer:amountTapGesture];
    peopleNumberView.userInteractionEnabled = YES;
    
    [peopleNumberView addSubview:peopleNumberLabel];
    [peopleNumberView addSubview:peopleLabel];
    [peopleNumberView addSubview:amountTipImageView];

    [peopleNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(peopleNumberView).offset(ScaleW(14));
        make.centerY.equalTo(peopleNumberView);
    }];
    
    [amountTipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(peopleNumberView).offset(- ScaleW(14));
        make.centerY.equalTo(peopleNumberView);
    }];
    
    [peopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(amountTipImageView.mas_left).offset(- ScaleW(8));
        make.centerY.equalTo(peopleNumberView);
    }];

//    [self setNavigationRightTitle:@"保存" fontSize:15 titleColor:[WLTools stringToColor:@"#00cc99"] isEnable:YES];
    self.accepetSwitch = accepetSwitch;
    self.peopleLabel = peopleLabel;
    self.peopleNumberView = peopleNumberView;
}
#pragma mark---获取车辆信息
-(void)loadCarInfomationFromServer
{
    [self showHud];
    [[WLNetworkDriverHandler sharedInstance] requestCarInfoWithCompanyID:nil AndDataBlock:^(WLResponseType responseType, id data, NSString *message) {
        
        if (responseType == WLResponseTypeSuccess) {
            if (data) {
                WLApplicationCarInfocar_infoModel *InfoModel = [(WLApplicationCarInfodataModel *)data Mycar_info];
                self.car_id = InfoModel.Myid;
                self.accepetSwitch.on = InfoModel.is_reception;
                self.peopleNumberView.userInteractionEnabled = self.accepetSwitch.isOn;
                self.seatCount = InfoModel.seat_amount;
                self.people = [InfoModel.reception_lowest isEqualToString:@"0"]?InfoModel.seat_amount:InfoModel.reception_lowest;
                self.peopleLabel.text = [NSString stringWithFormat:@"%@ 人",self.people];
                [self hidHud];
            }
            [self hidHud];
        }else if (responseType == WLResponseTypeServerError)
        {
            self.peopleLabel.text = @"0";
            [[WL_TipAlert_View sharedAlert] createTip:@"网络错误,请重试"];
        }
        [self hidHud];
    }];
    
}
- (void)NavigationLeftEvent
{
    [self showHud];
    [[WLNetworkDriverHandler sharedInstance] setAcceptOrderParasWithCarID:self.car_id  Is_reception:self.accepetSwitch.isOn Reception_lowest:self.people statusBlock:^(WLResponseType responseType, NSInteger status, NSString *message) {
        if(status == 200){
            [self hidHud];
            [[WL_TipAlert_View sharedAlert] createTip:@"保存成功"];
            [NSThread sleepForTimeInterval:0.5];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self hidHud];
            [[WL_TipAlert_View sharedAlert] createTip:@"网络错误,请重试"];
        }
        
    }];
}
//- (void)NavigationRightEvent
//{
//    [self showHud];
//    [[WLNetworkDriverHandler sharedInstance] setAcceptOrderParasWithCarID:self.car_id  Is_reception:self.accepetSwitch.isOn Reception_lowest:self.people statusBlock:^(WLResponseType responseType, NSInteger status, NSString *message) {
//        if(status == 200){
//          [self hidHud];
//          [[WL_TipAlert_View sharedAlert] createTip:@"保存成功"];
//          [NSThread sleepForTimeInterval:0.5];
//            [self.navigationController popViewControllerAnimated:YES];
//        }else{
//          [self hidHud];
//          [[WL_TipAlert_View sharedAlert] createTip:@"网络错误,请重试"];
//        }
//        
//    }];
//    
//}
- (void)didChangeSwitch:(UISwitch *)sender
{
    self.peopleNumberView.userInteractionEnabled = sender.isOn;
}
- (void)didTapAmountTipImageView
{
    WLApplicationAcceptOrderPeopleNumberController *VC = [[WLApplicationAcceptOrderPeopleNumberController alloc]init];
    VC.people = self.people;
    VC.seatCount = self.seatCount;
    VC.peopleNumberBlock = ^(NSString *peopleNumber){
        self.people = peopleNumber;
        self.peopleLabel.text = [NSString stringWithFormat:@"%@ 人",peopleNumber];
    };
    [self.navigationController pushViewController:VC animated:YES];
}

@end
