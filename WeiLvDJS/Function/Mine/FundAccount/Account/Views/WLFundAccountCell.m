//
//  WLFundAccountCell.m
//  WeiLvDJS
//
//  Created by ternence on 16/12/15.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLFundAccountCell.h"
#define cellIdentifier @"WLFundAccountCell"

@interface WLFundAccountCell ()

@property (nonatomic,strong) UIImageView *leftImageVIew;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *rightLabel;
@property (nonatomic,strong) UIImageView *rightImageVIew;

@end

@implementation WLFundAccountCell
+ (WLFundAccountCell *)cellWithTableView:(UITableView*)tableView{
    WLFundAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLFundAccountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.exclusiveTouch = YES;
        self.multipleTouchEnabled = NO;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

- (void)setupUI{

    self.leftImageVIew = [[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(12),(ScaleH(55)-24)/2,20,24)];
    self.leftImageVIew.layer.masksToBounds = YES;
    self.leftImageVIew.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.leftImageVIew];

    self.nameLabel = [WLTools allocLabel:@"" font:WLFontSize(15) textColor:Color2 frame:CGRectMake(ViewRight(self.leftImageVIew)+ScaleW(15), 0, 120,  ScaleH(55))textAlignment:0];
    [self.contentView addSubview:self.nameLabel];

    self.rightImageVIew = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-19, (ScaleH(55)-15)/2, 9, 15)];
    self.rightImageVIew.image = [UIImage imageNamed:@"arrow"];
    [self.contentView addSubview:self.rightImageVIew];

    self.rightLabel=[WLTools allocLabel:@"" font:WLFontSize(14) textColor:Color3 frame:CGRectMake(ScreenWidth-180-30, 0, 180, ScaleH(55))textAlignment:NSTextAlignmentRight];
    self.rightLabel.numberOfLines = 1;
    [self.contentView addSubview:self.rightLabel];

    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, ScaleH(55) - 1, ScreenWidth,1)];
    line.backgroundColor = bordColor;
    [self.contentView addSubview:line];
}

- (void)setCellModel:(WLFundAccountCellModel *)cellModel
{
    _cellModel = cellModel;
    
    self.leftImageVIew.image =[UIImage imageNamed:self.cellModel.iconImage];
    self.nameLabel.text = cellModel.leftTitle;
    self.rightLabel.text = self.cellModel.rightTitle;

}

- (void)setTitleArray:(NSArray *)titleArray
{
    self.leftImageVIew.hidden = YES;
    self.nameLabel.frame = CGRectMake(10, 0,120,  50);
    self.nameLabel.text = titleArray[0];
    self.rightLabel.text = titleArray[1];
}
@end

@implementation WLFundAccountCellModel

+ (instancetype)modelWithIconImage:(NSString *)iconImage leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle
{
    WLFundAccountCellModel *model = [[WLFundAccountCellModel alloc] init];
    model.iconImage = iconImage;
    model.leftTitle = leftTitle;
    model.rightTitle = rightTitle;
    return model;
}

@end
