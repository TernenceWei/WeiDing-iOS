//
//  WLCarBookingDetailOrderCell.m
//  WeiLvDJS
//
//  Created by ternence on 2017/1/20.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLCarBookingDetailOrderCell.h"
#define cellIdentifier @"WLCarBookingDetailOrderCell"

@interface WLCarBookingDetailOrderCell ()

@property (nonatomic, strong) NSMutableArray *itemArray;
@property (nonatomic, strong) void(^onFoldAction)(BOOL isFold);
@property (nonatomic, assign) BOOL isFold;
@property (nonatomic, strong) UIButton *arrowBtn;

@property (nonatomic, copy)  void(^lookImgBtnAction)();

@end

@implementation WLCarBookingDetailOrderCell
- (NSMutableArray *)itemArray
{
    if (!_itemArray) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

+ (WLCarBookingDetailOrderCell *)cellWithTableView:(UITableView*)tableView
                                            isFold:(BOOL)isFold
                                        foldAction:(void(^)(BOOL isFold))foldAction
{
    WLCarBookingDetailOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLCarBookingDetailOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.isFold = isFold;
    cell.onFoldAction = foldAction;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.exclusiveTouch = YES;
        self.multipleTouchEnabled = NO;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setObject:(WLCarBookingOrderDetailObject *)object
{
    _object = object;
    if (object == nil) {
        return;
    }
    if (([object.memo isEqualToString:@""] || object.memo == nil) && object.trip_image.count != 0) {
        _object.memo = @"查看行程详情";
    }
    [self setupUI];
}

- (void)setupUI{
    
    for (UIView *subview in self.contentView.subviews) {
        [subview removeFromSuperview];
    }
    
    CGFloat xMargin = ScaleW(12);
    
    NSString *startString = [WLUITool timeStringWithTimeInterval:self.object.start_at.integerValue formatter:@"MM月dd日 HH:mm"];
    NSString *endString = [WLUITool timeStringWithTimeInterval:self.object.end_at.integerValue formatter:@"MM月dd日"];
    NSString *timeString = [NSString stringWithFormat:@"%@ - %@",startString, endString];
    
    NSString *carString = @"大巴车";
    if (self.object.car_model.integerValue == 2) {
        carString = @"商务车";
    }else if (self.object.car_model.integerValue == 4){
        carString = @"小轿车";
    }
    NSString *seatString = [NSString stringWithFormat:@"%@,需%@座",carString,self.object.car_seat_amount];
    
    NSArray *timeArray = @[timeString, seatString];
    CGFloat timeX = xMargin;
    CGFloat timeW = ScreenWidth - ScaleW(24);
    
    for (int i = 0; i <2; i++) {
        
        UILabel *label = [UILabel labelWithText:timeArray[i] textColor:Color2 fontSize:15];
        label.textAlignment = (i==0? NSTextAlignmentLeft:NSTextAlignmentRight);
        label.frame = CGRectMake(timeX, 0, timeW, ScaleH(45));
        [self.contentView addSubview:label];
    }
    
    NSMutableArray *addressArray = [NSMutableArray arrayWithObject:self.object.start_address];
    NSArray *visArray = [NSArray array];
    NSUInteger visaCount = 0;
    
    if (![self.object.via_address isEqualToString:@""]) {
        visArray = [self.object.via_address componentsSeparatedByString:@","];
        
        if (visArray.count > 2) {
            visaCount = self.isFold ? 2: visArray.count;
        }else{
            visaCount = visArray.count;
        }
        for (int i = 0; i < visaCount; i++) {
            [addressArray addObject:visArray[i]];
        }
    }

    [addressArray addObject:self.object.end_address];
    
    CGFloat addressX = ScaleW(20);
    CGFloat addressW = ScreenWidth - ScaleW(32);
    CGFloat addressY = ScaleH(45) + ScaleH(10);
    NSUInteger addressCount = 2 + visaCount;
    
    for (int i = 0; i < addressCount; i++) {
        
        UILabel *label = [UILabel labelWithText:addressArray[i] textColor:Color2 fontSize:15];
        label.textAlignment = NSTextAlignmentLeft;
        if (i != 0) {
            UILabel *itemLabel = self.itemArray[i - 1];
            addressY = itemLabel.bottom + ScaleH(10);
        }
        CGFloat addressH = [WLUITool sizeWithString:label.text font:label.font constrainedToSize:CGSizeMake(addressW, MAXFLOAT)].height;
        label.frame = CGRectMake(addressX + ScaleW(15), addressY, addressW, addressH);
        
        UIImageView * dianImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        if (i == 0) {
            dianImg.frame = CGRectMake(addressX - ScaleW(5), label.frame.origin.y + ScaleH(4), ScaleW(10), ScaleH(10));
            [dianImg setImage:[UIImage imageNamed:@"startPlace"]];
        }
        else if (i == (addressCount - 1))
        {
            dianImg.frame = CGRectMake(addressX - ScaleW(5), label.frame.origin.y + ScaleH(4), ScaleW(10), ScaleH(10));
            [dianImg setImage:[UIImage imageNamed:@"endOfPlace"]];
        }
        else
        {
            dianImg.frame = CGRectMake(addressX - ScaleW(5), label.frame.origin.y + ScaleH(6), ScaleW(7), ScaleH(7));
            [dianImg setImage:[UIImage imageNamed:@"afterPlace"]];
        }
        
        [self.contentView addSubview:dianImg];
        [self.contentView addSubview:label];
        [self.itemArray addObject:label];
    }
    
    if (visArray.count > 2) {
        UILabel *secondLabel = self.itemArray[2];
        
        UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        moreBtn.frame = CGRectMake(ScreenWidth - ScaleW(120), secondLabel.bottom - ScaleH(30), ScaleW(90), ScaleH(30));
        [moreBtn setTitle:@"更多途径城市" forState:UIControlStateNormal];
        [moreBtn setTitleColor:Color1 forState:UIControlStateNormal];
        moreBtn.titleLabel.font = [UIFont WLFontOfSize:12];
        moreBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [moreBtn addTarget:self action:@selector(foldBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:moreBtn];
        
        UIButton *arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        arrowBtn.frame = CGRectMake(moreBtn.right + 4, secondLabel.bottom - 21, 14, 12);
        [arrowBtn setImage:[UIImage imageNamed:@"group_angel_down"] forState:UIControlStateNormal];
        [arrowBtn setImage:[UIImage imageNamed:@"group_angel_up"] forState:UIControlStateSelected];
        [arrowBtn addTarget:self action:@selector(foldBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:arrowBtn];
        self.arrowBtn = arrowBtn;
        self.arrowBtn.selected = !self.isFold;
        
    }
    
    UILabel *lastLabel = [self.itemArray lastObject];
    if (![self.object.memo isEqualToString:@""] && self.object.memo != nil) {

        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(12), lastLabel.bottom + ScaleH(22), ScaleW(18), ScaleH(20))];
        iconView.image = [UIImage imageNamed:@"carBooking_detail_remark"];
        [self.contentView addSubview:iconView];
        
        CGFloat remarkHeight = [WLUITool sizeWithString:self.object.memo font:[UIFont WLFontOfSize:14] constrainedToSize:CGSizeMake(ScreenWidth - ScaleW(60), MAXFLOAT)].height;
        
        UIButton *remarkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        remarkBtn.frame = CGRectMake(iconView.right + ScaleW(5), lastLabel.bottom + ScaleH(22), ScreenWidth - ScaleW(45), remarkHeight);
        [remarkBtn setTitle:self.object.memo forState:UIControlStateNormal];
        [remarkBtn setTitleColor:Color2 forState:UIControlStateNormal];
        remarkBtn.titleLabel.font = [UIFont WLFontOfSize:14];
        remarkBtn.titleLabel.numberOfLines = 0;
        remarkBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [remarkBtn addTarget:self action:@selector(lookImgBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:remarkBtn];
        
        UIImageView * arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - ScaleW(20), remarkBtn.frame.origin.y + (remarkBtn.frame.size.height / 2) - ScaleH(10), ScaleW(10), ScaleH(20))];
        [arrowImg setImage:[UIImage imageNamed:@"arrow"]];
        [self.contentView addSubview:arrowImg];
        
        if (!_iSChooseVC) {
            UILabel * iconView2Line = [[UILabel alloc] initWithFrame:CGRectMake(0, remarkBtn.bottom + ScaleH(11), ScreenWidth, ScaleH(1))];
            iconView2Line.backgroundColor = bordColor;
            [self.contentView addSubview:iconView2Line];
            
            UIImageView *iconView2 = [[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(12), remarkBtn.bottom + ScaleH(22), ScaleW(18), ScaleW(20))];
            iconView2.image = [UIImage imageNamed:@"yongcherImg"];
            [self.contentView addSubview:iconView2];
            
            UILabel * userManlabel = [UILabel labelWithText:[NSString stringWithFormat:@"用车人 %@ %@",self.object.use_car_contacts, self.object.use_car_mobile] textColor:Color2 fontSize:14.0];
            userManlabel.frame = CGRectMake(iconView.right + ScaleW(5), remarkBtn.bottom + ScaleH(22), ScreenWidth - ScaleW(45), ScaleH(20));
            [self.contentView addSubview:userManlabel];
            
            UIButton * noLookBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - ScaleW(95), userManlabel.frame.origin.y, ScaleW(85), ScaleH(20))];
            [noLookBtn setTitle:@"对方暂不可见" forState:UIControlStateNormal];
            noLookBtn.titleLabel.font = [UIFont WLFontOfSize:11.0];
            [noLookBtn setTitleColor:bordColor forState:UIControlStateNormal];
            noLookBtn.layer.borderColor = bordColor.CGColor;
            noLookBtn.layer.borderWidth = 1;
            [self.contentView addSubview:noLookBtn];
            
            // 比较是否相等
            NSString *startTimeString = [WLUITool timeStringWithTimeInterval:self.object.start_at.integerValue formatter:@"dd"];
            
            NSDate *nowDate = [NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDateComponents *dateComps = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:nowDate];
            
            if ([startTimeString integerValue] <= [dateComps day]) {
                NSString * startTimeMonString = [WLUITool timeStringWithTimeInterval:self.object.start_at.integerValue formatter:@"MM"];
                if ([startTimeMonString integerValue] <= [dateComps month]) {
                    noLookBtn.hidden = YES;
                }
                else
                {
                    noLookBtn.hidden = NO;
                }
            }
            else
            {
                noLookBtn.hidden = NO;
            }
        }
    }
    else
    {
        if (!_iSChooseVC) {
            UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(12), lastLabel.bottom + ScaleH(22), ScaleW(18), ScaleW(20))];
            iconView.image = [UIImage imageNamed:@"yongcherImg"];
            [self.contentView addSubview:iconView];
            
            UILabel * userManlabel = [UILabel labelWithText:[NSString stringWithFormat:@"用车人 %@ %@",self.object.use_car_contacts, self.object.use_car_mobile] textColor:Color2 fontSize:14.0];
            userManlabel.frame = CGRectMake(iconView.right + ScaleW(5), lastLabel.bottom + ScaleH(22), ScreenWidth - ScaleW(45), ScaleH(20));
            [self.contentView addSubview:userManlabel];
            
            UIButton * noLookBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - ScaleW(95), userManlabel.frame.origin.y, ScaleW(85), ScaleH(20))];
            [noLookBtn setTitle:@"对方暂不可见" forState:UIControlStateNormal];
            noLookBtn.titleLabel.font = [UIFont WLFontOfSize:11.0];
            [noLookBtn setTitleColor:bordColor forState:UIControlStateNormal];
            noLookBtn.layer.borderColor = bordColor.CGColor;
            noLookBtn.layer.borderWidth = 1;
            [self.contentView addSubview:noLookBtn];
            
            if (_object.trip_status == 0) {
                noLookBtn.hidden = NO;
            }
            else
            {
                noLookBtn.hidden = YES;
            }
        }
        
    }
    
    for (int i = 0; i < 2; i++) {
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = bordColor;
        line.frame = CGRectMake(0, i==0?ScaleH(45):lastLabel.bottom + ScaleH(10), ScreenWidth, 1);
        [self.contentView addSubview:line];
    }
}

- (void)lookImgBtnClick
{
    _lookImgBtnAction();
}

- (void)lookImgClickAction:(void (^)())action
{
    _lookImgBtnAction = action;
}

- (void)foldBtnClick
{
    self.isFold = !self.isFold;
    self.arrowBtn.selected = !self.arrowBtn.selected;
    self.onFoldAction(self.isFold);
}


@end
