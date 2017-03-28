//
//  WLApplicationDriverBookOrderDetailCell6.m
//  WeiLvDJS
//
//  Created by whw on 17/2/27.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLApplicationDriverBookOrderDetailCell6.h"

typedef NS_ENUM(NSInteger, WLTripStatus){
    WLRecivedOrder = 400,                 /** 收到 */
    WLUnConfirm,                          /**< 已报价 待客户确认*/
    WLPickUser,                           /**去接乘客  */
    WLTripStar,                           /** 出发 */
    WLTripFinish,                         /**< 行程结束 */
    WLTripPaid                            /**< 已支付 */
};

@interface WLApplicationDriverBookOrderDetailCell6 ()
@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, weak) UILabel *lineLabel;/**< 竖线 */
@property (nonatomic, strong) NSMutableArray <UIImageView *>*imagesArr;/**< 保存所有图片的数组 */
@property (nonatomic, strong) NSMutableArray <UILabel *>*labelsArr;/**< 保存所有时间描述的数组 */


@end

#define ArrCount 6
#define imageOriginX ScaleW(27.3)
#define imageOriginY ScaleH(28)

#define lineOriginX ScaleW(27.3)
#define lineOriginY ScaleH(28)
#define Magrin  ScaleH(40)
#define norImage [UIImage imageNamed:@"xiangqingdianN"]
#define selImage [UIImage imageNamed:@"xiangqingdian"]
#define FormatterString @"yyyy-MM-dd HH:mm"

@implementation WLApplicationDriverBookOrderDetailCell6
static NSString *identifier = @"boookOrderDetailCell6";
#pragma mark - 重写构造方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //设置cell点击不变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
        [self setupUI];
    }
    return self;
}
- (void)setupUI
{

    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    lineLabel.backgroundColor = Color3;
    self.lineLabel = lineLabel;
    [self.contentView addSubview:lineLabel];
    
    for (int i = 0; i < ArrCount; i++) {
        
        UIImageView *statusImageView = [[UIImageView alloc]init];
        UILabel *descriptionLabel = [[UILabel alloc]init];
        descriptionLabel.backgroundColor = [UIColor clearColor];
        if (i == 0) {
            statusImageView.image = selImage;
            descriptionLabel.textColor = Color1;
        }else{
            statusImageView.image = norImage;
            descriptionLabel.textColor = Color3;
        }
        [statusImageView sizeToFit];
        statusImageView.hidden = YES;
        descriptionLabel.font = [UIFont WLFontOfSize:14];
        
        [self.contentView addSubview:statusImageView];
        [self.contentView addSubview:descriptionLabel];
        
        [self.imagesArr addObject:statusImageView];
        [self.labelsArr addObject:descriptionLabel];
        
    }
    
}

- (void)setBookStatus:(WLBookOrderStatus)bookStatus
{
    _bookStatus = bookStatus;
    switch (bookStatus) {
        case WLWaitOrderStatus:
        {
            self.imagesArr[0].center = CGPointMake(imageOriginX, imageOriginY);
            self.imagesArr[0].hidden = NO;
            [self.labelsArr[0] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView).offset(ScaleH(20));
                make.left.equalTo(self.contentView).offset(ScaleW(40));
                make.bottom.equalTo(self.contentView).offset(- ScaleH(20));
            }];
            [self configLabelWithIndex:0 currentTrip:WLRecivedOrder];
            break;
        }
        case WLUnpaidStatus:
        {
            self.imagesArr[0].center = CGPointMake(imageOriginX, imageOriginY);
            self.imagesArr[1].center = CGPointMake(imageOriginX, imageOriginY+Magrin);
            self.imagesArr[0].hidden = self.imagesArr[1].hidden = NO;
            self.lineLabel.frame = CGRectMake(lineOriginX, lineOriginY, 1.5, Magrin);
            
            [self.labelsArr[0] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView).offset(ScaleH(20));
                make.left.equalTo(self.contentView).offset(ScaleW(40));
            }];
            [self.labelsArr[1] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView).offset(ScaleH(20) + Magrin);
                make.left.equalTo(self.contentView).offset(ScaleH(40));
                make.bottom.equalTo(self.contentView).offset(ScaleH(-20));
            }];
            [self configLabelWithIndex:0 currentTrip:WLUnConfirm];
            [self configLabelWithIndex:1 currentTrip:WLRecivedOrder];
            break;
        }
        case WLOrderStatusStart:
        {
            self.imagesArr[0].center = CGPointMake(imageOriginX, imageOriginY);
            self.imagesArr[1].center = CGPointMake(imageOriginX, imageOriginY+Magrin);
            self.imagesArr[2].center = CGPointMake(imageOriginX, imageOriginY+Magrin*2);
            self.imagesArr[0].hidden = self.imagesArr[1].hidden = self.imagesArr[2].hidden = NO;
                                                                     
            [self.labelsArr[0] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView).offset(ScaleH(20));
                make.left.equalTo(self.contentView).offset(ScaleW(40));
            }];
            [self.labelsArr[1] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView).offset(ScaleH(20) + Magrin);
                make.left.equalTo(self.contentView).offset(ScaleH(40));
            }];
            
            if ([self.orderModel.pay_status integerValue] == 1||[self.orderModel.pay_status integerValue] == 2) {/**< 表示已支付 */
                self.imagesArr[3].center = CGPointMake(imageOriginX, imageOriginY+Magrin*3);
                self.imagesArr[3].hidden = NO;
                [self.labelsArr[2] mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.contentView).offset(ScaleH(20) + Magrin*2);
                    make.left.equalTo(self.contentView).offset(ScaleH(40));
                }];
                [self.labelsArr[3] mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.contentView).offset(ScaleH(20) + Magrin*3);
                    make.left.equalTo(self.contentView).offset(ScaleH(40));
                    make.bottom.equalTo(self.contentView).offset(ScaleH(-20));
                }];
                [self configLabelWithIndex:0 currentTrip:WLTripPaid];
                [self configLabelWithIndex:1 currentTrip:WLPickUser];
                [self configLabelWithIndex:2 currentTrip:WLUnConfirm];
                [self configLabelWithIndex:3 currentTrip:WLRecivedOrder];
                self.lineLabel.frame = CGRectMake(lineOriginX, lineOriginY, 1.5, Magrin*3);
        
            }else
            {
                self.imagesArr[3].hidden = YES;
                [self.labelsArr[2] mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.contentView).offset(ScaleH(20) + Magrin*2);
                    make.left.equalTo(self.contentView).offset(ScaleH(40));
                    make.bottom.equalTo(self.contentView).offset(ScaleH(-20));
                }];
                [self configLabelWithIndex:0 currentTrip:WLPickUser];
                [self configLabelWithIndex:1 currentTrip:WLUnConfirm];
                [self configLabelWithIndex:2 currentTrip:WLRecivedOrder];
                self.lineLabel.frame = CGRectMake(lineOriginX, lineOriginY, 1.5, Magrin*2);
            }
            break;
        }case WLOrderStatusTravel:
        {
            self.imagesArr[0].center = CGPointMake(imageOriginX, imageOriginY);
            self.imagesArr[1].center = CGPointMake(imageOriginX, imageOriginY+Magrin);
            self.imagesArr[2].center = CGPointMake(imageOriginX, imageOriginY+Magrin*2);
            self.imagesArr[3].center = CGPointMake(imageOriginX, imageOriginY+Magrin*3);
            self.imagesArr[0].hidden = self.imagesArr[1].hidden = self.imagesArr[2].hidden = self.imagesArr[3].hidden = NO;
            [self.labelsArr[0] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView).offset(ScaleH(20));
                make.left.equalTo(self.contentView).offset(ScaleW(40));
            }];
            [self.labelsArr[1] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView).offset(ScaleH(20) + Magrin);
                make.left.equalTo(self.contentView).offset(ScaleH(40));
            }];
            [self.labelsArr[2] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView).offset(ScaleH(20) + Magrin*2);
                make.left.equalTo(self.contentView).offset(ScaleH(40));
            }];
          
            
            if ([self.orderModel.pay_status integerValue] == 1||[self.orderModel.pay_status integerValue] == 2) {/**< 表示已支付 */
                self.imagesArr[4].center = CGPointMake(imageOriginX, imageOriginY+Magrin*4);
                self.imagesArr[4].hidden = NO;
                [self.labelsArr[3] mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.contentView).offset(ScaleH(20) + Magrin*3);
                    make.left.equalTo(self.contentView).offset(ScaleH(40));
                }];
                [self.labelsArr[4] mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.contentView).offset(ScaleH(20) + Magrin*4);
                    make.left.equalTo(self.contentView).offset(ScaleH(40));
                    make.bottom.equalTo(self.contentView).offset(ScaleH(-20));
                }];
                
                
                if([self.orderModel.trip_start_at doubleValue] >= [self.orderModel.pay_at doubleValue])
                {
                    [self configLabelWithIndex:0 currentTrip:WLTripStar];
                     [self configLabelWithIndex:1 currentTrip:WLTripPaid];
                    
                }else{
                    [self configLabelWithIndex:0 currentTrip:WLTripPaid];
                    [self configLabelWithIndex:1 currentTrip:WLTripStar];
                }
               
                [self configLabelWithIndex:2 currentTrip:WLPickUser];
                [self configLabelWithIndex:3 currentTrip:WLUnConfirm];
                [self configLabelWithIndex:4 currentTrip:WLRecivedOrder];
                self.lineLabel.frame = CGRectMake(lineOriginX, lineOriginY, 1.5, Magrin*4);
            }else
            {
                self.imagesArr[4].hidden = YES;
                [self.labelsArr[3] mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.contentView).offset(ScaleH(20) + Magrin*3);
                    make.left.equalTo(self.contentView).offset(ScaleH(40));
                    make.bottom.equalTo(self.contentView).offset(ScaleH(-20));
                }];
                [self configLabelWithIndex:0 currentTrip:WLTripStar];
                [self configLabelWithIndex:1 currentTrip:WLPickUser];
                [self configLabelWithIndex:2 currentTrip:WLUnConfirm];
                [self configLabelWithIndex:3 currentTrip:WLRecivedOrder];
                self.lineLabel.frame = CGRectMake(lineOriginX, lineOriginY, 1.5, Magrin*3);
            }
            break;
        }case WLOrderStatusFinish:
        {
            self.imagesArr[0].center = CGPointMake(imageOriginX, imageOriginY);
            self.imagesArr[1].center = CGPointMake(imageOriginX, imageOriginY+Magrin);
            self.imagesArr[2].center = CGPointMake(imageOriginX, imageOriginY+Magrin*2);
            self.imagesArr[3].center = CGPointMake(imageOriginX, imageOriginY+Magrin*3);
            self.imagesArr[4].center = CGPointMake(imageOriginX, imageOriginY+Magrin*4);
            self.imagesArr[0].hidden = self.imagesArr[1].hidden = self.imagesArr[2].hidden = self.imagesArr[3].hidden = self.imagesArr[4].hidden = NO;
            [self.labelsArr[0] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView).offset(ScaleH(20));
                make.left.equalTo(self.contentView).offset(ScaleW(40));
            }];
            [self.labelsArr[1] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView).offset(ScaleH(20) + Magrin);
                make.left.equalTo(self.contentView).offset(ScaleH(40));
            }];
            [self.labelsArr[2] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView).offset(ScaleH(20) + Magrin*2);
                make.left.equalTo(self.contentView).offset(ScaleH(40));
            }];
            
            [self.labelsArr[3] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView).offset(ScaleH(20) + Magrin*3);
                make.left.equalTo(self.contentView).offset(ScaleH(40));
            }];
            if ([self.orderModel.pay_status integerValue] == 1||[self.orderModel.pay_status integerValue] == 2) {/**< 表示已支付 */
                self.imagesArr[5].center = CGPointMake(imageOriginX, imageOriginY+Magrin*5);
                self.imagesArr[5].hidden = NO;
                
                [self.labelsArr[4] mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.contentView).offset(ScaleH(20) + Magrin*4);
                    make.left.equalTo(self.contentView).offset(ScaleH(40));
                }];
                [self.labelsArr[5] mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.contentView).offset(ScaleH(20) + Magrin*5);
                    make.left.equalTo(self.contentView).offset(ScaleH(40));
                    make.bottom.equalTo(self.contentView).offset(ScaleH(-20));
                }];
                
                if([self.orderModel.pay_at doubleValue] < [self.orderModel.trip_start_at doubleValue])
                {
                   
                    [self configLabelWithIndex:0 currentTrip:WLTripFinish];
                    [self configLabelWithIndex:1 currentTrip:WLTripStar];
                    [self configLabelWithIndex:2 currentTrip:WLTripPaid];
                    
                }else if ([self.orderModel.pay_at doubleValue] >= [self.orderModel.trip_start_at doubleValue] &&[self.orderModel.pay_at doubleValue] <= [self.orderModel.trip_end_at doubleValue])
                {
                    [self configLabelWithIndex:0 currentTrip:WLTripFinish];
                    [self configLabelWithIndex:1 currentTrip:WLTripPaid];
                    [self configLabelWithIndex:2 currentTrip:WLTripStar];
                    
                }else if ([self.orderModel.trip_end_at doubleValue] < [self.orderModel.pay_at doubleValue])
                {
                    [self configLabelWithIndex:0 currentTrip:WLTripPaid];
                    [self configLabelWithIndex:1 currentTrip:WLTripFinish];
                    [self configLabelWithIndex:2 currentTrip:WLTripStar];
                
                }
                [self configLabelWithIndex:3 currentTrip:WLPickUser];
                [self configLabelWithIndex:4 currentTrip:WLUnConfirm];
                [self configLabelWithIndex:5 currentTrip:WLRecivedOrder];
                self.lineLabel.frame = CGRectMake(lineOriginX, lineOriginY, 1.5, Magrin*5);
            }else
            {
                self.imagesArr[5].hidden = YES;
                [self.labelsArr[4] mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.contentView).offset(ScaleH(20) + Magrin*4);
                    make.left.equalTo(self.contentView).offset(ScaleH(40));
                    make.bottom.equalTo(self.contentView).offset(ScaleH(-20));
                }];
                [self configLabelWithIndex:0 currentTrip:WLTripFinish];
                [self configLabelWithIndex:1 currentTrip:WLTripStar];
                [self configLabelWithIndex:2 currentTrip:WLPickUser];
                [self configLabelWithIndex:3 currentTrip:WLUnConfirm];
                [self configLabelWithIndex:4 currentTrip:WLRecivedOrder];
                self.lineLabel.frame = CGRectMake(lineOriginX, lineOriginY, 1.5, Magrin*4);
            }
            
            break;
        }
        default:
            break;
    }
      [self.contentView layoutIfNeeded];
}
- (void)configLabelWithIndex:(NSInteger )index currentTrip:(WLTripStatus)tripStatus
{
    switch (tripStatus) {
        case WLRecivedOrder:
            self.labelsArr[index].text = [NSString stringWithFormat:@"收到派单                           %@",[NSString getDateStringWithTime:self.orderModel.send_at andFormatter:FormatterString]];
            break;
        case WLUnConfirm:
            self.labelsArr[index].text = [NSString stringWithFormat:@"报价成功,待客户确认       %@",[NSString getDateStringWithTime:[self.orderModel.bid objectForKey:@"bid_at"] andFormatter:FormatterString]];
            break;
        case WLPickUser:
            self.labelsArr[index].text = [NSString stringWithFormat:@"竞价成功,去接乘客           %@",[NSString getDateStringWithTime:self.orderModel.reception_at andFormatter:FormatterString]];
            break;
        case WLTripStar:
        {
            if (IsiPhone5) {
                self.labelsArr[index].text = [NSString stringWithFormat:@"接到乘客,出发                  %@",[NSString getDateStringWithTime:self.orderModel.trip_start_at andFormatter:FormatterString]];
            }else
            {
                self.labelsArr[index].text = [NSString stringWithFormat:@"接到乘客,出发                   %@",[NSString getDateStringWithTime:self.orderModel.trip_start_at andFormatter:FormatterString]];
            }
            break;
        }
        case WLTripFinish:
        {
            if (IsiPhone5) {
                self.labelsArr[index].text = [NSString stringWithFormat:@"行程已结束                       %@",[NSString getDateStringWithTime:self.orderModel.trip_end_at andFormatter:FormatterString]];
            }else
            {
                self.labelsArr[index].text = [NSString stringWithFormat:@"行程已结束                        %@",[NSString getDateStringWithTime:self.orderModel.trip_end_at andFormatter:FormatterString]];
            }
           
            break;
        }
        case WLTripPaid:
            self.labelsArr[index].text = [NSString stringWithFormat:@"乘客已付款                        %@",[NSString getDateStringWithTime:self.orderModel.pay_at andFormatter:FormatterString]];
            break;
        default:
            break;
    }
    
}
- (NSMutableArray *)imagesArr
{
    if (_imagesArr == nil) {
        _imagesArr = [NSMutableArray array];
    }
    return _imagesArr;
}
- (NSMutableArray *)labelsArr
{
    if (_labelsArr == nil) {
        _labelsArr = [NSMutableArray array];
    }
    return _labelsArr;
}
+ (instancetype)cellForTableView:(UITableView *)tableView
{
    WLApplicationDriverBookOrderDetailCell6 *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[WLApplicationDriverBookOrderDetailCell6 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

@end
