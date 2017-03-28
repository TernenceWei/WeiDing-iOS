//
//  WL_AddressBook_MyFriends_addWeiDingFriends_ViewController.m
//  WeiLvDJS
//
//  Created by whw on 16/12/9.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  添加微叮好友主控制器

#import "WL_AddressBook_MyFriends_addWeiDingFriends_ViewController.h"
#import "WL_AddressBook_Search_SearchView.h"
#import "WL_AddressBook_SearchWeiDingFriends_ViewController.h"
@interface WL_AddressBook_MyFriends_addWeiDingFriends_ViewController ()<UITextFieldDelegate>
/**< 搜索框 */
@property (nonatomic, weak) WL_AddressBook_Search_SearchView *searchView;
@end

@implementation WL_AddressBook_MyFriends_addWeiDingFriends_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - 创建UI
- (void)setupUI
{
    self.view.backgroundColor = [WLTools stringToColor:@"#f7f7f8"];
    self.title = @"添加好友";
    //添加头部搜索框
    WL_AddressBook_Search_SearchView *searchView = [[WL_AddressBook_Search_SearchView alloc] initWithFrame:CGRectZero];
    searchView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    searchView.layer.cornerRadius = 5.0f;
    searchView.layer.masksToBounds = YES;
    [self.view addSubview:searchView];
    
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(ScaleH(20));
        make.left.equalTo(self.view).offset(ScaleW(30));
        make.height.offset(ScaleH(30));
        make.right.equalTo(self.view).offset(ScaleW(-30));
    }];

    self.searchView = searchView;
    searchView.searchField.delegate = self;
    [searchView.searchField addTarget:self action:@selector(searchWeiDingFriends:) forControlEvents:UIControlEventEditingChanged];
    searchView.searchField.keyboardType = UIKeyboardTypeNumberPad;
//
    
    //添加右边扫描二维码
    [self setNavigationRightImg:@"scan"];
    
}
#pragma mark - 控制器的生命周期

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.searchView.searchField becomeFirstResponder];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.searchView.searchField resignFirstResponder];
}
#pragma mark - 搜索微叮好友
- (void)searchWeiDingFriends:(UITextField *)textfield
{
    if ([RegexTools isAllNumber:textfield.text])
    {
        
    }else
    {
        [[WL_TipAlert_View sharedAlert] createTip:@"输入格式错误,请输入全数字"];
    }
}

#pragma mark - 跳转到扫描二维码控制器
- (void)NavigationRightEvent
{
    WL_AddressBook_SearchWeiDingFriends_ViewController *weiDingVC = [[WL_AddressBook_SearchWeiDingFriends_ViewController alloc]init];
    
    [self.navigationController pushViewController:weiDingVC animated:YES];
}
@end
