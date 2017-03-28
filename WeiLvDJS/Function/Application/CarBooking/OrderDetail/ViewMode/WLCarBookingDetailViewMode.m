//
//  WLCarBookingDetailViewMode.m
//  WeiLvDJS
//
//  Created by ternence on 2017/1/21.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLCarBookingDetailViewMode.h"

@implementation WLCarBookingDetailViewMode

+ (NSArray *)getPaymentCellTimeArray:(WLCarBookingOrderDetailObject *)object
{
    
    NSMutableArray *textArray = [NSMutableArray array];
    [textArray addObject:[NSString stringWithFormat:@"订单编号： %@",object.number]];
    [textArray addObject:[NSString stringWithFormat:@"创建时间： %@",[WLUITool timeStringWithTimeInterval:object.created_at.integerValue formatter:@"yyyy-MM-dd HH:mm:ss"]]];
    if ((object.reception_status.integerValue == 4) || (object.reception_status.integerValue == 6) || (object.reception_status.integerValue == 7)) {//已取消
        if (object.reception_status.integerValue == 6) {
            [textArray addObject:[NSString stringWithFormat:@"订单关闭： %@",[WLUITool timeStringWithTimeInterval:object.bid_expiry_at.integerValue formatter:@"yyyy-MM-dd HH:mm:ss"]]];
        }
        else
        {
            [textArray addObject:[NSString stringWithFormat:@"订单关闭： %@",[WLUITool timeStringWithTimeInterval:object.updated_at.integerValue formatter:@"yyyy-MM-dd HH:mm:ss"]]];
        }
        return [textArray copy];
    }
//    if (object.pay_status.integerValue == 0) {//待支付
//        
//    }else{
        [textArray addObject:[NSString stringWithFormat:@"开始选择： %@",[WLUITool timeStringWithTimeInterval:object.frist_bid_at.integerValue formatter:@"yyyy-MM-dd HH:mm:ss"]]];
        
        //[textArray addObject:[NSString stringWithFormat:@"付款时间： %@",[WLUITool timeStringWithTimeInterval:object.pay_at.integerValue formatter:@"yyyy-MM-dd HH:mm:ss"]]];
        if (object.trip_status.integerValue == 0) {//待出行
            if (object.pay_at != nil && ![object.pay_at isEqual:@""]) {
                [textArray addObject:[NSString stringWithFormat:@"付款时间： %@",[WLUITool timeStringWithTimeInterval:object.pay_at.integerValue formatter:@"yyyy-MM-dd HH:mm:ss"]]];
            }
        }else{//出行中，已结束
            
            if (object.trip_status.integerValue == 2) {//已结束
                if(object.pay_at.integerValue > object.trip_end_at.integerValue)
                {
                    [textArray addObject:[NSString stringWithFormat:@"行程开始： %@",[WLUITool timeStringWithTimeInterval:object.trip_start_at.integerValue formatter:@"yyyy-MM-dd HH:mm:ss"]]];
                    [textArray addObject:[NSString stringWithFormat:@"行程结束： %@",[WLUITool timeStringWithTimeInterval:object.trip_end_at.integerValue formatter:@"yyyy-MM-dd HH:mm:ss"]]];
                    if (object.pay_at != nil && ![object.pay_at isEqual:@""]) {
                        [textArray addObject:[NSString stringWithFormat:@"付款时间： %@",[WLUITool timeStringWithTimeInterval:object.pay_at.integerValue formatter:@"yyyy-MM-dd HH:mm:ss"]]];
                    }
                }
                else
                {
                    if (object.pay_at.integerValue > object.trip_start_at.integerValue) {
                        [textArray addObject:[NSString stringWithFormat:@"行程开始： %@",[WLUITool timeStringWithTimeInterval:object.trip_start_at.integerValue formatter:@"yyyy-MM-dd HH:mm:ss"]]];
                        if (object.pay_at != nil && ![object.pay_at isEqual:@""]) {
                            [textArray addObject:[NSString stringWithFormat:@"付款时间： %@",[WLUITool timeStringWithTimeInterval:object.pay_at.integerValue formatter:@"yyyy-MM-dd HH:mm:ss"]]];
                        }
                    }
                    else
                    {
                        if (object.pay_at != nil && ![object.pay_at isEqual:@""]) {
                            [textArray addObject:[NSString stringWithFormat:@"付款时间： %@",[WLUITool timeStringWithTimeInterval:object.pay_at.integerValue formatter:@"yyyy-MM-dd HH:mm:ss"]]];
                        }
                        [textArray addObject:[NSString stringWithFormat:@"行程开始： %@",[WLUITool timeStringWithTimeInterval:object.trip_start_at.integerValue formatter:@"yyyy-MM-dd HH:mm:ss"]]];
                    }
                    [textArray addObject:[NSString stringWithFormat:@"行程结束： %@",[WLUITool timeStringWithTimeInterval:object.trip_end_at.integerValue formatter:@"yyyy-MM-dd HH:mm:ss"]]];
                }
            }
            else
            {
                if (object.pay_at.integerValue > object.trip_start_at.integerValue) {
                    [textArray addObject:[NSString stringWithFormat:@"行程开始： %@",[WLUITool timeStringWithTimeInterval:object.trip_start_at.integerValue formatter:@"yyyy-MM-dd HH:mm:ss"]]];
                    if (object.pay_at != nil && ![object.pay_at isEqual:@""]) {
                        [textArray addObject:[NSString stringWithFormat:@"付款时间： %@",[WLUITool timeStringWithTimeInterval:object.pay_at.integerValue formatter:@"yyyy-MM-dd HH:mm:ss"]]];
                    }
                }
                else
                {
                    if (object.pay_at != nil && ![object.pay_at isEqual:@""]) {
                        [textArray addObject:[NSString stringWithFormat:@"付款时间： %@",[WLUITool timeStringWithTimeInterval:object.pay_at.integerValue formatter:@"yyyy-MM-dd HH:mm:ss"]]];
                    }
                    [textArray addObject:[NSString stringWithFormat:@"行程开始： %@",[WLUITool timeStringWithTimeInterval:object.trip_start_at.integerValue formatter:@"yyyy-MM-dd HH:mm:ss"]]];
                }
            }
//        }
    }
    return [textArray copy];
}

+ (CGFloat)getPaymentCellHeight:(WLCarBookingOrderDetailObject *)object
{
    if (object.reception_status.integerValue == 1) {
        return ScaleH(110) + [self getPaymentCellTimeArray:object].count * ScaleH(30) + ScaleH(10);
    }
    return [self getPaymentCellTimeArray:object].count * ScaleH(30) + ScaleH(10);
}

+ (CGFloat)getOrderCellHeightWithObject:(WLCarBookingOrderDetailObject *)object isFold:(BOOL)isFold
{
    CGFloat height = ScaleH(45);
    if (object == nil) {
        return height;
    }
    
    NSUInteger visaCount = 0;
    NSMutableArray *addressArray = [NSMutableArray arrayWithObject:object.start_address];
    
    if (![object.via_address isEqualToString:@""]) {
        NSArray *visArray = [object.via_address componentsSeparatedByString:@","];
        if (visArray.count > 2) {
            visaCount = isFold ? 2: visArray.count;
        }else{
            visaCount = visArray.count;
        }
        for (int i = 0; i < visaCount; i++) {
            [addressArray addObject:visArray[i]];
        }
    }
    [addressArray addObject:object.end_address];
    
    CGFloat addressW = ScreenWidth - ScaleW(32);
    NSUInteger addressCount = 2 + visaCount;
    for (int i = 0; i < addressCount; i++) {
        
        CGFloat addressH = [WLUITool sizeWithString:addressArray[i] font:[UIFont WLFontOfSize:15] constrainedToSize:CGSizeMake(addressW, MAXFLOAT)].height;
        height += addressH;
        
    }
    height += ScaleH(10) * (addressCount + 1);
    if (![object.memo isEqualToString:@""] && object.memo != nil) {
        CGFloat remarkHeight = [WLUITool sizeWithString:object.memo font:[UIFont WLFontOfSize:14] constrainedToSize:CGSizeMake(ScreenWidth - ScaleW(45), MAXFLOAT)].height + ScaleH(20);
        height += remarkHeight;
    }
    return height + ScaleH(40);
}


+ (NSString *)dateTimeDifferenceWithEndTime:(NSDate *)endDate
{
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";

    NSString *expireDateStr = [dateFomatter stringFromDate:endDate];
    NSString *nowDateStr = [dateFomatter stringFromDate:[NSDate date]];

    NSDate *expireDate = [dateFomatter dateFromString:expireDateStr];
    NSDate *nowDate = [dateFomatter dateFromString:nowDateStr];

    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateCom = [calendar components:unit fromDate:nowDate toDate:expireDate options:0];

    NSInteger hour = dateCom.hour;
    NSInteger minute = dateCom.minute;
    NSInteger second = dateCom.second;
    NSString *timeString = @"";
    if (hour == 0) {
        timeString = [NSString stringWithFormat:@"%02ld:%02ld", (long)minute,second];
    }else{
        timeString = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hour, minute,second];
    }
    return timeString;
}

+ (NSString *)dateTimeDifferenceWithBeginDate:(NSDate *)beginDate
{
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSString *expireDateStr = [dateFomatter stringFromDate:beginDate];
    NSString *nowDateStr = [dateFomatter stringFromDate:[NSDate date]];
    
    NSDate *expireDate = [dateFomatter dateFromString:expireDateStr];
    NSDate *nowDate = [dateFomatter dateFromString:nowDateStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateCom = [calendar components:unit fromDate:expireDate toDate:nowDate options:0];
    
    NSInteger hour = dateCom.hour;
    NSInteger minute = dateCom.minute;
    NSInteger second = dateCom.second;
    NSString *timeString = @"";
    if (hour == 0) {
        timeString = [NSString stringWithFormat:@"%02ld:%02ld", (long)minute,second];
    }else{
        timeString = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hour, minute,second];
    }
    return timeString;
}

+ (NSUInteger)getSecondsWithEndTime:(NSDate *)endDate
{
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSString *expireDateStr = [dateFomatter stringFromDate:endDate];
    NSString *nowDateStr = [dateFomatter stringFromDate:[NSDate date]];
    
    NSDate *expireDate = [dateFomatter dateFromString:expireDateStr];
    NSDate *nowDate = [dateFomatter dateFromString:nowDateStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateCom = [calendar components:unit fromDate:nowDate toDate:expireDate options:0];

    NSInteger hour = dateCom.hour;
    NSInteger minute = dateCom.minute;
    NSInteger second = dateCom.second;
    return hour * 3600 + minute *60 + second;
}
@end
