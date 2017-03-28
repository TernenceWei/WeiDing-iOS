//
//  WLOneCardCell.m
//  WeiLvDJS
//
//  Created by ternence on 2017/1/10.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLOneCardCell.h"

#define cellIdentifier @"WLOneCardCell"

@interface WLOneCardCell ()

@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;

@property (nonatomic, strong) UILabel *rightinvalidLabel;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UIImageView * IDCardImg;

@end

@implementation WLOneCardCell
+ (WLOneCardCell *)cellWithTableView:(UITableView*)tableView{
    WLOneCardCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLOneCardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
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
    
    CGFloat leftWidth = ScaleW(120);
    self.leftLabel = [UILabel labelWithText:@"姓名" textColor:Color3 fontSize:14];
    self.leftLabel.frame = CGRectMake(ScaleW(12), 0, leftWidth - ScaleW(12), ScaleH(56));
    [self.contentView addSubview:self.leftLabel];
    
    self.rightLabel = [UILabel labelWithText:@"" textColor:Color2 fontSize:14];
    self.rightLabel.frame = CGRectMake(self.leftLabel.right, 0, ScreenWidth - leftWidth, ScaleH(56));
    [self.contentView addSubview:self.rightLabel];
    
    self.rightinvalidLabel = [UILabel labelWithText:@"" textColor:Color2 fontSize:14];
    self.rightinvalidLabel.frame = CGRectMake(ScreenWidth - ScaleW(60), ScaleH(15), ScaleW(50), ScaleH(20));
    self.rightinvalidLabel.textAlignment = NSTextAlignmentRight;
    self.rightinvalidLabel.hidden = YES;
    [self.contentView addSubview:self.rightinvalidLabel];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = bordColor;
    _line.frame = CGRectMake(ScaleW(12), ScaleH(56), ScreenWidth, 1);
    [self.contentView addSubview:_line];
    
    _IDCardImg = [[UIImageView alloc] init];
    _IDCardImg.frame = CGRectMake(ScaleW(40), ScaleH(25), ScreenWidth - ScaleW(80), ScaleH(170));
    [self addSubview:_IDCardImg];
  
}

- (void)setTextArray:(NSArray *)array isinvalid:(BOOL)isinvalid IndexPath:(NSIndexPath *)indexPath
{
    self.leftLabel.text = array[0];
    self.rightLabel.text = array[1];
    if (indexPath.section == 0 && indexPath.row == 1) {
        self.rightinvalidLabel.hidden = NO;
        if (isinvalid) {
            self.rightinvalidLabel.text = @"(无效)";
            self.rightinvalidLabel.textColor = Color2;
        }
        else
        {
            self.rightinvalidLabel.text = @"(有效)";
            self.rightinvalidLabel.textColor = [WLTools stringToColor:@"#00cc99"];
        }
    }
    else
    {
        self.rightinvalidLabel.hidden = YES;
    }
    
    // 身份证照片
    if (indexPath.section == 1 && indexPath.row == 3) {
        _leftLabel.hidden = YES;
        _rightLabel.hidden = YES;
        _line.hidden = YES;
        _IDCardImg.hidden = NO;
        [_IDCardImg sd_setImageWithURL:[NSURL URLWithString:array[1]] placeholderImage:[UIImage imageNamed:@"WLPersonInfoIDCardFont"]];
    }
    else if (indexPath.section == 1 && indexPath.row == 4) {
        _leftLabel.hidden = YES;
        _rightLabel.hidden = YES;
        _line.hidden = YES;
        _IDCardImg.hidden = NO;
        [_IDCardImg sd_setImageWithURL:[NSURL URLWithString:array[1]] placeholderImage:[UIImage imageNamed:@"WLPersonInfoIDCardBack"]];
    }
    else
    {
        _leftLabel.hidden = NO;
        _rightLabel.hidden = NO;
        _line.hidden = NO;
        _IDCardImg.hidden = YES;
    }
}
@end
