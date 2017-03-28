//
//  WLCurrentGroupHeader.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/14.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLCurrentGroupHeader.h"

@interface WLCurrentGroupHeader ()
@property (nonatomic, copy) void (^onFoldAction)(BOOL isFold);
@property (nonatomic, assign) BOOL isFold;
@property (nonatomic, strong) UIButton *foldBtn;
@property (nonatomic, strong) UIView *line;
@end

@implementation WLCurrentGroupHeader
- (instancetype)initWithType:(TouristItemType)type
                  foldAction:(void (^)(BOOL))action
                    selected:(BOOL)selected
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        UIButton *titleBtn = [[UIButton alloc] init];
        [titleBtn setTitle:[self getTitleWithType:type] forState:UIControlStateNormal];
        [titleBtn setTitleColor:HEXCOLOR(0x2f2f2f) forState:UIControlStateNormal];
        [titleBtn setImage:[UIImage imageNamed:[self getImageNameWithType:type]] forState:UIControlStateNormal];
        titleBtn.frame = CGRectMake(ScaleW(10), 0, ScreenWidth / 2, ScaleH(45));
        titleBtn.titleLabel.font = WLFontSize(15);
        titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, ScaleW(5), 0, 0);
        titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self addSubview:titleBtn];
        
        UIButton *foldBtn = [[UIButton alloc] init];
        [foldBtn setImage:[UIImage imageNamed:@"group_angel_up"] forState:UIControlStateNormal];
        [foldBtn setImage:[UIImage imageNamed:@"group_angel_down"] forState:UIControlStateSelected];
        foldBtn.frame = CGRectMake(ScreenWidth - ScaleW(45), 0, ScaleW(50), ScaleH(45));
        [foldBtn addTarget:self action:@selector(foldThelist) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:foldBtn];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = HEXCOLOR(0xd8d9dd);
        line.frame = CGRectMake(ScaleW(10), ScaleH(45) - 1, ScreenWidth - ScaleW(10), 1);
        [self addSubview:line];
        self.line = line;
        
        self.onFoldAction = action;
        self.foldBtn = foldBtn;
        self.foldBtn.selected = selected;
        self.line.hidden = selected;
        
    }
    return self;
}

- (void)foldThelist
{
    self.foldBtn.selected = !self.foldBtn.selected;
    self.line.hidden = self.foldBtn.selected;
    self.onFoldAction(self.foldBtn.selected);
}

- (NSString *)getTitleWithType:(TouristItemType)type
{
    NSString *text = @"酒店住宿";
    if (type == TouristItemTypeMeal) {
        text = @"用餐";
    }else if (type == TouristItemTypeTicket) {
        text = @"门票";
    }else if (type == TouristItemTypeCar) {
        text = @"用车";
    }else if (type == TouristItemTypeShopping) {
        text = @"购物店";
    }else if (type == TouristItemTypeAdditional) {
        text = @"加点项目";
    }
    return text;
}

- (NSString *)getImageNameWithType:(TouristItemType)type
{
    NSString *text = @"group_hotel";
    if (type == TouristItemTypeMeal) {
        text = @"group_meal";
    }else if (type == TouristItemTypeTicket) {
        text = @"group_ticket";
    }else if (type == TouristItemTypeCar) {
        text = @"group_car";
    }else if (type == TouristItemTypeShopping) {
        text = @"group_shop";
    }else if (type == TouristItemTypeAdditional) {
        text = @"group_add";
    }
    return text;
}
@end
