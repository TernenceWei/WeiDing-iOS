//
//  WL_Application_Driver_OrderDetailCell0TableViewCell.m
//  WeiLvDJS
//
//  Created by whw on 16/12/25.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_OrderDetailCell0.h"

@interface WL_Application_Driver_OrderDetailCell0 ()
/**< 订单描述 */
@property (nonatomic, weak) UILabel *detaillabel;
/**< 订单价格 */
@property (nonatomic, weak) UILabel *priceLabel;
/**< 车辆座位 */
@property (nonatomic, weak) UILabel *seatCountLabe;
@end

@implementation WL_Application_Driver_OrderDetailCell0
static NSString *identifier = @"OrderDetailCell0";
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
    UILabel *detaillabel = [[UILabel alloc]init];
    UILabel *priceLabel = [[UILabel alloc]init];
    UIImageView *carImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zuowei"]];
    UILabel *seatCountLabel = [[UILabel alloc]init];
    
    detaillabel.textColor = [WLTools stringToColor:@"#333333"];
    detaillabel.numberOfLines = 0;
    detaillabel.font = [UIFont WLFontOfSize:17];
    detaillabel.textAlignment = NSTextAlignmentCenter;
    
    priceLabel.textColor = [WLTools stringToColor:@"#333333"];
    priceLabel.font = [UIFont WLFontOfSize:19];
   
    
    seatCountLabel.textColor = [WLTools stringToColor:@"#929292"];
    seatCountLabel.font = [UIFont WLFontOfSize:14];
   
    
    [self.contentView addSubview:detaillabel];
    [self.contentView addSubview:priceLabel];
    [self.contentView addSubview:carImageView];
    [self.contentView addSubview:seatCountLabel];
    
    [detaillabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(ScaleH(30));
        make.left.equalTo(self.contentView).offset(ScaleW(47));
        make.right.equalTo(self.contentView).offset(- ScaleW(47));
    }];
    
   [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(detaillabel.mas_bottom).offset(ScaleH(36));
       make.left.equalTo(self.contentView).offset(ScaleW(110));
       make.bottom.equalTo(self.contentView).offset(- ScaleH(41));
   }];
    
    [carImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(priceLabel);
        make.left.equalTo(priceLabel.mas_right).offset(ScaleW(14));
    }];
    
    [seatCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(priceLabel);
        make.left.equalTo(carImageView.mas_right).offset(ScaleW(6));
    }];
    
    self.detaillabel = detaillabel;
    self.priceLabel = priceLabel;
    self.seatCountLabe = seatCountLabel;
    
    detaillabel.text = @"假数据";
    priceLabel.text = @"¥0.00";
    seatCountLabel.text = @"0座";
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    if (dataArray && dataArray.count > 0) {
        self.detaillabel.text = [dataArray objectAtIndex:0];
        self.priceLabel.text = [NSString stringWithFormat:@"¥%@",[dataArray objectAtIndex:1]];
        self.seatCountLabe.text = [NSString stringWithFormat:@"%@座",[dataArray objectAtIndex:2]];
    }
}

+ (instancetype)cellForTableView:(UITableView *)tableView
{
    WL_Application_Driver_OrderDetailCell0 *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[WL_Application_Driver_OrderDetailCell0 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
@end


