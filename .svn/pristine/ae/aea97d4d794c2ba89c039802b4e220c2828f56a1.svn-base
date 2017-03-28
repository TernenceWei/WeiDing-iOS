//
//  WL_NoticeDetail_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 2016/11/19.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_NoticeDetail_ViewController.h"

#import "WL_AnnouncementList_ViewController.h"

#import <WebKit/WebKit.h>

@interface WL_NoticeDetail_ViewController ()<WKUIDelegate,WKNavigationDelegate,UIWebViewDelegate>

{
    WKWebView *_webView;
    
    UILabel *_pdfLabel;
    
    NSURLSessionDownloadTask *_downloadTask;
}

@end

@implementation WL_NoticeDetail_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title =@"公告详情";
    
    self.view.backgroundColor =BgViewColor;
    
    if (self.typeOfPush==1) {
        
        [self setNavigationRightTitle:@"全部公告" fontSize:14 titleColor:[UIColor whiteColor] isEnable:YES];
    }else
    {
        
    }

    _webView =[[WKWebView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    
    _webView.UIDelegate =self;
    
    _webView.navigationDelegate =self;
    
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    

    
    NSURL *rul =[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",NoticeDetailUrl,self.notice_id]];
    
   
    
    [_webView loadRequest:[NSURLRequest requestWithURL:rul]];
    
    [self.view addSubview:_webView];
    
    [self showHud];
    
   
}


//- (void)downFileFromServer{
//    
//    //远程地址
//    //NSURL *URL = [NSURL URLWithString:@"http://www.baidu.com/img/bdlogo.png"];
//    //默认配置
//    //NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    
//    //AFN3.0+基于封住URLSession的句柄
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    
//    [manager GET:@"http://dev.nawanr.com/api/Notice/NoticeDetail?nId=195" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//        WlLog(@"%lld", downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
//        
//         _pdfLabel.text =[NSString stringWithFormat:@"%lld/1.0",downloadProgress.completedUnitCount / downloadProgress.totalUnitCount];
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//       
//        WlLog(@"12");
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        WlLog(@"12");
//
//        
//    }];
//    
//    
//
//}


- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    WlLog(@"%s", __FUNCTION__);
    
    
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSURL *URL = navigationAction.request.URL;
    NSString *scheme = [URL scheme];
    if ([scheme isEqualToString:@"haleyaction"]) {
        //[self handleCustomAction:URL];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context

{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        WlLog(@"%f",_webView.estimatedProgress);
        
      
        
        if (_webView.estimatedProgress==1.0) {
            
            [self hidHud];
        }
    }
}




-(void)NavigationRightEvent
{
    WL_AnnouncementList_ViewController *VC =[[WL_AnnouncementList_ViewController alloc]init];
    
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)dealloc
{
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
