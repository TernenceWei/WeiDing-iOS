//
//  WL_AddressBook_MyAddressBook_Linkman_View.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/16.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_MyAddressBook_Linkman_View.h"

@implementation WL_AddressBook_MyAddressBook_Linkman_View

- (instancetype)initWithFrame:(CGRect)frame withName:(NSString *)name withMobile:(NSString *)mobile
{
    if (self = [super initWithFrame:frame]) {
        //设置子界面
        [self setupContentViewToMyAddressBookLinkmanWithName:name withMobile:mobile];
    }
    return self;
}


#pragma mark - 设置子界面
- (void)setupContentViewToMyAddressBookLinkmanWithName:(NSString *)name withMobile:(NSString *)mobile
{
    //1.头像Lable
    UILabel *iconImageLable = [[UILabel alloc] init];
    [self addSubview:iconImageLable];
    [iconImageLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(14);
        make.centerY.equalTo(self.mas_centerY);
        make.width.and.height.equalTo(@42);
    }];
    iconImageLable.layer.cornerRadius = 21.0f;
    iconImageLable.layer.masksToBounds = YES;
    iconImageLable.textAlignment = NSTextAlignmentCenter;
    iconImageLable.textColor = [WLTools stringToColor:@"#ffffff"];
    iconImageLable.font = WLFontSize(14);
    //解决通讯录名字为一个文字 越界导致的崩溃
    if (name.length <= 2)
    {
        iconImageLable.text = name;
    }else {
       iconImageLable.text = [name substringFromIndex:name.length - 2];
    }
//    iconImageLable.backgroundColor = [WLTools stringToColor:@"#ff0000"];
    NSArray *array = [[NSArray alloc] initWithObjects:@"#eeb723",@"#f66d81",@"#ff7e44",@"#69c95f",@"#c670db",@"#4499ff",@"#b38979",@"#18c195",nil];
    NSMutableSet *randomSet = [[NSMutableSet alloc] init];
    
    while ([randomSet count] < 1) {
        int r = arc4random() % [array count];
        [randomSet addObject:[array objectAtIndex:r]];
    }
    
    NSArray *randomArray = [randomSet allObjects];
    NSString *colorStr = randomArray.lastObject;
    
    
    
    iconImageLable.backgroundColor = [WLTools stringToColor:colorStr];
    
    
    //2.姓名
    UILabel *nameLable = [[UILabel alloc] init];
    [self addSubview:nameLable];
    [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(69);
        make.top.equalTo(self.mas_top).offset(33);
        make.height.equalTo(@18);
    }];
    nameLable.font = WLFontSize(15);
    nameLable.textColor = [WLTools stringToColor:@"#b2b2b2"];
    nameLable.text = name;
    
    //3.电话号码Lable
    UILabel *mobileNum = [[UILabel alloc] init];
    [self addSubview:mobileNum];
    [mobileNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLable.mas_left);
        make.top.equalTo(self.mas_top).offset(58);
        make.height.equalTo(@15);
    }];
    mobileNum.font = WLFontSize(11);
    mobileNum.textColor = [WLTools stringToColor:@"#4778e7"];
    mobileNum.text = mobile;
    
    //4.添加好友Button
    UIButton *addButton = [[UIButton alloc] init];
    [self addSubview:addButton];
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-16);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@90);
        make.height.equalTo(@30);
    }];
    addButton.layer.cornerRadius = 15.0f;
    addButton.layer.masksToBounds = YES;
    [addButton setTitleColor:[WLTools stringToColor:@"#ffffff"] forState:UIControlStateNormal];
    [addButton setTitle:@"加为好友" forState:UIControlStateNormal];
    [addButton setBackgroundColor:[WLTools stringToColor:@"#b5b5b5"]];
    addButton.enabled = NO;
    [addButton.titleLabel setFont:WLFontSize(14)];
    
  
}

@end
