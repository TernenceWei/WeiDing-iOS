//
//  WLCarBookingHeaderView.m
//  WeiLvDJS
//
//  Created by ternence on 2017/1/19.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLCarBookingHeaderView.h"

@interface WLCarBookingHeaderView ()

@property (nonatomic, strong) WLCarBookingItemView *selectedView;
@property (nonatomic, strong) NSMutableArray *itemArray;

@end

@implementation WLCarBookingHeaderView

- (NSMutableArray *)itemArray
{
    if (!_itemArray) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

- (instancetype)initWithFrame:(CGRect)frame
                 selectAction:(void (^)(NSUInteger))selectAction
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat width = ScreenWidth / 2;
        NSArray *imageArray = @[@"bus",@"buscar"];
        NSArray *titleArray = @[@"大巴车",@"商务车"];

        WS(weakSelf);
        for (int i = 0; i < 2; i++) {
            WLCarBookingItemView *itemView = [[WLCarBookingItemView alloc] initWithFrame:CGRectMake(width * i, 0, width, self.height)
                                                                               imageName:imageArray[i]
                                                                                   title:titleArray[i]
                                                                            selectAction:^(NSUInteger index, WLCarBookingItemView *view) {
                                                                                if ([view isEqual:weakSelf.selectedView]) {
                                                                                    return ;
                                                                                }
                                                                                weakSelf.selectedView.selected = NO;
                                                                                weakSelf.selectedView = view;
                                                                                selectAction(index);
                                                                            }];
            itemView.tag = i;
            [self.itemArray addObject:itemView];
            [self addSubview:itemView];
            if (i == 0) {
                itemView.selected = YES;
                self.selectedView = itemView;
            }
        }
        
//        for (int i = 0; i < 2; i++) {
//            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth / 3 * (i + 1), 0, 1, self.height)];
//            line.backgroundColor = bordColor;
//            [self addSubview:line];
//        }
        
    }
    return self;
}

- (void)selectItem:(NSUInteger)index
{
    WLCarBookingItemView *itemView = self.itemArray[index];
    self.selectedView.selected = NO;
    itemView.selected = YES;
    self.selectedView = itemView;
}

@end







@interface WLCarBookingItemView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, copy) void(^onSelectAction)(NSUInteger index, WLCarBookingItemView *view);


@end


@implementation WLCarBookingItemView

- (instancetype)initWithFrame:(CGRect)frame
                    imageName:(NSString *)imageName
                        title:(NSString *)title
                 selectAction:(void (^)(NSUInteger, WLCarBookingItemView *))selectAction
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        CGFloat iconW = ScaleW(56);
        CGFloat iconH = ScaleW(24);
        
        self.onSelectAction = selectAction;
        
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.frame = CGRectMake((self.width - iconW) / 2, ScaleH(30), iconW, iconH);
        iconView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",imageName]];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        self.imageName = imageName;
        
        UIColor *textColor = Color2;
        UILabel *titleLabel = [UILabel labelWithText:title textColor:textColor fontSize:14];
        titleLabel.frame = CGRectMake(0, iconView.bottom + 10, self.width, ScaleH(20));
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:gesture];
        
        
    }
    return self;
}

- (void)tapAction
{
    self.selected = YES;
    self.onSelectAction(self.tag,self);
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    UIColor *textColor = selected ? Color1: Color2;
    self.titleLabel.textColor = textColor;
    NSString *temp = selected ? @"_selected":@"_normal";
    self.iconView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",self.imageName,temp]];
}

@end
