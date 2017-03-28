//
//  WLGuideDetailFooterView.m
//  WeiLvDJS
//
//  Created by whw on 16/10/28.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLGuideDetailFooterView.h"
@interface WLGuideDetailFooterView()

@property(nonatomic, strong)UILabel *label1;
@property(nonatomic, strong)UILabel *label2;
@property(nonatomic, strong)UILabel *label3;

@property(nonatomic, strong)UIImageView *imageView1;
@property(nonatomic, strong)UIImageView *imageView2;

@end

@implementation WLGuideDetailFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

-(void)setDetailInfo:(WLGroupDetailInfo *)detailInfo{
    _detailInfo = detailInfo;
    [self creatView];
    if ([self.detailInfo.statusInfo isEqualToString:@"待接单"]) {
        self.label2.text = [NSString stringWithFormat:@"接单状态:%@",self.detailInfo.statusInfo];
        self.label3.text = [NSString stringWithFormat:@"派单时间:%@",self.detailInfo.sendTime];
        self.label4.hidden = YES;
        self.label5.hidden = YES;
    }
    else if ([self.detailInfo.statusInfo isEqualToString:@"已接单"]) {
        self.label2.text = [NSString stringWithFormat:@"接单状态:%@",self.detailInfo.statusInfo];
        self.label3.text = [NSString stringWithFormat:@"行程状况:%@",self.detailInfo.groupStatus];
        self.label4.text = [NSString stringWithFormat:@"派单时间:%@",self.detailInfo.sendTime];
        self.label5.text = [NSString stringWithFormat:@"接单时间:%@",self.orderInfo.acceptOrderDate];
    }
    else if ([self.detailInfo.statusInfo isEqualToString:@"已失效"]) {
        self.label2.text = [NSString stringWithFormat:@"订单状态:%@",self.detailInfo.orderStatus];
        self.label3.text = [NSString stringWithFormat:@"拒绝原因:%@",self.detailInfo.statusInfo];
        self.label4.text = [NSString stringWithFormat:@"派单时间:%@",self.detailInfo.sendTime];
        self.label5.text = [NSString stringWithFormat:@"失效时间:%@",self.orderInfo.acceptOrderDate];
        
    }
}

-(void)creatView{
    self.imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(25), ScaleH(75), ScaleW(115), 2)];
    self.imageView1.backgroundColor = HEXCOLOR(0xd8d9dd);
    [self addSubview:self.imageView1];
    
    self.imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(225), ScaleH(75), ScaleW(115), 2)];
    self.imageView2.backgroundColor = HEXCOLOR(0xd8d9dd);
    [self addSubview:self.imageView2];
    
    self.label1 = [[UILabel alloc] init];
    [self addSubview:self.label1];
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imageView1.mas_centerY);
        make.left.equalTo(self.mas_left).offset(ScaleW(155));
    }];
    self.label1.textColor = HEXCOLOR(0xd8d9dd);
    self.label1.font = WLFontSize(14);
    self.label1.text = @"订单状态";
    
    self.label2 = [[UILabel alloc] initWithFrame:CGRectMake(ScaleW(15), ScaleH(100), ScreenWidth, ScaleH(15))];
    [self addSubview:self.label2];
    
    self.label2.textColor = HEXCOLOR(0xb5b5b5);
    self.label2.font = WLFontSize(13);
    
    self.label3 = [[UILabel alloc] initWithFrame:CGRectMake(ScaleW(15), ScaleH(124), ScreenWidth, ScaleH(15))];
    [self addSubview:self.label3];
    
    self.label3.textColor = HEXCOLOR(0xb5b5b5);
    self.label3.font = WLFontSize(13);
    
    self.label4 = [[UILabel alloc] initWithFrame:CGRectMake(ScaleW(15), ScaleH(148), ScreenWidth, ScaleH(15))];
    [self addSubview:self.label4];
    
    self.label4.textColor = HEXCOLOR(0xb5b5b5);
    self.label4.font = WLFontSize(13);
    
    self.label5 = [[UILabel alloc] initWithFrame:CGRectMake(ScaleW(15), ScaleH(172), ScreenWidth, ScaleH(15))];
    [self addSubview:self.label5];
    
    self.label5.textColor = HEXCOLOR(0xb5b5b5);
    self.label5.font = WLFontSize(13);
    
}

@end
