//
//  WLStoreViewController.m
//  WeiLvDJS
//
//  Created by ternence on 2017/1/6.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLStoreViewController.h"

@interface WLStoreViewController ()
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation WLStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人店铺";

    
}

- (void)setUrlString:(NSString *)urlString
{
    _urlString = urlString;
    UIWebView *leoWB = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    leoWB.backgroundColor = [UIColor whiteColor];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [leoWB loadRequest:request];
    [self.view addSubview:leoWB];
    
    
}
@end
