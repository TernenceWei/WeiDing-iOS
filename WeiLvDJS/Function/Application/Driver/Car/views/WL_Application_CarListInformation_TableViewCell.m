//
//  WL_Application_CarListInformation_TableViewCell.m
//  WeiLvDJS
//
//  Created by liuxin on 16/9/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_CarListInformation_TableViewCell.h"
#import "WL_Application_carListInformation_Bom_model.h"//公司model
@implementation WL_Application_CarListInformation_TableViewCell

//- (void)awakeFromNib {
//    // Initialization code
//}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.userInteractionEnabled = YES;
        [self creatView];
    }
    
    return  self;
}

-(void)creatView
{
    CGFloat Photoheight,Labelheight,topHeight;
    if (IsiPhone4||IsiPhone5) {
        Photoheight = 190;
        Labelheight = 35;
        topHeight = 12;
    }
    else
    {
        Labelheight = 40;
        Photoheight = 200;
        topHeight = 15;
    }

    //车辆图片
    self.photoImageView = [[UIImageView alloc] init];
    self.photoImageView.frame = CGRectMake(15, topHeight, ScreenWidth-30, Photoheight-topHeight-5);
    self.photoImageView.layer.masksToBounds = YES;
    self.photoImageView.layer.cornerRadius = 5;
    self.photoImageView.userInteractionEnabled = YES;
     self.photoImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.photoImageView];
    UIView *backView = [[UIView alloc] init];
    backView.frame = CGRectMake(0, self.photoImageView.height-35, ScreenWidth-30, 35);
    backView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self.photoImageView addSubview:backView];
    //车辆的信息
    self.labelTitleName = [[UILabel alloc] init];
    _labelTitleName.frame = CGRectMake(10, 0, ScreenWidth-100, 35);
    _labelTitleName.backgroundColor = [UIColor clearColor];
    _labelTitleName.textColor = [UIColor whiteColor];
    
    [backView addSubview:_labelTitleName];
    //
    self.UIImageViewTitle = [[UIImageView alloc] init];
    _UIImageViewTitle.frame = CGRectMake(self.photoImageView.size.width-70, 5, 60, 25);
    _UIImageViewTitle.layer.masksToBounds = YES;
    _UIImageViewTitle.layer.cornerRadius = 13;
    
   // _UIImageViewTitle.backgroundColor = [UIColor redColor];
    _UIImageViewTitle.userInteractionEnabled = YES;
    [backView addSubview:_UIImageViewTitle];
    //
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ViewTitleTapDown)];
    [_UIImageViewTitle addGestureRecognizer:tap];
    //公司信息载体
    
    self.view = [[UIView alloc] init];
    _view.frame = CGRectMake(0, 200, ScreenWidth, 100);
    //_view.layer.cornerRadius = 5;
    _view.layer.masksToBounds = YES;
    [self addSubview:_view];
    _view.backgroundColor = [UIColor whiteColor];
    
    
}
-(void)setModel:(WL_Application_carListInformation_model *)model
{
    CGFloat Labelheight1,topHeight1,height;
    if (IsiPhone4||IsiPhone5) {
        height = 190;
        Labelheight1 = 35;
        topHeight1 = 12;
    }
    else
    {
        Labelheight1 = 40;
        height = 200;
        topHeight1 = 15;
    }

    [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",DriverPhotoUrl,model.photo]] placeholderImage:[UIImage imageNamed:@""]];
    NSInteger count = 0;
    if (model.bom) {
        count = model.bom.count;
    }
    NSString *title = [NSString stringWithFormat:@"%@-%@座-%@",model.car_brand,model.car_mode,model.car_number];
    self.labelTitleName.text = title;
    self.view.frame = CGRectMake(0, height, ScreenWidth,count*Labelheight1+10);
    for (UIView *viewSon in self.view.subviews) {
        [viewSon removeFromSuperview];
    }
    
    for (int i = 0; i<count; i++) {
        //获取数据模型
        NSDictionary *dict = model.bom[i];
        WL_Application_carListInformation_Bom_model *Bom_model = [[WL_Application_carListInformation_Bom_model alloc] init];
        [Bom_model setValuesForKeysWithDictionary:dict];
        //创建模型的载体
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(15, i*Labelheight1+5, ScreenWidth/2, 30);
        label.font = WLFontSize(15);
        label.text = Bom_model.company_name;
        label.textColor = [UIColor grayColor];
        //label.backgroundColor = [UIColor redColor];
        [self.view addSubview:label];
        //审核按钮
        CGSize size = [self sizeWithString:label.text font:WLFontSize(15)];
        UIImageView *ImageViewCard = [[UIImageView alloc] init];
         label.frame = CGRectMake(15, i*Labelheight1+5, size.width, 30);
        ImageViewCard.frame = CGRectMake(size.width+25, i*Labelheight1+10, 20*3.79, 20);
        ImageViewCard.layer.cornerRadius = 10;
        ImageViewCard.layer.masksToBounds = YES;
        ImageViewCard.layer.borderWidth = 1;
        ImageViewCard.layer.borderColor = [UIColor clearColor].CGColor;
        if ([Bom_model.status isEqualToString:@"0"]) {
            //认证失败
            ImageViewCard.image = [UIImage imageNamed:@"RenZhengShibai"];
            ImageViewCard.layer.borderColor = [WLTools stringToColor:@"#416f86"].CGColor;
        }else if ([Bom_model.status isEqualToString:@"1"])
        {
            //审核中
            ImageViewCard.image = [UIImage imageNamed:@"ShenHezhong"];
            ImageViewCard.layer.borderColor = [WLTools stringToColor:@"#4f94e2"].CGColor;
        }
        else if ([Bom_model.status isEqualToString:@"2"])
        {
            //已经认证
           // kColor(<#r#>, <#g#>, <#b#>).CGColor
            ImageViewCard.image = [UIImage imageNamed:@"YiRenzheng"];
            ImageViewCard.layer.borderColor = HHColor(181, 222, 176).CGColor;
        }
        else if ([Bom_model.status isEqualToString:@"3"])
        {
            //未认证
            ImageViewCard.image = [UIImage imageNamed:@"WeiRenzheng"];
            ImageViewCard.layer.borderColor = [WLTools stringToColor:@"#b0b7c1"].CGColor;
        }
        else if ([Bom_model.status isEqualToString:@"-1"])
        {
           ImageViewCard.image = [UIImage imageNamed:@"WeiRenzheng"];
            ImageViewCard.layer.borderColor = [WLTools stringToColor:@"#b0b7c1"].CGColor;
        }
        

       // ImageViewCard.backgroundColor = [UIColor redColor];
        
       // ImageViewCard.layer.borderWidth = 1.0;
        //ImageViewCard.layer.borderColor = [UIColor blackColor].CGColor;
        [self.view addSubview:ImageViewCard];
        }
    if ([model.status isEqualToString:@"2"]) {
       
        _UIImageViewTitle.image = [UIImage imageNamed:@"YiQiyong"];
    }
    else
    {
      _UIImageViewTitle.image = [UIImage imageNamed:@"WeiQiYong"];
    }
   // if (count>0) {
        //编辑文字
        UILabel *Editlabel = [[UILabel alloc] init];
        Editlabel.frame = CGRectMake(self.view.size.width-45, count*Labelheight1-30, 30, 30);
        Editlabel.text = @"编辑";
        Editlabel.font = WLFontSize(14);
        Editlabel.textColor = [WLTools stringToColor:@"#6f7378"];
        [self.view addSubview:Editlabel];
        //编辑的图片
        UIImageView *imageTapView = [[UIImageView alloc] init];
        imageTapView.frame = CGRectMake(self.view.size.width-65, count*Labelheight1-23, 15, 13);
        imageTapView.image = [UIImage imageNamed:@"CarEditImage"];
        [self.view addSubview:imageTapView];
        //可用于编辑的事件
        UIButton *btnTap = [UIButton buttonWithType:UIButtonTypeSystem];
        btnTap.frame = CGRectMake(self.view.size.width-75, count*Labelheight1-30, 60, 40);
        //btnTap.backgroundColor = [UIColor redColor];
        [btnTap addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btnTap];
    //}
    UIView *bottomView = [[UIView alloc] init];
    bottomView.frame = CGRectMake(0, count*40, ScreenWidth, 20);
    bottomView.backgroundColor = BgViewColor;
    [self.view addSubview:bottomView];
//    UIButton *btnTap = [UIButton buttonWithType:UIButtonTypeSystem];
//    btnTap.frame = CGRectMake(self.photoImageView.size.width-70, _photoImageView.size.height-30, 60, 25);
//;
//    [btnTap addTarget:self action:@selector(ViewTitleBlock) forControlEvents:UIControlEventTouchUpInside];
//    [self.photoImageView addSubview:btnTap];
    
}
-(void)btnClick:(UIButton *)btn
{
    if (_BtnBlock) {
        self.BtnBlock();
    }
}
#pragma mark---启用车辆
-(void)ViewTitleTapDown
{
    if (_ViewTitleBlock) {
        self.ViewTitleBlock();
    }
}
#pragma mark----定义成方法方便多个label调用 增加代码的复用性，根据字符串的长度和字体的大小计算字符串咋一定宽度内的长和宽
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGFloat width = ScreenWidth -15-150;
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
