//
//  WLPhotoCheckView.m
//  WeiLvDJS
//
//  Created by ternence on 16/11/7.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLPhotoCheckView.h"
#import "UIImageView+WebCache.h"

@interface WLPhotoCheckView ()
@property (nonatomic, copy) void(^onTapAction)();
@property (nonatomic, copy) void(^onModifyAction)(BOOL isDelete);
@end

@implementation WLPhotoCheckView
- (instancetype)initWithFrame:(CGRect)frame
                        image:(UIImage *)image
                     imageUrl:(NSURL *)imageUrl
                    tapAction:(void (^)())tapAction
                 modifyAction:(void (^)(BOOL isDelete))modifyAction
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        UIImageView *imageView = [[UIImageView alloc] init];
        if (image) {
            imageView.image = image;
        }else{
           [imageView sd_setImageWithURL:imageUrl placeholderImage:nil];
        }
        imageView.bounds = CGRectMake(0, 0, ScreenWidth, ScreenWidth);
        imageView.center = self.center;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
        
        self.onTapAction = tapAction;
        self.onModifyAction = modifyAction;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction)];
        [self addGestureRecognizer:tapGesture];
        
        UIButton *modifyBtn = [[UIButton alloc] init];
        [modifyBtn setTitle:@"更改" forState:UIControlStateNormal];
        [modifyBtn setTitleColor:HEXCOLOR(0x879efb) forState:UIControlStateNormal];
        modifyBtn.titleLabel.font = [UIFont WLFontOfSize:16];
        modifyBtn.frame = CGRectMake(ScreenWidth - ScaleW(80), 20, ScaleW(60), ScaleH(50));
        modifyBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [modifyBtn addTarget:self action:@selector(modifyThePicture:) forControlEvents:UIControlEventTouchUpInside];
        modifyBtn.tag = 0;
        [self addSubview:modifyBtn];
        
        UIButton *deleteBtn = [[UIButton alloc] init];
        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [deleteBtn setTitleColor:HEXCOLOR(0x879efb) forState:UIControlStateNormal];
        deleteBtn.titleLabel.font = [UIFont WLFontOfSize:16];
        deleteBtn.frame = CGRectMake(ScaleW(20), 20, ScaleW(60), ScaleH(50));
        deleteBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [deleteBtn addTarget:self action:@selector(modifyThePicture:) forControlEvents:UIControlEventTouchUpInside];
        deleteBtn.tag = 1;
        [self addSubview:deleteBtn];
        
    }
    return self;
}

- (void)tapGestureAction
{
    self.onTapAction();
}

- (void)modifyThePicture:(UIButton *)button
{
    BOOL isDelete = NO;
    if (button.tag == 1) {
        isDelete = YES;
    }
    self.onModifyAction(isDelete);

}
@end
