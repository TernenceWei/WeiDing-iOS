//
//  WLChargeUpHeader.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLChargeUpHeader.h"
#import "UIImageView+WebCache.h"

@interface WLChargeUpHeader ()<UIScrollViewDelegate>
@property(nonatomic, copy) void(^onSelectionAction)();
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) NSMutableArray *btnArray;
@property (nonatomic, strong) UIImageView *indicatorView;
@property (nonatomic, strong) UIScrollView *scrollView ;
@end

@implementation WLChargeUpHeader
- (instancetype)initWithFrame:(CGRect)frame selectAction:(void (^)(WLChargeUpRoleObject *))selectionAction
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.onSelectionAction = selectionAction;
    }
    return self;
}

- (NSMutableArray *)btnArray
{
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (void)setRoleArray:(NSArray *)roleArray
{
    _roleArray = roleArray;
    if (roleArray.count == 0) {
        return;
    }

    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, ScaleH(15), ScreenWidth, ScaleH(95))];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    
    NSUInteger count = roleArray.count;
    CGFloat width = ScreenWidth / count;
    if (count >= 4) {
        width = ScaleH(100);
    }
    self.scrollView.contentSize = CGSizeMake(width * count, ScaleH(95));
    for (int i = 0; i < count; i++) {
        [self setupRoleViwWithIndex:i frame:CGRectMake(width * i, 0, width, ScaleH(95)) locationView:self.scrollView];
    }
    
    UIImageView *indicatorView = [[UIImageView alloc] init];
    indicatorView.image = [UIImage imageNamed:@"allGroup_role_select_angel"];
    indicatorView.bounds = CGRectMake(0, 0, ScaleW(16), ScaleW(8));
    [self addSubview:indicatorView];
    self.indicatorView = indicatorView;
    [self updateIndicatorViewCenter];
    
}

- (void)updateIndicatorViewCenter
{
    self.indicatorView.center = CGPointMake(self.selectedBtn.center.x, self.bounds.size.height - ScaleW(4));
}

- (void)setupRoleViwWithIndex:(NSUInteger)index frame:(CGRect)frame locationView:(UIView *)locationView
{
    CGFloat width = ScaleW(60);
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.frame = CGRectMake(frame.size.width * index + (frame.size.width - width) / 2, ScaleW(5), width, width);
    iconView.layer.cornerRadius = width / 2;
    iconView.backgroundColor = [self getBgColorWithIndex:index];
    WLChargeUpRoleObject *object = self.roleArray[index];
    [iconView sd_setImageWithURL:[NSURL URLWithString:object.headImage] placeholderImage:nil];
    iconView.userInteractionEnabled = YES;
    iconView.tag = index;
    iconView.layer.cornerRadius = width / 2;
    iconView.layer.masksToBounds = YES;
    [locationView addSubview:iconView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    [iconView addGestureRecognizer:tapGesture];
    
    WLChargeUpRoleObject *info = self.roleArray[index];
    UIButton *titleBtn = [[UIButton alloc] init];
    [titleBtn setTitle:info.userName forState:UIControlStateNormal];
    [titleBtn setTitleColor:HEXCOLOR(0x2f2f2f) forState:UIControlStateNormal];
    [titleBtn setTitleColor:HEXCOLOR(0x879efb) forState:UIControlStateSelected];
    titleBtn.titleLabel.font = [UIFont WLFontOfSize:14];
    titleBtn.frame = CGRectMake(frame.size.width * index, CGRectGetMaxY(iconView.frame) + ScaleW(8), frame.size.width, ScaleW(20));
    titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [titleBtn addTarget:self action:@selector(titleBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [locationView addSubview:titleBtn];
    titleBtn.tag = index;
    if (index == 0) {
        titleBtn.selected = YES;
        self.selectedBtn = titleBtn;
    }
    [self.btnArray addObject:titleBtn];
    
    
}

- (void)titleBtnDidClicked:(UIButton *)button
{
    button.selected = YES;
    self.selectedBtn.selected = NO;
    self.selectedBtn = button;
    
    [self updateIndicatorViewCenter];
    self.onSelectionAction(self.roleArray[self.selectedBtn.tag]);
}

- (void)tapGestureAction:(UITapGestureRecognizer *)tapGesture
{
    UIView *view = tapGesture.view;
    UIButton *button = self.btnArray[view.tag];
    [self titleBtnDidClicked:button];
}

- (UIColor *)getBgColorWithIndex:(NSUInteger)index
{
    UIColor *color = HEXCOLOR(0xfe798c);
    NSUInteger temp = index % 6;
    if (temp == 1) {
        color = HEXCOLOR(0x69c95f);
    }else if (temp == 2){
        color = HEXCOLOR(0x879efa);
    }else if (temp == 3){
        color = HEXCOLOR(0xc670db);
    }else if (temp == 4){
        color = HEXCOLOR(0xff7e44);
    }else if (temp == 5){
        color = HEXCOLOR(0x4499ff);
    }
    return color;
}
@end
