//
//  WLItemCheckCell.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/31.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLItemCheckCell.h"
#import "WLItemCheckTopView.h"
#import "WLItemCheckBottomView.h"

#define cellIdentifier @"WLItemCheckCell"

@interface WLItemCheckCell ()
@property (nonatomic, assign) TouristItemType itemType;
@property (nonatomic, strong) WLItemDetailHotelObject *hotelObject;

@property (nonatomic, strong) WLItemCheckTopView *topView;
@property (nonatomic, strong) UIView *marginView;
@property (nonatomic, strong) WLItemCheckBottomView *bottomView;
@end

@implementation WLItemCheckCell

+ (WLItemCheckCell *)cellWithTableView:(UITableView*)tableView
                              itemType:(TouristItemType)itemType
                                object:(WLItemDetailHotelObject *)object{
    
    WLItemCheckCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLItemCheckCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.itemType = itemType;
    cell.hotelObject = object;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setupUI];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.exclusiveTouch = YES;
        self.multipleTouchEnabled = NO;
    }
    return self;
}

- (void)setupUI{
    
    if (self.hotelObject == nil) {
        return;
    }
    
    if (self.itemType == TouristItemTypeHotel || self.itemType == TouristItemTypeMeal || self.itemType == TouristItemTypeTicket) {
        
        CGFloat  bottomHeight = ScaleH(50) * (self.hotelObject.scheduleList.count + 1);
        
        self.topView = [[WLItemCheckTopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(135)) itemType:self.itemType object:self.hotelObject];
        [self addSubview:self.topView];
        
        self.marginView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), ScreenWidth, ScaleH(10))];
        self.marginView.backgroundColor = HEXCOLOR(0xeff1fe);
        [self addSubview:self.marginView];
        
        
        self.bottomView = [[WLItemCheckBottomView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.marginView.frame), ScreenWidth, bottomHeight) itemType:self.itemType object:self.hotelObject];
        [self addSubview:self.bottomView];
        
        
    }else{//加点和购物店

        self.topView = [[WLItemCheckTopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(90)) itemType:self.itemType object:self.hotelObject];
        [self addSubview:self.topView];
        
    }

}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [self.topView removeFromSuperview];
    [self.bottomView removeFromSuperview];
    [self.marginView removeFromSuperview];
}
@end
