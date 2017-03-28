//
//  WL_AddressBook_Search_View.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/9.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_Search_View.h"

@interface WL_AddressBook_Search_View ()

@property (nonatomic, copy) void(^onClickAction)();

@end

@implementation WL_AddressBook_Search_View

- (instancetype)initWithSearchPlaceholder:(NSString *)placeholder
                          backgroundColor:(UIColor *)color
                                    frame:(CGRect)frame
                              clickAction:(void (^)())clickAction
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = color;
        self.onClickAction = clickAction;
        //设置子控件
        [self setupContentViewToSearchView:placeholder withBackgroundColor:color];
    }
    return self;
}


#pragma mark - 设置子控件
- (void)setupContentViewToSearchView:(NSString *)placeholder withBackgroundColor:(UIColor *)color
{
    //头部搜索框SearchView
    UIView *searchView = [[UIView alloc] init];
    searchView.layer.cornerRadius = 5.0;
    searchView.layer.masksToBounds = YES;
    searchView.layer.borderColor = [WLTools stringToColor:@"#eeeff3"].CGColor;
    searchView.layer.borderWidth = 0.5f;
    searchView.backgroundColor = color;
    [self addSubview:searchView];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(13);
        make.right.equalTo(self.mas_right).offset(-13);
        make.top.equalTo(self.mas_top).offset(9);
        make.height.equalTo(@29);
    }];
    //搜索框内的文字和图片
    UIButton *searchButton = [[UIButton alloc] init];
    [searchButton setTitle:placeholder forState:UIControlStateNormal];
    [searchButton setTitleColor:[WLTools stringToColor:@"#b0b7c1"] forState:UIControlStateNormal];
    [searchButton.titleLabel setFont:WLFontSize(14)];
    [searchButton setImage:[UIImage imageNamed:@"AddressBook_search"] forState:UIControlStateNormal];
    [self addSubview:searchButton];
    [searchButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 3.5, 0, 0)];
    [searchButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 3.5)];
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(searchView.mas_centerX);
        make.centerY.equalTo(searchView.mas_centerY);
        make.height.equalTo(searchView.mas_height).offset(-2);
        make.width.equalTo(searchView.mas_width).offset(-5);
    }];
    self.searchButton = searchButton;
//    searchButton.backgroundColor = Color3;
    [searchButton addTarget:self action:@selector(searchButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(0, self.height - 1, ScreenWidth, 1);
    line.backgroundColor = [bordColor colorWithAlphaComponent:0.5];
    [self addSubview:line];
    
}

- (void)searchButtonClickAction:(UIButton *)button
{
    self.onClickAction();
}

@end
