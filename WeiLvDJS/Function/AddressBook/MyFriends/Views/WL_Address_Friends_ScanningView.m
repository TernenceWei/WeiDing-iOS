//
//  WL_Address_Friends_ScanningView.m
//  WeiLvDJS
//
//  Created by whw on 16/12/11.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
// 二维码扫描的view

#import "WL_Address_Friends_ScanningView.h"

#define kWLQRCodeTipString  @"对方可在\"我的\"头像旁打开二维码"
#define kWLQRCodeUnRestrictedTipString  @"请在%@的\"设置-隐私-相机\"选项中，\r允许%@访问你的相机"
#define kWLQRCodeRectPaddingX 55

/**< 扫描区域的尺寸 */
static CGRect scanningRect;

@interface WL_Address_Friends_ScanningView ()

@property (nonatomic, assign) CGRect cleanRect;

@property (nonatomic, assign) CGRect scanningRect;
/**< 扫描的那根线 */
@property (nonatomic, strong) UIImageView *scanningImageView;
/**< 提示 */
@property (nonatomic, strong) UILabel *QRCodeTipLabel;
/**< 预览图层 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *preViewLayer;
@end
@implementation WL_Address_Friends_ScanningView

+ (Class)layerClass {
    return [AVCaptureVideoPreviewLayer class];
}

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupView];
        self.cleanRect = CGRectMake(kWLQRCodeRectPaddingX, 110, CGRectGetWidth(frame) - kWLQRCodeRectPaddingX * 2, CGRectGetWidth(frame) - kWLQRCodeRectPaddingX * 2);
    }
    return self;
}
- (void)setupView {
    self.isRestrict = YES;
    self.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.500];
    
    [self addSubview:self.scanningImageView];
    [self addSubview:self.QRCodeTipLabel];
    [self QRCodeQRCodeTipLabelString];
   
}
#pragma mark - According authorized and unauthorized show different tip string

- (void )QRCodeQRCodeTipLabelString {
    if (self.isRestrict) {
        self.QRCodeTipLabel.text = kWLQRCodeTipString;
    } else {
        NSString *appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleDisplayName"];
        if (!appName) appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleName"];
        self.QRCodeTipLabel.text = [NSString stringWithFormat:kWLQRCodeUnRestrictedTipString,[UIDevice currentDevice].model,appName];;
    }
}

- (void)scanning {
    self.scanningImageView.frame = scanningRect;
    CGRect animatationRect = scanningRect;
    animatationRect.origin.y += CGRectGetWidth(self.bounds) - CGRectGetMinX(animatationRect) * 2 - CGRectGetHeight(animatationRect);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0];
    [UIView setAnimationDuration:1.2];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationRepeatCount:FLT_MAX];
    [UIView setAnimationRepeatAutoreverses:NO];
    
    self.scanningImageView.frame = animatationRect;
    [UIView commitAnimations];
}
#pragma mark - Remove ScaningImageViAnimations

- (void)removeScanningAnimations {
    [self.scanningImageView.layer removeAllAnimations];
};
- (void)drawRect:(CGRect)rect {
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(contextRef, self.backgroundColor.CGColor);
    CGContextFillRect(contextRef, rect);
    CGRect clearRect;
    CGFloat paddingX = kWLQRCodeRectPaddingX;
    CGFloat tipLabelPadding = 30.0f;
    clearRect = CGRectMake(paddingX, 130, CGRectGetWidth(rect) - paddingX * 2, CGRectGetWidth(rect) - paddingX * 2);
    self.cleanRect = clearRect;
    
    CGRect QRCodeTipLabelFrame = self.QRCodeTipLabel.frame;
    QRCodeTipLabelFrame.origin.y = CGRectGetMaxY(self.cleanRect) + tipLabelPadding;
    self.QRCodeTipLabel.frame = QRCodeTipLabelFrame;
    
    CGContextClearRect(contextRef, self.cleanRect);
    CGContextSaveGState(contextRef);
    
    CGFloat padding = 0.5;
    CGContextMoveToPoint(contextRef, CGRectGetMinX(_cleanRect) - padding, CGRectGetMinY(_cleanRect) - padding);
    CGContextAddLineToPoint(contextRef, CGRectGetMaxX(_cleanRect) + padding, CGRectGetMinY(_cleanRect) + padding);
    CGContextAddLineToPoint(contextRef, CGRectGetMaxX(_cleanRect) + padding, CGRectGetMaxY(_cleanRect) + padding);
    CGContextAddLineToPoint(contextRef, CGRectGetMinX(_cleanRect) - padding, CGRectGetMaxY(_cleanRect) + padding);
    CGContextAddLineToPoint(contextRef, CGRectGetMinX(_cleanRect) - padding, CGRectGetMinY(_cleanRect) - padding);
    CGContextSetLineWidth(contextRef, padding);
    CGContextSetStrokeColorWithColor(contextRef, [UIColor whiteColor].CGColor);
    CGContextStrokePath(contextRef);
}

- (AVCaptureSession *)session {
    return self.preViewLayer.session;
}

- (void)setSession:(AVCaptureSession *)session {
    self.preViewLayer.session = session;
}

- (AVCaptureVideoPreviewLayer *)previewLayer {
    return (AVCaptureVideoPreviewLayer *)self.layer;
}
#pragma mark - UI控件懒加载
- (UIImageView *)scanningImageView {
    if (!_scanningImageView) {
        _scanningImageView = [[UIImageView alloc] initWithFrame:CGRectMake(55, 130, CGRectGetWidth(self.bounds) - 110, 3)];
        _scanningImageView.backgroundColor = [UIColor greenColor];
        scanningRect  = _scanningImageView.frame;
    }
    return _scanningImageView;
}
- (UILabel *)QRCodeTipLabel {
    if (!_QRCodeTipLabel) {
        _QRCodeTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.cleanRect) + 30, CGRectGetWidth(self.bounds) - 20, 20)];
        _QRCodeTipLabel.font = [UIFont systemFontOfSize:12];
        _QRCodeTipLabel.backgroundColor = [UIColor clearColor];
        _QRCodeTipLabel.textAlignment = NSTextAlignmentCenter;
        _QRCodeTipLabel.textColor = [UIColor whiteColor];
        _QRCodeTipLabel.numberOfLines = 0;
    }
    return _QRCodeTipLabel;
}
@end
