//
//  WL_AddressBook_Main_SearchResult_Cell.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_Main_SearchResult_Cell.h"
#import "WL_AddressBook_SearchResult_Contact_Model.h"
#import "WL_AddressBook_SearchResult_Company_Model.h"

@interface WL_AddressBook_Main_SearchResult_Cell ()

/** 头像 */
@property(nonatomic, weak) UIImageView *iconImageView;
/** 头像Lable */
@property(nonatomic, weak) UILabel *headerImageLable;

/** 名称Lable */
@property(nonatomic, weak) UILabel *nameLable;

@end



@implementation WL_AddressBook_Main_SearchResult_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置子控件
        [self setupChildViewToSearchResultCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

#pragma mark - 设置子控件
- (void)setupChildViewToSearchResultCell
{
    //1.头像imageView
    UIImageView *iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(9);
        make.height.and.width.equalTo(@40);
    }];
    iconImageView.layer.cornerRadius = 20.0f;
    iconImageView.layer.masksToBounds = YES;
    self.iconImageView = iconImageView;
    
    UILabel *headerImageLable = [[UILabel alloc] init];
    [self.contentView addSubview:headerImageLable];
    [headerImageLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(iconImageView.mas_centerX);
        make.centerY.equalTo(iconImageView.mas_centerY);
        make.height.and.width.equalTo(@40);
    }];
    headerImageLable.layer.cornerRadius = 20.0f;
    headerImageLable.layer.masksToBounds = YES;
    headerImageLable.textAlignment = NSTextAlignmentCenter;
    
    headerImageLable.font = WLFontSize(14);
    headerImageLable.textColor = [WLTools stringToColor:@"#ffffff"];
    self.headerImageLable = headerImageLable;
    
    //2.名称Lable
    UILabel *nameLable = [[UILabel alloc] init];
    [self.contentView addSubview:nameLable];
    [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(iconImageView.mas_centerY);
        make.left.equalTo(iconImageView.mas_right).offset(19);
        make.height.equalTo(@20);
    }];
    nameLable.font = WLFontSize(16);
    self.nameLable = nameLable;
    
    //3.电话号码Lable
    
    
    //3.顶部分隔线
    UIView *lineView = [[UIView alloc] init];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(14);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_top);
        make.height.equalTo(@0.5);
    }];
    lineView.backgroundColor = [WLTools stringToColor:@"#d8d9dd"];
    
    //4.底部分隔线
    UIView *bottomLineView = [[UIView alloc] init];
    [self.contentView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@0.5);
    }];
    bottomLineView.backgroundColor = [WLTools stringToColor:@"#d8d9dd"];
    bottomLineView.hidden = YES;
    self.bottomLineView = bottomLineView;
    
}

- (void)setSearchContactModel:(WL_AddressBook_SearchResult_Contact_Model *)searchContactModel
{
    _searchContactModel = searchContactModel;
    self.nameLable.text = searchContactModel.name;
    if (searchContactModel.photo == nil || searchContactModel.photo.length == 0) {
        NSArray *array = [[NSArray alloc] initWithObjects:@"#eeb723",@"#f66d81",@"#ff7e44",@"#69c95f",@"#c670db",@"#4499ff",@"#b38979",@"#18c195",nil];
        NSMutableSet *randomSet = [[NSMutableSet alloc] init];
        
        while ([randomSet count] < 1) {
            int r = arc4random() % [array count];
            [randomSet addObject:[array objectAtIndex:r]];
        }
        NSArray *randomArray = [randomSet allObjects];
        NSString *colorStr = randomArray.lastObject;
        self.headerImageLable.backgroundColor = [WLTools stringToColor:colorStr];
        self.iconImageView.hidden = YES;
        self.headerImageLable.hidden = NO;
        NSString *headerStr = [searchContactModel.name substringFromIndex:searchContactModel.name.length - 2];
        self.headerImageLable.text = headerStr;
    }
    else
    {
        self.iconImageView.hidden = NO;
        self.headerImageLable.hidden = YES;
       [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:searchContactModel.photo] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
    }

}

- (void)setSearchCompanyModel:(WL_AddressBook_SearchResult_Company_Model *)searchCompanyModel
{
    _searchCompanyModel = searchCompanyModel;
    self.nameLable.text = searchCompanyModel.name;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:searchCompanyModel.photo] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
}
@end
