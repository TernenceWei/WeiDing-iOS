//
//  WL_Chat_ViewController.m
//  WeiLvDJS
//
//  Created by zhaoxiao on 16/9/1.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Chat_ViewController.h"

@interface WL_Chat_ViewController ()

@end

@implementation WL_Chat_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //将拍摄的照片存储到本地
    self.enableSaveNewPhotoToLocalSystem = YES;
    //
    
    
}








#pragma mark - 点击方法
/** 点击cell中的消息内容的回调 */
- (void)didTapMessageCell:(RCMessageModel *)model
{
    
}

/** 点击cell中的消息内容的回调 */
- (void)didLongTouchMessageCell:(RCMessageModel *)model inView:(UIView *)view
{
    
}

/** 点击cell中的URL的回调 */
- (void)didTapUrlInMessageCell:(NSString *)url model:(RCMessageModel *)model
{
    
}

/** 点击cell中电话号码的回调 */
- (void)didTapPhoneNumberInMessageCell:(NSString *)phoneNumber model:(RCMessageModel *)model
{
    
}
/** 点击cell中的头像的回调 */
- (void)didTapCellPortrait:(NSString *)userId
{
    
}
/** 长按cell中的头像的回调 */
- (void)didLongPressCellPortrait:(NSString *)userId
{
    
}




@end
