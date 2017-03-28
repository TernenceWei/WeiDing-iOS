//
//  WLApplicationDriverBookOrderDetailCell0.m
//  WeiLvDJS
//
//  Created by whw on 17/1/21.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLApplicationDriverBookOrderDetailCell0.h"

@interface WLApplicationDriverBookOrderDetailCell0 ()
/**< 订单描述 */
@property (nonatomic, weak) UILabel *detaillabel;
/**< 订单价格 */
@property (nonatomic, weak) UILabel *priceLabel;
/**< 车辆座位 */
@property (nonatomic, weak) UILabel *seatCountLabe;
/**< 车辆类型 */
@property (nonatomic, weak) UILabel *carTypeLabel;
/**< 线路详情的按钮 */
@property (nonatomic, weak) UIButton *tripButton;
/**< 保存图片路劲的数组 */
@property (nonatomic, strong) NSArray *urlArray;

@end
@implementation WLApplicationDriverBookOrderDetailCell0
static NSString *identifier = @"bookOrderDetailCell0";
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
    UILabel *tripLabel = [[UILabel alloc]init];
    UILabel *detaillabel = [[UILabel alloc]init];
    UILabel *priceLabel = [[UILabel alloc]init];
    UILabel *carTypeLabel = [[UILabel alloc]init];
    UIImageView *carImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zuowei"]];
    UILabel *seatCountLabel = [[UILabel alloc]init];
    UIButton *tripButton = [[UIButton alloc]init];
    
    tripLabel.textColor = Color3;
    tripLabel.font = [UIFont WLFontOfSize:14];
    tripLabel.text = @"行程:";
    detaillabel.textColor = Color2;
    detaillabel.numberOfLines = 0;
    detaillabel.font = [UIFont WLFontOfSize:17];
    detaillabel.textAlignment = NSTextAlignmentLeft;
    
    priceLabel.textColor = Color2;
    priceLabel.font = [UIFont WLFontOfSize:19];
    
    carTypeLabel.textColor = Color3;
    carTypeLabel.font = [UIFont WLFontOfSize:14];
    
    seatCountLabel.textColor = Color3;
    seatCountLabel.font = [UIFont WLFontOfSize:14];
    
    [tripButton setImage:[UIImage imageNamed:@"chakanxiangqingNor"] forState:UIControlStateNormal];
    [tripButton setImage:[UIImage imageNamed:@"xiangqingSel"] forState:UIControlStateSelected];
    
    [tripButton setTitle:@"查看详情" forState:UIControlStateNormal];
    [tripButton setTitleColor:Color3 forState:UIControlStateNormal];
    [tripButton setTitleColor:Color1 forState:UIControlStateSelected];
    tripButton.titleLabel.font = [UIFont WLFontOfSize:15];
    tripButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    tripButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [tripButton addTarget:self action:@selector(didClickTripButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:tripLabel];
    [self.contentView addSubview:detaillabel];
    [self.contentView addSubview:priceLabel];
    [self.contentView addSubview:carTypeLabel];
    [self.contentView addSubview:carImageView];
    [self.contentView addSubview:seatCountLabel];
    [self.contentView addSubview:tripButton];
    
    [tripLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(ScaleH(23));
        make.left.equalTo(self.contentView).offset(ScaleW(12));
        make.width.offset(ScaleW(40));
    }];
    [detaillabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(ScaleH(23));
        make.left.equalTo(tripLabel.mas_right).offset(ScaleW(42));
        make.right.equalTo(self.contentView).offset(-ScaleW(10));
    }];
    
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(detaillabel.mas_bottom).offset(ScaleH(30));
        make.left.equalTo(self.contentView).offset(ScaleW(80));
//        make.bottom.equalTo(self.contentView).offset(- ScaleH(20));
    }];
    
    [carTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(priceLabel);
        make.left.equalTo(priceLabel.mas_right).offset(ScaleW(15));
    }];
    [carImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(priceLabel);
        make.left.equalTo(carTypeLabel.mas_right).offset(ScaleW(13));
    }];
    
    [seatCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(priceLabel);
        make.left.equalTo(carImageView.mas_right).offset(ScaleW(6));
    }];
    
    [tripButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(carImageView.mas_bottom).offset(ScaleH(30));
        make.left.equalTo(self.contentView).offset(ScaleW(80));
        make.width.offset(ScaleW(200));
        make.bottom.equalTo(self.contentView).offset(- ScaleH(20));
    }];
    
    self.detaillabel = detaillabel;
    self.priceLabel = priceLabel;
    self.carTypeLabel = carTypeLabel;
    self.seatCountLabe = seatCountLabel;
    self.tripButton = tripButton;
    
    detaillabel.text = @"假数据";
    priceLabel.text = @"¥0.00";
    carTypeLabel.text = @"其它";
    seatCountLabel.text = @"0座";
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    if (dataArray && dataArray.count > 0) {
        NSString *startString = [dataArray objectAtIndex:0];
        NSString *viaString = [dataArray objectAtIndex:1];
        NSString *endString = [dataArray objectAtIndex:2];
        if (viaString.length > 0) {
            viaString = [viaString stringByReplacingOccurrencesOfString:@"," withString:@"---"];
            self.detaillabel.text = [NSString stringWithFormat:@"%@---%@---%@",startString,viaString,endString];
        }else
        {
            self.detaillabel.text = [NSString stringWithFormat:@"%@---%@",startString,endString];
        }
        self.priceLabel.text =  [dataArray objectAtIndex:3];
        switch ([[dataArray objectAtIndex:4] integerValue]) {
            case 1:
                self.carTypeLabel.text = @"大巴车";
                break;
            case 2:
                self.carTypeLabel.text = @"商务车";
                break;
            case 4:
                self.carTypeLabel.text = @"小汽车";
                break;
            default:
                self.carTypeLabel.text = @"其它";
                break;
        }
        self.seatCountLabe.text = [NSString stringWithFormat:@"%@座",[dataArray objectAtIndex:5]];
        self.urlArray = [self getPictureUrlFromDataArray:[dataArray objectAtIndex:6]];
        
        if (self.urlArray .count>0) {
            self.tripButton.selected = YES;
            self.tripButton.userInteractionEnabled = YES;
        }else
        {
            self.tripButton.selected = NO;
            self.tripButton.userInteractionEnabled = NO;
        }
    }
}
- (NSArray *)getPictureUrlFromDataArray:(NSArray *)dataArray
{
    
    NSMutableArray *urlArray = [NSMutableArray arrayWithCapacity:dataArray.count];
    for (NSDictionary *picDict in dataArray) {
        NSString *url1 = picDict[@"base_url"];
        NSString *url2 = picDict[@"path"];
        NSString *picUrl = [NSString stringWithFormat:@"%@/%@",url1,url2];
        [urlArray addObject:picUrl];
    }
    
    return urlArray.copy;
    
}
- (void)didClickTripButton
{
    WS(weakSelf);
    if (self.tripButtonCallBack) {
        self.tripButtonCallBack(weakSelf.urlArray);
    }
}
+ (instancetype)cellForTableView:(UITableView *)tableView
{
    WLApplicationDriverBookOrderDetailCell0 *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[WLApplicationDriverBookOrderDetailCell0 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
@end
