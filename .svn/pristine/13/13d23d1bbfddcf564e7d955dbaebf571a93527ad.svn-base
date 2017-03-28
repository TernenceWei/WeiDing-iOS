//
//  WL_Application_Driver_BillList_Cell.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/4.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_BillList_Cell.h"

#import "WLDataHotelHandler.h"

#define cellIdentifier @"BillListCell"

@interface WL_Application_Driver_BillList_Cell ()
{
    UIView * backView;
    UILabel * starDate;
    UILabel * endDate;
    UILabel * endTime;
    UILabel * endTimeMoney;
    UILabel * showLabel;
}

@end

@implementation WL_Application_Driver_BillList_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupChildViewToDriverBillCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

+ (WL_Application_Driver_BillList_Cell *)cellCreateTableView:(UITableView *)tableView
{
    WL_Application_Driver_BillList_Cell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WL_Application_Driver_BillList_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

#define leftSpace ScaleW(10)

#pragma mark - 设置子控件
- (void)setupChildViewToDriverBillCell
{
    backView = [[UIView alloc] init];
    backView.frame = CGRectMake(0, 0, ScreenWidth, ScaleH(165));
    backView.backgroundColor = [UIColor whiteColor];//[WLTools stringToColor:@"#f7f7f8"];
    [self addSubview:backView];
    
//***时间日程显示***//
    starDate = [WLTools allocLabel:@"" font:[UIFont WLFontOfSize:14.0] textColor:[WLTools stringToColor:@"#333333"] frame:CGRectMake(leftSpace, leftSpace * 2, ScaleW(75), ScaleH(15)) textAlignment:NSTextAlignmentCenter];
    [backView addSubview:starDate];
    
    UIView *radiusView = [[UIView alloc] init];
    radiusView.frame = CGRectMake(starDate.frame.origin.x + starDate.frame.size.width + ScaleW(5), starDate.frame.origin.y - ScaleH(3), ScaleW(20), ScaleH(20));
    radiusView.backgroundColor = [WLTools stringToColor:@"#929292"];
    radiusView.layer.cornerRadius = 10;
    [backView addSubview:radiusView];
    
    UILabel * starGoendLabel = [WLTools allocLabel:@"至" font:[UIFont WLFontOfSize:11.0] textColor:[UIColor whiteColor] frame:CGRectMake(ScaleW(3),ScaleH(3), ScaleW(15), ScaleH(15)) textAlignment:NSTextAlignmentCenter];
    [radiusView addSubview:starGoendLabel];
    
    endDate = [WLTools allocLabel:@"" font:[UIFont WLFontOfSize:14.0] textColor:[WLTools stringToColor:@"#333333"] frame:CGRectMake(radiusView.frame.origin.x + radiusView.frame.size.width + ScaleW(5), starDate.frame.origin.y, starDate.frame.size.width, starDate.frame.size.height) textAlignment:NSTextAlignmentCenter];
    [backView addSubview:endDate];
    
//***中间的内容显示***//
    NSArray * arr = [[NSArray alloc] initWithObjects:@"订单金额：",@"实际金额：",@"已支付:", nil];
    
    for (NSInteger i = 0; i < arr.count; i ++) {
        UILabel * leftLabel = [WLTools allocLabel:[NSString stringWithFormat:@"%@",arr[i]] font:[UIFont WLFontOfSize:13.0] textColor:[WLTools stringToColor:@"#929292"] frame:CGRectMake(leftSpace, starDate.frame.origin.y + starDate.frame.size.height + ScaleH(20) + ScaleH(20) * i, ScaleW(80), ScaleH(15)) textAlignment:NSTextAlignmentLeft];
        leftLabel.tag = 11990 + i;
        [backView addSubview:leftLabel];
        
        UILabel * rightLabel = [WLTools allocLabel:@"" font:[UIFont WLFontOfSize:13.0] textColor:[WLTools stringToColor:@"#333333"] frame:CGRectMake(ScreenWidth - ScaleW(200), leftLabel.frame.origin.y , ScaleW(190), leftLabel.frame.size.height) textAlignment:NSTextAlignmentRight];
        rightLabel.tag = 1990 + i;
        [backView addSubview:rightLabel];
    }
    
    UILabel * lineLabel = [[UILabel alloc] init];
    lineLabel.frame = CGRectMake(0, backView.frame.size.height - ScaleH(40), backView.frame.size.width, ScaleH(0.5));
    lineLabel.backgroundColor = [WLTools stringToColor:@"#e4e4e4"];
    [backView addSubview:lineLabel];
    
    endTime = [WLTools allocLabel:@"" font:[UIFont WLFontOfSize:13.0] textColor:[WLTools stringToColor:@"#929292"] frame:CGRectMake(leftSpace, lineLabel.frame.origin.y + lineLabel.frame.size.height + ScaleH(7), backView.frame.size.width / 2, ScaleH(20)) textAlignment:NSTextAlignmentLeft];
    [backView addSubview:endTime];
    
    

    endTimeMoney = [WLTools allocLabel:@"" font:[UIFont WLFontOfSize:13.0] textColor:[WLTools stringToColor:@"#00cc99"] frame:CGRectZero textAlignment:NSTextAlignmentCenter];
    [backView addSubview:endTimeMoney];
    
    showLabel = [WLTools allocLabel:@"待支付:" font:[UIFont WLFontOfSize:13.0] textColor:[WLTools stringToColor:@"#2f2f2f"] frame:CGRectZero textAlignment:NSTextAlignmentRight];
    showLabel.textColor = [UIColor lightGrayColor];
    [backView addSubview:showLabel];
    
    UILabel * lineLabelbottom = [[UILabel alloc] init];
    lineLabelbottom.frame = CGRectMake(0, backView.frame.size.height - ScaleH(5), backView.frame.size.width, ScaleH(5));
    lineLabelbottom.backgroundColor = [WLTools stringToColor:@"#f2f2f2"];
    [backView addSubview:lineLabelbottom];
}

- (void)setCellModel:(WLDriverBillItemObject *)daModel stauts:(NSInteger)status
{
    starDate.text = [NSString stringWithFormat:@"%@",([daModel.start_at isEqualToString:@"0"])?@"":[WLDataHotelHandler getYMStringWithYMDString:[WLDataHotelHandler TimeIntervalChangeWithYMDString:daModel.start_at]]];
    endDate.text = [NSString stringWithFormat:@"%@",([daModel.end_at isEqualToString:@"0"])?@"":[WLDataHotelHandler getYMStringWithYMDString:[WLDataHotelHandler TimeIntervalChangeWithYMDString:daModel.end_at]]];

    endTime.text = [NSString stringWithFormat:@"结束时间：%@",([daModel.trip_end_at isEqualToString:@"0"])?@"":[WLDataHotelHandler TimeIntervalChangeWithYMDString:daModel.trip_end_at]];
    CGSize size =[[NSString stringWithFormat:@"%@",daModel.no_pay] sizeWithAttributes:@{NSFontAttributeName:WLFontSize(13.0)}];
    endTimeMoney.frame = CGRectMake(backView.frame.size.width - size.width - ScaleW(20), endTime.frame.origin.y, size.width + ScaleW(15), endTime.frame.size.height);
    endTimeMoney.text = [NSString stringWithFormat:@"%@",daModel.no_pay];
    
    showLabel.frame = CGRectMake(endTimeMoney.frame.origin.x - ScaleW(70), endTimeMoney.frame.origin.y, ScaleW(70), 20);
    
    NSArray * arr2 = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%@",daModel.order_price],[NSString stringWithFormat:@"%@",daModel.actual_pay],[NSString stringWithFormat:@"%@",daModel.pay], nil];

    if (arr2.count != 0) {
        UILabel *rightLabel1 = (UILabel *)[self viewWithTag:1990];
        rightLabel1.text = [NSString stringWithFormat:@"%@",arr2[0]];
        
        UILabel *rightLabel12 = (UILabel *)[self viewWithTag:1991];
        rightLabel12.text = [NSString stringWithFormat:@"%@",arr2[1]];
        
        UILabel *rightLabel13 = (UILabel *)[self viewWithTag:1992];
        rightLabel13.text = [NSString stringWithFormat:@"%@",arr2[2]];
        
        if ([daModel.no_confirm isEqual:@"0"] && [daModel.is_local isEqual:@"1"]) {
            rightLabel12.text = @"待确定";
        }
    }
    
    // 判断是否结清两个切换按钮
    if (status == 1) {
        showLabel.hidden = NO;
        if ([daModel.no_confirm isEqual:@"0"] && [daModel.is_local isEqual:@"1"]) {
            endTimeMoney.text = [NSString stringWithFormat:@"待确定"];
            CGSize size =[[NSString stringWithFormat:@"待确定"] sizeWithAttributes:@{NSFontAttributeName:WLFontSize(13.0)}];
            endTimeMoney.frame = CGRectMake(backView.frame.size.width - size.width - ScaleW(20), endTime.frame.origin.y, size.width + ScaleW(15), endTime.frame.size.height);
        }
    }
    if (status == 2) {
        showLabel.hidden = YES;
        endTimeMoney.text = [NSString stringWithFormat:@"已结清"];
        CGSize size =[[NSString stringWithFormat:@"已结清"] sizeWithAttributes:@{NSFontAttributeName:WLFontSize(13.0)}];
        endTimeMoney.frame = CGRectMake(backView.frame.size.width - size.width - ScaleW(20), endTime.frame.origin.y, size.width + ScaleW(15), endTime.frame.size.height);
    }
    if (daModel.order_type == 2 && status == 2) {
        UILabel *rightLabel12 = (UILabel *)[self viewWithTag:1991];
        rightLabel12.hidden = NO;
        rightLabel12.text = [NSString stringWithFormat:@"%@",daModel.driver_price];
        
        UILabel *rightLabel13 = (UILabel *)[self viewWithTag:1992];
        rightLabel13.text = [NSString stringWithFormat:@"%@",daModel.dispatch_price];
        
        UILabel *rightLabel122 = (UILabel *)[self viewWithTag:11991];
        rightLabel122.text = [NSString stringWithFormat:@"已结算:"];
        rightLabel122.hidden = NO;
        
        UILabel *rightLabel133 = (UILabel *)[self viewWithTag:11992];
        rightLabel133.text = [NSString stringWithFormat:@"企业抽成："];
        endTime.text = [NSString stringWithFormat:@"到账时间：%@",([daModel.pay_at isEqualToString:@"0"])?@"":[WLDataHotelHandler TimeIntervalChangeWithYMDString:daModel.pay_at]];
    }
    else
    {
        UILabel *rightLabel12 = (UILabel *)[self viewWithTag:1991];
        rightLabel12.text = [NSString stringWithFormat:@"%@",daModel.actual_pay];
        rightLabel12.hidden = YES;
        
        UILabel *rightLabel13 = (UILabel *)[self viewWithTag:1992];
        rightLabel13.text = [NSString stringWithFormat:@"%@",daModel.pay];
        
        UILabel *rightLabel122 = (UILabel *)[self viewWithTag:11991];
        rightLabel122.text = [NSString stringWithFormat:@"实际金额："];
        rightLabel122.hidden = YES;
        UILabel *rightLabel133 = (UILabel *)[self viewWithTag:11992];
        rightLabel133.text = [NSString stringWithFormat:@"已支付:"];
    }
}

@end
