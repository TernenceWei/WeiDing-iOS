//
//  WLApplicationDriverBookOrderSectionStatusView.m
//  WeiLvDJS
//
//  Created by whw on 17/1/21.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLApplicationDriverBookOrderSectionStatusView.h"
#import "WLBezierPath.h"
@interface WLApplicationDriverBookOrderSectionStatusView ()
/**< 保存文字的数组 */
@property (nonatomic, strong) NSArray *titleArray;
/**< 保存图片的数组 */
@property (nonatomic, strong) NSArray *imageArray;
/**< 保存imageView的数组 */
@property (nonatomic, strong) NSMutableArray *imageViewArray;
/**< 保存label的数组 */
@property (nonatomic, strong) NSMutableArray *labelArray;
/**< 保存路劲的数组 */
@property (nonatomic, strong) NSArray *pathArray;
/**< 记录当前的等级 */
@property (nonatomic, assign) int currentLevel;
/**< 当前状态 */
@property (nonatomic, assign) WLBookOrderStatus status;


@end

#define originX  ScaleW(30)
#define originY  ScaleH(36)
#define margin   ScaleW(75)
#define levelColor Color1
@implementation WLApplicationDriverBookOrderSectionStatusView

- (instancetype)initWithStatus:(WLBookOrderStatus)status andFrame:(CGRect)frame
{
    
    if (self = [super init]) {
        self.backgroundColor = [WLTools stringToColor:@"#ffffff"];
        self.status = status;
        self.frame = frame;
        [self setupUI];
    }
    return self;
}
- (void)setStatus:(WLBookOrderStatus)status
{
    _status = status;
    
    NSMutableArray *tempArray = [NSMutableArray array];
    WLBezierPath *path = [WLBezierPath bezierPath];
    [path moveToPoint:CGPointMake(originX, originY)];
    [path addLineToPoint:CGPointMake(originX + 4*margin, originY)];
    path.lineWidth = 2;
    path.lineColor = [UIColor grayColor];
    [tempArray addObject:path];
    
    switch (status) {
        case WLWaitOrderStatus:
        {
            _titleArray = @[ @"待报价",@"客户付款",@"出发",@"结束",@"结算" ];
            _imageArray = @[ @"zhuangtai",@"zhaungtai1",@"zhaungtai1",@"zhaungtai1",@"zhaungtai1" ];
            _currentLevel = 0;
        }
            break;
        case WLUnpaidStatus:
        {
            _titleArray = @[ @"已报价",@"待客户确认",@"出发",@"结束",@"结算" ];
            _imageArray = @[ @"zhuangtai2",@"zhuangtai",@"zhaungtai1",@"zhaungtai1",@"zhaungtai1" ];
            _currentLevel = 1;
            
            WLBezierPath *path = [WLBezierPath bezierPath];
            [path moveToPoint:CGPointMake(originX, originY)];
            [path addLineToPoint:CGPointMake(originX + margin, originY)];
            path.lineWidth = 2;
            path.lineColor = levelColor;
            [tempArray addObject:path];
        }
            break;
        case WLOrderStatusStart:
        {
            _titleArray = @[ @"已接单",@"客户已付款",@"待出发",@"结束",@"结算" ];
            _imageArray = @[ @"zhuangtai2",@"zhuangtai2",@"zhuangtai",@"zhaungtai1",@"zhaungtai1" ];
            _currentLevel = 2;
            
            WLBezierPath *path = [WLBezierPath bezierPath];
            [path moveToPoint:CGPointMake(originX, originY)];
            [path addLineToPoint:CGPointMake(originX + 2 *margin, originY)];
            path.lineWidth = 2;
            path.lineColor = levelColor;
            [tempArray addObject:path];
        }
            break;
        case WLOrderStatusTravel:
        {
            _titleArray = @[ @"已接单",@"客户已付款",@"行程中",@"待结束",@"结算" ];
            _imageArray = @[ @"zhuangtai2",@"zhuangtai2",@"zhuangtai2",@"zhuangtai",@"zhaungtai1" ];
            _currentLevel = 3;
            
            WLBezierPath *path = [WLBezierPath bezierPath];
            [path moveToPoint:CGPointMake(originX, originY)];
            [path addLineToPoint:CGPointMake(originX + 3 *margin, originY)];
            path.lineWidth = 2;
            path.lineColor = levelColor;
            [tempArray addObject:path];
        }
            break;
        case WLOrderStatusSettlement:
        {
            _titleArray = @[ @"已接单",@"客户已付款",@"行程中",@"已结束",@"待结算" ];
            _imageArray = @[ @"zhuangtai2",@"zhuangtai2",@"zhuangtai2",@"zhuangtai2",@"zhuangtai" ];
            _currentLevel = 4;
            
            WLBezierPath *path = [WLBezierPath bezierPath];
            [path moveToPoint:CGPointMake(originX, originY)];
            [path addLineToPoint:CGPointMake(originX + 4 *margin, originY)];
            path.lineWidth = 2;
            path.lineColor = levelColor;
            [tempArray addObject:path];
        }
            break;
        case WLOrderStatusFinish:
        {
            _titleArray = @[ @"已接单",@"客户已付款",@"行程中",@"已结束",@"已结清" ];
            _imageArray = @[ @"zhuangtai2",@"zhuangtai2",@"zhuangtai2",@"zhuangtai2",@"zhuangtai2" ];
            _currentLevel = 4;
            
            WLBezierPath *path = [WLBezierPath bezierPath];
            [path moveToPoint:CGPointMake(originX, originY)];
            [path addLineToPoint:CGPointMake(originX + 4 *margin, originY)];
            path.lineWidth = 2;
            path.lineColor = levelColor;
            [tempArray addObject:path];
        }
            break;
        default:
            break;
    }
    _pathArray = tempArray.copy;
    [self setNeedsDisplay];
    
}

- (void)setupUI
{
    for (int i = 0; i < 5; i++)
    {
        UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:self.imageArray[i]]];
        image.center = CGPointMake(originX + i*margin,originY);
        [image sizeToFit];
        
        UILabel *label = [[UILabel alloc]init];
        label.textColor = [WLTools stringToColor:@"#929292"];
        label.font = [UIFont WLFontOfSize:14];
        label.center = i == 1?CGPointMake(originX + i*margin - ScaleW(30), ScaleH(60)):CGPointMake(originX + i*margin - ScaleW(20), ScaleH(60));
        label.textAlignment = i == 1?NSTextAlignmentLeft:NSTextAlignmentCenter;
        label.text = self.titleArray[i];
        label.textAlignment = NSTextAlignmentCenter;
        [label sizeToFit];
        
        [self.imageViewArray addObject:image];
        [self.labelArray addObject:label];
        
        [self addSubview:image];
        [self addSubview:label];
    }
    
    [self.labelArray enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.textColor = [WLTools stringToColor:@"#333333"];
        if (idx == self.currentLevel) {
            *stop = YES;
        }
    }];
    
    UILabel *lineLabel = [[UILabel alloc]init];
    lineLabel.backgroundColor = Color4;
    lineLabel.frame = CGRectMake(0, self.height - 0.8, ScreenWidth, 0.8);
    [self addSubview:lineLabel];
}
- (void)drawRect:(CGRect)rect
{
    for (WLBezierPath *path in self.pathArray)
    {
        [path.lineColor set];
        [path stroke];
    }
}




- (NSMutableArray *)labelArray
{
    if (_labelArray == nil) {
        _labelArray = [NSMutableArray arrayWithCapacity:5];
    }
    return _labelArray;
}
- (NSMutableArray *)imageViewArray
{
    if (_imageViewArray == nil)
    {
        _imageViewArray = [NSMutableArray arrayWithCapacity:5];
    }
    return _imageViewArray;
}
@end
