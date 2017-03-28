//
//  WLItemCheckTopView.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/31.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLItemCheckTopView.h"

@interface WLItemCheckTopView ()
@property (nonatomic, assign) TouristItemType itemType;
@property (nonatomic, strong) WLItemDetailHotelObject *hotelObject;
@end

@implementation WLItemCheckTopView
- (instancetype)initWithFrame:(CGRect)frame
                     itemType:(TouristItemType)itemType
                       object:(WLItemDetailHotelObject *)object
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _itemType = itemType;
        self.hotelObject = object;
        [self setupUI];
        
    }
    return self;
}

- (NSArray *)getTextArray
{
    NSArray *textArray;
    NSString *modeText = @"挂账";
    if (self.hotelObject.settlementMode == PaymentModeCash) {
        modeText = @"现金";
    }
    if (self.itemType == TouristItemTypeHotel) {
        
        textArray = @[@"入住人数",CHECKNIL(self.hotelObject.actualPerson),@"入住时间" ,CHECKNIL([self getTimeTextWithTimeString:self.hotelObject.whichDate]), @"支付方式",modeText];
        
    }else if (self.itemType == TouristItemTypeMeal){
        
       textArray = @[@"用餐人数",CHECKNIL(self.hotelObject.actualPerson),@"消费时间" ,CHECKNIL([self getTimeTextWithTimeString:self.hotelObject.whichDate]), @"支付方式",modeText];
        
    }else if (self.itemType == TouristItemTypeTicket){
        
        textArray = @[@"消费人数",CHECKNIL(self.hotelObject.actualPerson),@"消费时间" ,CHECKNIL([self getTimeTextWithTimeString:self.hotelObject.whichDate]), @"支付方式",modeText];
        
    }else if (self.itemType == TouristItemTypeShopping){
        
        textArray = @[@"消费时间" ,CHECKNIL([self getTimeTextWithTimeString:self.hotelObject.whichDate]), @"返点",CHECKNIL(self.hotelObject.rate)];
        
    }else if (self.itemType == TouristItemTypeAdditional){
        
        textArray = @[@"消费时间" ,CHECKNIL([self getTimeTextWithTimeString:self.hotelObject.whichDate]), @"返点",CHECKNIL(self.hotelObject.rate)];
        
    }
    return textArray;
}

- (void)setupUI
{
    if (self.hotelObject == nil) {
        return;
    }
    
    NSArray *textArray = [self getTextArray];
    for (int i = 0; i < textArray.count; i++) {
        if (i != 1) {
            [self setupHotelLabelWithIndex:i text:textArray[i]];
        }
    }
    
    for (int i = 0; i < textArray.count / 2; i++) {
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = HEXCOLOR(0xd8d9dd);
        line.frame = CGRectMake(ScaleW(12), ScaleH(45) * (i + 1), ScreenWidth, 1);
        [self addSubview:line];
        
    }
    
}


- (void)setupHotelLabelWithIndex:(NSUInteger)index text:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = HEXCOLOR(0x6f7378);
    label.font = [UIFont WLFontOfSize:14];
    CGFloat x = ScaleW(12);
    CGFloat width = ScreenWidth / 2;
    CGFloat height = ScaleH(45);
    if (index % 2 == 0) {
        label.textColor = HEXCOLOR(0x2f2f2f);
        label.textAlignment = NSTextAlignmentLeft;
        
    }else {
        label.textColor = HEXCOLOR(0x868686);
        label.textAlignment = NSTextAlignmentRight;
        x = ScreenWidth - ScaleW(12) - width;
    }
    
    label.frame = CGRectMake(x, height * (index / 2), width, height);
    label.text = text;
    [self addSubview:label];
}

- (NSString *)getTimeTextWithTimeString:(NSString *)timeString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:timeString];
    
    
    NSDateComponents *dateComps = [[NSCalendar currentCalendar] components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:date];
    NSInteger year = [dateComps year];
    NSInteger month = [dateComps month];
    NSInteger day = [dateComps day];
    return [NSString stringWithFormat:@"%ld年%ld月%ld日",year, month,day];
    
}

@end
