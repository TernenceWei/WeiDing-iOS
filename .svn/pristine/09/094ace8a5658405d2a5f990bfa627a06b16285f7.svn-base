//
//  WLLetterDetailCell.m
//  WeiLvDJS
//
//  Created by ternence on 16/12/12.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLLetterDetailCell.h"
#define cellIdentifier @"WLLetterDetailCell"

@interface WLLetterDetailCell ()
@property (nonatomic, strong) UIImageView *portrait;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@end

@implementation WLLetterDetailCell
+ (WLLetterDetailCell *)cellWithTableView:(UITableView*)tableView{
    WLLetterDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLLetterDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setupUI];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.exclusiveTouch = YES;
        self.multipleTouchEnabled = NO;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setupUI{
    
    self.portrait = [UIImageView new];
    [self addSubview:self.portrait];
    [self.portrait mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    self.portrait.layer.cornerRadius = 22.5;
    self.portrait.layer.masksToBounds = YES;
    
    self.nameLabel =[UILabel new];
    self.nameLabel.font =WLFontSize(15);
    self.nameLabel.textColor = BlackColor;
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.portrait.mas_right).mas_offset(10);
        make.top.mas_equalTo(self.portrait.mas_top).offset(2);
        make.height.mas_equalTo(20);
    }];
    
    self.dateLabel = [UILabel new];
    self.dateLabel.textColor = [WLTools stringToColor:@"#6f7378"];
    self.dateLabel.textAlignment = NSTextAlignmentRight;
    self.dateLabel.font = WLFontSize(14);
    [self addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.top.mas_equalTo(self.nameLabel.mas_top);
    }];
    
    self.detailLabel = [UILabel new];
    self.detailLabel.numberOfLines= 0;
    self.detailLabel.textColor =[WLTools stringToColor:@"#6f7378"];
    self.detailLabel.font =WLFontSize(12.5);
    [self addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.width.mas_equalTo(ScreenWidth-85);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-15);
    }];
}

- (void)setDetailModel:(WL_PrivateDetail_Model *)detailModel
{
    _detailModel = detailModel;
    
    [self.portrait sd_setImageWithURL:[NSURL URLWithString:_detailModel.userInfo.photo] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
    self.nameLabel.text = _detailModel.userInfo.user_name;
    self.dateLabel.text = _detailModel.create_date;
    self.detailLabel.text = _detailModel.content;
    
}
@end
