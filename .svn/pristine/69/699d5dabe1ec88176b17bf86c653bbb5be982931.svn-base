//
//  WL_AddressBook_DepartMent_Cell.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/10.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_DepartMent_Cell.h"
#import "WL_AddressBook_LinkMan_Company_Model.h"
#import "WL_AddressBook_LinkMan_Department_Model.h"

@implementation WL_AddressBook_DepartMent_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupChildViewToDpeartMentCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupChildViewToDpeartMentCell
{
    //左侧标题Lable
    UILabel *titleLable = [[UILabel alloc] init];
    [self.contentView addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    titleLable.font = WLFontSize(15);
    titleLable.textColor = [WLTools stringToColor:@"#2f2f2f"];
    self.titleLable = titleLable;
    
    //右侧信息Lable
    UILabel *messageLable = [[UILabel alloc] init];
    [self.contentView addSubview:messageLable];
    [messageLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLable.mas_right).offset(52);
        make.centerY.equalTo(titleLable.mas_centerY);
        make.height.equalTo(@15);
    }];
    messageLable.font = WLFontSize(12);
    messageLable.textColor = [WLTools stringToColor:@"#2f2f2f"];
    self.messageLable = messageLable;
    
    //4.底部分隔线
    UIView *lineView = [[UIView alloc] init];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(14);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@0.5);
    }];
    lineView.backgroundColor = [WLTools stringToColor:@"#d4d4d4"];
    self.lineView = lineView;
}


- (void)setCompanyModel:(WL_AddressBook_LinkMan_Company_Model *)companyModel
{
    _companyModel = companyModel;
    self.titleLable.text = @"职位";
    //职位名称
    self.messageLable.text = companyModel.position_name;
    
    
}

- (void)setDepartmentModel:(WL_AddressBook_LinkMan_Department_Model *)departmentModel
{
    _departmentModel = departmentModel;
    self.titleLable.text = @"部门";
    //部门名称
    self.messageLable.text = departmentModel.department_name;
}


@end
