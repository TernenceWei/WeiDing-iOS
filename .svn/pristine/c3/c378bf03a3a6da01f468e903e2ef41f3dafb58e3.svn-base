//
//  WL_AddressBook_Organization_Staff_Cell.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_Organization_Staff_Cell.h"
#import "WL_AddressBook_Organization_Staff_Model.h"
#import "WL_AddressBook_Organization_Search_Staff_Model.h"

@interface WL_AddressBook_Organization_Staff_Cell ()



@property(nonatomic, weak) UILabel *positionLable;

@property(nonatomic, weak) UIImageView *iconImageView;


@end

@implementation WL_AddressBook_Organization_Staff_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置子控件
        [self setupContentViewToStaffCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


- (void)setupContentViewToStaffCell
{
    //1左侧头像
    UIImageView *iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(11);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.and.width.equalTo(@40);
    }];
    iconImageView.layer.cornerRadius = 20.0f;
    iconImageView.layer.masksToBounds = YES;
    self.iconImageView = iconImageView;
    
    //2.右侧指示器
    UIImageView *sliderImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
    [self.contentView addSubview:sliderImageView];
    [sliderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-12.5);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    //3. 姓名lable
    UILabel *nameLable = [[UILabel alloc] init];
    [self.contentView addSubview:nameLable];
    [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(11);
        make.left.equalTo(self.contentView.mas_left).offset(64.5);
        make.height.equalTo(@18);
    }];
    nameLable.font = WLFontSize(14);
//    nameLable.textColor = [WLTools stringToColor:@"#2f2f2f"];
    self.nameLable = nameLable;
    
    //4.职位Lable
    UILabel *positionLable = [[UILabel alloc] init];
    [self.contentView addSubview:positionLable];
    [positionLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(31);
        make.left.equalTo(self.contentView.mas_left).offset(64.5);
        make.height.equalTo(@18);
    }];
    positionLable.font = WLFontSize(14);
    positionLable.textColor = [WLTools stringToColor:@"#868686"];
    self.positionLable = positionLable;
    
    //5.添加底部分隔线
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

- (void)setStaffModel:(WL_AddressBook_Organization_Staff_Model *)staffModel
{
    _staffModel = staffModel;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:staffModel.photo] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
    self.nameLable.text = staffModel.real_name;
    self.positionLable.text = staffModel.position_name;
    //如果是自己的话,就高亮显示
    if ([staffModel.user_id isEqualToString:[WLUserTools getUserId]])
    {
        self.nameLable.textColor = [WLTools stringToColor:@"#879efa"] ;
    }
    else
    {
        self.nameLable.textColor = [WLTools stringToColor:@"#2f2f2f"];
    }
  
}

- (void)setSearchModel:(WL_AddressBook_Organization_Search_Staff_Model *)searchModel
{
    _searchModel = searchModel;
    //头像
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:searchModel.photo] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
    //姓名
    if ([searchModel.real_name isEqualToString:@""] || searchModel.real_name == nil)
    {
        self.nameLable.text = searchModel.user_name;
    }
    else
    {
        self.nameLable.text = searchModel.real_name;
    }

    //职位
    self.positionLable.text = searchModel.position_name;
    
    
    
}

@end
