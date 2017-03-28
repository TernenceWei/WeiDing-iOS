//
//  WLChargeUpFooter.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLChargeUpFooter.h"

@interface WLChargeUpFooter ()
@property (nonatomic, assign) TouristItemType type;
@end

@implementation WLChargeUpFooter
- (instancetype)initWithFrame:(CGRect)frame itemType:(TouristItemType)itemType{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.type = itemType;
        
    }
    return self;
}

- (void)setName:(NSString *)name time:(NSString *)time
{
    NSArray *textArray;
    if (self.type == TouristItemTypeCar || self.type == TouristItemTypeHotel || self.type == TouristItemTypeMeal || self.type == TouristItemTypeTicket) {
        NSString *nameText = name;
        if (![nameText isEqualToString:@""] && nameText != nil) {
            nameText = [@"记账人:" stringByAppendingString:nameText];
        }
        textArray = @[nameText,time];
    }else{
        textArray = @[CHECKNIL(time),@"重要提示：有返现的项目，导游记录自己所带游客的消费信息。\n但必须将所有收款交由主导游进行统一管理。"];
    }
    for (int i = 0; i <2; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = HEXCOLOR(0x2f2f2f);
        label.font = [UIFont WLFontOfSize:14];
        label.textAlignment = NSTextAlignmentRight;
        
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat width = ScreenWidth - ScaleW(12);
        CGFloat height = ScaleH(30);
        
        if (self.type == TouristItemTypeCar || self.type == TouristItemTypeHotel || self.type == TouristItemTypeMeal || self.type == TouristItemTypeTicket) {
            if (i == 1) {
                y = ScaleH(30);
            }
        }else{
            if (i == 1) {
                x = ScaleW(12);
                y = ScaleH(30);
                width = ScreenWidth - ScaleW(24);
                height = ScaleH(80);
                label.textAlignment = NSTextAlignmentLeft;
                label.numberOfLines = 0;
                
            }
        }
        
        label.frame = CGRectMake(x, y, width, height);
        label.text = textArray[i];
        [self addSubview:label];
    }
}

@end
