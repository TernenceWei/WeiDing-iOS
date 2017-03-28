//
//  WL_Mine_Setting_Acount_Cell.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/12.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Mine_Setting_Account_Cell.h"

@interface WL_Mine_Setting_Account_Cell ()

/** 右侧指示器 */
@property(nonatomic, weak)UIImageView *slider;


@end

@implementation WL_Mine_Setting_Account_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置账户与安全的cell的子控件
        [self setupChildViewToAccount];
        //设置cell点击不变灰
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

#pragma mark - 设置账户与安全的cell的子控件
- (void)setupChildViewToAccount
{
    //设置cell的左侧文字标题
    [self setupTitleToAccountCell];
    //设置cell的右侧指示器
    [self setupSliderToAccountCell];
    //设置cell的右侧提示Button
    [self setupPromptToAccountCell];
    //设置cell底部分隔线
    [self setupLineToAccountCell];
}

#pragma mark - 设置cell的左侧文字标题
- (void)setupTitleToAccountCell
{
    //初始化
    UILabel *titleLable = [[UILabel alloc] init];
    //添加到父控件
    [self.contentView addSubview:titleLable];
    //设置属性
    titleLable.textColor = [WLTools stringToColor:@"#474747"];
    titleLable.font = WLFontSize(15);
    titleLable.textAlignment = NSTextAlignmentLeft;
    //添加约束
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(13);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    self.titleLable = titleLable;
    
}

#pragma mark - 设置cell的右侧指示器
- (void)setupSliderToAccountCell
{
    //初始化
    UIImageView *slider = [[UIImageView alloc] init];
    //添加到父控件
    [self.contentView addSubview:slider];
    //设置属性
    slider.image = [UIImage imageNamed:@"arrow"];
    //添加约束
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-13);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.equalTo(@16);
        make.width.equalTo(@9);
    }];
    self.slider = slider;
}
#pragma mark - 设置cell的右侧提示是否保护
- (void)setupPromptToAccountCell
{
    //提示是否保护按钮
    UIButton *promptButton = [[UIButton alloc] init];
    
    //添加到父控件
    [self.contentView addSubview:promptButton];
    //设置属性
    //1.不可与用户交互
    promptButton.userInteractionEnabled = NO;
    //2,设置promptButton的字体属性
    [promptButton setTitle:@"已保护" forState:UIControlStateNormal];
    [promptButton setTitleColor:WLColor(176, 183, 193, 1) forState:UIControlStateNormal];
    promptButton.titleLabel.textAlignment = NSTextAlignmentRight;
    promptButton.titleLabel.font = WLFontSize(14);
    [promptButton setImage:[UIImage imageNamed:@"SetProtect"] forState:UIControlStateNormal];
    //3,设置偏移量
    [promptButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [promptButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 12, 0, 0)];
    
    //添加约束
    [promptButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.slider.mas_left).offset(-14);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.equalTo(self.contentView.mas_height);
        make.width.equalTo(@80);
    }];
    //默认隐藏
    promptButton.hidden = YES;
    self.promptButton = promptButton;
}

#pragma mark - 设置cell底部分隔线
- (void)setupLineToAccountCell
{
    UIView *line = [[UIView alloc] init];
    [self.contentView addSubview:line];
    //设置属性
    line.backgroundColor = [WLTools stringToColor:@"#d8d9dd"];
    line.hidden = YES;
    //添加约束
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    self.line = line;
}
@end
