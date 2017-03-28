
//
//  WL_Application_Driver_OrderSectionStatusView.m
//  WeiLvDJS
//
//  Created by whw on 16/12/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_OrderSectionStatusView.h"
#import "WLBezierPath.h"

@interface WL_Application_Driver_OrderSectionStatusView ()
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
@property (nonatomic, assign) WLOrderDetailStatus status;


@end

#define startX  ScaleW(77)
#define startY  ScaleH(36)
#define marginW ScaleW(70)
#define selectedColor Color1
@implementation WL_Application_Driver_OrderSectionStatusView

- (instancetype)initWithStatus:(WLOrderDetailStatus)status andFrame:(CGRect)frame
{
   
    if (self = [super init]) {
        self.backgroundColor = [WLTools stringToColor:@"#ffffff"];
        self.status = status;
        self.frame = frame;
        [self setupUI];
    }
    return self;
}
- (void)setStatus:(WLOrderDetailStatus)status
{
    _status = status;
    
    NSMutableArray *tempArray = [NSMutableArray array];
    WLBezierPath *path = [WLBezierPath bezierPath];
    [path moveToPoint:CGPointMake(startX, startY)];
    [path addLineToPoint:CGPointMake(startX + 3*marginW, startY)];
    path.lineWidth = 2;
    path.lineColor = [UIColor grayColor];
    [tempArray addObject:path];
    
    switch (_status) {
        case WLOrderDetailWait:
        {
            _titleArray = @[ @"待接单",@"出发",@"结束",@"结算" ];
            _imageArray = @[ @"zhuangtai",@"zhaungtai1",@"zhaungtai1",@"zhaungtai1" ];
            _currentLevel = 0;
        }
            break;
        case WLOrderDetailStart:
        {
            _titleArray = @[ @"已接单",@"待出发",@"结束",@"结算" ];
            _imageArray = @[ @"zhuangtai2",@"zhuangtai",@"zhaungtai1",@"zhaungtai1" ];
            _currentLevel = 1;
            
            WLBezierPath *path = [WLBezierPath bezierPath];
            [path moveToPoint:CGPointMake(startX, startY)];
            [path addLineToPoint:CGPointMake(startX + marginW, startY)];
            path.lineWidth = 2;
            path.lineColor = selectedColor;
            [tempArray addObject:path];
        }
            break;
        case WLOrderDetailTravel:
        {
            _titleArray = @[ @"已接单",@"已出发",@"出行中",@"结算" ];
            _imageArray = @[ @"zhuangtai2",@"zhuangtai2",@"zhuangtai",@"zhaungtai1" ];
            _currentLevel = 2;
            
            WLBezierPath *path = [WLBezierPath bezierPath];
            [path moveToPoint:CGPointMake(startX, startY)];
            [path addLineToPoint:CGPointMake(startX + 2 *marginW, startY)];
            path.lineWidth = 2;
            path.lineColor = selectedColor;
            [tempArray addObject:path];
        }
            break;
        case WLOrderDetailSettlement:
        {
            _titleArray = @[ @"已接单",@"已出发",@"已结束",@"结算中" ];
            _imageArray = @[ @"zhuangtai2",@"zhuangtai2",@"zhuangtai2",@"zhuangtai" ];
            _currentLevel = 3;
            
            WLBezierPath *path = [WLBezierPath bezierPath];
            [path moveToPoint:CGPointMake(startX, startY)];
            [path addLineToPoint:CGPointMake(startX + 3 *marginW, startY)];
            path.lineWidth = 2;
            path.lineColor = selectedColor;
            [tempArray addObject:path];
        }
            break;
        case WLOrderDetailFinished:
        {
            _titleArray = @[ @"已接单",@"已出发",@"已结束",@"已结清" ];
            _imageArray = @[ @"zhuangtai2",@"zhuangtai2",@"zhuangtai2",@"zhuangtai2" ];
            _currentLevel = 3;
            
            WLBezierPath *path = [WLBezierPath bezierPath];
            [path moveToPoint:CGPointMake(startX, startY)];
            [path addLineToPoint:CGPointMake(startX + 3 *marginW, startY)];
            path.lineWidth = 2;
            path.lineColor = selectedColor;
            [tempArray addObject:path];
        }
            break;
        case WLOrderDetailRefuse:
        {
            _titleArray = @[ @"已拒绝",@"出发",@"结束",@"结算" ];
            _imageArray = @[ @"jujue",@"zhaungtai1",@"zhaungtai1",@"zhaungtai1" ];
            _currentLevel = 0;
        }
            break;
        case WLOrderDetailCancel:
        {
            _titleArray = @[ @"已取消",@"出发",@"结束",@"结算" ];
            _imageArray = @[ @"jujue",@"zhaungtai1",@"zhaungtai1",@"zhaungtai1" ];
            _currentLevel = 0;
        }
            break;
        case WLOrderDetailOverTime:
        {
            _titleArray = @[ @"已超时",@"出发",@"结束",@"结算" ];
            _imageArray = @[ @"jujue",@"zhaungtai1",@"zhaungtai1",@"zhaungtai1" ];
            _currentLevel = 0;
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
    for (int i = 0; i < self.imageArray.count; i++)
    {
        UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:self.imageArray[i]]];
        image.center = CGPointMake(startX + i*marginW,startY);
        [image sizeToFit];
        
        UILabel *label = [[UILabel alloc]init];
        label.textColor = [WLTools stringToColor:@"#929292"];
        label.font = [UIFont WLFontOfSize:14];
        
        label.center = CGPointMake(startX + i*marginW - ScaleW(20), ScaleH(60));        
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
        _labelArray = [NSMutableArray arrayWithCapacity:4];
    }
    return _labelArray;
}
- (NSMutableArray *)imageViewArray
{
    if (_imageViewArray == nil)
    {
        _imageViewArray = [NSMutableArray arrayWithCapacity:4];
    }
    return _imageViewArray;
}

@end
