//
//  WL_Trip_Cell.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Trip_Cell.h"

#import "WL_Pop_CallWindow.h"
@interface WL_Trip_Cell()

@property(nonatomic,strong)WL_Pop_CallWindow *CallWindow;

@end

@implementation WL_Trip_Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.dateImage =[UIImageView new];
        
        self.dateImage.image =[UIImage imageNamed:@"tripCalendar"];
        
        [self.contentView addSubview:self.dateImage];
        
        [self.dateImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(10);
            
            make.size.mas_equalTo(CGSizeMake(15, 15));
            
            make.top.mas_equalTo(15);
            
        }];
        
        self.dateLabel =[UILabel new];
        
        self.dateLabel.font =WLFontSize(12);
        
        self.dateLabel.textColor = BlackColor;
        
        [self.contentView addSubview:self.dateLabel];
        
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.dateImage.mas_right).mas_equalTo(10);
            
            make.top.mas_equalTo(15);
            
            make.height.mas_equalTo(15);
            
        }];
        
        self.dateLabel .text = @"2016-8-11  星期三";
        
        UILabel *line =[UILabel new];
        
        line.backgroundColor = bordColor;
        
        [self.contentView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(45);
            
            make.size.mas_equalTo(CGSizeMake(ScreenWidth, 0.5));
            
        }];
 
    }
    
    self.startButton =[UIButton new];
    
    [self.startButton setTitle:@"开始" forState:UIControlStateNormal];
    
    [self.startButton setTitleColor:WLColor(140, 157, 244, 1) forState:UIControlStateNormal];
    
    self.startButton.titleLabel.font =WLFontSize(14);
    
    self.startButton.layer.borderColor = WLColor(140, 157, 244, 1).CGColor;
    
    self.startButton.layer.borderWidth =1.0;
    
    [self.startButton addTarget:self action:@selector(startButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:self.startButton];
    
    [self.startButton mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.right.mas_equalTo(-10);
        
        make.size.mas_equalTo(CGSizeMake(60, 25));
        
        make.top.mas_equalTo(10);
        
    }];
    
    self.startButton.layer.cornerRadius = 12.5;
    
    self.startButton.layer.masksToBounds =YES;
    
    UILabel *line1 =[UILabel new];
    
    line1.backgroundColor = bordColor;
    
    [self.contentView addSubview:line1];
    
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(45);
        
        make.left.mas_equalTo(0);
        
        make.size.mas_equalTo(CGSizeMake(ScreenWidth, 0.5));
        
    }];
    
    self.orderNumber =[UILabel new];
    
    self.orderNumber.textColor =[WLTools stringToColor:@"#6f7378"];
    
    self.orderNumber.font =WLFontSize(12);
    
    self.orderNumber.text =@"订单编号:NBM20160914";
    
    [self.contentView addSubview:self.orderNumber];
    
    [self.orderNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(10);
        
        make.top.mas_equalTo(60);
    }];
    
    self.startCity =[UILabel new];
    
    self.startCity.textColor =BlackColor;
    
    self.startCity.font =WLFontSize(20);
    
    self.startCity.text =@"深圳";
    
    [self.contentView addSubview:self.startCity];
    
    [self.startCity mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(30);
        
        make.top.mas_equalTo(self.orderNumber.mas_bottom).offset(20);
        
    }];
    
    self.personNumber =[UILabel new];
    
    self.personNumber.textColor =[WLTools stringToColor:@"#6f7378"];
    
    self.personNumber.font =WLFontSize(12);
    
    self.personNumber.text =@"33人";
    
    [self.contentView addSubview:self.personNumber];
    
    [self.personNumber mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(self.contentView);
        
        make.top.mas_equalTo(self.startCity.mas_top);
        
    }];
    
    self.arrowImage =[UIImageView new];
    
    self.arrowImage.image =[UIImage imageNamed:@"directArrow"];
    
    
    [self.contentView addSubview:self.arrowImage];
    
    [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.centerX.mas_equalTo(self.contentView);
        
        make.top.mas_equalTo(self.personNumber.mas_bottom).offset(-3);
        
    }];
    
    
    self.endCity =[UILabel new];
    
    self.endCity.textColor =BlackColor;
    
    self.endCity.font =WLFontSize(20);
    
    self.endCity.text =@"深圳";
    
    [self.contentView addSubview:self.endCity];
    
    [self.endCity mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-30);
        
        make.top.mas_equalTo(self.orderNumber.mas_bottom).offset(20);
        
    }];

    
    self.startTime =[UILabel new];
    
    self.startTime.textColor =[WLTools stringToColor:@"#6f7378"];
    
    self.startTime.font =WLFontSize(12);
    
    self.startTime.text =@"08-27 周六";
    
    [self.contentView addSubview:self.startTime];

    
    [self.startTime mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.centerX.mas_equalTo(self.startCity);
        
        make.height.mas_equalTo(15);
        
        make.top.mas_equalTo(self.startCity.mas_bottom).offset(10);
        
        
    }];
    
    self.company =[UILabel new];
    
    self.company.textColor =[WLTools stringToColor:@"#6f7378"];
    
    self.company.font =WLFontSize(12);
    
    self.company.text =@"厦门金龙车队有限公司";
    
    [self.contentView addSubview:self.company];
    
    [self.company mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerX.mas_equalTo(self.contentView);
        
        make.top.mas_equalTo(self.arrowImage.mas_bottom).offset(4);
        
    }];
    
    self.endTime =[UILabel new];
    
    self.endTime.textColor =[WLTools stringToColor:@"#6f7378"];
    
    self.endTime.font =WLFontSize(12);
    
    self.endTime.text =@"08-27 周六";
    
    [self.contentView addSubview:self.endTime];
    
    
    [self.endTime mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.endCity);
        
        make.height.mas_equalTo(15);
        
        make.top.mas_equalTo(self.startTime.mas_top);
        
        
    }];
    
    UILabel *line2 =[UILabel new];
    
    line2.backgroundColor =bordColor;
    
    [self.contentView addSubview:line2];
    
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(10);
        
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-20, 0.5));
        
        make.top.mas_equalTo(155);
        
    }];
    
    self.concactService =[UIButton new];
    
    [self.concactService setImage:[UIImage imageNamed:@"tripService"] forState:UIControlStateNormal];
    
    [self.concactService setTitle:@"联系计调" forState:UIControlStateNormal];
    
    [self.concactService setTitleColor:[WLTools stringToColor:@"#6f7378"] forState:UIControlStateNormal];
    
    self.concactService.titleLabel.font =WLFontSize(14);
    
    [self.concactService setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0,0)];
    
    [self.concactService addTarget:self action:@selector(concactServiceClick) forControlEvents:UIControlEventTouchUpInside];

    [self.contentView addSubview:self.concactService];
    
    [self.concactService mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(35);
        
        make.top.mas_equalTo(line2.mas_bottom).offset(10);
        
        make.width.mas_equalTo(100);
        
    }];
    
    self.concactTour =[UIButton new];
    
    [self.concactTour setImage:[UIImage imageNamed:@"tripTour"] forState:UIControlStateNormal];
    
    [self.concactTour setTitle:@"联系导游" forState:UIControlStateNormal];
    
    [self.concactTour setTitleColor:[WLTools stringToColor:@"#6f7378"] forState:UIControlStateNormal];

    self.concactTour.titleLabel.font =WLFontSize(14);
    
    [self.concactTour setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0,0)];
    
    [self.concactTour addTarget:self action:@selector(concactTourClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.contentView addSubview:self.concactTour];
    
    [self.concactTour mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-35);
        
        make.top.mas_equalTo(line2.mas_bottom).offset(10);
        
        make.width.mas_equalTo(100);
        
    }];

    
    return self;
}

-(void)startButtonClick

{
    
    
}

-(WL_Pop_CallWindow *)CallWindow
{
    
    if (_CallWindow==nil) {
        
        _CallWindow =[[WL_Pop_CallWindow alloc]init];
        
        [_CallWindow setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        
    }
    return _CallWindow;
}

//联系客服
-(void)concactServiceClick
{
   
    [[UIApplication sharedApplication].keyWindow addSubview:self.CallWindow];
    
    self.CallWindow.dispatcher_Model= self.dispatcher_Model;

}

//联系导游
-(void)concactTourClick
{
   [[UIApplication sharedApplication].keyWindow addSubview:self.CallWindow];
    
    self.CallWindow.guide_Model =self.guide_Model;

}


-(void)setOrderModel:(WL_Trip_OrderModel *)orderModel

{
    
    self.orderMod = orderModel;
    
    self.orderNumber.text = [NSString stringWithFormat:@"订单号:%@",orderModel.order_number];
    
    self.startCity.text = orderModel.start_city;
    
    self.personNumber.text = [NSString stringWithFormat:@"%lu座",[orderModel.persons_count integerValue]];
    
    self.endCity.text =orderModel.end_city;
    
    self.company.text =orderModel.order_source_Fleet;
    
    self.startTime.text = [NSString stringWithFormat:@"%@ %@",[self getDateStringFromDate:[self getDateFromNsString:orderModel.start_time]],[self weekStringFromDate:[self getDateFromNsString:orderModel.start_time]]];
    
    self.endTime.text = [NSString stringWithFormat:@"%@ %@",[self getDateStringFromDate:[self getDateFromNsString:orderModel.end_time]],[self weekStringFromDate:[self getDateFromNsString:orderModel.end_time]]];
    
    self.concactTour.userInteractionEnabled = self.guide_Model ? YES :NO;
    
    if (!self.guide_Model.mobile) {
        
        [self.concactTour setImage:[UIImage imageNamed:@"tripTourGray"] forState:UIControlStateNormal];
        
        self.concactTour.userInteractionEnabled = NO;
        
    }else
    {
        [self.concactTour setImage:[UIImage imageNamed:@"tripTour"] forState:UIControlStateNormal];
        
        self.concactTour.userInteractionEnabled = YES;
    }
    if ([orderModel.trip_status integerValue]==1) {
        
       
        if ([orderModel.beg_buttom integerValue]==1) {
           
            self.startButton.layer.borderColor = WLColor(237, 131, 67, 1).CGColor;
            
            self.startButton.layer.borderWidth =1.0;
            
            [self.startButton setTitleColor:WLColor(237, 131, 67, 1) forState:UIControlStateNormal];
            
            [self.startButton setTitle:@"出发" forState:UIControlStateNormal];
            
            self.startButton.hidden= NO;
            
        }else if ([orderModel.beg_buttom integerValue]==2)
        {
            self.startButton.hidden = YES;
        }
        
       
        
    }else if ([orderModel.trip_status integerValue]==2)
    {
    
            self.startButton.layer.borderColor = WLColor(112, 139, 227, 1).CGColor;
            
            self.startButton.layer.borderWidth =1.0;
            
            [self.startButton setTitleColor:WLColor(112, 139, 227, 1) forState:UIControlStateNormal];
            
            [self.startButton setTitle:@"结束" forState:UIControlStateNormal];
            
            self.startButton.hidden=NO;
            
        
    }else if ([orderModel.trip_status integerValue]==3)
    {
        self.startButton.hidden = YES;
    }
}

//根据date获取 周几
-(NSString *)weekStringFromDate:(NSDate *)date

{
    
    NSArray *array =@[@"",@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSCalendarUnit calendarUit =NSCalendarUnitWeekday;
    
    NSDateComponents *components =[calendar components:calendarUit fromDate:date];
    
    return [array objectAtIndex:components.weekday];
}

-(NSDate *)getDateFromNsString:(NSString *)dateString

{
    NSDateFormatter *formate =[[NSDateFormatter alloc]init];
    
    [formate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date =[formate dateFromString:dateString];
    
    return  date;
    
}

-(NSString *)getDateStringFromDate:(NSDate *)date

{
    NSDateFormatter *formate =[[NSDateFormatter alloc]init];
    
    [formate setDateFormat:@"MM-dd"];
    
    NSString *dateString=[formate stringFromDate:date];
    
    return  dateString;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
