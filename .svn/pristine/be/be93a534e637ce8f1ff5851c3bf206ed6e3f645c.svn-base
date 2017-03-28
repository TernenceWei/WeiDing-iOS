//
//  WLApplicationDriverBookOrderDetailCell3.m
//  WeiLvDJS
//
//  Created by whw on 17/1/21.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLApplicationDriverBookOrderDetailCell3.h"
#import "WLBusinessCardView.h"
@interface WLApplicationDriverBookOrderDetailCell3 ()
/**< 订单号 */
@property (nonatomic, weak) UILabel *orderNumberDescription;
/**< 用车客户 */
@property (nonatomic, weak) UILabel *carUserDescription;
@property (nonatomic, weak) UIButton *callButton;/**< 拨打电话按钮 */
@property (nonatomic, weak) UILabel *carUserLabel;
@property (nonatomic, weak) UILabel *orderNumberLabel;
@end
@implementation WLApplicationDriverBookOrderDetailCell3
static NSString *identifier = @"bookOrderDetailCell3";
#pragma mark - 重写构造方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置子控件
        [self setupUI];
        //设置cell点击不变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    }
    return self;
}

- (void)setupUI
{
   
    UILabel *orderNumberLabel = [[UILabel alloc]init];
    UILabel *orderNumberDescription = [[UILabel alloc]init];
    UILabel *carUserLabel = [[UILabel alloc]init];
    UILabel *carUserDescription = [[UILabel alloc]init];
    UIButton *callButton = [[UIButton alloc]init];
    
    orderNumberLabel.font = [UIFont WLFontOfSize:14];
    orderNumberLabel.textColor = Color3;
  
    orderNumberDescription.font = [UIFont WLFontOfSize:14];
    orderNumberDescription.textColor = Color2;
    
    carUserLabel.textColor = Color3;
    carUserLabel.font = [UIFont WLFontOfSize:14];
    carUserDescription.textColor = Color2;
    carUserDescription.font = [UIFont WLFontOfSize:14];
    [callButton setImage:[UIImage imageNamed:@"dianhua"] forState:UIControlStateNormal];
    callButton.hidden = YES;
    
    [self.contentView addSubview:orderNumberLabel];
    [self.contentView addSubview:orderNumberDescription];
    [self.contentView addSubview:carUserLabel];
    [self.contentView addSubview:carUserDescription];
    [self.contentView addSubview:callButton];
    

    [orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(ScaleH(17));
        make.left.equalTo(self.contentView).offset(ScaleW(12));
    }];
    [orderNumberDescription mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(ScaleH(17));
        make.left.equalTo(self.contentView).offset(ScaleW(90));
    }];
    [carUserLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(orderNumberLabel.mas_bottom).offset(ScaleH(17));
        make.left.equalTo(self.contentView).offset(ScaleW(12));
        make.bottom.equalTo(self.contentView).offset(- ScaleH(17));
    }];
    [carUserDescription mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(orderNumberDescription.mas_bottom).offset(ScaleH(17));
        make.left.equalTo(self.contentView).offset(ScaleW(90));
    }];
    [callButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(carUserLabel);
        make.right.equalTo(self.contentView).offset(-ScaleW(20));
    }];
    
    [callButton addTarget:self action:@selector(didClickContactButton:) forControlEvents:UIControlEventTouchUpInside];
    orderNumberLabel.text = @"订单号:";
    orderNumberDescription.text = @"HHHHHHH";
    carUserLabel.text = @"用车客户:";
    carUserDescription.text = @"假数据";
    
    self.callButton = callButton;
    self.orderNumberDescription = orderNumberDescription;
    self.carUserDescription = carUserDescription;
    self.carUserLabel = carUserLabel;
    self.orderNumberLabel = orderNumberLabel;
}
- (void)setBookStatus:(WLBookOrderStatus)bookStatus
{
    _bookStatus = bookStatus;
    if (bookStatus==WLFailureOrderStatusOverTime||bookStatus==WLFailureOrderStatusQuoted||bookStatus==WLFailureOrderStatusUnquoted||bookStatus==WLFailureOrderStatusQuotedCanceled||bookStatus==WLFailureOrderStatusUnquotedCanceled) {
        self.carUserLabel.hidden = YES;
        self.callButton.hidden = YES;
        self.carUserDescription.text = @"";
        [self.orderNumberLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(ScaleH(17));
            make.left.equalTo(self.contentView).offset(ScaleW(12));
            make.bottom.equalTo(self.contentView).offset(- ScaleH(17));
        }];
    }else{
        self.carUserLabel.hidden = NO;
        [self.orderNumberLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(ScaleH(17));
            make.left.equalTo(self.contentView).offset(ScaleW(12));
        }];
        [self.carUserLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.orderNumberLabel.mas_bottom).offset(ScaleH(17));
            make.left.equalTo(self.contentView).offset(ScaleW(12));
            make.bottom.equalTo(self.contentView).offset(- ScaleH(17));
        }];
        if (bookStatus == WLWaitOrderStatus||bookStatus == WLUnpaidStatus) {
            self.callButton.hidden = YES;
            self.carUserDescription.text = @"出发当天可见";
            self.carUserDescription.font = [UIFont WLFontOfSize:13];
            self.carUserDescription.textColor = Color3;
        }else  if(bookStatus==WLOrderStatusStart||bookStatus==WLOrderStatusTravel||bookStatus==WLOrderStatusSettlement||bookStatus==WLOrderStatusFinish)
        {
            NSString *start_at = [self.dataArray objectAtIndex:3];
            if([NSString isTodayOfTimeString:start_at])/**< 是不是今天 */
            {
                self.callButton.hidden = NO;
                self.carUserDescription.font = [UIFont WLFontOfSize:14];
                self.carUserDescription.textColor = Color2;
                self.orderNumberDescription.text = [self.dataArray objectAtIndex:0];
                self.carUserDescription.text = [NSString stringWithFormat:@"%@   %@",[self.dataArray objectAtIndex:1],[self.dataArray objectAtIndex:2]];
            }else
            {
                self.callButton.hidden = YES;
                self.carUserDescription.text = @"出发当天可见";
                self.carUserDescription.font = [UIFont WLFontOfSize:13];
                self.carUserDescription.textColor = Color3;
            }
        }
        
    }
}
- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;

    if (dataArray && dataArray.count > 0) {
        self.orderNumberDescription.text = [dataArray objectAtIndex:0];
        if ([[dataArray objectAtIndex:2] length] == 0) {
            self.callButton.hidden = YES;
            self.carUserDescription.text = @"出发当天可见";
            self.carUserDescription.font = [UIFont WLFontOfSize:13];
            self.carUserDescription.textColor = Color3;
        }else
        {
            self.callButton.hidden = NO;
            self.carUserDescription.font = [UIFont WLFontOfSize:14];
            self.carUserDescription.textColor = Color2;
            self.orderNumberDescription.text = [dataArray objectAtIndex:0];
            self.carUserDescription.text = [NSString stringWithFormat:@"%@   %@",[dataArray objectAtIndex:1],[dataArray objectAtIndex:2]];
        }
        
    }
}
+ (instancetype)cellForTableView:(UITableView *)tableView
{
    WLApplicationDriverBookOrderDetailCell3 *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[WLApplicationDriverBookOrderDetailCell3 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
- (void)didClickContactButton:(UIButton *)button
{
    NSString *telPhoneStr = [NSString stringWithFormat:@"tel:%@", [self.dataArray objectAtIndex:2]];
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:telPhoneStr]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telPhoneStr]];
    }
//    WS(WeakSelf);
//    NSArray *textArray = @[[WeakSelf.dataArray objectAtIndex:1],@"用车人",[WeakSelf.dataArray objectAtIndex:2] ];
//    
//    __block WLBusinessCardView *cardView = [[WLBusinessCardView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) textArray:textArray phoneCallAction:^(NSString *phoneNO) {
//        [WeakSelf removeCardView:cardView];
//        NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNO]];
//        [[UIApplication sharedApplication] openURL:phoneURL];
//    } cancelAction:^{
//        [WeakSelf removeCardView:cardView];
//    }];
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    [window addSubview: cardView];
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
