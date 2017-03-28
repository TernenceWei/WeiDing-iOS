//
//  WL_Application_Driver_OrderDetailCell3.m
//  WeiLvDJS
//
//  Created by whw on 16/12/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_OrderDetailCell3.h"


@interface WL_Application_Driver_OrderDetailCell3 ()
/**< 车调中心 */
@property (nonatomic, weak) UILabel *carCenterDescription;
/**< 订单号 */
@property (nonatomic, weak) UILabel *orderNumberDescription;
/**< 用车客户 */
@property (nonatomic, weak) UILabel *carUserDescription;
/**< 成团单号 */
@property (nonatomic, weak) UILabel *cloudsNumberDescription;

@end
@implementation WL_Application_Driver_OrderDetailCell3
static NSString *identifier = @"OrderDetailCell3";
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
    UILabel *carCenterLabel = [[UILabel alloc]init];
    UILabel *carCenterDescription = [[UILabel alloc]init];
    UILabel *orderNumberLabel = [[UILabel alloc]init];
    UILabel *orderNumberDescription = [[UILabel alloc]init];
    UILabel *carUserLabel = [[UILabel alloc]init];
    UILabel *carUserDescription = [[UILabel alloc]init];
    //成团单号
    UILabel *cloudsNumberLabel = [[UILabel alloc]init];
    UILabel *cloudsNumberDescription = [[UILabel alloc]init];

    carCenterLabel.textColor = Color3;
    carCenterLabel.font = [UIFont WLFontOfSize:14];
    carCenterDescription.textColor = Color2;
    carCenterDescription.font = [UIFont WLFontOfSize:14];
    orderNumberLabel.textColor = Color3;
    orderNumberLabel.font = [UIFont WLFontOfSize:14];
    orderNumberDescription.textColor = Color2;
    orderNumberDescription.font = [UIFont WLFontOfSize:14];
    carUserLabel.textColor = Color3;
    carUserLabel.font = [UIFont WLFontOfSize:14];
    carUserDescription.textColor = Color2;
    carUserDescription.font = [UIFont WLFontOfSize:14];
    cloudsNumberLabel.textColor = Color3;
    cloudsNumberLabel.font = [UIFont WLFontOfSize:14];
    cloudsNumberDescription.textColor = Color2;
    cloudsNumberDescription.font = [UIFont WLFontOfSize:14];
    
    [self.contentView addSubview:carCenterLabel];
    [self.contentView addSubview:carCenterDescription];
    [self.contentView addSubview:orderNumberLabel];
    [self.contentView addSubview:orderNumberDescription];
    [self.contentView addSubview:carUserLabel];
    [self.contentView addSubview:carUserDescription];
    [self.contentView addSubview:cloudsNumberLabel];
    [self.contentView addSubview:cloudsNumberDescription];
    
    [carCenterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(ScaleH(23));
        make.left.equalTo(self.contentView).offset(ScaleW(12));
    }];
    [carCenterDescription mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(ScaleH(23));
        make.left.equalTo(self.contentView).offset(ScaleW(90));
    }];
    [orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(carCenterLabel.mas_bottom).offset(ScaleH(17));
        make.left.equalTo(self.contentView).offset(ScaleW(12));
    }];
    [orderNumberDescription mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(carCenterDescription.mas_bottom).offset(ScaleH(17));
        make.left.equalTo(self.contentView).offset(ScaleW(90));
    }];
    [carUserLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(orderNumberLabel.mas_bottom).offset(ScaleH(17));
        make.left.equalTo(self.contentView).offset(ScaleW(12));
    }];
    [carUserDescription mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(orderNumberDescription.mas_bottom).offset(ScaleH(17));
        make.left.equalTo(self.contentView).offset(ScaleW(90));
    }];
    [cloudsNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(carUserLabel.mas_bottom).offset(ScaleH(17));
        make.left.equalTo(self.contentView).offset(ScaleW(12));
    }];
    [cloudsNumberDescription mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(carUserDescription.mas_bottom).offset(ScaleH(17));
        make.left.equalTo(self.contentView).offset(ScaleW(90));
        make.bottom.equalTo(self.contentView).offset(- ScaleH(23));
    }];
    
    carCenterLabel.text = @"车调中心:";
    carCenterDescription.text = @"假数据";
    orderNumberLabel.text = @"订单号:";
    orderNumberDescription.text = @"HHHHHHH";
    carUserLabel.text = @"用车客户:";
    carUserDescription.text = @"假数据";
    cloudsNumberLabel.text = @"成团单号:";
    cloudsNumberDescription.text = @"HHHHHHH";
    
    self.carCenterDescription = carCenterDescription;
    self.orderNumberDescription = orderNumberDescription;
    self.carUserDescription = carUserDescription;
    self.cloudsNumberDescription = cloudsNumberDescription;
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    if (dataArray && dataArray.count > 0) {
        self.carCenterDescription.text = [dataArray objectAtIndex:0];
        self.orderNumberDescription.text = [dataArray objectAtIndex:1];
        self.carUserDescription.text = [dataArray objectAtIndex:2];
        self.cloudsNumberDescription.text = [dataArray objectAtIndex:3];
        if (self.carUserDescription.text.length == 0) {
            self.carUserDescription.text = @"无所属公司";
        }
        self.cloudsNumberDescription.text = [dataArray objectAtIndex:3];
        if ( self.cloudsNumberDescription.text.length == 0) {
            self.cloudsNumberDescription.text = @"无成团单号";
        }
    }
}
+ (instancetype)cellForTableView:(UITableView *)tableView
{
    WL_Application_Driver_OrderDetailCell3 *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[WL_Application_Driver_OrderDetailCell3 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

@end
