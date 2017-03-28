//
//  WL_Application_Driver_OrderDetailBottomView.m
//  WeiLvDJS
//
//  Created by whw on 16/12/25.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_OrderDetailBottomView.h"
#import "WLBusinessCardView.h"
@interface WL_Application_Driver_OrderDetailBottomView ()
{
    dispatch_source_t _timer;/**< 倒计时 */
}
/**< 计调按钮 */
@property (nonatomic, weak) WL_Application_Driver_Order_Tour_Button *dispatchButton;
/**< 用车人按钮 */
@property (nonatomic, weak) WL_Application_Driver_Order_Tour_Button *userButton;

@end
@implementation WL_Application_Driver_OrderDetailBottomView

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
    //联系调度按钮
    WL_Application_Driver_Order_Tour_Button *dispatchButton = [[WL_Application_Driver_Order_Tour_Button alloc] init];
   //联系用车人
    WL_Application_Driver_Order_Tour_Button *userButton = [[WL_Application_Driver_Order_Tour_Button alloc] init];;
    //设置bottomView中的子控件
    UIButton *refuseButton = [[UIButton alloc]init];
    UIButton *acceptButton = [[UIButton alloc]init];
    
    lineLabel.backgroundColor = [WLTools stringToColor:@"#f2f2f2"];
    dispatchButton.nameLable.text = @"联系调度";
    dispatchButton.tag = 10;
    userButton.nameLable.text = @"联系用车人";
    userButton.tag = 11;
    [dispatchButton addTarget:self action:@selector(didClickContactButton:) forControlEvents:UIControlEventTouchUpInside];
    [userButton addTarget:self action:@selector(didClickContactButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [refuseButton setTitle:@"拒绝" forState:UIControlStateNormal];
    [refuseButton setTitleColor:[WLTools stringToColor:@"#333333"] forState:UIControlStateNormal];
    [refuseButton setBackgroundImage:[UIImage imageNamed:@"judan"] forState:UIControlStateNormal];
    refuseButton.titleLabel.font = [UIFont WLFontOfSize:17];
    [refuseButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    
//    [acceptButton setTitle:@"接单 59:59" forState:UIControlStateNormal];
    [acceptButton setTitleColor:[WLTools stringToColor:@"#ffffff"] forState:UIControlStateNormal];
    acceptButton.titleLabel.font = [UIFont WLFontOfSize:17];
    [acceptButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    
    [self addSubview:lineLabel];
    [self addSubview:dispatchButton];
    [self addSubview:userButton];
    [self addSubview:refuseButton];
    [self addSubview:acceptButton];
    
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.offset(1);
    }];
    [dispatchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(ScaleW(30));
        make.bottom.equalTo(self).offset(-ScaleH(10));
    }];
    [userButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(dispatchButton.mas_right).offset(ScaleW(45));
        make.bottom.equalTo(self).offset(-ScaleH(10));
    }];
    
    [acceptButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).offset(- 12);
        make.width.offset(ScaleW(120));
    }];
    [refuseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(acceptButton);
        make.right.equalTo(acceptButton.mas_left).offset(- 12);
        make.width.offset(ScaleW(80));
    }];
    
    
    self.dispatchButton = dispatchButton;
    self.userButton = userButton;
    self.acceptButton = acceptButton;
    self.refuseButton = refuseButton;
}

- (void)setOrderDetailStatus:(WLOrderDetailStatus)orderDetailStatus
{
    _orderDetailStatus = orderDetailStatus;
    if (self.orderDetailStatus == WLOrderDetailCancel ||self.orderDetailStatus == WLOrderDetailRefuse||self.orderDetailStatus == WLOrderDetailOverTime)  {
        self.hidden = YES;
    }else
    {
        self.hidden = NO;
    }
    if (self.orderDetailStatus == WLOrderDetailWait)
    {
        self.dispatchButton.hidden = YES;
        self.userButton.hidden = YES;
        self.refuseButton.hidden = NO;
    }else
    {
        self.dispatchButton.hidden = NO;
        self.userButton.hidden = NO;
        self.refuseButton.hidden = YES;
    }
    if (self.orderDetailStatus == WLOrderDetailStart) {
        self.userButton.enabled = NO;
        self.userButton.nameLable.textColor = Color3;
        self.userButton.photoImageView.image = [UIImage imageNamed:@"lianxirenbukedianji"];
    }else
    {
        self.userButton.enabled = YES;
        self.userButton.nameLable.textColor = Color2;
        self.userButton.photoImageView.image = [UIImage imageNamed:@"lianxiren"];
    }

    if (self.orderDetailStatus == WLOrderDetailSettlement || self.orderDetailStatus == WLOrderDetailFinished) {
        self.acceptButton.hidden = YES;
    }else {
        self.acceptButton.hidden = NO;
    }
    
    if (self.orderDetailStatus == WLOrderDetailWait) {
        
       [self achieveCaptchaStartTime:[WLTools setupDifferentTime:self.expiry_at]];
        [self.acceptButton setBackgroundImage:[UIImage imageNamed:@"jiedan"] forState:UIControlStateNormal];
        
        [self.acceptButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(ScaleW(130));
        }];
    }else if(self.orderDetailStatus == WLOrderDetailStart)
    {
        [self.acceptButton setTitle:@"出发" forState:UIControlStateNormal];
        [self.acceptButton setBackgroundImage:[UIImage imageNamed:@"chufa"] forState:UIControlStateNormal];
        [self.acceptButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(ScaleW(80));
        }];
    }else if (self.orderDetailStatus == WLOrderDetailTravel)
    {
        [self.acceptButton setTitle:@"结束" forState:UIControlStateNormal];
        [self.acceptButton setBackgroundImage:[UIImage imageNamed:@"chufa"] forState:UIControlStateNormal];
        [self.acceptButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(ScaleW(80));
        }];
    }
    [self layoutIfNeeded];
}
#pragma mark - 开启获取验证码定时器
- (void)achieveCaptchaStartTime:(double)differentTime
{
    __block int timeout = differentTime; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
               
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
                if (self.orderDetailStatus == WLOrderDetailWait) {
                      [self.acceptButton setTitle:[NSString stringWithFormat:@"接单%@:%@",strMinTime, strTime] forState:UIControlStateNormal];
                }
              
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

- (void)didClickContactButton:(WL_Application_Driver_Order_Tour_Button *)button
{
    
    WS(WeakSelf);
    NSDictionary *contactDict = WeakSelf.orderDetailData.contact;
    NSArray *textArray = button.tag == 10?@[ contactDict[@"contact_name"],@"调度",contactDict[@"contact_phone"] ]:@[WeakSelf.orderDetailData.use_car_contacts,@"用车人",WeakSelf.orderDetailData.use_car_mobile];
    
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
@end
