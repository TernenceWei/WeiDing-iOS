//
//  WLEndUserLicenseViewController.m
//  WeiLvDJS
//
//  Created by hsliang on 2017/1/22.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLEndUserLicenseViewController.h"
#import <WebKit/WebKit.h>
@interface WLEndUserLicenseViewController ()<UIWebViewDelegate,WKNavigationDelegate>

@property (nonatomic, strong) UIScrollView * lisenceScrollView;
@property (nonatomic, strong) UILabel * lisenceStr;

@end

@implementation WLEndUserLicenseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];

}

- (void)createUI
{
    self.titleItem.title = @"用户注册协议";
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 65, self.view.width, ScreenHeight-65)];
    // 2.创建请求
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://i.d.vding.wang/protocol.html"]];
    // 3.加载网页
    [webView loadRequest:request];
    webView.navigationDelegate = self;
//    webView.allowsBackForwardNavigationGestures = YES;/*允许右滑返回*/
    // 最后将webView添加到界面
    [self.view addSubview:webView];

}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
 
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self showHud];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [self hidHud];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
     [self hidHud];
}

//- (void)dataDownLoad
//{
//    //显示菊花
//    [self showHud];
//    [[WLNetworkLoginHandler sharedInstance] UserLicenseWithUserName:^(BOOL success, id data, NSString *message) {
//        if (success) {
//            NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
//            NSStringDrawingUsesFontLeading;
//            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
//            [style setLineBreakMode:NSLineBreakByCharWrapping];
//            NSDictionary *attributes = @{ NSFontAttributeName : WLFontSize(15), NSParagraphStyleAttributeName : style };
//            CGSize size = [[NSString stringWithFormat:@"%@",data] boundingRectWithSize:CGSizeMake(ScreenWidth - ScaleW(20), CGFLOAT_MAX) options:opts attributes:attributes context:nil].size;
////            CGSize size = [[NSString stringWithFormat:@"%@",data] sizeWithFont:WLFontSize(15) constrainedToSize:CGSizeMake(ScreenWidth - ScaleW(20), CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
//            if (size.height < ScreenHeight) {
//                _lisenceScrollView.contentSize = CGSizeMake(ScreenWidth,ScreenHeight - ScaleH(64));
//            }
//            else
//            {
//                _lisenceScrollView.contentSize = CGSizeMake(ScreenWidth,size.height + ScaleH(30));
//            }
//            _lisenceStr.frame = CGRectMake(ScaleW(10), ScaleH(10), _lisenceScrollView.frame.size.width - ScaleW(20), size.height);
//            _lisenceStr.text = [NSString stringWithFormat:@"%@",data];
//        }
//        //隐藏菊花
//        [self hidHud];
//    }];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
///*
//    _lisenceScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - ScaleH(64))];
//
//    [self.view addSubview:_lisenceScrollView];
//
//    _lisenceStr = [[UILabel alloc] initWithFrame:CGRectZero];
//    _lisenceStr.numberOfLines = 0;
//    _lisenceStr.font = [UIFont WLFontOfSize:15.0];
//    [_lisenceScrollView addSubview:_lisenceStr];
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/

@end
