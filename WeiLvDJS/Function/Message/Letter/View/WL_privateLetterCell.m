//
//  WL_privateLetterCell.m
//  WeiLvDJS
//
//  Created by jyc on 2016/11/10.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_privateLetterCell.h"

@implementation WL_privateLetterCell

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
        
        self.nameLabel.font =WLFontSize(15);
        
        self.nameLabel.textColor = BlackColor;
        
        self.nameLabel.text = @"丽丽";
        
        [self.contentView addSubview:self.nameLabel];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.portrait.mas_right).mas_offset(10);
            
            make.top.mas_equalTo(self.portrait.mas_top).offset(2);
            
            make.height.mas_equalTo(20);
            
        }];
        
        self.dateLabel = [UILabel new];
        
        self.dateLabel.textColor = [WLTools stringToColor:@"#6f7378"];
        
        self.dateLabel.textAlignment = NSTextAlignmentRight;
        
        self.dateLabel.font = WLFontSize(14);
        
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
            
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
            
        }];
        
        self.message = [UIImageView new];
        
        self.message.image =[UIImage imageNamed:@"Unread"];
        
        [self.contentView addSubview:self.message];
        
        [self.message mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.mas_equalTo(self.nameLabel.mas_left);
            
            make.top.mas_equalTo(self.detailLabel.mas_bottom).offset(15);
            
            make.size.mas_equalTo(CGSizeMake(15, 15));
            
        }];
        
        self.messageNum = [UILabel new];
        
        self.messageNum.textColor = [WLTools stringToColor:@"#6f7378"];
        
        self.messageNum.font =WLFontSize(12);
        
        [self.contentView addSubview:self.messageNum];
        
        [self.messageNum mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.mas_equalTo(self.message.mas_right).offset(10);
            
            make.top.mas_equalTo(self.message.mas_top);
            
            make.height.mas_equalTo(15);
            
        }];
        
    }

    return self;
}

-(void)setModel:(WL_privateLetter_Model *)model
{
    self.nameLabel.text= model.realName;
    
    self.dateLabel.text = model.createDate;
    
    self.detailLabel.text = model.letterContent;
    
    [self getAttributedStringFrom:self.detailLabel];

    self.detailLabel.numberOfLines = 0;

    if ([model.noReadCount integerValue]==0) {
        
      self.message.image =[UIImage imageNamed:@"MessageRead"];
        
      self.messageNum.text = model.replyCount;
        
    }else
    {
        self.message.image =[UIImage imageNamed:@"Unread"];
        
        self.messageNum.text = model.noReadCount;
    }
    
    [self.detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
      
        make.left.mas_equalTo(self.nameLabel.mas_left);
        
        make.width.mas_equalTo(ScreenWidth-85);
        
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
        
    }];
    
    [self.message mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.nameLabel.mas_left);
        
        //make.top.mas_equalTo(self.detailLabel.mas_bottom).offset(15);
        
        make.size.mas_equalTo(CGSizeMake(15, 15));
        
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-15);
        
    }];

    [self.messageNum mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.message.mas_right).offset(10);
        
        //make.top.mas_equalTo(self.message.mas_top);
        
        make.height.mas_equalTo(15);
        
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-15);
        
    }];
   
    [self.portrait sd_setImageWithURL:[NSURL URLWithString:model.UserPhoto] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
    
    [self.contentView updateConstraints];
   
    [self.contentView updateConstraintsIfNeeded];
    
    [self.contentView layoutIfNeeded];
}

- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(ScreenWidth-85, 1000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}

+(CGFloat)heightWithModel:(WL_privateLetter_Model *)model
{
    
    WL_privateLetterCell *cell = [[WL_privateLetterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    
     CGSize size = [cell sizeWithString:model.letterContent font:WLFontSize(12.5)];
    
    return 85+size.height;
    
}

-(void)getAttributedStringFrom:(UILabel *)label
{
    
    NSMutableAttributedString *attrawardLabel = [[NSMutableAttributedString alloc] initWithString:label.text];
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 6; // 调整行间距
    NSRange rang = NSMakeRange(0, [label.text length]);
    [attrawardLabel addAttribute:NSParagraphStyleAttributeName value:paragraph range:rang];
    
    label.attributedText =attrawardLabel;
    
    label.textAlignment =NSTextAlignmentLeft;
}

@end
