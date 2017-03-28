//
//  CycleScrollView.m
//  WeiLv
//
//  Created by WeiLv on 16/6/14.
//  Copyright © 2016年 WeiLv Technology. All rights reserved.
//

#import "CycleScrollView.h"

@implementation CycleScrollView

@synthesize delegate;
//@synthesize myTimer;

//控制图片轮播
-(id)initWithFrameRect:(CGRect)rect ImageArray:(NSArray *)imgArr
{
    if ((self=[super initWithFrame:rect])) {
        self.frame = rect;
     
        self.userInteractionEnabled =YES;
        self.isLunp = NO;
        viewSize = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self initView:imgArr];
        
    }
    return self;
    
}

//控制图片不自动轮播
-(id)initWithFrameRect:(CGRect)rect ImageArray:(NSArray *)imgArr isXunHuan:(BOOL)isLunp height:(float)bannerHeight
{
    if ((self=[super initWithFrame:rect])) {
        self.frame = rect;
        self.userInteractionEnabled=YES;
        self.isLunp = isLunp;
        viewSize = CGRectMake(0, 0, self.frame.size.width, bannerHeight);
        [self initView:imgArr];
        
    }
    return self;
}

- (void)initView:(NSArray *)imgArr
{
    [scrollView removeFromSuperview];
    [self stopTimer];
    NSMutableArray *tempArray;
    if (imgArr.count <= 0)
    {
        NSArray *data = @[@""];
        if (data.count <= 0)
        {
            tempArray = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",@"", nil];
        }
        else
        {
            imgArr = data;
        }
        return;
    }else if (imgArr.count > 0) {
        [tempArray removeAllObjects];
        tempArray=[NSMutableArray arrayWithArray:imgArr];
        [tempArray insertObject:[imgArr lastObject] atIndex:0];
        [tempArray addObject:[imgArr firstObject]];
    }
    imageArray=[NSArray arrayWithArray:tempArray];
    //WlLog(@"%ld",(unsigned long)imageArray.count);
    NSUInteger pageCount=[imageArray count];
    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    //WlLog(@"%@",NSStringFromCGRect(scrollView.frame));
    
    
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(self.frame.size.width * pageCount, self.frame.size.height);
    //WlLog(@"%ld",(unsigned long)pageCount);
    //scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"默认图3"]];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    UIImage *image;
    if (self.isLunp == NO) {
        image = [UIImage imageNamed:@"public_product_detail_default"];
    }else
    {
        image = [UIImage imageNamed:@"public_product_detail_default"];
    }
    scrollView.layer.contents = (id) image.CGImage;
    for (int i=0; i<pageCount; i++) {
        NSString *imgURL=[imageArray objectAtIndex:i];
        UIImageView *imgView=[[UIImageView alloc] init];
        if ([imgURL hasPrefix:@"https://"] || [imgURL hasPrefix:@"http://"]) {
            //网络图片 请使用ego异步图片库
            //imgView.contentMode = UIViewContentModeScaleAspectFit;
            
            if (self.isLunp == NO) {
                [imgView sd_setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@"public_product_detail_default"]];
            }else
            {
                [imgView sd_setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@"public_product_detail_default"]];
            }
        }
        else
        {
            UIImage *img= [UIImage imageNamed:[imageArray objectAtIndex:i]];
            [imgView setImage:img];
        }
        
        [imgView setFrame:CGRectMake(self.frame.size.width*i, 0,self.frame.size.width, self.frame.size.height)];
        //WlLog(@"%@",NSStringFromCGRect(imgView.frame));
        imgView.tag=i;

    
        self.Tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePressed:)];
        [self.Tap  setNumberOfTapsRequired:1];
        [self.Tap  setNumberOfTouchesRequired:1];
        imgView.userInteractionEnabled=YES;
//        [imgView addGestureRecognizer:self.Tap];
        [scrollView addSubview:imgView];
    }
    
    [scrollView setContentOffset:CGPointMake(viewSize.size.width, 0)];
    [self addSubview:scrollView];
    
    float pageControlWidth=(pageCount-2)*10.0f+40.f;
    float pagecontrolHeight=20.0f;
    
    
    _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(((viewSize.size.width-pageControlWidth)/2),viewSize.size.height-20, pageControlWidth, pagecontrolHeight)];
//    _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake((viewSize.size.width-pageControlWidth),ScaleH(viewSize.size.height-69), pageControlWidth, pagecontrolHeight)];
    _pageControl.currentPage=0;
    _pageControl.numberOfPages=(pageCount-2);
    _pageControl.currentPageIndicatorTintColor = Color1;
    _pageControl.pageIndicatorTintColor = Color4;
    [self addSubview:_pageControl];
    //    self.pageControl = _pageControl;
    if (self.isLunp == NO) {
        _myTimer=[NSTimer scheduledTimerWithTimeInterval:4.0f target:self selector:@selector(scrollToNextPage:) userInfo:nil repeats:YES];
        //        [[NSRunLoop currentRunLoop]addTimer:myTimer forMode:NSRunLoopCommonModes];
    }
    
    
}
-(void)scrollToNextPage:(id)sender
{
    
    CGPoint offset = scrollView.contentOffset;
    
    NSInteger page = (offset.x + 20)/ScreenWidth;
    
    [scrollView setContentOffset:CGPointMake((page + 1) * ScreenWidth, 0) animated:YES];
}

-(void)setIsPageControlShow:(BOOL)isPageControlShow
{
    _isPageControlShow = isPageControlShow;
    _pageControl.hidden = !isPageControlShow;
    
}
#pragma mark ---设置滑动动画
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    
    //-
    if (scrollView.contentOffset.x >= ((imageArray.count)-1)*self.frame.size.width) {
        scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    }
    if (scrollView.contentOffset.x <= 0) {
        scrollView.contentOffset = CGPointMake(((imageArray.count)-2)*self.frame.size.width, 0);
    }
    //-
    
    CGFloat pageWidth = sender.frame.size.width;
    int page = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    currentPageIndex=page;
    if (sender == scrollView) {
        _pageControl.currentPage=(page-1);
    }
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView
{
    
    if (currentPageIndex==0) {
        if (_scrollView == scrollView) {
            [scrollView setContentOffset:CGPointMake(([imageArray count]-2)*self.frame.size.width, 0)];
            [_bgScrollView setContentOffset:scrollView.contentOffset];
        }else
        {
            [_bgScrollView setContentOffset:CGPointMake(([imageArray count]-2)*self.frame.size.width, 0)];
            [scrollView setContentOffset:_bgScrollView.contentOffset];
            
        }
        
        
    }else if (currentPageIndex==([imageArray count]-1)) {
        
        if (_scrollView == scrollView) {
            [scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
            [_bgScrollView setContentOffset:scrollView.contentOffset];
        }else
        {
            [_bgScrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
            [scrollView setContentOffset:_bgScrollView.contentOffset];
            
        }
        
    }else
    {
        if (_scrollView == scrollView) {
            [_bgScrollView setContentOffset:scrollView.contentOffset];
        }else
        {
            [scrollView setContentOffset:_bgScrollView.contentOffset];
        }
    }
    
}
- (void)imagePressed:(UITapGestureRecognizer *)sender
{
    if ([delegate respondsToSelector:@selector(EScrollerViewDidClicked:)]) {
        [delegate EScrollerViewDidClicked:sender.view.tag];
    }
}

#pragma mark ---手动滑动后重置时间
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //    关闭定时器(注意点; 定时器一旦被关闭,无法再开启)
    [_myTimer invalidate];
    _myTimer= nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    _myTimer=[NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(scrollToNextPage:) userInfo:nil repeats:YES];
    
    //    [[NSRunLoop currentRunLoop]addTimer:myTimer forMode:NSRunLoopCommonModes];
}

- (void)startTimer{
    
    _myTimer=[NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(scrollToNextPage:) userInfo:nil repeats:YES];
}

- (void)stopTimer{
    
    [_myTimer invalidate];
    _myTimer = nil;
}


@end
