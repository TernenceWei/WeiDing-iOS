//
//  WL_BankCardsList_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BankCardsList_ViewController.h"
#import "WL_BankCard_Model.h"
#import "WLNetworkAccountHandler.h"

@interface WL_BankCardsList_ViewController ()
{
    WL_BankCard_Model *bankCardModel;
}

@property(nonatomic,strong)WL_NoData_View *noDataView;
@property (nonatomic, strong) NSDictionary *dataDict;

@end

@implementation WL_BankCardsList_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleItem.title =@"我的银行卡";
    self.view.backgroundColor = BgViewColor;
    [self.view addSubview:self.noDataView];
    [self initData];

}

//无数据提示
- (WL_NoData_View *)noDataView {
    
    if (_noDataView == nil) {
       // WS(ws);
        _noDataView = [[WL_NoData_View alloc] initWithFrame:self.view.frame andRefreshBlock:^{
            
        }];
        _noDataView.hidden = YES;
    }
    return _noDataView;
}



-(void)initData
{
//    WS(weakSelf);
//    [WLNetworkAccountHandler requestBindBankInfoWithResultBlock:^(WLResponseType responseType, id data, NSString *message) {
//        
//        if (responseType == WLResponseTypeSuccess) {
//            weakSelf.dataDict = [data objectForKey:@"bank"];
//            [weakSelf initUI];
//        }else{
//            [[WL_TipAlert_View sharedAlert] createTip:message];
//        }
//        
//        
//    }];
    
    
}

-(void)initUI
{
    
    UIView *bankCards =[UIView new];
    [bankCards setFrame:CGRectMake(10, 64 + 25, ScreenWidth -20, 150)];
    bankCards.backgroundColor = WLColor(124, 150, 225, 1);
    bankCards.layer.cornerRadius = 3.0;
    [self.view addSubview:bankCards];
    
    UIView *circleView =[UIView new];
    [circleView setFrame:CGRectMake(35, 25, 50, 50)];
    circleView.backgroundColor = [UIColor whiteColor];
    circleView.layer.cornerRadius = 25.0;
    [bankCards addSubview:circleView];
    
    UIImageView *imageView =[UIImageView new];
    imageView.size =CGSizeMake(30, 30);
    imageView.center = circleView.center;
    NSString *imageName = [NSString stringWithFormat:@"%@.png",[self.dataDict objectForKey:@"bank_name"]];
    imageView.image = [UIImage imageNamed:imageName];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:bankCardModel.bank_logo] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
    [bankCards addSubview:imageView];
    
    UILabel *bankName =[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(circleView)+15,ViewY(circleView)+15, 200, 20)];
    bankName.textColor =[UIColor whiteColor];
    bankName.font =WLFontSize(19);
    bankName.textAlignment =NSTextAlignmentLeft;
    bankName.text = [self.dataDict objectForKey:@"bank_name"];
    [bankCards addSubview:bankName];
    
    UILabel *bankNumber = [[UILabel alloc]initWithFrame:CGRectMake(ViewRight(circleView), ViewBelow(circleView)+23, 140, 20)];
    bankNumber.textColor = [UIColor whiteColor];
    bankNumber.textAlignment = NSTextAlignmentLeft;
    bankNumber.text = @"****   ****   ****";
    [bankCards addSubview:bankNumber];
    
    UILabel *bankNumber2 = [[UILabel alloc]initWithFrame:CGRectMake(ViewRight(bankNumber), ViewBelow(circleView)+20, 50, 20)];
    bankNumber2.textColor = [UIColor whiteColor];
    bankNumber2.textAlignment = NSTextAlignmentLeft;
    NSString *bankNo = [self.dataDict objectForKey:@"bank_number"];
    NSString *bankNumberSting = [bankNo substringFromIndex:(bankNo.length-4)];
    bankNumber2.text = bankNumberSting;
    [bankCards addSubview:bankNumber2];
    
    UILabel *tipLabel =[UILabel new];
    tipLabel.textColor =[WLTools stringToColor:@"#6f7378"];
    tipLabel.numberOfLines = 0;
    tipLabel.lineBreakMode = NSLineBreakByCharWrapping;
    tipLabel.font =WLFontSize(15);
    tipLabel.text = @"温馨提示：该卡为提现唯一卡，如需更换请联系客服。";
    [self.view addSubview:tipLabel];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bankCards.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(ScreenWidth-20);
        
    }];
}

#pragma makr - 设置无数据提示的显示、隐藏及类型
- (void)hideNoData:(BOOL)hidden andType:(WLNetworkType)type {
    
    self.noDataView.hidden = hidden;
    if (!hidden) {
        self.noDataView.type = type;
    }
}

@end
