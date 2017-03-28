//
//  WL_AddressBook_ChangeRemarkName_Field.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/11.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_ChangeRemarkName_Field.h"

@implementation WL_AddressBook_ChangeRemarkName_Field

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupContentViewToChangeRemarkNameField];
    }
    return self;
}

- (void)setupContentViewToChangeRemarkNameField
{
    UILabel *placeholderLable = [[UILabel alloc] init];
    [self addSubview:placeholderLable];
    [placeholderLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.centerY.equalTo(self.mas_centerY);
    }];
    placeholderLable.font = WLFontSize(14);
    placeholderLable.textColor = [WLTools stringToColor:@"#b0b7c1"];
    placeholderLable.text = @"请输入十字以内的备注名";
    self.placeholderLable = placeholderLable;
    self.textColor = [WLTools stringToColor:@"#868686"];
    
    
}

@end
