//
//  WL_Application_Driver_AcceptOrderTipView.m
//  WeiLvDJS
//
//  Created by whw on 16/12/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_OrderTipView.h"

@interface WL_Application_Driver_OrderTipView ()
@property (nonatomic, assign) WLOrderTipType type;

/**< 提示详情Label */
@property (nonatomic, weak) UILabel *detailLabel;
@end

#define tipColor [WLTools stringToColor:@"#000000"]
@implementation WL_Application_Driver_OrderTipView

/**< 自定义构造方法 */
- (instancetype)initWithFrame:(CGRect)frame andTipType:(WLOrderTipType)type
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [WLTools stringToColor:@"#ffffff"];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.type = type;
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI
{
    UILabel *tipLabel = [[UILabel alloc]init];
    UILabel *detailLabel = [[UILabel alloc]init];
    UIButton *notButton = [[UIButton alloc]init];
    UIButton *yesButton = [[UIButton alloc]init];
    
    tipLabel.text = @"提示";
    tipLabel.textColor = tipColor;
    tipLabel.font = [UIFont WLFontOfBoldSize:15];
    
    switch (self.type) {
        case WLOrderTipAccept:
            detailLabel.text = @"该订单需要在 \"10月12日 - 深圳\"出发,是否确认接单?";
            [yesButton setTitle:@"接单" forState:UIControlStateNormal];
            break;
        case WLOrderTipStart:
            detailLabel.text = @"出发前, 请与导游共同核对人员情况!";
            [yesButton setTitle:@"确认出发" forState:UIControlStateNormal];
            break;
        case WLBookOrderTipStart:
            detailLabel.text = @"出发前，请确认客户已上车，若产生客户投诉，将会影响您的订单收益及派单量";
            [yesButton setTitle:@"确认出发" forState:UIControlStateNormal];
            break;
        case WLOrderTipEnd:
            [yesButton setTitle:@"确认结束" forState:UIControlStateNormal];
            detailLabel.text = @"请确保您已经将该团所有游客送达了目的地,是否结束行程?";
            break;
        case WLBookOrderTipEnd:
            [yesButton setTitle:@"确认结束" forState:UIControlStateNormal];
            detailLabel.text = @"请确保您已经将所有乘客送达了目的地，是否结束行程?";
            break;
        case WLOrderTipMoney:
            detailLabel.text = @"实际金额为跟据出行情况调整后的价格,若有疑义,请与车调中心或导游联系";
            [yesButton setTitle:@"好的" forState:UIControlStateNormal];
            break;
        case WLOrderTipDelete:
            [yesButton setTitle:@"全部删除" forState:UIControlStateNormal];
            detailLabel.text = @"是否删除所有已失效订单?";
            break;
        case WLReceivedRecord:
            [yesButton setTitle:@"好的" forState:UIControlStateNormal];
            detailLabel.text = @"若您因为实际出行与订单不符,需要调整订单价格,请与导游或客户商议,并由导游记账或车调中心进行调价.";
            break;
        case WLCarTipNOEdit:
            [yesButton setTitle:@"知道了" forState:UIControlStateNormal];
            detailLabel.text = @"您当前有尚未出发或未结束的订单,无法编辑";
            break;
        case WLCarTipEdit:
            [yesButton setTitle:@"确认编辑" forState:UIControlStateNormal];
            detailLabel.text = @"编辑后需要重新提交审核,确认是否编辑";
            break;
        case WLCarTipSubmit:
            [yesButton setTitle:@"知道了" forState:UIControlStateNormal];
            detailLabel.text = @"您没有修改资料,请根据失败原因修改资料后提交";
            break;
        case WLCarAddSuccess:
            [yesButton setTitle:@"知道了" forState:UIControlStateNormal];
            detailLabel.text = @"您的个人信息已成功提交审核,工作人员将在3～5个工作日内完成审核，请耐心等待.";
            break;
        default:
            break;
    }
    
    detailLabel.numberOfLines = 0;
    detailLabel.textColor = tipColor;
    detailLabel.font = [UIFont WLFontOfSize:12];
    detailLabel.textAlignment = NSTextAlignmentCenter;
    
    if (self.type == WLOrderTipStart ||self.type == WLBookOrderTipStart ) {
        [notButton setTitle:@"取消" forState:UIControlStateNormal];
    }else
    {
        [notButton setTitle:@"否" forState:UIControlStateNormal];
    }
    
    [notButton setTitleColor:[WLTools stringToColor:@"#333333"] forState:UIControlStateNormal];
    notButton.titleLabel.font = [UIFont WLFontOfSize:14];
    notButton.layer.borderColor = [WLTools stringToColor:@"#e4e4e4"].CGColor;
    notButton.layer.borderWidth = 0.5;
    [notButton addTarget:self action:@selector(didClickIsAcceptButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [yesButton setTitleColor:[WLTools stringToColor:@"#00cc99"] forState:UIControlStateNormal];
     yesButton.titleLabel.font = [UIFont WLFontOfSize:14];
    yesButton.layer.borderColor = [WLTools stringToColor:@"#e4e4e4"].CGColor;
    yesButton.layer.borderWidth = 0.5;
    [yesButton addTarget:self action:@selector(didClickIsAcceptButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:tipLabel];
    [self addSubview:detailLabel];
    [self addSubview:notButton];
    [self addSubview:yesButton];
    
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(ScaleH(20));
    }];
    
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipLabel.mas_bottom).offset(ScaleH(5));
        make.left.equalTo(self).offset(ScaleH(18));
        make.right.equalTo(self).offset(-ScaleH(18));
    }];
    
    [notButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(self);
        make.height.offset(ScaleH(45));
    }];
    
    
    if(self.type == WLOrderTipMoney || self.type == WLReceivedRecord ||self.type == WLCarTipNOEdit||self.type == WLCarTipSubmit||self.type == WLCarAddSuccess)
    {
        notButton.hidden = YES;
        [yesButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.bottom.equalTo(self);
            make.height.offset(ScaleH(45));
        }];
        
        
    }else
    {
        notButton.hidden = NO;
        [yesButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.bottom.equalTo(self);
            make.left.equalTo(notButton.mas_right);
            make.width.height.equalTo(notButton);
        }];
    }
    
    [self layoutIfNeeded];
    
    self.detailLabel = detailLabel;
}
/**< 出发信息 */
- (void)setStartInfo:(NSString *)startInfo
{
    _startInfo = startInfo;
    if (self.type == WLOrderTipAccept) {
        self.detailLabel.text = [NSString stringWithFormat:@"该订单需要在 \"%@\"出发,是否确认接单?",startInfo];
    }
}
- (void)didClickIsAcceptButton:(UIButton *)button
{
    if (self.seletedCallBack)
    {
        if ([button.currentTitle isEqualToString:@"否"]||[button.currentTitle isEqualToString:@"取消"])
        {
            self.seletedCallBack(NO);
        }else
        {
            self.seletedCallBack(YES);
        }
    }
}
@end
