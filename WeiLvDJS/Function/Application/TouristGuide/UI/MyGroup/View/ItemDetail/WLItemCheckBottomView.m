//
//  WLItemCheckBottomView.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/31.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLItemCheckBottomView.h"

@interface WLItemCheckBottomView ()
@property (nonatomic, assign) TouristItemType itemType;
@property (nonatomic, strong) WLItemDetailHotelObject *hotelObject;

@end

@implementation WLItemCheckBottomView
- (instancetype)initWithFrame:(CGRect)frame
                     itemType:(TouristItemType)itemType
                       object:(WLItemDetailHotelObject *)object
{
    self = [super initWithFrame:frame];
    if (self) {
        _itemType = itemType;
        self.hotelObject =  object;
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    if (self.hotelObject == nil) {
        return;
    }
    
    if (self.itemType == TouristItemTypeHotel || self.itemType == TouristItemTypeMeal || self.itemType == TouristItemTypeTicket) {
        
        for (int i = 0; i < 3; i++) {
            [self setupTitleLabelWithIndex:i];
        }
        
        for (int i = 0; i < self.hotelObject.scheduleList.count; i++) {
            
            WLItemDetailScheduleObject *object = self.hotelObject.scheduleList[i];
            NSArray *textArray = @[CHECKNIL(object.priceName), CHECKNIL(object.checkPrice), CHECKNIL(object.checkCount)];
            for (int j = 0; j < 3; j ++) {
                [self setupLabelWithIndex:j yIndex:i textArray:textArray];
            }
        }
        for (int i = 0; i < self.hotelObject.scheduleList.count; i++) {
            [self setupLineWithIndex:i];
        }
        
    }
}

- (void)setupTitleLabelWithIndex:(NSUInteger)index
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = HEXCOLOR(0x2f2f2f);
    label.font = [UIFont WLFontOfSize:14];
    CGFloat width = ScreenWidth / 3;
    CGFloat height = ScaleH(50);
    label.frame = CGRectMake(width * index, 0, width, height);
    label.text = [self getTitleTextArray][index];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    [self addSubview:label];
}

- (void)setupLabelWithIndex:(NSUInteger)index yIndex:(NSUInteger)yIndex textArray:(NSArray *)textArray
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = HEXCOLOR(0x6f7378);
    label.font = [UIFont WLFontOfSize:14];
    CGFloat width = ScreenWidth / 3;
    CGFloat height = ScaleH(50);
    if (index == 0) {
        label.textColor = HEXCOLOR(0x2f2f2f);
    }else{
        label.textColor = HEXCOLOR(0x868686);
    }
    label.text = textArray[index];
    label.frame = CGRectMake(width * index, height * (yIndex+ 1), width, height);
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    [self addSubview:label];
}


- (void)setupLineWithIndex:(NSUInteger)index
{
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = HEXCOLOR(0xd8d9dd);
    line.frame = CGRectMake(ScaleW(12), ScaleH(50) * (index+1), ScreenWidth, 1);
    [self addSubview:line];
}

- (NSArray *)getTitleTextArray
{
    NSArray *titleArray = nil;
    if (self.itemType == TouristItemTypeHotel) {
        titleArray = @[@"房型",@"调配单价\n（元/间）",@"调配数量\n（间）"];
    }else if (self.itemType == TouristItemTypeMeal) {
        titleArray = @[@"团餐类型",@"调配单价\n（元/桌）",@"调配数量\n（桌）"];
    }else if (self.itemType == TouristItemTypeTicket) {
        titleArray = @[@"门票类别",@"调配单价\n（元/张）",@"调配数量\n（人）"];
    }
    return titleArray;
    
}

@end
