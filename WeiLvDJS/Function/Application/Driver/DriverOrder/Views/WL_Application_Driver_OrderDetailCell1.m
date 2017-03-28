//
//  WL_Application_Driver_OrderDetailCell1TableViewCell.m
//  WeiLvDJS
//
//  Created by whw on 16/12/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_OrderDetailCell1.h"

@interface WL_Application_Driver_OrderDetailCell1 ()

/**< 开始时间 */
@property (nonatomic, weak) UILabel *startTimeLabel;
/**< 起始位置 */
@property (nonatomic, weak) UILabel *startPositionLabel;
/**< 结束时间 */
@property (nonatomic, weak) UILabel *endTimeLabel;
/**< 结束位置 */
@property (nonatomic, weak) UILabel *endPositionLabel;

@end

@implementation WL_Application_Driver_OrderDetailCell1
static NSString *identifier = @"OrderDetailCell1";
#define cell1Margin 10
#pragma mark - 重写构造方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置子控件
        [self setupUI];
        //设置cell点击不变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    }
    return self;
}

- (void)setupUI
{
    UILabel *originLabel = [[UILabel alloc]init];
    UILabel *startTimeLabel = [[UILabel alloc]init];
    UILabel *startPositionLabel = [[UILabel alloc]init];
    UILabel *endPointLabel = [[UILabel alloc]init];
    UILabel *endTimeLabel = [[UILabel alloc]init];
    UILabel *endPositionLabel = [[UILabel alloc]init];
    
    originLabel.text = @"起点";
    originLabel.textColor = Color3;
    originLabel.font = [UIFont WLFontOfSize:14];
    startTimeLabel.textAlignment = NSTextAlignmentLeft;
    startTimeLabel.textColor = Color2;
    startTimeLabel.font = [UIFont WLFontOfSize:14];
    startPositionLabel.textColor = Color2;
    startPositionLabel.font = [UIFont WLFontOfSize:14];
    startPositionLabel.numberOfLines = 0;
    startPositionLabel.textAlignment = NSTextAlignmentLeft;
    endPointLabel.text = @"终点";
    endPointLabel.textColor = Color3;
    endPointLabel.font = [UIFont WLFontOfSize:14];
    endTimeLabel.textAlignment = NSTextAlignmentLeft;
    endTimeLabel.textColor = Color2;
    endTimeLabel.font = [UIFont WLFontOfSize:14];
    endPositionLabel.textColor = Color2;
    endPositionLabel.font = [UIFont WLFontOfSize:14];
    endPositionLabel.numberOfLines = 0;
    endPositionLabel.textAlignment = NSTextAlignmentLeft;
    
    [self.contentView addSubview:originLabel];
    [self.contentView addSubview:startTimeLabel];
    [self.contentView addSubview:startPositionLabel];
    [self.contentView addSubview:endPointLabel];
    [self.contentView addSubview:endTimeLabel];
    [self.contentView addSubview:endPositionLabel];
    
    [originLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(ScaleH(23));
        make.left.equalTo(self.contentView).offset(ScaleW(12));
        make.width.offset(ScaleW(40));
    }];
   [startTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerY.equalTo(originLabel);
       make.left.equalTo(originLabel.mas_right).offset(ScaleW(42));
   }];
    [startPositionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(startTimeLabel);
        make.top.equalTo(startTimeLabel.mas_bottom).offset(ScaleH(15));
        make.right.equalTo(self.contentView).offset(- ScaleW(12));
    }];
    [endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(startPositionLabel.mas_bottom).offset(ScaleH(30));
        make.leading.equalTo(startTimeLabel);
        
    }];
    [endPositionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(endTimeLabel.mas_bottom).offset(ScaleH(15));
        make.leading.equalTo(startTimeLabel);
        make.bottom.equalTo(self.contentView).offset(- ScaleH(23));
         make.right.equalTo(self.contentView).offset(- ScaleW(12));
    }];
    [endPointLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(ScaleW(12));
        make.top.equalTo(startPositionLabel.mas_bottom).offset(ScaleH(30));
        make.width.offset(ScaleW(40));
    }];

    self.startTimeLabel = startTimeLabel;
    self.startPositionLabel = startPositionLabel;
    self.endTimeLabel = endTimeLabel;
    self.endPositionLabel = endPositionLabel;
    
     startTimeLabel.text = @"2016-1-1 00: 00";
     startPositionLabel.text = @"假数据";
     endTimeLabel.text = @"2016-1-1 00: 00";
     endPositionLabel.text = @"假数据";
}
- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    if (dataArray && dataArray.count > 0) {
        self.startTimeLabel.text = [NSString getDateStringWithTime:[dataArray objectAtIndex:0] andFormatter:@"yyyy-MM-dd HH: mm"];
        self.startPositionLabel.text = [dataArray objectAtIndex:1];
        self.endTimeLabel.text = [NSString getDateStringWithTime:[dataArray objectAtIndex:2] andFormatter:@"yyyy-MM-dd"];
        self.endPositionLabel.text = [dataArray objectAtIndex:3];
    }
}

+ (instancetype)cellForTableView:(UITableView *)tableView
{
    WL_Application_Driver_OrderDetailCell1 *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[WL_Application_Driver_OrderDetailCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
@end
