//
//  WLBaseShowView.m
//  Show
//
//  Created by whw on 16/11/30.
//  Copyright © 2016年 huhanhui. All rights reserved.
//

#import "WLBaseShowView.h"


@interface WLBaseShowView ()
/** 内容的View */
@property (nonatomic, weak) UIView *contentView;
/** 是否点击屏幕外消失 */
@property (nonatomic, assign) BOOL canTouchDismiss;
/** 点击回调 */
@property (nonatomic, copy) void(^callBlackBlock)();
/** 保存内容View的最大Y值 */
@property (nonatomic, assign) CGFloat maxY;
@end
static WLBaseShowView *instance = nil;
@implementation WLBaseShowView

+ (instancetype)sharedBaseShowView
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[WLBaseShowView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        instance.backgroundColor = [UIColor darkGrayColor];
        instance.alpha = 0.6;
        
    });
    return instance;
}
- (void)showWithContentView:(UIView *)contentView andTouch:(BOOL)canTouchDismiss andCallBlack:(void(^)())callblack
{
    self.callBlackBlock = callblack;
    self.canTouchDismiss = canTouchDismiss;
    //将之前的弹框移除掉
    [self removeFromSuperview];
    _contentView = nil;
    _contentView = contentView;
    //拿到当前的窗口
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview: self];
    
//动画1
//    CGPoint tempCenter = CGPointMake(self.center.x, self.center.y - 300);
//    contentView.center = tempCenter;
//    [window addSubview:contentView];
//    //usingSpringWithDamping: 弹力系数, 从0-1, 越小越弹
//    //Velocity 重力系数 9.8
//    [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:10 options:0 animations:^{
//        contentView.center = self.center;
//    } completion:nil];

//动画2
    contentView.center = self.center;
    contentView.transform = CGAffineTransformScale(contentView.transform, 0.7, 0.7);
    contentView.alpha = 0;
    [window addSubview:contentView];
    
    [UIView animateWithDuration:0.5 animations:^{
        contentView.alpha = 1;
        contentView.transform = CGAffineTransformIdentity;
    }];
    
}
/** 点击阴影让弹框消失 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    if(!self.canTouchDismiss)
    {
        return;
    }
    
    if (self.callBlackBlock)
    {
        self.callBlackBlock();
    }
    UITouch *touch = touches.anyObject;
    if([touch.view isEqual:KWLBaseShowView])
    {
    
        [UIView animateWithDuration:0.3 animations:^{
            [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [self removeFromSuperview];
            [_contentView removeFromSuperview];
        }];
    }
}
/** 手动去掉弹框 */
- (void)dismiss
{
    if (self.callBlackBlock)
    {
        self.callBlackBlock();
    }
    //当可以点击屏幕外消失时,不让调这个方法
    if (self.canTouchDismiss)
    {
        return;
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self removeFromSuperview];
        [_contentView removeFromSuperview];
          _contentView = nil;
    }];
}

- (void)showContentView:(UIView *)contentView
{
    [self showWithContentView:contentView andTouch:YES andCallBlack:nil];
}
/** 注册与移除键盘通知 */
- (void)willMoveToWindow:(UIWindow *)newWindow
{
    
    if([newWindow isEqual:[UIApplication sharedApplication].keyWindow])
    {
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
    }else
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    
}

/** 键盘frame改变调用的方法 */
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    
    // 取出键盘最终的frame
    CGFloat keyBoardY = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    // 取出键盘弹出需要花费的时间
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    self.maxY = CGRectGetMaxY(self.contentView.frame);
    if (self.maxY > keyBoardY)
    {
        
        CGFloat ty = self.maxY - keyBoardY;
        // 修改transform
        [UIView animateWithDuration:duration animations:^{
            _contentView.transform = CGAffineTransformTranslate(_contentView.transform, 0, - (ty+10));
        }];
    }
    //复原
    if (keyBoardY == [UIScreen mainScreen].bounds.size.height)
    {
        [UIView animateWithDuration:duration animations:^{
            _contentView.transform = CGAffineTransformIdentity;
        }];
    }
    
}
@end
