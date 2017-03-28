//
//  WL_Application_Driver_Bill_Companys_Cell.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/10/9.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_Bill_Companys_Cell.h"
#import "WL_Application_Driver_Bill_Statistics_Company_Model.h"

@interface WL_Application_Driver_Bill_Companys_Cell ()
/** 所占比例Lable */
@property(nonatomic, weak)UILabel *scaleLable;

@end

@implementation WL_Application_Driver_Bill_Companys_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置子控件
        [self setupChildViewToBillCompanysCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

#pragma mark - 设置子控件
- (void)setupChildViewToBillCompanysCell
{
    //左侧的色块View
    UIView *colorView = [[UIView alloc] init];
    //添加到父控件
    [self.contentView addSubview:colorView];
    //添加约束
    [colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.equalTo(@14);
        make.width.equalTo(@14);
    }];
    //设置属性
    colorView.layer.cornerRadius = 2.0f;
    colorView.layer.masksToBounds = YES;
    self.colorView = colorView;
    //测试数据
    colorView.backgroundColor = [UIColor redColor];
    //中间的车队Lable
    UILabel *companysLable = [[UILabel alloc] init];
    [self.contentView addSubview:companysLable];
    //添加约束
    [companysLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(colorView.mas_centerY);
        make.left.equalTo(colorView.mas_right).offset(10 * AUTO_IPHONE6_WIDTH_375);
        make.width.equalTo(@(100 * AUTO_IPHONE6_WIDTH_375));
    }];
    //设置属性
    companysLable.font = WLFontSize(14);
    companysLable.textAlignment = NSTextAlignmentLeft;
    companysLable.textColor = WLColor(111, 115, 120, 1);
    self.companysLable = companysLable;
//    //测试数据
//    companysLable.text = @"南阳去哪儿网股份有限公司郑州分公司";
    
    //所占比例Lable
    UILabel *scaleLable = [[UILabel alloc] init];
    //添加到父控件
    [self.contentView addSubview:scaleLable];
    //添加约束
    [scaleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right);
    }];
    //设置属性
    scaleLable.font = WLFontSize(14);
    scaleLable.textAlignment = NSTextAlignmentRight;
    scaleLable.textColor = WLColor(47, 47, 47, 1);
    self.scaleLable = scaleLable;
    
}


- (void)setCompanyModel:(WLDriverBillStatisticsProportionObject *)companyModel
{
    _companyModel = companyModel;
    
    self.scaleLable.text = self.companyModel.percent;
    self.companysLable.text = self.companyModel.company_name;
    
    
}

@end
