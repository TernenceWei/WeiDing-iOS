//
//  WLItemSelectionHeaderView.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/31.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLItemSelectionHeaderView.h"

@implementation WLItemSelectionHeaderView
- (instancetype)initWithFrame:(CGRect)frame itemType:(TouristItemType)type section:(NSUInteger)section
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = HEXCOLOR(0xeff1fe);
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = HEXCOLOR(0x868686);
        titleLabel.font = [UIFont WLFontOfSize:14];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.frame = CGRectMake(ScaleW(12), 0, ScreenWidth, 40);
        [self addSubview:titleLabel];
        NSString *text = @"调配信息";
        if (type == TouristItemTypeCar) {
            if (section == 0) {
                text = @"其他车辆信息";
            }else if (section == 1){
                text = @"出行信息";
                
            }else if (section == 2){
                text = @"支付信息";
            }
        }else {
            if (section == 1){
                if (type == TouristItemTypeHotel) {
                    text = @"酒店详情";
                }else if (type == TouristItemTypeMeal) {
                    text = @"用餐详情";
                }else if (type == TouristItemTypeTicket) {
                    text = @"景点详情";
                }else if (type == TouristItemTypeShopping) {
                    text = @"购物店详情";
                }else if (type == TouristItemTypeAdditional) {
                    text = @"商家详情";
                }
            }
        }
        titleLabel.text = text;

        
    }
    return self;
}
@end
