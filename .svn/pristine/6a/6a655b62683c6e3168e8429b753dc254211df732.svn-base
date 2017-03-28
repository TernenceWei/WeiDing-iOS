//
//  WL_AddressBook_Organization_Department_Cell.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_Organization_Department_Cell.h"

#import "WL_AddressBook_Organization_Department_Model.h"

@interface WL_AddressBook_Organization_Department_Cell ()

@property(nonatomic, weak) UILabel *departmentNameLable;

@property(nonatomic, weak) UILabel *staffNumLable;

@end

@implementation WL_AddressBook_Organization_Department_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置子控件
        [self setupContentViewToDepartmentCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupContentViewToDepartmentCell
{
    //1.添加左侧的Lable
    UILabel *departmentNameLable = [[UILabel alloc] init];
    [self.contentView addSubview:departmentNameLable];
    [departmentNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(9);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.equalTo(@20);
    }];
    departmentNameLable.font = WLFontSize(16);
    departmentNameLable.textColor = [WLTools stringToColor:@"#2f2f2f"];
    self.departmentNameLable = departmentNameLable;
    
    //2.右侧指示器
    UIImageView *sliderImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
    [self.contentView addSubview:sliderImageView];
    [sliderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-12.5);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    //3.右侧部门人数Lable
    UILabel *staffNumLable = [[UILabel alloc] init];
    [self.contentView addSubview:staffNumLable];
    [staffNumLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(sliderImageView.mas_left).offset(-14);
        make.centerY.equalTo(sliderImageView.mas_centerY);
    }];
    staffNumLable.font = WLFontSize(14);
    staffNumLable.textColor = [WLTools stringToColor:@"#879efa"];
    self.staffNumLable = staffNumLable;
    //4.添加底部分隔线
    UIView *lineView = [[UIView alloc] init];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(7.5);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@0.5);
    }];
    lineView.backgroundColor = [WLTools stringToColor:@"#d8d9dd"];
    self.lineView = lineView;
}

- (void)setDepartmentModel:(WL_AddressBook_Organization_Department_Model *)departmentModel
{
    _departmentModel = departmentModel;
    self.departmentNameLable.text = departmentModel.department_name;
    self.staffNumLable.text = departmentModel.total_staff;
    
    
}

@end
