//
//  WLApplicationDriverBookOrderDetailBottomView.m
//  WeiLvDJS
//
//  Created by whw on 17/1/20.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLApplicationDriverBookOrderDetailBottomView.h"
#import "WL_Application_Driver_Order_Tour_Button.h"
#import "WLBusinessCardView.h"
@interface WLApplicationDriverBookOrderDetailBottomView ()
{
    dispatch_source_t _timer;/**< 倒计时 */
}
/**< 用车人按钮 */
@property (nonatomic, weak) WL_Application_Driver_Order_Tour_Button *userButton;
@end
@implementation WLApplicationDriverBookOrderDetailBottomView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame: frame])
    {
        self.backgroundColor = [WLTools stringToColor:@"#f2f2f2"];
        [self setupUI];
    }
    return self;
}
- (void)setupUI
{
    
    UILabel *lineLabel = [[UILabel alloc]init];

    //联系用车人
    WL_Application_Driver_Order_Tour_Button *userButton = [[WL_Application_Driver_Order_Tour_Button alloc] init];;
    UIButton *bookButton = [[UIButton alloc]init];
    
    lineLabel.backgroundColor = [WLTools stringToColor:@"#f2f2f2"];
    userButton.nameLable.text = @"联系用车人";
    userButton.tag = 11;
    [userButton addTarget:self action:@selector(didClickContactButton:) forControlEvents:UIControlEventTouchUpInside];

//    [bookButton setTitle:@"报价" forState:UIControlStateNormal];
    [bookButton setBackgroundImage:[UIImage imageNamed:@"jiedan"] forState:UIControlStateNormal];
    [bookButton setTitleColor:[WLTools stringToColor:@"#ffffff"] forState:UIControlStateNormal];
    bookButton.titleLabel.font = [UIFont WLFontOfSize:17];
//    [bookButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];

    [self addSubview:lineLabel];
    [self addSubview:userButton];
    [self addSubview:bookButton];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.offset(1);
    }];
    [userButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(ScaleW(30));
        make.bottom.equalTo(self).offset(-ScaleH(10));
    }];
   
    [bookButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).offset(- 12);
        make.width.offset(ScaleW(120));
    }];

    self.userButton = userButton;
    self.bookButton = bookButton;

}

- (void)setBookStatus:(WLBookOrderStatus)bookStatus
{
    _bookStatus = bookStatus;
    if(bookStatus==WLWaitOrderStatus||bookStatus==WLOrderStatusStart||bookStatus==WLOrderStatusTravel||bookStatus==WLOrderStatusSettlement||bookStatus==WLOrderStatusFinish){
        self.hidden = NO;
    }else
    {
        self.hidden = YES;
    }
    if (bookStatus==WLWaitOrderStatus) {
        self.userButton.hidden = YES;
        [self achieveCaptchaStartTime:[WLTools setupDifferentTime:self.orderModel.bid_expiry_at]];
        [self.bookButton mas_updateConstraints:^(MASConstraintMaker *make) {
            if (IsiPhone5) {
                make.width.offset(140);
            }else{
                make.width.offset(ScaleW(140));
            }
        }];
    }else
    {
       self.userButton.hidden = NO;
    }
    if(bookStatus == WLOrderStatusSettlement||bookStatus == WLOrderStatusFinish){
        self.bookButton.hidden = YES;
    }else{
        self.bookButton.hidden = NO;
    }
    
    
    if(bookStatus == WLOrderStatusStart){
        self.userButton.hidden = YES;
        [self.bookButton setTitle:@"出发" forState:UIControlStateNormal];
        [self.bookButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(ScaleW(80));
        }];
    }else if(bookStatus == WLOrderStatusTravel){
        self.userButton.hidden = YES;
        [self.bookButton setTitle:@"结束" forState:UIControlStateNormal];
        [self.bookButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(ScaleW(80));
        }];
    }
    
}
- (void)didClickContactButton:(WL_Application_Driver_Order_Tour_Button *)button
{
    
    WS(WeakSelf);
    NSArray *textArray = @ [WeakSelf.orderModel.use_car_contacts,@"叫车人",WeakSelf.orderModel.use_car_mobile];
    
    __block WLBusinessCardView *cardView = [[WLBusinessCardView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) textArray:textArray phoneCallAction:^(NSString *phoneNO) {
        [WeakSelf removeCardView:cardView];
        NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNO]];
        [[UIApplication sharedApplication] openURL:phoneURL];
    } cancelAction:^{
        [WeakSelf removeCardView:cardView];
    }];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview: cardView];
}
- (void)removeCardView:(WLBusinessCardView *)cardView
{
    __block WLBusinessCardView *blockView = cardView;
    [UIView animateWithDuration:0.5 animations:^{
        blockView.alpha = 0;
    }completion:^(BOOL finished) {
        [blockView removeFromSuperview];
        blockView = nil;
    }];
}
#pragma mark - 开启获取验证码定时器
- (void)achieveCaptchaStartTime:(double)differentTime
{
    __block int timeout = differentTime; //倒计时时间
    WS(weakSelf);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{ //处理关闭后的逻辑
                [weakSelf.bookButton setTitle:@"报价 0:00" forState:UIControlStateNormal];
                if(weakSelf.timeEndCallBack){
                    _timeEndCallBack();
                }
            });
        }
        else
        {
            int minutes = timeout / 61;
            int seconds = timeout % 61;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            NSString *strMinTime = [NSString stringWithFormat:@"%d", minutes];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                //DLog(@"____%@",strTime);
                if (self.bookStatus == WLWaitOrderStatus) {
                    [self.bookButton setTitle:[NSString stringWithFormat:@"报价 %@:%@",strMinTime, strTime] forState:UIControlStateNormal];
                }
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}
@end
