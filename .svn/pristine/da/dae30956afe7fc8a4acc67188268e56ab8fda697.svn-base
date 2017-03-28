//
//  WL_messageTableViewCell.m
//  WeiLvDJS
//
//  Created by jyc on 2016/11/9.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_messageTableViewCell.h"

@interface WL_messageTableViewCell ()
/**< 小红点 */
@property (nonatomic, weak) UIImageView *smallRedImageView;
@end
@implementation WL_messageTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.contentView.backgroundColor = BgViewColor;
        
        self.whiteView =[UIView new];
        
        self.whiteView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.whiteView];
        
        [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self.contentView);
            
        }];
        
        self.markImage = [UIImageView new];
        
        [self.whiteView addSubview:self.markImage];
        
        [self.markImage mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.whiteView).offset(ScaleH(21));
            make.left.equalTo(self.whiteView).offset(ScaleW(12));
            make.height.offset(ScaleH(35));
            make.width.offset(ScaleW(35));
            
        }];
        
        self.tipLabel =[UILabel new];
        
        self.tipLabel.text = @"接单提醒";
        
        self.tipLabel.numberOfLines = 2;
        self.tipLabel.textAlignment = NSTextAlignmentLeft;
        self.tipLabel.font = WLFontSize(17);
        
        self.tipLabel.textColor =[WLTools stringToColor:@"#333333"];
        
        [self.whiteView addSubview:self.tipLabel];
        
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.whiteView).offset(ScaleH(20));
            make.left.equalTo(self.markImage.mas_right).offset(ScaleW(15));
            make.right.equalTo(self.whiteView);
            
        }];

        self.dateLabel = [UILabel new];
        
        self.dateLabel.textColor =[WLTools stringToColor:@"#929292"];
        
        self.dateLabel.textAlignment = NSTextAlignmentRight;
        
        self.dateLabel.text = @"11:35";
        
        self.dateLabel.font = WLFontSize(12);
        
        [self.whiteView addSubview:self.dateLabel];
        
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.tipLabel);
            make.right.equalTo(self.whiteView).offset(-12);
            make.width.offset(100);
        }];

        self.tipDetailLabel = [UILabel new];
        
        self.tipDetailLabel.numberOfLines = 0;
        
        self.tipDetailLabel.font = WLFontSize(14);
        
        self.tipDetailLabel.textColor = [WLTools stringToColor:@"#929292"];
        
        [self.whiteView addSubview:self.tipDetailLabel];
        
        [self.tipDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.markImage.mas_right).offset(ScaleW(15));
            make.top.equalTo(self.tipLabel.mas_bottom).offset(10);
//            make.bottom.equalTo(self.whiteView).offset(-ScaleH(15));
            make.right.equalTo(self.whiteView).offset(-ScaleW(80));
         
        }];
        
        UILabel *line =[UILabel new];
        
        line.backgroundColor =bordColor;
        
        [self.whiteView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.markImage.mas_right).offset(ScaleW(15));
            
            make.bottom.equalTo(self.whiteView);
            make.right.equalTo(self.whiteView);
            make.height.offset(0.6);
            
        }];
      /**< 小红点 */
        UIImageView *smallRedImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"weiduMark"]];
        self.smallRedImageView = smallRedImageView;
        [self.whiteView addSubview:smallRedImageView];
        
        [smallRedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.whiteView).offset(ScaleW(-12.5));
            make.bottom.equalTo(self.whiteView).offset(ScaleH(-20));
            make.width.offset(8);
            make.height.offset(8);
        }];
        
 
    }

    return self;
}

-(void)setModel:(WL_MessageList_itemsModel *)model
{
 
    self.dateLabel.text = [NSString getDateStringWithTime:model.created_at andFormatter:@"MM月dd日"];
    self.tipDetailLabel.text = model.message;
    
    if([model.status integerValue] == 0)//未读
    {
        self.smallRedImageView.hidden = NO;
    }else if([model.status integerValue] == 1)//已读
    {
        self.smallRedImageView.hidden = YES;
    }
    switch ([model.msg_type integerValue]) {
        case 1:
            
            self.markImage.image = [UIImage imageNamed:@"jiedantixingNew"];
            self.tipLabel.text =@"接单提醒";
            break;
        case 2:
            
            self.markImage.image = [UIImage imageNamed:@"dingdanquxiao"];
            
            self.tipLabel.text =@"订单被取消";
            break;
        case 3:
            
            self.markImage.image = [UIImage imageNamed:@"chutuantixing"];
            
            self.tipLabel.text =@"出团提醒";
            break;
        case 4:
            
            self.markImage.image = [UIImage imageNamed:@"daoyoutixing"];
            self.tipLabel.text =@"导游变动提醒";
            break;
       //预付款
        case 5:
            
            self.markImage.image = [UIImage imageNamed:@"shengfenrenzhengNew"];
            self.tipLabel.text =@"身份认证提醒";
            break;
        case 6:
            
            self.markImage.image = [UIImage imageNamed:@"shengfenshibai"];
            self.tipLabel.text =@"身份认证提醒";
            break;
        case 7:
            self.markImage.image = [UIImage imageNamed:@"zijingbiandongNew"];
            self.tipLabel.text =@"资金变动提醒";
        case 8:
            self.markImage.image = [UIImage imageNamed:@"jiedantixingNew"];
            self.tipLabel.text =@"接单提醒";
            break;
        case 9:
            self.markImage.image = [UIImage imageNamed:@"dingdanquxiao"];
            self.tipLabel.text =@"订单被取消";
            break;
        case 10:
            self.markImage.image = [UIImage imageNamed:@"jingjiachenggongNew"];
            self.tipLabel.text =@"竞价成功";
            break;
        case 11:
            self.markImage.image = [UIImage imageNamed:@"jingjiashibaiNew"];
            self.tipLabel.text =@"竞价失败";
            break;
        case 12:
            self.markImage.image = [UIImage imageNamed:@"cheliangchegong"];
            self.tipLabel.text =@"车辆认证提醒";
            break;
        case 13:
            self.markImage.image = [UIImage imageNamed:@"cheliangshibai"];
            self.tipLabel.text =@"车辆认证提醒";
            break;
        case 14:
            self.markImage.image = [UIImage imageNamed:@"yiyousijibaojia"];
            self.tipLabel.text =@"已有司机报价";
            break;
        case 15:
            self.markImage.image = [UIImage imageNamed:@"tripStart"];
            self.tipLabel.text =@"行程开始";
            break;
        case 16:
            self.markImage.image = [UIImage imageNamed:@"tripEnd"];
            self.tipLabel.text =@"行程结束";
            break;
        case 17:
            self.markImage.image = [UIImage imageNamed:@"wuyingda"];
            self.tipLabel.text =@"无司机应答";
            break;
        case 18:
            self.markImage.image = [UIImage imageNamed:@"jiedantixingNew"];
            self.tipLabel.text =@"出行提醒";
            break;
        case 19:
            self.markImage.image = [UIImage imageNamed:@"jiedantixingNew"];
            self.tipLabel.text =@"选择司机超时";
            break;
        default:
            break;
    }
    
    
    
    /**< 调整行间距 */
    if (self.tipDetailLabel.text.length>0) {
       
        [self getAttributedStringFrom:self.tipDetailLabel];
        
    }
    
//    
//    CGSize size = [self sizeWithString:model.msg_content font:WLFontSize(14)];
//    
//    if (size.height>45) {
//        [self.tipDetailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//            
//            make.left.mas_equalTo(35);
//            
//            make.top.mas_equalTo(50);
//            
//            make.width.mas_equalTo(ScreenWidth-20-35-15);
//            
//            make.bottom.mas_equalTo(self.whiteView.mas_bottom).mas_offset(-5);
//            
//        }];
//        
//        [self.whiteView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            
//            make.left.mas_equalTo(10);
//            
//            make.top.mas_equalTo(0);
//            
//            make.width.mas_equalTo(ScreenWidth-20);
//            
//            make.bottom.mas_equalTo(self.contentView.mas_bottom);
//            
//        }];
//        
//        [self.tapButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.edges.mas_equalTo(self.tipDetailLabel);
//            
//        }];
//        
//        [self.contentView setNeedsUpdateConstraints];
//        [self.contentView updateConstraintsIfNeeded];
//        [self.contentView layoutIfNeeded];
//        
//    }else
//    {
//        [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.left.mas_equalTo(10);
//            
//            make.top.mas_equalTo(0);
//            
//            make.width.mas_equalTo(ScreenWidth-20);
//            
//            make.height.mas_greaterThanOrEqualTo(90);
//            
//        }];
//        
//        [self.tipDetailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//            
//            make.left.mas_equalTo(35);
//            
//            make.top.mas_equalTo(45);
//            
//            make.width.mas_equalTo(ScreenWidth-20-35-15);
//            
//            make.height.mas_greaterThanOrEqualTo(45);
//            
//        }];
//        
//        [self.tapButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.edges.mas_equalTo(self.tipDetailLabel);
//            
//        }];
//        [self.contentView setNeedsUpdateConstraints];
//        [self.contentView updateConstraintsIfNeeded];
//        [self.contentView layoutIfNeeded];
//        
//    }


    
    
}


-(void)tapButtonClick
{
    WlLog(@"%@",self.indexPath);
}

+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(ScreenWidth-ScaleW(80)-ScaleW(66.5), MAXFLOAT)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}

+ (CGFloat)getCellHeightWithContentString:(NSString *)string
{

    CGSize size = [self sizeWithString:string font:WLFontSize(14)];
    if(IsiPhone5)
    {
      return size.height + ScaleH(77);
    }
    return size.height + ScaleH(73);


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
