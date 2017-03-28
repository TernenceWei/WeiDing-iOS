//
//  WL_AddressBook_Camera_ViewController.h
//  WeiLvDJS
//
//  Created by whw on 16/12/11.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseViewController.h"
#import <AVFoundation/AVFoundation.h>

@protocol WLCameraControllerDelegate <NSObject>

/** 扫描二维码结果 */
- (void)didDetectCodes:(NSString *)codesString;

@end

@interface WL_AddressBook_Camera_ViewController : WL_BaseViewController

@property (nonatomic, assign) id <WLCameraControllerDelegate> delegate;
/**< 会话 */
@property (nonatomic, strong) AVCaptureSession *captureSession;

/** 配置会话 */
- (void)startSession;
- (void)stopSession;
- (BOOL)setupSession:(NSError **)error;
/** 设置相机显示的UIView */
- (void)showCaptureOnView:(UIView *)preview;
@end
