//
//  WLHotelBillDetailSectionFooter.m
//  WeiLvDJS
//
//  Created by ternence on 16/11/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLHotelBillDetailSectionFooter.h"

@interface WLHotelBillDetailSectionFooter ()
@property (nonatomic, assign) BOOL isPriceHeader;
@end

@implementation WLHotelBillDetailSectionFooter

- (instancetype)initWithFrame:(CGRect)frame
                isPriceHeader:(BOOL)isPriceHeader
                         text:(NSString *)text
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isPriceHeader = isPriceHeader;
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
        lineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
        [self addSubview:lineView];
        
        if (self.isPriceHeader) {
            
            self.backgroundColor = [WLTools stringToColor:@"#f7f7f8"];
            
        }else{
            self.backgroundColor = [UIColor whiteColor];
            UILabel *detailLabel = [[UILabel alloc] init];
            detailLabel.textColor = [WLTools stringToColor:@"#b5b5b5"];
            detailLabel.textAlignment = NSTextAlignmentRight;
            detailLabel.font = [UIFont WLFontOfSize:16];
            detailLabel.frame = CGRectMake(0 , 0 , ScreenWidth - ScaleW(12), ScaleH(40));
            detailLabel.text = [NSString stringWithFormat:@"合计 ¥%@",text];
            [self addSubview:detailLabel];
        }
    }
    return self;
}


@end
