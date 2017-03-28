//
//  WL_AddressBook_MyAddressBook_Cell.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/8.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_MyAddressBook_Cell.h"
#import "WL_AddressBook_Content_Model.h"
#import "WL_AddressBook_MyAddressBook_SearchContent_Model.h"
@interface WL_AddressBook_MyAddressBook_Cell ()

@property (nonatomic,strong) UIImageView *headerImageview;

@property (nonatomic,strong) UILabel *headerImageLable;

//@property (nonatomic,strong) UILabel *nameLabel;

//@property (nonatomic,strong) UILabel *phoneLabel;



//@property (nonatomic,strong) UIButton *addButton;

//@property (nonatomic,strong) UIImageView *selectHeaderImage;
@end

@implementation WL_AddressBook_MyAddressBook_Cell

- (UIImageView *)headerImageview{
    
    if (!_headerImageview) {
        _headerImageview = [[UIImageView alloc]init];
        [self.contentView addSubview:_headerImageview];
    }
    return _headerImageview;
}

- (UILabel *)nameLabel{
    
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [WLTools stringToColor:@"#2f2f2f"];
        _nameLabel.font = WLFontSize(15);
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)phoneLabel {
    
    if (!_phoneLabel) {
        
        _phoneLabel = [UILabel new];
        _phoneLabel.textColor = [WLTools stringToColor:@"#868686"];
        _phoneLabel.font = WLFontSize(12);
        [self.contentView addSubview:_phoneLabel];
        
    }
    
    return _phoneLabel;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [WLTools stringToColor:@"#f1f1f1"];
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
}




- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
    
}

- (void)setUpViews{
    
    
    [self.headerImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.contentView.mas_centerY);
        
        make.left.equalTo(self.contentView.mas_left).offset(12.5);
        
        make.width.and.height.equalTo(@42);
        
        
    }];
    self.headerImageview.layer.cornerRadius = 21;
    self.headerImageview.layer.masksToBounds = YES;
    
    self.headerImageLable = [[UILabel alloc] init];
    [self.headerImageview addSubview:self.headerImageLable];
    [self.headerImageLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerImageview.mas_centerX);
        make.centerY.equalTo(self.headerImageview.mas_centerY);
        make.height.equalTo(@18);
    }];
    
    self.headerImageLable.font = WLFontSize(14);
    self.headerImageLable.textColor = [WLTools stringToColor:@"#ffffff"];

    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).offset(13);
        make.left.equalTo(self.headerImageview.mas_right).offset(13);
        make.height.equalTo(@18);
        make.right.lessThanOrEqualTo(self.contentView.mas_right).offset(-150);
    }];
    
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-11);
        make.left.equalTo(self.nameLabel.mas_left);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(72);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@1);
    }];
    

    
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    
    [UIView commitAnimations];
    
}

- (void)changeSelectedState
{
    _isSelected = !_isSelected;
    [self setNeedsLayout];
}


- (void)configCellWithModel:(WL_AddressBook_Content_Model *)model{
    
    self.nameLabel.text = model.name;
    self.phoneLabel.text = model.phone;
    NSArray *array = [[NSArray alloc] initWithObjects:@"#eeb723",@"#f66d81",@"#ff7e44",@"#69c95f",@"#c670db",@"#4499ff",@"#b38979",@"#18c195",nil];
    NSMutableSet *randomSet = [[NSMutableSet alloc] init];
    
    while ([randomSet count] < 1) {
        int r = arc4random() % [array count];
        [randomSet addObject:[array objectAtIndex:r]];
    }
    
    NSArray *randomArray = [randomSet allObjects];
    NSString *colorStr = randomArray.lastObject;
    
    
    
    self.headerImageview.backgroundColor = [WLTools stringToColor:colorStr];
    NSString *fullName = model.name;
    if (fullName.length <= 2)
    {
        self.headerImageLable.text = fullName;
    }
    else
    {
        self.headerImageLable.text = [fullName substringFromIndex:(fullName.length - 2)];
    }
    
    
    
    self.userInteractionEnabled = YES;
    
}

- (void)hideInfo
{
//    self.addLabel.hidden = YES;
//    self.addButton.hidden = YES;
//    self.userInteractionEnabled = YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setSearchContent:(WL_AddressBook_MyAddressBook_SearchContent_Model *)searchContent
{
    _searchContent = searchContent;
    if (searchContent.firstName == nil && searchContent.lastName == nil) {
        self.nameLabel.text = searchContent.phone;
    }
    else if (searchContent.firstName == nil && searchContent.lastName != nil)
    {
        self.nameLabel.text = searchContent.lastName;
    }
    else if (searchContent.firstName != nil && searchContent.lastName == nil)
    {
        self.nameLabel.text = searchContent.firstName;
    }
    else
    {
         self.nameLabel.text = [NSString stringWithFormat:@"%@%@", searchContent.firstName, searchContent.lastName];
    }
   
    self.phoneLabel.text = searchContent.phone;
    NSArray *array = [[NSArray alloc] initWithObjects:@"#eeb723",@"#f66d81",@"#ff7e44",@"#69c95f",@"#c670db",@"#4499ff",@"#b38979",@"#18c195",nil];
    NSMutableSet *randomSet = [[NSMutableSet alloc] init];
    
    while ([randomSet count] < 1) {
        int r = arc4random() % [array count];
        [randomSet addObject:[array objectAtIndex:r]];
    }
    
    NSArray *randomArray = [randomSet allObjects];
    NSString *colorStr = randomArray.lastObject;
    
    
    
    self.headerImageview.backgroundColor = [WLTools stringToColor:colorStr];
    NSString *fullName = self.nameLabel.text;
    if (fullName.length <= 2)
    {
        self.headerImageLable.text = fullName;
    }
    else
    {
        self.headerImageLable.text = [fullName substringFromIndex:(fullName.length - 2)];
    }
    

    
}





@end
