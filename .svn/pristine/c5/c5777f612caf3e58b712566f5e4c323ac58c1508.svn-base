//
//  WL_Application_Car_Company_TableViewCell.m
//  WeiLvDJS
//
//  Created by liuxin on 16/9/27.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Car_Company_TableViewCell.h"
#import "WL_Application_carListInformation_Bom_model.h"
@implementation WL_Application_Car_Company_TableViewCell

//- (void)awakeFromNib {
//    // Initialization code
//}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setViewSuperViews];
    }
    
    return  self;
}
-(void)setViewSuperViews
{
   
    CGFloat height=0;
    
    if (IsiPhone4||IsiPhone5) {
        
        height =45;
    }else
    {
        height =50;
    }
    //是否认证
    self.HeadImageView = [[UIImageView alloc] init];
    self.HeadImageView.frame = CGRectMake(15,height/2-15, 30, 30);
   // self.HeadImageView.backgroundColor = [UIColor grayColor];
    self.HeadImageView.layer.masksToBounds = YES;
    self.HeadImageView.layer.cornerRadius = 3;
    [self addSubview:self.HeadImageView];
    self.HeadImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *headGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headImageTap)];
    
    
    
    [self.HeadImageView addGestureRecognizer:headGesture];
    //公司名称
    self.companyTitle = [[UILabel alloc] init];
    self.companyTitle.frame = CGRectMake(55, (height-30)/2, 150, 30);
    self.companyTitle.font = WLFontSize(14);
    [self addSubview:self.companyTitle];
    //是否是第一次提交
    self.isFristImageView = [[UILabel alloc] init];
    self.isFristImageView.frame = CGRectMake(250, (height-20)/2, 60, 20);
    self.isFristImageView.layer.masksToBounds = YES;
    self.isFristImageView.font = WLFontSize(12);
    self.isFristImageView.layer.cornerRadius = 10;
    self.isFristImageView.textAlignment = NSTextAlignmentCenter;
   
    [self addSubview:self.isFristImageView];
    
}
//点击事件
-(void)headImageTap
{
    if (self.HeadimageViewBack) {
        self.HeadimageViewBack(self.index);
    }
    
}
-(void)setBom_model:(WL_Application_carListInformation_Bom_model *)model_bom with:(NSMutableArray *)titleArr isChange:(BOOL)isChange
{
    CGFloat heightCell;
    if (IsiPhone4||IsiPhone5) {
        heightCell = 45;
    }
    else
    {
        heightCell = 50;
    }
   
    self.companyTitle.text = [NSString stringWithFormat:@"%@",model_bom.company_name];
    CGSize size = [self sizeWithString:model_bom.company_name font:WLFontSize(12)];
     self.companyTitle.frame = CGRectMake(55, heightCell/2-15, size.width+20, 30);
     self.isFristImageView.frame = CGRectMake(size.width+55, heightCell/2-10, 60, 20);
       if (!self.isADD) {
        
           if ([model_bom.status isEqualToString:@"0"]) {
               //认证失败
               self.HeadImageView.image = [UIImage imageNamed:@"choseCompanyEmpty"];
               
           }else if ([model_bom.status isEqualToString:@"1"])
           {
               //审核中
               if (isChange) {
                  self.HeadImageView.image = [UIImage imageNamed:@"ChoseCompanyMoren"];
               }
               else
               {
               self.HeadImageView.image = [UIImage imageNamed:@"NOchoseAompany"];
               }
               
           }
           else if ([model_bom.status isEqualToString:@"2"])
           {
               //已经认证
               if (isChange)
               {
                 self.HeadImageView.image = [UIImage imageNamed:@"ChoseCompanyMoren"];
               }
               else
               {
               self.HeadImageView.image = [UIImage imageNamed:@"NOchoseAompany"];
               }
               
           }
           else if ([model_bom.status isEqualToString:@"3"])
           {
               //已经认证
               self.HeadImageView.image = [UIImage imageNamed:@"NOchoseAompany"];
               
           }
           else if ([model_bom.status isEqualToString:@"-1"])
           {
               //首次提交
               self.HeadImageView.image = [UIImage imageNamed:@"choseCompanyEmpty"];
               
           }

        if ([model_bom.status isEqualToString:@"0"]) {
            //认证失败
            self.isFristImageView.text = @"认证失败";
            
            self.isFristImageView.backgroundColor = [WLTools stringToColor:@"#416f86"];
            self.isFristImageView.frame = CGRectMake(size.width+80, heightCell/2-10, 62, 20);
            
        }else if ([model_bom.status isEqualToString:@"1"])
        {
            //审核中
            self.isFristImageView.text = @"审核中";
            self.isFristImageView.backgroundColor = [WLTools stringToColor:@"#4f94e2"];
            self.isFristImageView.frame = CGRectMake(size.width+80, heightCell/2-10, 45, 20);
            
        }
        else if ([model_bom.status isEqualToString:@"2"])
        {
            //已经认证
            self.isFristImageView.text = @"已认证";
            self.isFristImageView.backgroundColor = [UIColor colorWithRed:181/255.0 green:222/255.0 blue:176/255.0 alpha:1.0];
            self.isFristImageView.frame = CGRectMake(size.width+80, heightCell/2-10, 62, 20);
            
        }
        else if ([model_bom.status isEqualToString:@"3"])
        {
            //未认证证
            self.isFristImageView.text = @"未认证";
             self.isFristImageView.backgroundColor = [WLTools stringToColor:@"#b0b7c1"];
            self.isFristImageView.frame = CGRectMake(size.width+80, heightCell/2-10, 45, 20);
            
        }
        else if ([model_bom.status isEqualToString:@"-1"])
        {
            //首次提交
             self.isFristImageView.text = @"首次提交";
             self.isFristImageView.backgroundColor = [UIColor grayColor];
             self.isFristImageView.frame = CGRectMake(size.width+80, heightCell/2-10, 62, 20);
            
        }
        
        self.isFristImageView.textColor = [UIColor whiteColor];
    }
    else
    {
        //首次提交
        self.isFristImageView.text = @"首次提交";
        self.isFristImageView.backgroundColor = [UIColor colorWithRed:91/255.0 green:213/255.0 blue:142/255.0 alpha:1.0];
        self.isFristImageView.textColor = [UIColor whiteColor];
        self.isFristImageView.frame = CGRectMake(size.width+80, heightCell/2-10, 62, 20);

        
            if (titleArr.count==1) {
               
                self.HeadImageView.image = [UIImage imageNamed:@"choseCompanyEmpty"];
            }
            else
            {
                self.HeadImageView.image = [UIImage imageNamed:@"choseCompanyEmpty"];
            }
        

    }

}
#pragma mark----定义成方法方便多个label调用 增加代码的复用性，根据字符串的长度和字体的大小计算字符串咋一定宽度内的长和宽
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGFloat width = ScreenWidth - 145;
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, 8000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
