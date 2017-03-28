//
//  WL_messageTableViewCell.m
//  WeiLvDJS
//
//  Created by jyc on 2016/11/9.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_messageTableViewCell.h"

@implementation WL_messageTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.contentView.backgroundColor = BgViewColor;
        
        self.whiteView =[UIView new];
        
        self.whiteView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.whiteView];
        
        self.whiteView.layer.cornerRadius = 3.0;
        
        self.whiteView.layer.masksToBounds = YES;
        
        [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(10);
            
            make.top.mas_equalTo(0);
            
            make.width.mas_equalTo(ScreenWidth-20);
            
            //make.height.mas_greaterThanOrEqualTo(90);
            
        }];
        
        self.markImage = [UIImageView new];
        
        [self.whiteView addSubview:self.markImage];
        
        self.markImage.image =[UIImage imageNamed:@""];
        
        [self.markImage mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.mas_equalTo(5);
            
            make.centerY.mas_equalTo(self.whiteView);
            
            make.size.mas_equalTo(CGSizeMake(20, 20));
            
        }];
        
        self.tipLabel =[UILabel new];
        
        self.tipLabel.text = @"接单提醒";
        
        self.tipLabel.numberOfLines = 2;
        
        self.tipLabel.font =WLFontSize(12);
        
        self.tipLabel.textColor =[WLTools stringToColor:@"#6f7378"];
        
        [self.whiteView addSubview:self.tipLabel];
        
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.mas_equalTo(35);
            
            make.top.mas_equalTo(0);
            
            make.width.mas_lessThanOrEqualTo(150);
            
            make.height.mas_greaterThanOrEqualTo(45);
            
        }];
        
        self.dateLabel =[UILabel new];
        
        self.dateLabel.textColor =[WLTools stringToColor:@"#6f7378"];
        
        self.dateLabel.textAlignment = NSTextAlignmentRight;
        
        self.dateLabel.text = @"2016-10-14 11:35";
        
        self.dateLabel.font =WLFontSize(12);
        
        [self.whiteView addSubview:self.dateLabel];
        
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.mas_equalTo(self.whiteView.mas_right).mas_offset(-5);
            
            make.top.mas_equalTo(0);
            
            make.height.mas_greaterThanOrEqualTo(45);
            
      
        }];
        
        UILabel *line =[UILabel new];
        
        line.backgroundColor =bordColor;
        
        [self.whiteView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
          
            make.left.mas_equalTo(35);
            
            make.top.mas_equalTo(45);
            
            make.size.mas_equalTo(CGSizeMake(ScreenWidth-20-35, 0.5));
            
        }];
        self.tipDetailLabel =[UILabel new];
        
        self.tipDetailLabel.text = @"接单提醒fgghth多少个法国人同行浑然天成";
        
        self.tipDetailLabel.numberOfLines = 0;
        
        self.tipDetailLabel.font =WLFontSize(12);
        
        self.tipDetailLabel.textColor =[WLTools stringToColor:@"#6f7378"];
        
        [self.whiteView addSubview:self.tipDetailLabel];
        
        [self.tipDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.mas_equalTo(35);
            
            make.top.mas_equalTo(line.mas_bottom);
            
            make.width.mas_equalTo(ScreenWidth-20-35-15);
            
         
        }];
        
        //self.tapButton = [UIButton new];
        
//        [self.contentView addSubview:self.tapButton];
//        
//        [self.tapButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.edges.mas_equalTo(self.tipDetailLabel);
//            
//        }];
        
        //[self.tapButton addTarget:self action:@selector(tapButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        self.rightArrow =[UIImageView new];
        
        self.rightArrow.image =[UIImage imageNamed:@"arrow"];
        
        [self.whiteView addSubview:self.rightArrow];
        
        [self.rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
          
            make.right.mas_equalTo(self.whiteView.mas_right).mas_offset(-5);
            
            make.centerY.mas_equalTo(self.tipDetailLabel);
            
        }];
        
 
    }

    return self;
}

-(void)setModel:(WL_MessageList_Model *)model
{
 
    self.dateLabel.text =model.create_date;
    
    self.tipDetailLabel.text = model.msg_content;
    
    switch ([model.msg_type integerValue]) {
        case 1:
            
            self.markImage.image = [UIImage imageNamed:@"jiedan"];
            self.tipLabel.text =@"接单提醒";
            break;
        case 2:
            
            self.markImage.image = [UIImage imageNamed:@"shenfenranzheng"];
            
            self.tipLabel.text =@"身份验证提醒";
            break;
        case 3:
            
            self.markImage.image = [UIImage imageNamed:@"zijinbianbong"];
            
            self.tipLabel.text =@"资金变动提醒提醒";
            break;
        case 4:
            
            self.markImage.image = [UIImage imageNamed:@"chutuan"];
            self.tipLabel.text =@"出团提醒";
            break;
       //预付款
        case 5:
            
            self.markImage.image = [UIImage imageNamed:@"baozhang"];
            self.tipLabel.text =@"预付款提醒";
            break;
        case 6:
            
            self.markImage.image = [UIImage imageNamed:@"beiyongjian"];
            self.tipLabel.text =@"备用金提醒";
            break;
            
        default:
            break;
    }
    
    
    
    
    if (self.tipDetailLabel.text.length>0) {
       
        [self getAttributedStringFrom:self.tipDetailLabel];
        
    }
    
    
    CGSize size = [self sizeWithString:model.msg_content font:WLFontSize(12)];
    
    if (size.height>45) {
        [self.tipDetailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(35);
            
            make.top.mas_equalTo(50);
            
            make.width.mas_equalTo(ScreenWidth-20-35-15);
            
            make.bottom.mas_equalTo(self.whiteView.mas_bottom).mas_offset(-5);
            
        }];
        
        [self.whiteView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(10);
            
            make.top.mas_equalTo(0);
            
            make.width.mas_equalTo(ScreenWidth-20);
            
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
            
        }];
        
        [self.tapButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.mas_equalTo(self.tipDetailLabel);
            
        }];
        
        [self.contentView setNeedsUpdateConstraints];
        [self.contentView updateConstraintsIfNeeded];
        [self.contentView layoutIfNeeded];
        
    }else
    {
        [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(10);
            
            make.top.mas_equalTo(0);
            
            make.width.mas_equalTo(ScreenWidth-20);
            
            make.height.mas_greaterThanOrEqualTo(90);
            
        }];
        
        [self.tipDetailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(35);
            
            make.top.mas_equalTo(45);
            
            make.width.mas_equalTo(ScreenWidth-20-35-15);
            
            make.height.mas_greaterThanOrEqualTo(45);
            
        }];
        
        [self.tapButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.mas_equalTo(self.tipDetailLabel);
            
        }];
        [self.contentView setNeedsUpdateConstraints];
        [self.contentView updateConstraintsIfNeeded];
        [self.contentView layoutIfNeeded];
        
    }
    

    
    
}


-(void)tapButtonClick
{
    WlLog(@"%@",self.indexPath);
}

- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(ScreenWidth-20-35-15, 1000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}

+ (CGFloat)heightWithModel:(NSString *)string
{
    WL_messageTableViewCell *cell = [[WL_messageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
 
    [cell.contentView layoutIfNeeded];

    CGSize size = [cell sizeWithString:string font:WLFontSize(12)];
    
    if (size.height>45) {
      
        return size.height + 45 + 10;
        
        
    }else
    
        return 90;
    
    

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
