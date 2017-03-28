//
//  WL_Applicaton_Main_Content_Cell.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Applicaton_Main_Content_Cell.h"

@implementation WL_Applicaton_Main_Content_Cell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //创建cell的子视图
        self.contentView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
        [self setupChildViewToApplicationContentCell];
    }
    return self;
}

#pragma mark - 创建cell的子视图
- (void)setupChildViewToApplicationContentCell
{
    //图标图片
    //初始化
    UIImageView *iconImageView = [[UIImageView alloc] init];
    //将图标图片添加到父控件上
    [self.contentView addSubview:iconImageView];
    //设置属性
    self.iconImageView = iconImageView;

    //添加约束
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);

    }];
    
   
    //应用标题Lable
    UILabel *functionLable = [[UILabel alloc] init];
    //添加到父控件
    [self.contentView addSubview:functionLable];
    //设置属性
    functionLable.font = WLFontSize(15);
    functionLable.textColor = [WLTools stringToColor:@"#333333"];
    functionLable.textAlignment = NSTextAlignmentCenter;
    
    //添加约束
    [functionLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconImageView.mas_bottom).offset(12);
        make.centerX.equalTo(iconImageView.mas_centerX);
        make.bottom.equalTo(self.contentView).offset(-ScaleH(31));
    }];
    self.functionLable = functionLable;
    
    //认证imageView
    //初始化
    UIImageView *certificationImageView = [[UIImageView alloc] init];
    UIImageView *failedImageView = [[UIImageView alloc]init];
    //添加到父控件
    [self.contentView addSubview:certificationImageView];
    [self.contentView addSubview:failedImageView];
    //添加约束
    [certificationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(functionLable.mas_centerY);
        make.left.equalTo(functionLable.mas_right).offset(4);
    }];
    
    [failedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(functionLable.mas_bottom).offset(5);
    }];
    
    certificationImageView.image = [UIImage imageNamed:@"renzheng"];

    failedImageView.image = [UIImage imageNamed:@"renzhengshibai"];

    
    certificationImageView.hidden = YES;
    failedImageView.hidden = YES;
    self.certificationImageView = certificationImageView;
    self.failedImageView = failedImageView;
    
    //认证状态
    UIImageView *certificationStatusImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:certificationStatusImageView];
    
    [certificationStatusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
    }];
    certificationStatusImageView.hidden = YES;
    certificationStatusImageView.image = [UIImage imageNamed:@"shenghezhong"];
    self.certificationStatusImageView = certificationStatusImageView;
    
    /**< 遮罩 */
    UIView *maskView = [[UIView alloc]init];
    [self.contentView addSubview:maskView];
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    maskView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    self.maskView = maskView;
    self.maskView.hidden = YES;
    
}
- (void)setDriverStatus:(WLDriverStatus)driverStatus
{
    _driverStatus = driverStatus;
    [self dealWithStatus:driverStatus];
}
- (void)setCarStaus:(WLCarStatus)carStaus
{
    _carStaus = carStaus;
    [self dealWithStatus:carStaus];
}
#pragma mark -隐藏认证状态图片
- (void)hideStatus
{
    self.failedImageView.hidden = YES;
    self.certificationImageView.hidden = YES;
    self.certificationStatusImageView.hidden = YES;
}
#pragma mark -认证状态
- (void)dealWithStatus:(NSInteger)status
{
    [self hideStatus];
    self.maskView.hidden = YES;
    switch (status)
    {
            
        case -1://未认证
            self.certificationStatusImageView.image = [UIImage imageNamed:@"weurengzheng"];
            self.certificationStatusImageView.hidden = NO;
            break;
        case 0://审核中
            self.certificationStatusImageView.image = [UIImage imageNamed:@"shenghezhong"];
            self.certificationStatusImageView.hidden = NO;
            break;
        case 1://已认证
            self.certificationStatusImageView.hidden = YES;
            self.certificationImageView.hidden = NO;
            break;
        case 2://认证失败
            self.failedImageView.image = [UIImage imageNamed:@"renzhengshibai"];
            self.failedImageView.hidden = NO;
            break;
        case 3://已禁用
            self.certificationStatusImageView.image = [UIImage imageNamed:@"yijingyong"];
            self.certificationStatusImageView.hidden = NO;
            self.functionLable.textColor = [WLTools stringToColor:@"#929292"];
            self.iconImageView.image = [UIImage imageNamed:@"jinyongcheliang"];
            self.certificationImageView.hidden = YES;
            break;
        default:
            break;
    }
}
@end
