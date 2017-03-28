//
//  WL_Application_Driver_OrderDetailCell2.m
//  WeiLvDJS
//
//  Created by whw on 16/12/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_OrderDetailCell2.h"
#import "WL_Application_Driver_OrderTipView.h"

@interface WLApplicationOrderPaidDetailModel : NSObject
@property (nonatomic, copy) NSString *company_name;//支付公司
@property (nonatomic, copy) NSString *pay_at;//支付时间(时间戳)
@property (nonatomic, copy) NSString *pay_amount;//支付金额
@end
@implementation WLApplicationOrderPaidDetailModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}

@end

@interface WL_Application_Driver_OrderDetailCell2 ()

@property (nonatomic, assign) BOOL paidTipIsTap;//是否点击
/**<已支付的View */
@property (nonatomic, weak) UIView *paidView;
@property (nonatomic, weak) UIView *paidDetailView;
/**< 未支付 */
@property (nonatomic, weak) UIView *unpayView;
/**< 订单金额 */
@property (nonatomic, weak) UILabel *orderPriceLabel;
/**< 实际金额 */
@property (nonatomic, weak) UILabel *amountPriceLabel;
/**< 已支付 */
@property (nonatomic, weak) UILabel *paidPriceLabel;
/**< 未支付 */
@property (nonatomic, weak) UILabel *unpayPriceLabel;
/**< 已支付详情的模型数组 */
@property (nonatomic, strong) NSArray <WLApplicationOrderPaidDetailModel *>*paidModelArray;
/**< 保存支付详情Labe的数组 */
@property (nonatomic, strong) NSMutableArray <UILabel *>*paidDetailArray;
/**< 支付详情指示图片 */
@property (nonatomic, weak) UIImageView *paidTipImageView;
@end


@implementation WL_Application_Driver_OrderDetailCell2
static NSString *identifier = @"OrderDetailCell2";
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
//    self.paidTipIsTap = NO;
    UIView *orderView = [[UIView alloc]init];
    UIView *amountView = [[UIView alloc]init];
    UIView *paidView  = [[UIView alloc]init];
    UIView *unpayView = [[UIView alloc]init];
    
    orderView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    amountView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    paidView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    unpayView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    
     [self.contentView addSubview:orderView];
     [self.contentView addSubview:amountView];
     [self.contentView addSubview:paidView];
     [self.contentView addSubview:unpayView];
    
    [orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.offset(ScaleH(44));
    }];
    [amountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(orderView.mas_bottom);
        make.height.offset(ScaleH(44));
    }];
    [paidView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(amountView.mas_bottom);
        make.height.offset(ScaleH(44));
    }];
    [unpayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(paidView.mas_bottom);
        make.height.offset(ScaleH(44));
    }];
    
/**< orderView子控件布局 */
    UILabel *orderLabel = [[UILabel alloc]init];
    UILabel *orderPriceLabel = [[UILabel alloc]init];
    UILabel *orderLineLabel = [[UILabel alloc]init];
 
    orderLabel.textColor = Color3;
    orderLabel.font = [UIFont WLFontOfSize:14];
    orderPriceLabel.textColor = Color2;
    orderPriceLabel.font = [UIFont WLFontOfSize:14];
    orderLineLabel.backgroundColor = Color4;
    
    [orderView addSubview:orderLabel];
    [orderView addSubview:orderPriceLabel];
    [orderView addSubview:orderLineLabel];
    
    [orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(orderView).offset(ScaleW(14));
        make.centerY.equalTo(orderView);
    }];
    [orderPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(orderView).offset(- ScaleW(14));
        make.centerY.equalTo(orderView);
    }];
    [orderLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(orderView).offset(ScaleW(14));
        make.right.bottom.equalTo(orderView);
        make.height.offset(0.5);
    }];
    
/**< amountView子控件布局 */
    UILabel *amountLabel = [[UILabel alloc]init];
    UILabel *amountPriceLabel = [[UILabel alloc]init];
    UIImageView *amountTipImageView = [[UIImageView alloc]init];
    UILabel *amountLineLabel = [[UILabel alloc]init];
    
    amountLabel.textColor = Color3;
    amountLabel.font = [UIFont WLFontOfSize:14];
    amountPriceLabel.textColor = Color2;
    amountPriceLabel.font = [UIFont WLFontOfSize:14];
    amountLineLabel.backgroundColor = Color4;
    amountTipImageView.image = [UIImage imageNamed:@"tshi01"];
    UITapGestureRecognizer *amountTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapAmountTipImageView)];
    [amountTipImageView addGestureRecognizer:amountTapGesture];
    amountTipImageView.userInteractionEnabled = YES;
    
    [amountView addSubview:amountLabel];
    [amountView addSubview:amountPriceLabel];
    [amountView addSubview:amountTipImageView];
    [amountView addSubview:amountLineLabel];
    
    
    [amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(amountView).offset(ScaleW(14));
        make.centerY.equalTo(amountView);
    }];
    [amountTipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(amountView).offset(- ScaleW(14));
        make.centerY.equalTo(amountView);
    }];
    [amountPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(amountTipImageView.mas_left).offset(- ScaleW(8));
        make.centerY.equalTo(amountView);
    }];
    [amountLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(amountView).offset(ScaleW(14));
        make.right.bottom.equalTo(amountView);
        make.height.offset(0.5);
    }];
    
/**< paidView子控件布局 */
    UILabel *paidLabel = [[UILabel alloc]init];
    UILabel *paidPriceLabel = [[UILabel alloc]init];
    UIImageView *paidTipImageView = [[UIImageView alloc]init];
    UILabel *paidLineLabel = [[UILabel alloc]init];
    //支付详情的View
    UIView *paidDetailView = [[UIView alloc]init];
    
    paidLabel.textColor = Color3;
    paidLabel.font = [UIFont WLFontOfSize:14];
    paidPriceLabel.textColor = Color2;
    paidPriceLabel.font = [UIFont WLFontOfSize:14];
    paidLineLabel.backgroundColor = Color4;
    paidTipImageView.image = [UIImage imageNamed:@"product_open"];
    UITapGestureRecognizer *paidTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapPaidTipImageView:)];
//    [paidTipImageView addGestureRecognizer:paidTapGesture];
     [paidView addGestureRecognizer:paidTapGesture];
    paidTipImageView.userInteractionEnabled = YES;
    paidDetailView.backgroundColor = [WLTools stringToColor:@"#f7f7f7"];
    paidDetailView.hidden = YES;
    
    [paidView addSubview:paidLabel];
    [paidView addSubview:paidPriceLabel];
    [paidView addSubview:paidTipImageView];
    [paidView addSubview:paidLineLabel];
    [paidView addSubview:paidDetailView];
    
    [paidLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(paidView).offset(ScaleW(14));
    }];
    [paidTipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(paidView).offset(- ScaleW(14));
        make.centerY.equalTo(paidLabel);
    }];
    [paidPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(paidTipImageView.mas_left).offset(- ScaleW(10));
        make.centerY.equalTo(paidLabel);
    }];
    [paidLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(paidView).offset(ScaleW(14));
        make.right.bottom.equalTo(paidView);
        make.height.offset(0.5);
    }];
    [paidDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(paidLabel.mas_bottom).offset(ScaleH(16));
        make.left.equalTo(paidView).offset(ScaleW(12));
        make.right.equalTo(paidView).offset(-ScaleW(12));
        make.height.offset(ScaleH(44));
    }];
    
    
/**< unpayView子控件布局 */
    UILabel *unpayLabel = [[UILabel alloc]init];
    UILabel *unpayPriceLabel = [[UILabel alloc]init];
    
    unpayLabel.textColor = Color3;
    unpayLabel.font = [UIFont WLFontOfSize:14];
    unpayPriceLabel.textColor = [WLTools stringToColor:@"#ff4242"];
    unpayPriceLabel.font = [UIFont WLFontOfSize:14];
    
    [unpayView addSubview:unpayLabel];
    [unpayView addSubview:unpayPriceLabel];
    
    [unpayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(unpayView).offset(ScaleW(14));
        make.centerY.equalTo(unpayView);
    }];
    [unpayPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(unpayView).offset(- ScaleW(14));
        make.centerY.equalTo(unpayView);
    }];
    
    orderLabel.text = @"订单金额:";
    orderPriceLabel.text = @"¥ 52005.00";
    amountLabel.text = @"实际金额:";
    amountPriceLabel.text = @"¥ 4800.00";
    paidLabel.text = @"已支付:";
    paidPriceLabel.text = @"¥ 3600.00";
    unpayLabel.text = @"待支付:";
    unpayPriceLabel.text = @"¥ 12.00";
    
    self.paidView = paidView;
    self.paidDetailView = paidDetailView;
    self.unpayView = unpayView;
    
    self.orderPriceLabel = orderPriceLabel;
    self.amountPriceLabel = amountPriceLabel;
    self.paidPriceLabel = paidPriceLabel;
    self.unpayPriceLabel = unpayPriceLabel;
    self.paidTipImageView = paidTipImageView;
}

- (void)setIsFinished:(BOOL)isFinished
{
    _isFinished = isFinished;
    if (isFinished) {
        self.unpayView.hidden = YES;
        [self.unpayView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(0);
        }];
    }else
    {
        self.unpayView.hidden = NO;
        [self.unpayView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(ScaleH(44));
        }];
    }
    [self.contentView layoutIfNeeded];
}

+ (instancetype)cellForTableView:(UITableView *)tableView
{
    WL_Application_Driver_OrderDetailCell2 *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[WL_Application_Driver_OrderDetailCell2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    if (dataArray && dataArray.count > 0) {
        self.orderPriceLabel.text = [dataArray objectAtIndex:0];
        self.amountPriceLabel.text = [dataArray objectAtIndex:1];
        self.paidPriceLabel.text = [dataArray objectAtIndex:2];
        self.paidModelArray = [dataArray objectAtIndex:3];
        self.unpayPriceLabel.text = [dataArray objectAtIndex:4];
    }
}
- (void)didTapAmountTipImageView
{
   WL_Application_Driver_OrderTipView *acceptOrderTipView = [[ WL_Application_Driver_OrderTipView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(ScreenWidth - 95), ScaleH(145)) andTipType:WLOrderTipMoney];
    [KWLBaseShowView showWithContentView:acceptOrderTipView andTouch:NO andCallBlack:nil];
    
    acceptOrderTipView.seletedCallBack = ^(BOOL isAccept)
    {
        [KWLBaseShowView dismiss];
    };
}

- (void)setPaidModelArray:(NSArray *)paidModelArray
{
    NSMutableArray *modelM = [NSMutableArray arrayWithCapacity:paidModelArray.count];
    for (NSDictionary *dict in paidModelArray) {
        WLApplicationOrderPaidDetailModel *model = [[WLApplicationOrderPaidDetailModel alloc]init];
        [model setValuesForKeysWithDictionary:dict];
        [modelM addObject:model];
    }
    _paidModelArray = modelM.copy;
    
    
    if (paidModelArray.count == 0) {
        [self.paidDetailView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(ScaleH(0));
        }];
    }else if (paidModelArray.count == 1)
    {
        [self.paidDetailView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(ScaleH(50));
        }];

        UILabel *paidDetailLabel = [[UILabel alloc]init];
        paidDetailLabel.textAlignment = NSTextAlignmentLeft;
        paidDetailLabel.textColor = Color2;
         paidDetailLabel.font = [UIFont WLFontOfSize:12];
        [self.paidDetailView addSubview:paidDetailLabel];
        [paidDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.paidDetailView).offset(ScaleW(23));
            make.top.equalTo(self.paidDetailView).offset(ScaleH(18));
            make.right.equalTo(self.paidDetailView).offset(- ScaleW(11));
        }];
        paidDetailLabel.text = [NSString stringWithFormat:@"%@    +%@    %@",[NSString getDateStringWithTime:_paidModelArray[0].pay_at andFormatter:@"MM-dd  HH:mm"],_paidModelArray[0].pay_amount,_paidModelArray[0].company_name];
    }else if (paidModelArray.count > 1)
    {
        CGFloat paidDetailViewHeight = 50 + (paidModelArray.count -1)*29;
        [self.paidDetailView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(ScaleH(paidDetailViewHeight));
        }];
        for (int i = 0; i < paidModelArray.count; i++) {
            UILabel *paidDetailLabel = [[UILabel alloc]init];
            paidDetailLabel.textAlignment = NSTextAlignmentLeft;
            paidDetailLabel.textColor = Color2;
            paidDetailLabel.font = [UIFont WLFontOfSize:12];
            [self.paidDetailView addSubview:paidDetailLabel];
            [self.paidDetailArray addObject:paidDetailLabel];
        }
        
        for (int i = 0; i < paidModelArray.count; i++) {
            if (i == 0) {
               [self.paidDetailArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                   make.left.equalTo(self.paidDetailView).offset(ScaleW(23));
                   make.top.equalTo(self.paidDetailView).offset(ScaleH(18));
                   make.right.equalTo(self.paidDetailView).offset(- ScaleW(11));
               }];
            }else
            {
                [self.paidDetailArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.paidDetailView).offset(ScaleW(23));
                    make.top.equalTo([self.paidDetailArray[i-1] mas_bottom]).offset(ScaleH(15));
                    make.right.equalTo(self.paidDetailView).offset(- ScaleW(11));
                }];
            }
         
            WLApplicationOrderPaidDetailModel *model = _paidModelArray[i];
             self.paidDetailArray[i].text = [NSString stringWithFormat:@"%@    +%@    %@",[NSString getDateStringWithTime:model.pay_at andFormatter:@"MM-dd  HH:mm"],model.pay_amount,model.company_name];
        }
    
    }
    [self.contentView layoutIfNeeded];
}

- (void)didTapPaidTipImageView:(UITapGestureRecognizer *)tapGesture
{
    
    self.paidTipIsTap = !self.paidTipIsTap;
    self.paidDetailView.hidden = !self.paidTipIsTap;
    self.paidTipImageView.image = self.paidTipIsTap == YES?[UIImage imageNamed:@"product_close"]:[UIImage imageNamed:@"product_open"];
    if (self.paidTipIsTap == YES)
    {
        if (self.paidModelArray.count) {
            if (self.paidModelArray.count == 0) {
                [self.paidView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.offset(ScaleH(44));
                }];
            }else{
                [self.paidView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.offset(ScaleH(106 + (self.paidModelArray.count -1)*29));
                }];
            }
           
        }
        
        
    }else if (self.paidTipIsTap == NO)
    {
        [self.paidView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(ScaleH(44));
        }];
    }
    [self.contentView layoutIfNeeded];
    if (self.paidTipImageViewTapHandBlack)
    {
        self.paidTipImageViewTapHandBlack();
    }
}
- (NSMutableArray *)paidDetailArray
{
    if (_paidDetailArray == nil) {
        _paidDetailArray = [NSMutableArray array];
    }
    return _paidDetailArray;
}
@end
