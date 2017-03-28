
//
//  WL_Application_Driver_OrderDetailCell4.m
//  WeiLvDJS
//
//  Created by whw on 16/12/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_OrderDetailCell4.h"

@interface WL_Application_Driver_OrderDetailCell4 ()

@end

@implementation WL_Application_Driver_OrderDetailCell4
static NSString *identifier = @"OrderDetailCell4";
#pragma mark - 重写构造方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置子控件
        [self setupUI];
        //设置cell点击不变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    }
    return self;
}

- (void)setupUI
{
    UILabel *commentLabel = [[UILabel alloc]init];
    
//    commentLabel.text = @"有三个小孩,不吃辣的";
    commentLabel.textColor = Color2;
    commentLabel.font = [UIFont WLFontOfSize:14];
    commentLabel.numberOfLines = 0;
    [self.contentView addSubview:commentLabel];
    
    [commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(ScaleW(12));
        make.right.equalTo(self.contentView).offset(-ScaleW(12));
        make.bottom.equalTo(self.contentView).offset(-ScaleH(13.5));
    }];
    self.commentLabel = commentLabel;
    
}

+ (instancetype)cellForTableView:(UITableView *)tableView
{
    WL_Application_Driver_OrderDetailCell4 *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[WL_Application_Driver_OrderDetailCell4 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
@end
