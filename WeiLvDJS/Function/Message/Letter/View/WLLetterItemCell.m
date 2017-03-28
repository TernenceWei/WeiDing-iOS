//
//  WLLetterItemCell.m
//  WeiLvDJS
//
//  Created by ternence on 16/12/12.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLLetterItemCell.h"

@implementation WLLetterItemCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.portrait = [UIImageView new];
        
        //self.portrait.backgroundColor = [UIColor redColor];
        
        [self.contentView addSubview:self.portrait];
        
        [self.portrait mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.top.mas_equalTo(15);
            
            make.size.mas_equalTo(CGSizeMake(45, 45));
            
        }];
        
        self.portrait.layer.cornerRadius = 22.5;
        
        self.portrait.layer.masksToBounds = YES;
        
        self.nameLabel =[UILabel new];
        
        self.nameLabel.font =WLFontSize(12.5);
        
        self.nameLabel.textColor = BlackColor;
        
        self.nameLabel.text = @"丽丽";
        
        [self.contentView addSubview:self.nameLabel];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.portrait.mas_right).mas_offset(10);
            
            make.top.mas_equalTo(self.portrait.mas_top).offset(2);
            
            make.height.mas_equalTo(15);
            
        }];
        
        self.dateLabel = [UILabel new];
        
        self.dateLabel.textColor = [WLTools stringToColor:@"#6f7378"];
        
        self.dateLabel.textAlignment = NSTextAlignmentRight;
        
        self.dateLabel.font = WLFontSize(12.5);
        
        [self.contentView addSubview:self.dateLabel];
        
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
            
            make.top.mas_equalTo(self.nameLabel.mas_top);
            
        }];
        
        self.detailLabel = [UILabel new];
        
        self.detailLabel.numberOfLines= 0;
        
        self.detailLabel.textColor =[WLTools stringToColor:@"#6f7378"];
        
        self.detailLabel.font =WLFontSize(12.5);
        
        [self.contentView addSubview:self.detailLabel];
        
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.nameLabel.mas_left);
            
            make.width.mas_equalTo(ScreenWidth-85);
            
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(15);
            
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-15);
            
        }];
        
        
    }
    
    return self;
}

-(void)setModel:(WL_authorInfo_Model *)model
{
    [self.portrait sd_setImageWithURL:[NSURL URLWithString:model.userInfo.photo] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
    
    self.nameLabel.text = model.userInfo.user_name;
    
    self.dateLabel.text = model.create_date;
    
    self.detailLabel.text =model.content;
    
    [self getAttributedStringFrom:self.detailLabel];
    
    [self.detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.nameLabel.mas_left);
        
        make.width.mas_equalTo(ScreenWidth-85);
        
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-15);
        
    }];
    
    
}

+(CGFloat)heightWithModel:(WL_authorInfo_Model *)model
{
    
    WLLetterItemCell *cell = [[WLLetterItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    
    CGSize size = [cell sizeWithString:model.content font:WLFontSize(12.5)];
    
    return 60+size.height;
    
}

- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(ScreenWidth-85, 1000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}

-(void)getAttributedStringFrom:(UILabel *)label
{
    
    NSMutableAttributedString *attrawardLabel = [[NSMutableAttributedString alloc] initWithString:label.text];
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 4; // 调整行间距
    NSRange rang = NSMakeRange(0, [label.text length]);
    [attrawardLabel addAttribute:NSParagraphStyleAttributeName value:paragraph range:rang];
    
    label.attributedText =attrawardLabel;
    
    label.textAlignment =NSTextAlignmentLeft;
}

@end
