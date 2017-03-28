//
//  WL_Mine_PersonInfo_QRcode_ViewController.m
//  WeiLvDJS
//
//  Created by liuxin on 16/9/12.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Mine_PersonInfo_QRcode_ViewController.h"

#import "UIImage+Helper.h" //二维码信息
#import "XJQRCodeModel.h" //最新二维码生成
@interface WL_Mine_PersonInfo_QRcode_ViewController ()
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)UIImageView *QRImageView;
@property(nonatomic,strong)UILabel *label1;//姓名
@property(nonatomic,strong)UILabel *label2;//昵称

@property (nonatomic, strong) UILabel * WDName;//微叮号

@end

@implementation WL_Mine_PersonInfo_QRcode_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self QRcodeCreatTitle];
    [self creatView1];
    [self downloadQRcode];
    
    // Do any additional setup after loading the view.
}
-(void)QRcodeCreatTitle
{
    //self.title = @"二维码名片";
    self.titleItem.title = @"二维码名片";
    self.view.backgroundColor = BgViewColor;
}

-(void)creatView1
{
    _backView = [[UIView alloc] init];
    if (ScreenWidth>320) {
        _backView.frame = CGRectMake(20, 100, ScreenWidth-40, ScreenHeight-120-64);

    }
    else
    {
        _backView.frame = CGRectMake(15, 95, ScreenWidth-30, ScreenHeight-70-64);
  
    }
    _backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backView];
  
    _backView.layer.cornerRadius = 5;
    _backView.layer.masksToBounds = YES;
//头视图圆角背景
    UIView *CireView = [[UIView alloc] init];
    CireView.frame = CGRectMake(0, 0, _backView.frame.size.width, ScaleH(180));
    CireView.backgroundColor = [WLTools stringToColor:@"#00cc99"];
    [_backView addSubview:CireView];
//头像视图
    _headImageView = [UIImageView new];
    _headImageView.frame = CGRectMake((CireView.frame.size.width / 2) - ScaleW(30), ScaleH(15), ScaleW(60), ScaleW(60));
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = ScaleW(30);
    //_headImageView.image = self.headImage;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_headImage]] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
    [CireView addSubview:_headImageView];
//分享二维码
    UIButton *SharkBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    SharkBtn.frame = CGRectMake(0, _backView.frame.size.height-49, _backView.frame.size.width, 49);
    [SharkBtn setTitle:@"在微叮上扫一扫加我" forState:UIControlStateNormal];
    [SharkBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    SharkBtn.backgroundColor = [UIColor clearColor];
    [_backView addSubview:SharkBtn];
//姓名
    _label1 = [[UILabel alloc] init];
    _label1.frame = CGRectMake(0, _headImageView.frame.origin.y + _headImageView.frame.size.height + ScaleH(10), _backView.frame.size.width, ScaleH(20));
    _label1.textAlignment = NSTextAlignmentCenter;
    _label1.text = _nickName;
    _label1.textColor = [UIColor whiteColor];
    _label1.font = [UIFont WLFontOfSize:16.0];
    [_backView addSubview:_label1];
    
// 微叮号
    _WDName = [[UILabel alloc] init];
    _WDName.frame = CGRectMake(0, _label1.frame.origin.y + _label1.frame.size.height + ScaleH(10), _backView.frame.size.width, ScaleH(20));
    _WDName.textAlignment = NSTextAlignmentCenter;
    _WDName.text = _userName;
    _WDName.textColor = [UIColor whiteColor];
    _WDName.font = [UIFont WLFontOfSize:10.0];
    [_backView addSubview:_WDName];
//昵称
    _label2 = [[UILabel alloc] init];
    _label2.frame = CGRectMake(0, _WDName.frame.origin.y + _WDName.frame.size.height + ScaleH(10), _backView.frame.size.width, ScaleH(20));
    _label2.textAlignment = NSTextAlignmentCenter;
    _label2.text = _phoneNO;
    _label2.textColor = [UIColor whiteColor];
    _label2.font = [UIFont WLFontOfSize:16.0];
    [_backView addSubview:_label2];
//二维码
    _QRImageView = [[UIImageView alloc] init];
    _QRImageView.frame = CGRectMake(ScaleW(50), CireView.frame.origin.y + CireView.frame.size.height + 20, _backView.frame.size.width - ScaleW(50) * 2, _backView.frame.size.width - ScaleW(50) * 2);
   // _QRImageView.image  = [UIImage generateQRCode:@"13949038485" size:CGSizeMake(width, width)];
    _QRImageView.image = [XJQRCodeModel createQRCodeWithString:[WLUserTools getUserMobile] ViewController:self];
    _QRImageView.backgroundColor = [UIColor blueColor];
    [_backView addSubview:_QRImageView];
}

- (void)downloadQRcode
{
    [[WLNetworkDriverHandler sharedInstance] requestQRcodeWithDataBlock:^(WLResponseType responseType, id data, NSString *message) {
        //
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
