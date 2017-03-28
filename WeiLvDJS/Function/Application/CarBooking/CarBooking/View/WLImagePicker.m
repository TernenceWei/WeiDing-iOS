//
//  WLImagePicker.m
//  WeiLvDJS
//
//  Created by ternence on 2017/2/22.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLImagePicker.h"
#import "DNImagePickerController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "XLPhotoBrowser.h"

#define margin ScaleW(12)

@interface WLImagePicker ()<UIActionSheetDelegate,DNImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,XLPhotoBrowserDelegate>

@property (nonatomic, assign) ImagePickerType type;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) UIViewController *attachedController;
@property (nonatomic, strong) UIImage *capturedPicture;

@end

@implementation WLImagePicker

- (instancetype)initWithFrame:(CGRect)frame
                   pickerType:(ImagePickerType)type
           attachedController:(UIViewController *)attachedController
                 selectAction:(void(^)(NSArray * array))selectAction
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.type = type;
        self.attachedController = attachedController;
        [self setupUI];
    }
    return self;
}

- (void)setupUI{

    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];

    CGFloat width = (ScreenWidth - 5 * margin) / 4;
    
    self.addButton = [[UIButton alloc] init];
    [self.addButton setImage:[[UIImage imageNamed:@"shangchuantupian"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    self.addButton.frame = CGRectMake(margin, margin, width, width);
    [self.addButton addTarget:self action:@selector(addNewPicture) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.addButton];
}

#pragma mark private method
- (void)addNewPicture{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    [actionSheet showInView:self];
}

- (void)openAlbum
{
    DNImagePickerController *imagePicker = [[DNImagePickerController alloc] init];
    imagePicker.imagePickerDelegate = self;
    [self.attachedController presentViewController:imagePicker animated:YES completion:nil];
    [[NSUserDefaults standardUserDefaults] setInteger:self.imageArray.count forKey:@"CarBookingSelectImageCount"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)capturePicture
{
    
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]&&mediaTypes.count>0) {
        UIImagePickerController *imagePick = [[UIImagePickerController alloc] init];
        imagePick.mediaTypes = mediaTypes;
        imagePick.navigationBarHidden = YES;
        imagePick.allowsEditing = YES;
        imagePick.delegate = self;
        imagePick.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self.attachedController presentViewController:imagePick animated:YES completion:nil];
        
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"设备不支持" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [alert show];
    }
    
}

- (void)updateFrameWithImageDataArray:(NSArray *)dataArray
{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSData *data in dataArray) {
        UIImage *tempImg=[UIImage imageWithData:data];
        [tempArray addObject:tempImg];
    }
    [self.imageArray addObjectsFromArray:[tempArray copy]];
    [self updateFrame];
}

- (void)updateFrame
{
    for (UIView *subView in self.scrollView.subviews) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            [subView removeFromSuperview];
        }
    }
    
    CGFloat width = (ScreenWidth - 5 * margin) / 4;
    NSUInteger count = self.imageArray.count;
    CGFloat height = (count + 1) > 4? (width + margin) * 2 + margin : (width + 2 * margin);
    self.frame = CGRectMake(self.x, self.y, ScreenWidth, height);
    self.scrollView.frame = self.bounds;
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, height);
    
    for (NSUInteger i = 0; i < count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = self.imageArray[i];
        CGFloat beginX = (width + margin) * (i % 4) + margin;
        CGFloat beginY = (width + margin) * (i / 4) + margin;
        imageView.frame = CGRectMake(beginX, beginY, width, width);
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.scrollView addSubview:imageView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapGestureAction:)];
        [imageView addGestureRecognizer:tapGesture];

    }
    CGFloat addButtonX = (width + margin) * (count % 4) + margin;
    CGFloat addButtonY = (width + margin) * (count / 4) + margin;
    self.addButton.frame = CGRectMake(addButtonX, addButtonY, width, width);

}

- (void)imageTapGestureAction:(UITapGestureRecognizer *)tapGesture
{
    NSUInteger tag = tapGesture.view.tag;
    XLPhotoBrowser *browser = [XLPhotoBrowser showPhotoBrowserWithImages:self.imageArray currentImageIndex:tag];
    browser.browserStyle = XLPhotoBrowserStyleCarBooking;
    browser.delegate = self;
    
}

- (NSArray *)getSelectedImageArray
{
    return [self.imageArray copy];
}

#pragma mark XLPhotoBrowserDelegate
- (void)photoBrowser:(XLPhotoBrowser *)browser deleteImage:(NSInteger)deleteIndex
{
    [self.imageArray removeObjectAtIndex:deleteIndex];
    [self updateFrame];

}

#pragma mark DNImagePickerControllerDelegate
- (void)dnImagePickerController:(DNImagePickerController *)imagePickerController sendImages:(NSArray *)imageAssets isFullImage:(BOOL)fullImage
{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (ALAsset *asset in imageAssets) {
        UIImage *tempImg=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        [tempArray addObject:tempImg];
    }
    [self.imageArray addObjectsFromArray:[tempArray copy]];
    [self updateFrame];
}

- (void)dnImagePickerControllerDidCancel:(DNImagePickerController *)imagePicker
{
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark ImagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        
        if ([info objectForKey:UIImagePickerControllerEditedImage]!= nil) {
            
            self.capturedPicture = [info objectForKey:UIImagePickerControllerEditedImage];
        }else{
            
            self.capturedPicture = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            
            UIImageWriteToSavedPhotosAlbum(self.capturedPicture, self, nil, NULL);
        }
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        
        [self.imageArray addObject:self.capturedPicture];
        [self updateFrame];
        
    }];

    
}

#pragma mark ActionSheet delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:{//相机
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在设置-隐私-相机中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                return;
            }
            
            [self capturePicture];
            
        }
            break;
        case 1:{//相册
            [self openAlbum];
            
        }
            break;
            
        default:
            break;
    }
}

#pragma mark Lazy load
- (NSMutableArray *)imageArray
{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
@end
