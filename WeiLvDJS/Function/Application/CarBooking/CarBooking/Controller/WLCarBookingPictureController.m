//
//  WLCarBookingPictureController.m
//  WeiLvDJS
//
//  Created by ternence on 2017/2/22.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLCarBookingPictureController.h"
#import "WLImagePicker.h"
#import "WLDataCarBookingHandler.h"

@interface WLCarBookingPictureController ()

@property (nonatomic, strong) UIBarButtonItem *rightItem;
@property (nonatomic, strong) WLImagePicker *imagePicker;
@property (nonatomic, copy) void(^onSaveAction)(NSArray *imageArray);

@end

@implementation WLCarBookingPictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupUI];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)setupNavigationBar
{
    self.title = @"行程详情";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveBtnClick)];
    self.navigationItem.rightBarButtonItem = item;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont WLFontOfSize:15];
    attrs[NSForegroundColorAttributeName] = Color1;
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    
    NSMutableDictionary *disAttrs = [NSMutableDictionary dictionary];
    disAttrs[NSFontAttributeName] = [UIFont WLFontOfSize:15];
    disAttrs[NSForegroundColorAttributeName] = Color3;
    [item setTitleTextAttributes:disAttrs forState:UIControlStateDisabled];
    
    self.rightItem = item;
    self.rightItem.enabled = YES;
    
}

- (void)setSaveAction:(void (^)(NSArray *))saveAction
{
    self.onSaveAction = saveAction;
}

- (void)setupUI{
    WLImagePicker *picker = [[WLImagePicker alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth, ScaleW(100)) pickerType:ImagePickerTypeCarBooking attachedController:self selectAction:^(NSArray *array) {
        
    }];
    [self.view addSubview:picker];
    self.imagePicker = picker;

    NSArray *tempArray = [[WLDataCarBookingHandler sharedInstance] getImageDataArray];
    [self.imagePicker updateFrameWithImageDataArray:tempArray];

}

- (void)setFillArray:(NSArray *)fillArray
{
    _fillArray = fillArray;
}

- (void)saveBtnClick{
    NSArray *imageArray = [self.imagePicker getSelectedImageArray];
    if (imageArray.count) {
        [[WLDataCarBookingHandler sharedInstance] saveCarBookingImageArray:imageArray];

    }else{
        [[WLDataCarBookingHandler sharedInstance] removeCarBookingImageArray];
    }
    self.onSaveAction([[WLDataCarBookingHandler sharedInstance] getImageDataArray]);
    [self.navigationController popViewControllerAnimated:YES];
}

@end
