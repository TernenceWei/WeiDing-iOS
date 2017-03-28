//
//  WL_AddressBook_Camera_ViewController.m
//  WeiLvDJS
//
//  Created by whw on 16/12/11.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  二维码扫描配置控制器

#import "WL_AddressBook_Camera_ViewController.h"

@interface WL_AddressBook_Camera_ViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureDevice *activeCamera;
@property (nonatomic, assign) AVCaptureDeviceInput *activeVideoInput;
@property (nonatomic, strong) AVCaptureMetadataOutput *metadataOutput;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
@property (nonatomic, strong) dispatch_queue_t videoQueue;

@end




@implementation WL_AddressBook_Camera_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
#pragma mark - Public Event

- (void)showCaptureOnView:(UIView *)preview {
    NSError *error;
    if ([self setupSession:&error]) {
        [self startSession];
    } else {
        NSLog(@"Error:%@",[error localizedDescription]);
    }
    
    self.captureVideoPreviewLayer.frame = preview.bounds;
    [preview.layer addSublayer:self.captureVideoPreviewLayer];
}
/**< 开始会话 */
- (void)startSession {
    if (![self.captureSession isRunning]) {
        dispatch_async(self.videoQueue, ^{
            [self.captureSession startRunning];
        });
    }
}
/**< 停止会话 */
- (void)stopSession {
    if ([self.captureSession isRunning]) {
        dispatch_async(self.videoQueue, ^{
            [self.captureSession stopRunning];
        });
    }
}

- (BOOL)setupSession:(NSError **)error {
    self.captureSession = [[AVCaptureSession alloc] init];
    self.captureSession.sessionPreset = [self sessionPreset];
    if (![self setupSessionInputs:error]) {
        return NO;
    }
    if (![self setupSessionOutputs:error]) {
        return NO;
    }
    _captureVideoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    _captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    return YES;
}
//AVCaptureAutoFocusRangeRestrictionNear ios7版本新增的属性，允许我们使用一个范围的约束对这个功能进行定制，我们扫描的大部分条码距离都不远，所以可以通过缩小扫描区域来提升识别的成功率。检测是否支持该功能
- (BOOL)setupSessionInputs:(NSError *__autoreleasing *)error {
    BOOL success = [self setupFatherSessionInputs:error];
    if (success) {
        if (self.activeCamera.autoFocusRangeRestrictionSupported) {         // 3
            if ([self.activeCamera lockForConfiguration:error]) {
                self.activeCamera.autoFocusRangeRestriction =
                AVCaptureAutoFocusRangeRestrictionNear;
                [self.activeCamera unlockForConfiguration];
            }
        }
    }
    return success;
}
- (BOOL)setupSessionOutputs:(NSError **)error {
    self.metadataOutput = [[AVCaptureMetadataOutput alloc] init];
    if ([self.captureSession canAddOutput:self.metadataOutput]) {
        [self.captureSession addOutput:self.metadataOutput];
        dispatch_queue_t mainqueue = dispatch_get_main_queue();
        [self.metadataOutput setMetadataObjectsDelegate:self queue:mainqueue];
        //设置扫描支持的类型
        NSArray *typesArr = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeAztecCode,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeInterleaved2of5Code,AVMetadataObjectTypeUPCECode,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode93Code,AVMetadataObjectTypeCode128Code];
        self.metadataOutput.metadataObjectTypes = typesArr;
    } else {
        
        WlLog(@"二维码绑定输出流失败");
        return NO;
    }
    return YES;
}

- (BOOL)setupFatherSessionInputs:(NSError **)error {
    AVCaptureDevice *videoDevice =
    [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.activeCamera = videoDevice;
    AVCaptureDeviceInput *videoInput =
    [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:error];
    if (videoInput) {
        if ([self.captureSession canAddInput:videoInput]) {
            [self.captureSession addInput:videoInput];
            self.activeVideoInput = videoInput;
        } else {
             WlLog(@"二维码绑定输入流失败");
            return NO;
        }
    } else {
        return NO;
    }
    
    return YES;
}
#pragma mark - AVCaptureMetadataOutputObjectsDelegate Delagate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection {
    [self stopSession];
    WlLog(@"metadataObjects:%@",metadataObjects);
    BOOL isAvailable = YES;
    if (metadataObjects.count > 0 && isAvailable == YES) {
        isAvailable = NO;
        NSString *metadataString = nil;
        AudioServicesPlaySystemSound(1360);
        AVMetadataMachineReadableCodeObject *MetadataObject = [metadataObjects objectAtIndex:0];
        metadataString = MetadataObject.stringValue;
        
        [self.delegate didDetectCodes:metadataString];
    }
}

#pragma mark - 属性懒加载


- (NSString *)sessionPreset{
    return AVCaptureSessionPresetHigh;
}

- (dispatch_queue_t)videoQueue {
    return dispatch_queue_create("com.WLQRCode.videoQueue", NULL);
}

@end
