//
//  WLGuideSuccessOrderController.m
//  WeiLvDJS
//
//  Created by whw on 16/10/29.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLGuideFailureOrderController.h"
#import "WLGroupDetailInfo.h"
#import "WLNetworkManager.h"
#import "WLGuideWaitOrderTableViewCell.h"
#import "WLGuideOrderListViewController.h"

@interface WLGuideFailureOrderController ()

@property(nonatomic, weak)UIImageView *backgroundImage;

@property(nonatomic, weak)UILabel *label1;

@property(nonatomic, weak)UILabel *label2;

@property(nonatomic, weak)UILabel *label3;

@property(nonatomic, weak)UIImageView *successImageView;

@property(nonatomic, weak)UIButton *checkButton;

@property(nonatomic, weak)UILabel *warnLabel;



@end

@implementation WLGuideFailureOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEXCOLOR(0x4877e7);
    [self creatView];
}

-(void)setOrderInfo:(WLOrderListInfo *)orderInfo{
    _orderInfo = orderInfo;

}

-(void)creatView{
    //设置返回按钮

    self.title = @"订单状况";
    
    //背景装饰图片
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, ScreenWidth, 180)];
    imageView1.image = [UIImage imageNamed:@"background"];
    [self.navigationController.view addSubview:imageView1];
    [self.view addSubview:imageView1];
    
    
    //文字
    UILabel *label1 = [[UILabel alloc] init];
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(ScaleH(45));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    label1.font = WLFontSize(17);
    label1.textColor = HEXCOLOR(0xffffff);
//    label1.text = @"恭喜你!";
    _label1 = label1;
    self.label1.text = @"很遗憾";
    
    //文字
    UILabel *label2 = [[UILabel alloc] init];
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(10);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    label2.font = WLFontSize(17);
    label2.textColor = HEXCOLOR(0xffffff);
//    label2.text = @"接单已成功";
    _label2 = label2;
    self.label2.text = @"订单没接到";
    
    //中间白色View
    UIView *view1 = [[UIView alloc] init];
    view1.frame = CGRectMake(ScaleW(35), ScaleH(140), ScaleW(307), ScaleH(214));
    view1.backgroundColor = HEXCOLOR(0xffffff);
    view1.layer.cornerRadius = 8;
    [self.view addSubview:view1];
    
    //view上方锯形
    UIImageView *imageView2 = [[UIImageView alloc] init];
    [self.view addSubview:imageView2];
    [imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view1.mas_left).offset(4);
        make.bottom.equalTo(view1.mas_top).offset(1);
    }];
    imageView2.image = [UIImage imageNamed:@"decorate"];
    
    //view下方锯形
    UIImageView *imageView3 = [[UIImageView alloc] init];
    [self.view addSubview:imageView3];
    [imageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view1.mas_left).offset(5);
        make.top.equalTo(view1.mas_bottom).offset(-1);
    }];
    imageView3.image = [UIImage imageNamed:@"underDecorate"];
    
    //行程标题
    UILabel *label3 = [[UILabel alloc] init];
    [view1 addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view1.mas_left).offset(8);
        make.top.equalTo(view1.mas_top).offset(20);
        make.right.equalTo(view1.mas_right).offset(-8);
    }];
    label3.font = WLFontSize(14);
    label3.textColor = HEXCOLOR(0x2f2f2f);
    //设置行间距
    label3.numberOfLines = 0;
    
    _label3 = label3;
    _label3.text = self.orderInfo.lineName;
    //    label3.text = @"华南沿海双人游，昆明-云南-上海，双飞豪华六天啊啊啊";
    
    //导服费
    UILabel *moneyLable = [[UILabel alloc] init];
    [view1 addSubview:moneyLable];
    [moneyLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view1.mas_right).offset(-ScaleH(23));
        make.bottom.equalTo(label3.mas_bottom).offset(2);
    }];
    moneyLable.textColor = HEXCOLOR(0xff5b3d);
    moneyLable.font = WLFontSize(20);
    //    moneyLable.text = @"15000";
    moneyLable.text = self.orderInfo.checkPrice;
    
    UILabel *RMBLabel = [[UILabel alloc] init];
    [view1 addSubview:RMBLabel];
    [RMBLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(moneyLable.mas_left).offset(-2);
        make.bottom.equalTo(moneyLable.mas_bottom);
    }];
    RMBLabel.textColor = HEXCOLOR(0xff5b3d);
    RMBLabel.font = WLFontSize(15);
    
    RMBLabel.text = @"¥";
    
    //导服费文字
    UILabel *ChineseLabel = [[UILabel alloc] init];
    [view1 addSubview:ChineseLabel];
    [ChineseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(moneyLable.mas_right);
        make.top.equalTo(moneyLable.mas_bottom).offset(10);
    }];
    ChineseLabel.textColor = HEXCOLOR(0xa4a4a4);
    ChineseLabel.font = WLFontSize(14);
    ChineseLabel.text = @"导服费";
    
    //出发日期图片
    UIImageView *receiveImageView = [[UIImageView alloc] init];
    [view1 addSubview:receiveImageView];
    [receiveImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view1.mas_left).offset(ScaleW(17));
        make.top.equalTo(label3.mas_bottom).offset(ScaleH(45));
    }];
    receiveImageView.image = [UIImage imageNamed:@"start"];
    
    //开始日期label
    UILabel *receiveLabel = [[UILabel alloc] init];
    [view1 addSubview:receiveLabel];
    [receiveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(receiveImageView.mas_right).offset(ScaleW(15));
        make.top.equalTo(receiveImageView.mas_top);
    }];
    receiveLabel.font = WLFontSize(14);
    receiveLabel.textColor = HEXCOLOR(0xa4a4a4);
    //    receiveLabel.text = @"08月20日";
    receiveLabel.text = self.orderInfo.receiveDate;
    
    //结束日期图片
    UIImageView *sendImageView = [[UIImageView alloc] init];
    [view1 addSubview:sendImageView];
    [sendImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view1.mas_left).offset(ScaleW(17));
        make.top.equalTo(receiveImageView.mas_bottom).offset(ScaleH(20));
    }];
    sendImageView.image = [UIImage imageNamed:@"end"];
    
    //结束日期label
    UILabel *sendLabel = [[UILabel alloc] init];
    [view1 addSubview:sendLabel];
    [sendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sendImageView.mas_right).offset(ScaleW(15));
        make.top.equalTo(sendImageView.mas_top);
    }];
    sendLabel.font = WLFontSize(14);
    sendLabel.textColor = HEXCOLOR(0xa4a4a4);
    //    sendLabel.text = @"09月20日";
    sendLabel.text = self.orderInfo.sendDate;
    
    //接单成功图片
    UIImageView *successImageView = [[UIImageView alloc] init];
    [view1 addSubview:successImageView];
    [successImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view1.mas_right).offset(-25);
        make.bottom.equalTo(view1.mas_bottom).offset(-23);
    }];
//    successImageView.image = [UIImage imageNamed:@"recieveSuccess"];
    successImageView.image = [UIImage imageNamed:@"recieveFail"];
    _successImageView = successImageView;
    
    //提示文字
    UILabel *warnLabel = [[UILabel  alloc] init];
    [self.view addSubview:warnLabel];
    [warnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_bottom).offset(-ScaleH(200));
    }];
    warnLabel.font = WLFontSize(14);
    warnLabel.textColor = HEXCOLOR(0xecd918);
//    warnLabel.text = @"该订单已加入您的日程，是否前往查看";
    _warnLabel = warnLabel;
    _warnLabel.text = @"提示:与您的日程有冲突";
    
    //前往查看按钮
    UIButton *checkButton = [[UIButton alloc] init];
    [self.view addSubview:checkButton];
    [checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(ScaleW(93));
        make.top.equalTo(warnLabel.mas_bottom).offset(ScaleH(38));
        make.width.equalTo(@(ScaleW(190)));
        make.height.equalTo(@(ScaleH(40)));
    }];
    checkButton.backgroundColor = HEXCOLOR(0xffffff);
    checkButton.layer.cornerRadius = 6;
//    [checkButton setTitle:@"前往查看" forState:UIControlStateNormal];
    [checkButton setTitle:@"看看其他" forState:UIControlStateNormal];
    [checkButton setTitleColor:HEXCOLOR(0x2f2f2f) forState:UIControlStateNormal];
    [checkButton.titleLabel setFont:WLFontSize(16)];
    _checkButton = checkButton;
    
}

-(void)popBack{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[WLGuideOrderListViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    
}

@end
