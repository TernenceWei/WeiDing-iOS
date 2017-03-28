//
//  WLAttachmentCell.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLAttachmentCell.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIImageView+WebCache.h"
#import "WLPhotoCheckView.h"
#import "WLNetworkManager.h"

#define cellIdentifier @"WLAttachmentCell"

@interface WLAttachmentCell ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImage *editImage;
@property (nonatomic, copy) void(^onOpenAlbumAction)(UIImagePickerController * pickerVC);
@property (nonatomic, copy) void(^onPhotoCheckAction)(UIImage *image, NSURL *imageUrl);
@property (nonatomic, strong) NSMutableArray *uploadImageArray;
@property (nonatomic, assign) BOOL canEdit;
@property (nonatomic, assign) BOOL isLocal;
@property (nonatomic, assign) NSUInteger selectedTag;
@end

@implementation WLAttachmentCell

- (NSMutableArray *)uploadImageArray
{
    if (!_uploadImageArray) {
        _uploadImageArray = [NSMutableArray array];
    }
    return _uploadImageArray;
}

+ (WLAttachmentCell *)cellWithTableView:(UITableView*)tableView
                        openAlbumAction:(void (^)(UIImagePickerController * pickerVC))action
                       photoCheckAction:(void (^)(UIImage *, NSURL *))photoCheckAction
                                canEdit:(BOOL)canEdit{
    
    WLAttachmentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLAttachmentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.canEdit = canEdit;
    cell.onOpenAlbumAction = action;
    cell.onPhotoCheckAction = photoCheckAction;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.exclusiveTouch = YES;
        self.multipleTouchEnabled = NO;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setImgArray:(NSMutableArray *)imgArray
{
    _imgArray = imgArray;

    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(100))];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    
    NSUInteger count = imgArray.count;
    CGFloat width = ScaleH(90);
    self.scrollView.contentSize = CGSizeMake(width * (count + 1) + ScaleH(10) + ScaleH(5) * count, ScaleH(100));
    
    for (int i = 0; i < count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        WLChargeUpFileObject *fileObject = self.imgArray[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:fileObject.fileUrl] placeholderImage:nil];
        imageView.frame = CGRectMake(ScaleH(10) + (width + ScaleH(5)) * i, ScaleH(5), width, width);
        imageView.userInteractionEnabled = YES;
        imageView.tag = 100 + i;
        [self.scrollView addSubview:imageView];
        
        if (self.canEdit) {
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapGestureAction:)];
            [imageView addGestureRecognizer:tapGesture];
        }
        
    }

    self.addBtn = [[UIButton alloc] init];
    [self.addBtn setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0xeff1fe)] forState:UIControlStateNormal];
    [self.addBtn setImage:[UIImage imageNamed:@"chargeup_addnewItem1"] forState:UIControlStateNormal];
    self.addBtn.frame = CGRectMake(ScaleH(10) + (width + ScaleH(5)) * count, ScaleH(5), width, width);
    [self.addBtn addTarget:self action:@selector(addNewPicture) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.addBtn];
}

- (void)imageTapGestureAction:(UITapGestureRecognizer *)gesture
{
    NSUInteger tag = gesture.view.tag;
    self.selectedTag = tag;
    if (tag < 1000) {//网络数据
        self.isLocal = NO;
        WLChargeUpFileObject *fileObject = self.imgArray[tag - 100];
        self.onPhotoCheckAction(nil, [NSURL URLWithString:fileObject.fileUrl]);
        
    }else{
        self.isLocal = YES;
        UIImage *image = self.uploadImageArray[tag - 1000];
        self.onPhotoCheckAction(image, nil);
    }
}

- (void)modifyPictureJustDelete:(BOOL)isDelete
{
    if (self.isLocal) {
        [self.uploadImageArray removeObjectAtIndex:(self.selectedTag - 1000)];
        self.editImage = nil;
        [self updateImageFrame];
    }else{
        WLChargeUpFileObject *fileObject = self.imgArray[self.selectedTag - 100];
        [WLNetworkManager deleteChargeupImageWithFileID:fileObject.fileID result:^(BOOL success, BOOL result, NSString *message) {
            if (message != nil && isDelete) {
                [[WL_TipAlert_View sharedAlert] createTip:message];
            }
            if (success && result) {
                [self.imgArray removeObjectAtIndex:self.selectedTag - 100];
                self.editImage = nil;
                [self updateImageFrame];
            }
        }];
        
    }
    if (!isDelete) {
        [self openAlubmWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
}

- (void)addNewPicture
{
    if (!self.canEdit) {
        return;
    }
    self.onOpenAlbumAction(nil);
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"更换图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
    [actionSheet showInView:self];
}


- (void)prepareForReuse
{
    [super prepareForReuse];
    for (UIView *subV in self.subviews) {
        [subV removeFromSuperview];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:{//相机
            NSString *mediaType = AVMediaTypeVideo;
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
            if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在设置-隐私-相机中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                return;
            }
            
            [self openAlubmWithSourceType:UIImagePickerControllerSourceTypeCamera];
            
        }
            break;
        case 1:{//相册

            [self openAlubmWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
            break;
            
        default:
            break;
    }
}

//压缩图片
- (UIImage *)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)openAlubmWithSourceType:(UIImagePickerControllerSourceType)sourceType
{
    
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]&&mediaTypes.count>0) {
        UIImagePickerController *imagePick = [[UIImagePickerController alloc] init];
        imagePick.mediaTypes = mediaTypes;
        imagePick.navigationBarHidden = YES;
        imagePick.allowsEditing = YES;
        imagePick.delegate = self;
        imagePick.sourceType = sourceType;
        
        self.onOpenAlbumAction(imagePick);
        
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"设备不支持" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [alert show];
    }

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];

    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        
        if ([info objectForKey:UIImagePickerControllerEditedImage]!= nil) {
            
            self.editImage = [info objectForKey:UIImagePickerControllerEditedImage];
        }else{

            self.editImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        }

        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            
            UIImageWriteToSavedPhotosAlbum(self.editImage, self, nil, NULL);
        }
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self updateImageFrame];

}

- (void)updateImageFrame
{
    NSUInteger imgCount = self.imgArray.count;
    if (self.editImage) {
        [self.uploadImageArray addObject:self.editImage];
    }
    for (UIView *subView in self.scrollView.subviews) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            [subView removeFromSuperview];
        }
    }
    
    NSUInteger count = self.uploadImageArray.count + imgCount;
    CGFloat width = ScaleH(90);
    self.scrollView.contentSize = CGSizeMake(width * (count + 1) + ScaleH(10) + ScaleH(5) * count, ScaleH(100));
    
    for (int i = 0; i < self.imgArray.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        WLChargeUpFileObject *fileObject = self.imgArray[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:fileObject.fileUrl] placeholderImage:nil];
        imageView.frame = CGRectMake(ScaleH(10) + (width + ScaleH(5)) * i, ScaleH(5), width, width);
        imageView.userInteractionEnabled = YES;
        imageView.tag = 100 + i;
        [self.scrollView addSubview:imageView];
        
        if (self.canEdit) {
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapGestureAction:)];
            [imageView addGestureRecognizer:tapGesture];
        }
        
    }
    
    for (int i = 0; i < self.uploadImageArray.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = self.uploadImageArray[i];
        imageView.frame = CGRectMake(ScaleH(10) + (width + ScaleH(5)) * (i + imgCount), ScaleH(5), width, width);
        imageView.userInteractionEnabled = YES;
        imageView.tag = 1000 + i;
        [self.scrollView addSubview:imageView];
        
        if (self.canEdit) {
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapGestureAction:)];
            [imageView addGestureRecognizer:tapGesture];
        }
        
    }
    self.addBtn.frame = CGRectMake(ScaleH(10) + (width + ScaleH(5)) * count, ScaleH(5), width, width);
}

- (NSArray *)getUploadImageArray
{
    return self.uploadImageArray;
}
@end
