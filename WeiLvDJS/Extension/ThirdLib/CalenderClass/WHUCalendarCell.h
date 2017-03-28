//
//  WHUCalendarCell.h
//  TEST_Calendar
//
//  Created by SuperNova(QQ:422596694) on 15/11/5.
//  Copyright (c) 2015年 SuperNova(QQ:422596694). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHUCalendarItem.h"
@interface WHUCalendarCell : UICollectionViewCell
@property(nonatomic,strong) UILabel* lbl;
@property(nonatomic,strong) UILabel* dbl;

@property(nonatomic,strong)UIImageView *selectImage;
@property(nonatomic,assign)BOOL beforeToday;
@property(nonatomic,assign) BOOL isToday;
@property(nonatomic,assign) BOOL isDayInCurMonth;
@property(nonatomic,assign) NSInteger rowIndex;
@property(nonatomic,assign) NSInteger total;
@property(nonatomic,assign)BOOL seleED;
@property(nonatomic,strong)UIView* view;

@property(nonatomic,assign)BOOL isLeave;

@property(nonatomic,strong)UIImageView *origin;

@property(nonatomic,strong)WHUCalendarItem *item;

@property(nonatomic,assign)BOOL click;

@property(nonatomic,copy)void (^cellSelceted)(BOOL select);
@end
