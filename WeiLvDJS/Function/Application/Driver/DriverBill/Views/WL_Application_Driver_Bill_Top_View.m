//
//  WL_Application_Driver_Bill_Top_View.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/19.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_Bill_Top_View.h"


@interface WL_Application_Driver_Bill_Top_View ()


@end
@implementation WL_Application_Driver_Bill_Top_View

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置内容子控件
        [self setupContentViewToDriverBillTopView];
        self.backgroundColor = [WLTools stringToColor:@"#fff3b8"];;
    }
    return self;
}
#pragma mark - 设置内容子控件
- (void)setupContentViewToDriverBillTopView
{
    //添加关闭按钮
    UIButton *closeButton = [[UIButton alloc] init];
    //添加到父控件
    [self addSubview:closeButton];
    //设置属性
    [closeButton setImage:[UIImage imageNamed:@"Driver_Order_Close"] forState:UIControlStateNormal];
    //添加约束
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-ScaleW(12));
        make.centerY.equalTo(self.mas_centerY);
    }];
    self.closeButton = closeButton;
    
    //设置订单页面内容
    UILabel *promptLable = [[UILabel alloc] init];
    //添加到父控件
    [self addSubview:promptLable];
    //设置属性
    promptLable.textColor = [WLTools stringToColor:@"#fb8200"];
    promptLable.text = @"提示:  拒单率太高,会导致派单变少哦!";
    promptLable.font = WLFontSize(14);
    promptLable.numberOfLines = 0;
    //添加约束
    [promptLable mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.mas_left).offset(ScaleW(12));
         make.centerY.equalTo(closeButton.mas_centerY);
     }];
    self.promptLable = promptLable;

}

@end
