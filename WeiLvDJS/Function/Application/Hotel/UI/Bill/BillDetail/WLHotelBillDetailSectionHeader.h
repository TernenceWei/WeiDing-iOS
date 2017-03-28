//
//  WLHotelBillDetailSectionHeader.h
//  WeiLvDJS
//
//  Created by ternence on 16/11/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLHotelBillDetailInfo.h"

@interface WLHotelBillDetailSectionHeader : UIView
- (instancetype)initWithFrame:(CGRect)frame
                isPriceHeader:(BOOL)isPriceHeader
                   detailInfo:(WLHotelBillDetailInfo *)detailInfo;
@end
