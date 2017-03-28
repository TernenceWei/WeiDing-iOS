//
//  GrowingLineView.m
//  DrawDemo
//
//  Created by StoneLam on 15/7/31.
//  Copyright (c) 2015年 LEOMaster. All rights reserved.
//

#import "GrowingLineView.h"
#import "FlowmeterTool.h"
#import "FlowViewFrame.h"
#import "WLUITool.h"

#define PI 3.14159265358979323846
#define kGrowCounts 40
#define VisibleCount 7

@interface GrowingLineView()
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSArray *xArray;
@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic, strong) NSNumber *maxValue;
@property (nonatomic, strong) UIView *alphaView;

@end

@implementation GrowingLineView
{
    NSInteger count;
    float _valueDensity;
    float _curueBeginY;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (instancetype)initWithFrame:(CGRect)frame xData:(NSArray *)xArray yData:(NSArray *)yArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        self.xArray = [xArray mutableCopy];
        self.dataArray = [yArray mutableCopy];

        FlowmeterTool *tool = [[FlowmeterTool alloc] init];
        self.maxValue = [tool getMaxFlowCount:self.dataArray];
        CGSize baseSize = [WLUITool sizeWithString:@"100M" font:flowGrowingView_growingView_flowCount_Font];
        _curueBeginY = baseSize.height + flowGrowingView_growingView_flowCount_point_margin;
        if (self.maxValue.floatValue < 0.01) {
            _valueDensity = 1;
        }else{
            _valueDensity = (flowGrowingView_growingView_H - _curueBeginY) / self.maxValue.floatValue;
        }
        
        [self startGrow];
        [self setupBottomBar];
        [self setNeedsDisplay];

        
        self.alphaView = [[UIView alloc] init];
        self.alphaView.frame = CGRectMake(0, 0, frame.size.width, flowGrowingView_growingView_H);
       
        UIColor *firstColor = HEXCOLOR(0x09d1e3);
        UIColor *secondColor = HEXCOLOR(0x09d1e3);
        UIColor *thirdColor = HEXCOLOR(0x09d1e3);
        NSArray *colors = @[(id)firstColor.CGColor,(id)secondColor.CGColor,(id)thirdColor.CGColor];
        NSArray *locations = @[[NSNumber numberWithFloat:1],[NSNumber numberWithFloat:1],[NSNumber numberWithFloat:1.0]];
        CAGradientLayer *layer = [CAGradientLayer layer];
        layer.colors = colors;
        layer.locations = locations;
        layer.frame = CGRectMake(0, 0, frame.size.width, flowGrowingView_growingView_H);
        [self.alphaView.layer addSublayer:layer];
        [self addSubview:self.alphaView];
        

    }
    return self;
}

- (void)setupBottomBar
{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 1; i <= self.xArray.count; i ++) {
        UILabel *dayLabel = [[UILabel alloc] init];
        dayLabel.text = [NSString stringWithFormat:@"%ld月",[(NSNumber *)self.xArray[i - 1] integerValue]];
        dayLabel.textColor = HEXCOLOR(0xb5b5b5);
        dayLabel.font = WLFontSize(12);
        CGSize daySize = [WLUITool sizeWithString:dayLabel.text font:dayLabel.font];
        CGFloat oneWidth = SCREEN_WIDTH / 7;
        CGFloat normalX = (oneWidth - daySize.width) / 2;
        CGFloat realY = self.frame.size.height - (flowGrowingView_bottomView_H - daySize.height) / 2- daySize.height;
        CGFloat realX = oneWidth * (i - 1) + normalX;
        dayLabel.frame = CGRectMake(realX, realY, daySize.width, daySize.height);
        [self addSubview:dayLabel];
        [tempArray addObject:[NSNumber numberWithFloat:dayLabel.center.x]];
    }
    self.xArray = tempArray;
    
}

- (void)setupFlowCount
{
    for (int i = 1; i <= self.dataArray.count; i ++) {
        UILabel *countLabel = [[UILabel alloc] init];
        double countValude = [(NSNumber *)self.dataArray[i - 1] doubleValue];
        NSString *text = [NSString stringWithFormat:@"%.2f",countValude];
        if (countValude >= 10000) {
            countValude = countValude / 10000;
            text = [NSString stringWithFormat:@"%.2f万",countValude];
        }
        countLabel.text = text;
        countLabel.textColor = [UIColor blackColor];
        countLabel.font = flowGrowingView_growingView_flowCount_Font;
        CGSize countSize = [WLUITool sizeWithString:countLabel.text font:flowGrowingView_growingView_flowCount_Font];
        CGFloat oneWidth = SCREEN_WIDTH / 7;
        CGFloat normalCountX = (oneWidth - countSize.width) / 2;
        CGFloat realCountX = oneWidth * (i - 1) + normalCountX;
        NSNumber *countValue = self.dataArray[i - 1];
        CGFloat realCountY = flowGrowingView_growingView_H - [countValue floatValue] * _valueDensity  - _curueBeginY;
        
        countLabel.frame = CGRectMake(realCountX, realCountY, countSize.width, countSize.height);
        countLabel.alpha = 0.0;
        [UIView animateWithDuration:1.0 animations:^{
            countLabel.alpha = 1.0;
        }];
//        [self addSubview:countLabel];
    }
}

- (void)startGrow{
    count = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(growOnce) userInfo:nil repeats:YES];
}

- (void)growOnce{
    [self setNeedsDisplay];
    if (count == kGrowCounts) {
        [self.timer invalidate];
        [self setupFlowCount];
    }
    count++;
}

- (void)drawRect:(CGRect)rect {
    if (!self.dataArray.count) {
        return;
    }

    NSMutableArray *yArray = [NSMutableArray array];
    for (NSNumber *yData in self.dataArray) {
        [yArray addObject:[NSNumber numberWithFloat:((float)flowGrowingView_growingView_H - [yData floatValue]*(float)count/(float)kGrowCounts * _valueDensity - _curueBeginY + (float)flowGrowingView_growingView_flowCount_point_margin * 2)]];
    }
    
    

    //画点
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, HEXCOLOR(0x09d1e3).CGColor);
//    for (NSInteger i=0; i<self.xArray.count; i++) {
//
//        CGContextAddArc(context, [self.xArray[i] floatValue], [yArray[i] floatValue], 4.0f, 0, 2*PI, 0);
//        CGContextDrawPath(context, kCGPathFill);
//
//    }
    
    /**
     *  透明区域
     */
    UIBezierPath* fillPath = [UIBezierPath bezierPath];
    [fillPath setLineWidth:2];
    fillPath.lineCapStyle = kCGLineCapButt;
    [HEXCOLOR(0x09d1e3) setFill];
    
    for(NSInteger i=0; i<self.xArray.count; i++){
        [fillPath addArcWithCenter:CGPointMake([self.xArray[i] floatValue], [yArray[i] floatValue]) radius:4.0 startAngle:0 endAngle:2*M_PI clockwise:true];
        if (i < self.xArray.count - 1) {
            CGPoint secondPoint = CGPointMake([self.xArray[i+1] floatValue], [yArray[i+1] floatValue]);
            [fillPath addLineToPoint:secondPoint];
        }
    }
    [fillPath addLineToPoint:CGPointMake(((NSNumber *)[self.xArray lastObject]).floatValue, self.frame.size.height - flowGrowingView_bottomView_H)];
    [fillPath addLineToPoint:CGPointMake(((NSNumber *)[self.xArray firstObject]).floatValue, self.frame.size.height - flowGrowingView_bottomView_H)];
    [fillPath addLineToPoint:CGPointMake(((NSNumber *)[self.xArray firstObject]).floatValue, ((NSNumber *)[yArray firstObject]).floatValue)];
    [fillPath fill];
    
    CAShapeLayer *mask = [CAShapeLayer layer];
    mask.path = fillPath.CGPath;
    self.alphaView.layer.mask = mask;

    
    //画曲线
    UIBezierPath* path = [UIBezierPath bezierPath];
    [path setLineWidth:2];
    for(NSInteger i=0; i<self.xArray.count-1; i++){
        CGPoint firstPoint = CGPointMake([self.xArray[i] floatValue], [yArray[i] floatValue] );
        CGPoint secondPoint = CGPointMake([self.xArray[i+1] floatValue] , [yArray[i+1] floatValue]);
        [path moveToPoint:firstPoint];
        [path addLineToPoint:secondPoint];
        [HEXCOLOR(0x09d1e3) setStroke];
    }
    path.lineCapStyle = kCGLineCapButt;
    [path strokeWithBlendMode:kCGBlendModeNormal alpha:1];
}

@end
