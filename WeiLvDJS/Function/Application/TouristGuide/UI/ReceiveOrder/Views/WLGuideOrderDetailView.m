//
//  WLGuideOrderDetailView.m
//  WeiLvDJS
//
//  Created by whw on 16/10/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//



#import "WLGuideOrderDetailView.h"
#import "WLGuideOrderLineView.h"

@interface WLGuideOrderDetailView()

@property(nonatomic, strong)UITableView *tableView;

@end

@implementation WLGuideOrderDetailView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        self.backgroundColor = HEXCOLOR(0xf7f7f8);
        [self creatView];
    }
    return self;
}
//画斜线
- (void)drawRect:(CGRect)rect {

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(context, 0, 160);
    
    CGContextAddLineToPoint(context, ScreenWidth, 40);
    
    CGContextAddLineToPoint(context, ScreenWidth, 0);
    
    CGContextAddLineToPoint(context, 0, 0);
    
    
    CGContextClosePath(context);
    
    [[UIColor clearColor] setStroke];
    
    [HEXCOLOR(0x4877e7) setFill];
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
}

-(void)creatView{
    UIView *topView = [[WLGuideOrderLineView alloc] init];
    topView.frame = CGRectMake(ScaleW(12), 0, ScreenWidth - ScaleW(22), ScaleH(275));
    [self addSubview:topView];
    
//    self.tableView = [[UITableView alloc] init];
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left);
//        make.right.equalTo(self.mas_right);
//        make.top.equalTo(self.top)
//    }]
}


@end
