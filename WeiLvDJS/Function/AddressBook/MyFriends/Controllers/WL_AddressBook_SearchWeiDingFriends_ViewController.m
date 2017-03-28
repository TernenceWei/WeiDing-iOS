//
//  WL_AddressBook_SearchWeiDingFriends_ViewController.m
//  WeiLvDJS
//
//  Created by whw on 16/12/11.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  扫描二维码主控制器

#import "WL_AddressBook_SearchWeiDingFriends_ViewController.h"
#import "WL_Address_Friends_ScanningView.h"
#import "WL_AddressBook_Camera_ViewController.h"
#import "WL_AddressBook_LinkManDetail_ViewController.h"
#import "WL_AddressBook_MyFriends_addWeiDingFriends_ViewController.h"
#define kIsAuthorizedString @"请在 设置 － 隐私 － 相机 中打开相机权限"

@interface WL_AddressBook_SearchWeiDingFriends_ViewController ()<WLCameraControllerDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UIView *preview;
@property (nonatomic, strong) WL_Address_Friends_ScanningView *scanningView;
@property (nonatomic, strong) WL_AddressBook_Camera_ViewController *cameraController;
/**< 提示框 */
@property(nonatomic, strong)WL_TipAlert_View *alert;
@end

@implementation WL_AddressBook_SearchWeiDingFriends_ViewController

#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([self isCameraIsAuthorized]) {
        [self setupView];
    } else {
        UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:kIsAuthorizedString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"扫描二维码";
    self.view.backgroundColor = [UIColor grayColor];
}

- (void)setupView
{
    [self.view addSubview:self.preview];
    [self.view addSubview:self.scanningView];
    [self.cameraController showCaptureOnView:self.preview];
    [self.scanningView scanning];
}
#pragma mark - The Camera is Authorized

/** 是否授权 */
- (BOOL)isCameraIsAuthorized {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusDenied){
        return NO;
    } else if (authStatus == AVAuthorizationStatusAuthorized) {
        return YES;
    }
    return YES;
}
/** codesString 扫描二维码返回的结果 */
- (void)didDetectCodes:(NSString *)codesString {
    [self.scanningView removeScanningAnimations];
    
    /**< 跳转到个人资料详情页 */
    WL_AddressBook_LinkManDetail_ViewController * linkManDetailVc = [[WL_AddressBook_LinkManDetail_ViewController alloc] init];
    /**< 被查看联系人的用户id */
//    linkManDetailVc.view_id = codesString;
    linkManDetailVc.view_id = @"13600000000";
    linkManDetailVc.isCompany = @"1";
    linkManDetailVc.addressBook = @"2";
    [self.navigationController pushViewController:linkManDetailVc animated:YES];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    /**
     *  buttonIndex排序规则:
     *  cancelButtonTitle为0
     *  otherButtonTitles 中按创建顺序依次递增
     */
    //验证:
    switch (buttonIndex)
    {
        case 0:
        {
            NSURL *setUrl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:setUrl]) {
                [[UIApplication sharedApplication] openURL:setUrl];
            }
        }
            break;
        case 1:
            NSLog(@"点击了确定按钮");
            break;
        case 2:
            NSLog(@"点击了其它按钮");
            break;
        default:
            break;
    }
}

- (void)dealloc {
    
    [self.cameraController stopSession];
}
#pragma mark - 懒加载
- (WL_Address_Friends_ScanningView *)scanningView
{
    if (_scanningView == nil) {
        _scanningView = [[WL_Address_Friends_ScanningView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    }
    return _scanningView;
}
- (UIView *)preview {
    if (!_preview) {
        _preview = [[UIView alloc] initWithFrame:self.view.bounds];
    }
    return _preview;
}

- (WL_AddressBook_Camera_ViewController *)cameraController {
    if (!_cameraController) {
        _cameraController = [[WL_AddressBook_Camera_ViewController alloc] init];
        _cameraController.delegate = self;
    }
    return _cameraController;
}

@end
