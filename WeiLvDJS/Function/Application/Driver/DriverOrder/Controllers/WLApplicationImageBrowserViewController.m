//
//  WLApplicationImageBrowserViewController.m
//  WeiLvDJS
//
//  Created by whw on 17/2/28.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLApplicationImageBrowserViewController.h"
#import "WLApplicationPhotoView.h"
@interface WLApplicationImageBrowserViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;/**< 背景容器视图 */

@property (nonatomic, weak) UILabel *titleLabel;
@property(nonatomic, assign) NSInteger currentIndex; /**< 当前图片的序号 */
@property (nonatomic, strong) NSMutableArray *subViewArray;
/** 记录当前的图片显示视图 */
@property(nonatomic,weak) WLApplicationPhotoView *photoView;
@end

@implementation WLApplicationImageBrowserViewController

- (instancetype)init{
    
    self=[super init];
    if (self) {
        _subViewArray = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.currentIndex = 0;
    self.scrollView.contentSize = CGSizeMake(ScreenWidth * self.imagesArray.count, 0);
    [self setupUI];
}

- (void)setupUI
{
    UIButton *backButton = [[UIButton alloc]init];
    UILabel *titleLabel = [[UILabel alloc]init];
    
    [backButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(didClickBackButton) forControlEvents:UIControlEventTouchUpInside];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont WLFontOfSize:17];
    titleLabel.text = [NSString stringWithFormat:@"1/%zd",self.imagesArray.count];
    
    self.titleLabel = titleLabel;
    [self.view addSubview:backButton];
    [self.view addSubview:titleLabel];
    
    
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.equalTo(self.view).offset(14);
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.centerX.equalTo(self.view);
    }];
    
    for (int i = 0; i < self.imagesArray.count; i++) {
        [_subViewArray addObject:[NSNull class]];
    }
    self.scrollView.contentOffset = CGPointMake(ScreenWidth*self.currentIndex, 0);//此句代码需放在[_subViewArray addObject:[NSNull class]]之后，因为其主动调用scrollView的代理方法，否则会出现数组越界
    [self loadPhote:self.currentIndex];
    
}
#pragma mark - 显示图片
-(void)loadPhote:(NSInteger)index{
    
    if (index<0 || index >=self.imagesArray.count) {
        return;
    }
    id currentPhotoView = [_subViewArray objectAtIndex:index];
    if (![currentPhotoView isKindOfClass:[WLApplicationPhotoView class]]) {
        //url数组或图片数组
        CGRect frame = CGRectMake(index*_scrollView.width, 0, self.view.width, self.view.height);
        
       
            WLApplicationPhotoView *photoV = [[WLApplicationPhotoView alloc] initWithFrame:frame withPhotoUrl:[self.imagesArray objectAtIndex:index]];
            [self.scrollView insertSubview:photoV atIndex:0];
            [_subViewArray replaceObjectAtIndex:index withObject:photoV];
            self.photoView=photoV;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.currentIndex  = (scrollView.contentOffset.x +ScreenWidth*0.5)/ScreenWidth;
    if (self.currentIndex<0||self.currentIndex>=self.imagesArray.count) {
        return;
    }
    self.titleLabel.text = [NSString stringWithFormat:@"%zd/%zd",self.currentIndex+1,self.imagesArray.count];
    for (UIView *view in scrollView.subviews) {
        if ([view isKindOfClass:[WLApplicationPhotoView class]]) {
            WLApplicationPhotoView *photoV=(WLApplicationPhotoView *)[_subViewArray objectAtIndex:self.currentIndex];
            if (photoV!=self.photoView) {
                [self.photoView.scrollView setZoomScale:1.0 animated:YES];
                self.photoView=photoV;
            }
        }
    }
    
    [self loadPhote:self.currentIndex];
}

- (void)didClickBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (UIScrollView *)scrollView{
    
    if (_scrollView==nil) {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _scrollView.delegate=self;
        _scrollView.pagingEnabled=YES;
        _scrollView.contentOffset=CGPointZero;
        //设置最大伸缩比例
        _scrollView.maximumZoomScale=3;
        //设置最小伸缩比例
        _scrollView.minimumZoomScale=1;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}
//- (void)dealloc
//{
//    NSLog(@"delloc *****");
//}
@end
