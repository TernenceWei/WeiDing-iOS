//
//  WL_NoData_View.m
//  WeiLv
//
//  Created by wangning on 16/6/17.
//  Copyright © 2016年 WeiLv Technology. All rights reserved.
//


static float const kUIemptyOverlayLabelX         = 0;
static float const kUIemptyOverlayLabelY         = 0;
static float const kUIemptyOverlayLabelHeight    = 20;

#import "WL_NoData_View.h"

@interface WL_NoData_View ()

@property (nonatomic,copy) void(^refreshBlock)();
@property (nonatomic,strong) UIImageView *emptyOverlayImageView;
@property (nonatomic,strong) UILabel *emptyOverlayLabel;
@property (nonatomic,strong) UIButton *searchButton;
@property(nonatomic,strong)UIButton *button;

@end

@implementation WL_NoData_View

- (instancetype)initWithFrame:(CGRect)frame andRefreshBlock:(void(^)())refresh
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.refreshBlock = refresh;

        self.userInteractionEnabled = YES;
        
        [self setUpUI];
        
    }
    return self;
}

#pragma mark -- 初始化UI
- (void)setUpUI
{
    
    [self sharedInit];
    
}

- (void)sharedInit {
    self.backgroundColor = [UIColor whiteColor];
    //self.contentMode =   UIViewContentModeTop;
    [self addUIemptyOverlayImageView];
    [self addUIemptyOverlayLabel];
   // [self addSearchButton];
   // [self setupUIemptyOverlay];
}

- (void)addUIemptyOverlayImageView {
    
    
    self.emptyOverlayImageView = [[UIImageView alloc] init];
    
    UIImage *image = [UIImage imageNamed:@"Error_None_Data"];

    self.emptyOverlayImageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    self.emptyOverlayImageView.center = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2 - 100);
    self.emptyOverlayImageView.image = image;
    

    [self addSubview:self.emptyOverlayImageView];
    
    self.emptyOverlayImageView.userInteractionEnabled=YES;
    
    UIButton *tapButton = [[UIButton alloc]initWithFrame:self.emptyOverlayImageView.frame];
    
    [tapButton addTarget:self action:@selector(tapButton) forControlEvents:UIControlEventTouchUpInside];
    
    self.button = tapButton;
    
    [self addSubview:tapButton];
    
}

- (void)addUIemptyOverlayLabel {
    CGRect emptyOverlayViewFrame = CGRectMake(kUIemptyOverlayLabelX, kUIemptyOverlayLabelY, CGRectGetWidth(self.frame), kUIemptyOverlayLabelHeight);
    UILabel *emptyOverlayLabel = [[UILabel alloc] initWithFrame:emptyOverlayViewFrame];
    emptyOverlayLabel.textAlignment = NSTextAlignmentCenter;
    emptyOverlayLabel.numberOfLines = 0;
    //emptyOverlayLabel.backgroundColor = [UIColor clearColor];
    emptyOverlayLabel.font = WLFontSize(14);
    emptyOverlayLabel.textColor = [WLTools stringToColor:@"#6f7378"];
    emptyOverlayLabel.frame = ({
        CGRect frame = emptyOverlayLabel.frame;
        frame.origin.y = CGRectGetMaxY(self.emptyOverlayImageView.frame) + 10;
        frame;
    });
    self.emptyOverlayLabel = emptyOverlayLabel;
    [self addSubview:emptyOverlayLabel];
}

//- (void)addSearchButton {
//    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//   // UIImage *image = [UIImage imageNamed:@"WLNODataSquare"];
//    button.frame = CGRectMake(0, 0, 100, 40);
//    button.center = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2 - 100);
//    //[button setBackgroundImage:image forState:UIControlStateNormal];
//    [button setTitle:@"重新加载" forState:UIControlStateNormal];
//    [button setTitleColor:[WLTools stringToColor:@"#1f7ffa"] forState:UIControlStateNormal];
//    
//    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
//    
//    button.titleLabel.font = WLFontSize(14);
//    button.frame = ({
//        CGRect frame = button.frame;
//        frame.origin.y = CGRectGetMaxY(self.emptyOverlayLabel.frame) + 10;
//        frame;
//    });
//    self.searchButton = button;
//    [self addSubview:button];
//    
//
//    
//}

-(void)tapButton
{
    if (self.refreshBlock) {
        self.refreshBlock();
    }
}



//- (void)setupUIemptyOverlay {
//    UILongPressGestureRecognizer *longPressUIemptyOverlay = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressUIemptyOverlay:)];
//    [longPressUIemptyOverlay setMinimumPressDuration:0.001];
//    [self.emptyOverlayImageView addGestureRecognizer:longPressUIemptyOverlay];
//    
//    [self.searchButton addGestureRecognizer:longPressUIemptyOverlay];
//}
//
//- (void)longPressUIemptyOverlay:(UILongPressGestureRecognizer *)gesture {
//    if (gesture.state == UIGestureRecognizerStateBegan) {
//        self.emptyOverlayImageView.alpha = 0.4;
//    }
//    if ( gesture.state == UIGestureRecognizerStateEnded ) {
//        self.emptyOverlayImageView.alpha = 1;
//
//        if (self.refreshBlock) {
//            self.refreshBlock();
//        }
//    }
//}


- (void)setType:(WLNetworkType)type
{
    
    NSString *imageName;
    NSString *tipString;

    switch (type) {
            //无网
        case WLNetworkTypeNONetWork:
            imageName = @"Error_Network_Failed";
            tipString = @"网页君已失联,请检查你的网络设置";

            //self.searchButton.hidden = YES;
            break;
            
             //无搜索结果
        case WLNetworkTypeNOSearchResult:
            imageName = @"Error_None_Search";
            tipString = @"没有找到你想要的结果";

            break;
            //无数据
        case WLNetworkTypeNOData:
            
            //没有无数据显示效果 统一无搜索结果 产品经理确认
            imageName = @"Error_None_Data";
            tipString = @"暂无数据";


            break;
        case WLNetworkTypeSeverError:
            
        
            imageName = @"Error_serverError";
            tipString = @"服务器出去旅行了,请稍等片刻~";
            
            break;
        case WLNetworkTypeCustom:
            
            //没有无数据显示效果 统一无搜索结果 产品经理确认
            imageName = self.errorImage;
            tipString = self.tipString;
            
            break;
            
        default:
            break;
    }
    UIImage *image = [UIImage imageNamed:imageName];
    self.emptyOverlayImageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    self.emptyOverlayImageView.center = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2 - 100);
    
    self.button.frame = self.emptyOverlayImageView.frame;
    
    self.emptyOverlayImageView.image = image;
    self.emptyOverlayLabel.text = tipString;
}

-(void)setIsFive:(NSString *)isFive

{
     self.emptyOverlayImageView.center = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2 - 50);
    
    self.emptyOverlayLabel.frame = ({
        CGRect frame = self.emptyOverlayLabel.frame;
        frame.origin.y = CGRectGetMaxY(self.emptyOverlayImageView.frame) + 10;
        frame;
    });
}

@end
