//
//  WL_Application_Driver_inforMation_TableViewCell0.m
//  WeiLvDJS
//
//  Created by jyc on 2016/11/1.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_inforMation_TableViewCell0.h"

@implementation WL_Application_Driver_inforMation_TableViewCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    
    return self;
}
- (void)setupUI
{
    UIImageView *tipImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"prompt"]];
    UILabel *noPassLabel = [[UILabel alloc]init];
    self.noPassReasonLabel = [[UILabel alloc]init];
    
    noPassLabel.font = [UIFont WLFontOfSize:14];
    noPassLabel.textColor = [WLTools stringToColor:@"#f7585e"];
    noPassLabel.text = @"未通过原因";
    self.noPassReasonLabel.font = [UIFont WLFontOfSize:14];
    self.noPassReasonLabel.textColor = Color3;
    self.noPassReasonLabel.numberOfLines = 0;
    
    [self.contentView addSubview:tipImageView];
    [self.contentView addSubview:noPassLabel];
    [self.contentView addSubview:self.noPassReasonLabel];
    
    [tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(ScaleH(15));
        make.left.equalTo(self.contentView).offset(ScaleW(20));
    }];
    
    [noPassLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(tipImageView.mas_right).offset(ScaleW(10));
        make.centerY.equalTo(tipImageView);
    }];
    [self.noPassReasonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(ScaleW(20));
        make.top.equalTo(noPassLabel.mas_bottom).offset(15);
        make.right.equalTo(self.contentView).offset(-ScaleW(10));
        make.bottom.equalTo(self.contentView).offset(-ScaleH(15));
    }];
}
@end
