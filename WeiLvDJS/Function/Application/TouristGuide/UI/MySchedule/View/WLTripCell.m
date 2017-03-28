//
//  WLTripCell.m
//  WeiLvDJS
//
//  Created by xiaobai2268 on 2016/10/31.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLTripCell.h"

#import "WL_Pop_CallWindow.h"
@interface WLTripCell()

@property(nonatomic,strong)WL_Pop_CallWindow *CallWindow;

@end

@implementation WLTripCell

//- (void)awakeFromNib {
//    // Initialization code
//}

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
    
    
// 主
    _mainRedLabel = [[UILabel alloc] init];
    _mainRedLabel.frame = CGRectMake(ScaleW(10), ScaleH(65), ScaleW(40), ScaleH(40));
    _mainRedLabel.backgroundColor = [WLTools stringToColor:@"#fe798c"];//HEXCOLOR(#fe798c);
    _mainRedLabel.text = @"主";
    _mainRedLabel.layer.cornerRadius = 20;
    _mainRedLabel.layer.masksToBounds = YES;
    _mainRedLabel.textColor = [UIColor whiteColor];
    _mainRedLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_mainRedLabel];
    
// 散客
    _howCustomerLabel = [[UILabel alloc] init];
    _howCustomerLabel.frame = CGRectMake(_mainRedLabel.frame.origin.x + _mainRedLabel.frame.size.width + ScaleW(12), _mainRedLabel.frame.origin.y - ScaleH(2), ScaleW(50), ScaleH(20));
    _howCustomerLabel.backgroundColor = [WLTools stringToColor:@"#64ceb7"];
    _howCustomerLabel.text = @"散客";
    _howCustomerLabel.font =WLFontSize(14);
    _howCustomerLabel.textColor = [UIColor whiteColor];
    _howCustomerLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_howCustomerLabel];
    
// 3导
    _howCourierLabel = [[UILabel alloc] init];
    _howCourierLabel.frame = CGRectMake(_howCustomerLabel.frame.origin.x + _howCustomerLabel.frame.size.width + ScaleW(7), _mainRedLabel.frame.origin.y - ScaleH(2), ScaleW(40), ScaleH(20));
    _howCourierLabel.font =WLFontSize(14);
    _howCourierLabel.backgroundColor = [WLTools stringToColor:@"#4499ff"];
    _howCourierLabel.text = @"3导";
    _howCourierLabel.textColor = [UIColor whiteColor];
    _howCourierLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_howCourierLabel];
    
// 导服费
    _howCourierFeeLabel = [[UILabel alloc] init];
    _howCourierFeeLabel.frame = CGRectMake(ScaleW(ScreenWidth - 210), _mainRedLabel.frame.origin.y, ScaleW(200), ScaleH(20));
    _howCourierFeeLabel.text = @"导服费：￥800";
    _howCourierFeeLabel.textColor = [WLTools stringToColor:@"#6f7378"];
    _howCourierFeeLabel.textAlignment = NSTextAlignmentRight;
    _howCourierFeeLabel.font = WLFontSize(14);
    [self.contentView addSubview:_howCourierFeeLabel];
    
    
    // 接单时间开始
    self.orderNumber =[UILabel new];
    
    self.orderNumber.textColor =[WLTools stringToColor:@"#6f7378"];
    
    self.orderNumber.font =WLFontSize(12);
    
    self.orderNumber.text =@"接单时间：2016-09-05 18:20";
    
    [self.contentView addSubview:self.orderNumber];
    
    [self.orderNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(_mainRedLabel.frame.origin.x + _mainRedLabel.frame.size.width + 12);
        
        make.top.mas_equalTo(95);
    }];
    
    self.personNumber =[UILabel new];
    
    self.personNumber.textColor =[WLTools stringToColor:@"#6f7378"];
    
    self.personNumber.font =WLFontSize(12);
    
    self.personNumber.text =@"33人";
    
    [self.contentView addSubview:self.personNumber];
    
    [self.personNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.contentView);
        
        make.top.mas_equalTo(self.orderNumber.mas_bottom).offset(25);
        
    }];
    
    self.arrowImage =[UIImageView new];
    
    self.arrowImage.image =[UIImage imageNamed:@"directArrow"];
    
    
    [self.contentView addSubview:self.arrowImage];
    
    [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.contentView);
        
        make.top.mas_equalTo(self.personNumber.mas_bottom).offset(-3);
        
    }];
    
    
    self.startTimee =[UILabel new];
    
    self.startTimee.textColor =[WLTools stringToColor:@"#6f7378"];
    
    self.startTimee.font =WLFontSize(20);
    
    self.startTimee.text =@"10月01日";

    self.startTimee.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:self.startTimee];
    
    
    [self.startTimee mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(10);//make.centerX.mas_equalTo(30);//make.left.mas_equalTo(30);
        
        make.height.mas_equalTo(20);
        
        make.top.mas_equalTo(self.orderNumber.mas_bottom).offset(35);
        
        
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
    
    self.endTime.font =WLFontSize(20);
    
    self.endTime.text =@"10月07日";
    
    [self.contentView addSubview:self.endTime];
    
    
    [self.endTime mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-10);//make.centerX.mas_equalTo(30);
        
        make.height.mas_equalTo(20);
        
        make.top.mas_equalTo(self.startTimee.mas_top);
        
        
    }];
    
    return self;
}

-(void)startButtonClick

{
    NSLog(@"点击了开始");
    
}

-(WL_Pop_CallWindow *)CallWindow
{
    
    if (_CallWindow==nil) {
        
        _CallWindow =[[WL_Pop_CallWindow alloc]init];
        
        [_CallWindow setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        
    }
    return _CallWindow;
}

//联系导游
-(void)concactTourClick
{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.CallWindow];
    
    //self.CallWindow.phone= self.orderMod.guide_mobile;
}

-(void)setOrderModel:(WLOrderListInfo *)orderModel
{
    
    if ([orderModel.mainGuide isEqualToString:@"1"]) {
        _mainRedLabel.text = @"主";
        self.startButton.hidden = NO;
    }
    else
    {
        _mainRedLabel.text = @"副";
        self.startButton.hidden = YES;
    }
    
    if ([orderModel.type isEqualToString:@"0"]) {
        _howCustomerLabel.text = @"散客";
    }
    else if([orderModel.type isEqualToString:@"1"])
    {
        _howCustomerLabel.text = @"定制团";
    }
    _howCourierLabel.text = [NSString stringWithFormat:@"%@导",orderModel.guideNums];
    _howCourierFeeLabel.text = [NSString stringWithFormat:@"导服费：￥%@",orderModel.checkPrice];
    //------
    self.orderMod = orderModel;
    self.orderNumber.text = [NSString stringWithFormat:@"接单时间:%@",orderModel.acceptOrderDate];
    
    self.personNumber.text = [NSString stringWithFormat:@"%ld人",([orderModel.adults integerValue] + [orderModel.children integerValue])];
    
    self.company.text =orderModel.lineName; //路线名
    
    self.startTimee.text = [NSString stringWithFormat:@"%@",orderModel.receiveDate];
    
    self.endTime.text = [NSString stringWithFormat:@"%@",orderModel.sendDate];
    
    if (orderModel.journeyStatus == 1) {
        
        self.startButton.layer.borderColor = WLColor(237, 131, 67, 1).CGColor;
        
        self.startButton.layer.borderWidth =1.0;
        
        [self.startButton setTitleColor:WLColor(237, 131, 67, 1) forState:UIControlStateNormal];
        
        [self.startButton setTitle:@"出发" forState:UIControlStateNormal];
        
        //self.startButton.hidden= NO;
        
    }else if (orderModel.journeyStatus == 2)
    {
        
        self.startButton.layer.borderColor = WLColor(112, 139, 227, 1).CGColor;
        
        self.startButton.layer.borderWidth =1.0;
        
        [self.startButton setTitleColor:WLColor(112, 139, 227, 1) forState:UIControlStateNormal];
        
        [self.startButton setTitle:@"结束" forState:UIControlStateNormal];
        
        //self.startButton.hidden=NO;
        
    }else if (orderModel.journeyStatus == 3)
    {
        self.startButton.hidden = YES;
    }
    else
    {
        self.startButton.hidden = YES;
    }
    
    if (orderModel.mainGuide.boolValue) {
        self.startButton.hidden = NO;
    }else{
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

    // Configure the view for the selected state
}

@end
