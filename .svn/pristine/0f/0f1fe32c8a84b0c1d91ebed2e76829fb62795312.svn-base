//
//  WLHotelPopView.m
//  WeiLvDJS
//
//  Created by ternence on 16/11/18.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLHotelPopView.h"
#import "XKPEPlaceholderTextView.h"

@interface WLHotelPopView ()
@property (nonatomic, strong) XKPEPlaceholderTextView *textView;
@property (nonatomic, copy) void(^onSubmmitAction)(NSString *text);
@end

@implementation WLHotelPopView

- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder submmitAction:(void(^)(NSString *remark))submmitAction
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        
        UILabel *textlabel = [[UILabel alloc] init];
        textlabel.textAlignment = NSTextAlignmentCenter;
        textlabel.frame = CGRectMake(0 ,ScaleH(30), frame.size.width, ScaleH(40));
        textlabel.text = @"备注";
        textlabel.textColor =[WLTools stringToColor:@"#2f2f2f"];
        textlabel.font = [UIFont WLFontOfSize:17];
        [self addSubview:textlabel];
        
        
        self.textView = [[XKPEPlaceholderTextView alloc] init];
        self.textView.layer.borderWidth = 0.5;
        self.textView.layer.masksToBounds = YES;
        self.textView.layer.borderColor = [UIColor grayColor].CGColor;
        self.textView.layer.cornerRadius = 5;
        self.textView.textColor = [WLTools stringToColor:@"#2f2f2f"];
        self.textView.placeholderColor = [WLTools stringToColor:@"#868686"];
        self.textView.font = [UIFont WLFontOfSize:14];
        self.textView.frame = CGRectMake(ScaleW(15), CGRectGetMaxY(textlabel.frame) + ScaleH(22), frame.size.width - ScaleW(30), ScaleH(130));
        self.textView.placeholder = placeholder;
        [self addSubview:self.textView];
        
        UIButton *submitBtn = [[UIButton alloc] init];
        [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [submitBtn setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateNormal];
        submitBtn.frame = CGRectMake(ScaleW(15) , CGRectGetMaxY(self.textView.frame) + ScaleH(30), frame.size.width - ScaleW(30), ScaleH(41));
        submitBtn.titleLabel.font = [UIFont WLFontOfSize:17];
        submitBtn.backgroundColor = [WLTools stringToColor:@"#4877e7"];
        submitBtn.layer.cornerRadius = 8;
        submitBtn.layer.masksToBounds = YES;
        [submitBtn addTarget:self action:@selector(submmitBtnDidClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:submitBtn];
        
        self.onSubmmitAction = submmitAction;
        
    }
    return self;
}

- (void)submmitBtnDidClicked
{
    self.onSubmmitAction(self.textView.text);
}
@end
