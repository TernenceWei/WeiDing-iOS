//
//  WLItemTableHeaderView.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/31.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLItemTableHeaderView.h"
#import "WLItemDetailCarObject.h"
#import "WLItemDetailHotelObject.h"

@interface WLItemTableHeaderView ()
@property (nonatomic, assign) TouristItemType type;
@property (nonatomic, strong) UIImageView *bgView ;
@end

@implementation WLItemTableHeaderView
- (instancetype)initWithFrame:(CGRect)frame type:(TouristItemType)type{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
    }
    return self;
}

- (void)setObject:(id)object
{
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(12), ScaleH(15), ScreenWidth - ScaleW(24), self.bounds.size.height - ScaleH(15))];
    bgView.image = [UIImage imageNamed:[self getBgImageNameWithType:self.type]];
    [self addSubview:bgView];
    self.bgView = bgView;
    
    if (self.type == TouristItemTypeCar) {
        WLItemDetailCarObject *carObject = (WLItemDetailCarObject *)object;
        NSArray *textArray = @[CHECKNIL(carObject.companyName),[NSString stringWithFormat:@"车型：%@",CHECKNIL(carObject.carAmount)],[NSString stringWithFormat:@"车牌号：%@",CHECKNIL(carObject.carNO)],[NSString stringWithFormat:@"司机：%@",CHECKNIL(carObject.driverName)],[NSString stringWithFormat:@"联系方式：%@",CHECKNIL(carObject.mobile)]];
        for (int i = 0; i < 5; i++) {
            [self setupCarLabelWithIndex:i text:textArray[i]];
        }
    }else{
        WLItemDetailHotelObject *hotelObject = (WLItemDetailHotelObject *)object;
        NSArray *textArray = @[CHECKNIL(hotelObject.companyName),[NSString stringWithFormat:@"地址：%@",CHECKNIL(hotelObject.address)],[NSString stringWithFormat:@"联系人：%@",CHECKNIL(hotelObject.contactName)],[NSString stringWithFormat:@"联系方式：%@",CHECKNIL(hotelObject.contactMobile)]];
        for (int i = 0; i < 4; i++) {
            [self setupHotelLabelWithIndex:i text:textArray[i]];
        }
    }
}

- (NSString *)getBgImageNameWithType:(TouristItemType)type
{
    NSString *imageName = @"groupDetail_top_car";
    if (type == TouristItemTypeHotel) {
        imageName = @"groupDetail_top_hotel";
    }else if (type == TouristItemTypeMeal) {
        imageName = @"groupDetail_top_meal";
    }else if (type == TouristItemTypeTicket) {
        imageName = @"groupDetail_top_ticket";
    }else if (type == TouristItemTypeShopping) {
        imageName = @"groupDetail_top_shop";
    }else if (type == TouristItemTypeAdditional) {
        imageName = @"groupDetail_top_additional";
    }
    return imageName;
}

- (void)setupCarLabelWithIndex:(NSUInteger)index text:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentLeft;
    
    CGFloat x = ScaleW(12);
    CGFloat y = ScaleH(8);
    CGFloat width = self.bgView.bounds.size.width / 2;
    CGFloat height = ScaleH(30);
    if (index == 0) {
        label.font = [UIFont WLFontOfSize:14];
        width = self.bgView.bounds.size.width;
        
    }else {
        
        label.font = [UIFont WLFontOfSize:12];
        if (index % 2 == 0) {
            x = width;
        }
        if (index <= 2) {
            y = ScaleH(40);
        }
        if (index > 2) {
            y = ScaleH(65);
        }
        
    }
    label.frame = CGRectMake(x, y, width, height);
    label.text = text;
    [self.bgView addSubview:label];
}

- (void)setupHotelLabelWithIndex:(NSUInteger)index text:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentLeft;
    
    CGFloat x = ScaleW(12);
    CGFloat y = ScaleH(8);
    CGFloat width = self.bgView.bounds.size.width / 2;
    CGFloat height = ScaleH(30);
    if (index == 0) {
        label.font = [UIFont WLFontOfSize:14];
        width = self.bgView.bounds.size.width;
    }else {
        label.font = [UIFont WLFontOfSize:12];
        if (index == 1) {
            
            width = self.bgView.bounds.size.width;
            y = ScaleH(40);
            
        }else{
            y = ScaleH(65);
        }
        if (index == 3) {
            x = width;
        }
        
    }
    label.frame = CGRectMake(x, y, width, height);
    label.text = text;
    [self.bgView addSubview:label];
}

@end
