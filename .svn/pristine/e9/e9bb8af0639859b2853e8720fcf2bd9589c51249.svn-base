//
//  WL_AddressBook_MyFriends_RightList_Cell.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/12.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_MyFriends_RightList_Cell.h"

@interface WL_AddressBook_MyFriends_RightList_Cell ()



@end

@implementation WL_AddressBook_MyFriends_RightList_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置子控件
        [self setupContentViewToMyFriendsRightListCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (void)setupContentViewToMyFriendsRightListCell
{
    UILabel *nameLable = [[UILabel alloc] init];
    [self.contentView addSubview:nameLable];
    [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    nameLable.font = WLFontSize(14);
    nameLable.textColor = [WLTools stringToColor:@"#4877e7"];
    self.nameLable = nameLable;

}


@end
