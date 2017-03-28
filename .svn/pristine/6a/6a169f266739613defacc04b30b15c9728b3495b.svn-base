//
//  BannerView.h
//  WeiLv
//
//  Created by WeiLv on 16/6/14.
//  Copyright © 2016年 WeiLv Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EScrollerViewDelegate <NSObject>
@optional
-(void)EScrollerViewDidClicked:(NSUInteger)index;
@end

@interface CycleScrollView : UIView<UIScrollViewDelegate>
{
    CGRect viewSize;
    UIScrollView *scrollView;
    NSArray *imageArray;
    NSArray *titleArray;
    //    UIPageControl *pageControl;
    int currentPageIndex;
    UILabel *noteTitle;
    //    NSTimer *myTimer;
    
    
    UIScrollView *_bgScrollView;
}

@property (nonatomic,strong)NSTimer *myTimer;
@property (nonatomic,strong)UITapGestureRecognizer *Tap;
@property(nonatomic,weak)id<EScrollerViewDelegate> delegate;
@property(nonatomic)BOOL isLunp;
@property(strong, nonatomic) UIPageControl *pageControl;
@property(nonatomic,assign)BOOL isPageControlShow;
@property (nonatomic, strong) NSArray *imageArray;
- (void)startTimer;
- (void)stopTimer;

//-(id)initWithFrameRect:(CGRect)rect bgImageArr:(NSArray *)imgArr;
-(id)initWithFrameRect:(CGRect)rect ImageArray:(NSArray *)imgArr;
-(id)initWithFrameRect:(CGRect)rect ImageArray:(NSArray *)imgArr isXunHuan:(BOOL)isLunp height:(float)bannerHeight;
- (void)initView:(NSArray *)imgArr;
@end
