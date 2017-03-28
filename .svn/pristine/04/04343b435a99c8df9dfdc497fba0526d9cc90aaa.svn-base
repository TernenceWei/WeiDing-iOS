//
//  WLApplicationDriverBookOrderDetailCell2.m
//  WeiLvDJS
//
//  Created by whw on 17/2/27.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLApplicationDriverBookOrderDetailCell2.h"

@interface WLApplicationDriverSettingOrderDetailButton : UIButton

@end
@implementation WLApplicationDriverSettingOrderDetailButton

- (instancetype)init
{
    if (self = [super init])
    {
        [self setImage:[UIImage imageNamed:@"feiyongbubaohan"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"feiyongbaohan"] forState:UIControlStateSelected];
        
        [self setTitleColor:Color3 forState:UIControlStateNormal];
        [self setTitleColor:Color2 forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont WLFontOfSize:11];
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.userInteractionEnabled = NO;
    }
    return self;
}

@end

@interface WLApplicationDriverBookOrderDetailCell2()
/**< 保存所有按钮的数组 */
@property (nonatomic, strong) NSMutableArray <WLApplicationDriverSettingOrderDetailButton *>*buttonsArray;
@property (nonatomic, strong) NSArray *titleArray;/**< 按钮文字的数组 */

@end
@implementation WLApplicationDriverBookOrderDetailCell2

static NSString *identifier = @"OrderDetailCell3";
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
    CGFloat btnW = 0.0;
    CGFloat buttinMargin;
    if(IsiPhone4 || IsiPhone5)
    {
        btnW = ScaleW(70);
        buttinMargin = ScaleW(15);
    }else
    {
       btnW = ScaleW(65);
        buttinMargin = ScaleW(20);
    }
    
    for (int i = 0; i < 4; i++) {
        WLApplicationDriverSettingOrderDetailButton *setButton = [[WLApplicationDriverSettingOrderDetailButton alloc]init];
        [self.contentView addSubview:setButton];
        
        [setButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(ScaleW(20));
            make.left.equalTo(self.contentView).offset(ScaleW(30) + (btnW + buttinMargin)*i);
            make.width.offset(btnW);
            make.bottom.equalTo(self.contentView).offset(-ScaleW(20));
        }];
        [setButton setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [self.buttonsArray addObject:setButton];
    }
}
+ (instancetype)cellForTableView:(UITableView *)tableView
{
    WLApplicationDriverBookOrderDetailCell2 *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[WLApplicationDriverBookOrderDetailCell2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    
    if(dataArray.count >0){
        self.buttonsArray[0].selected = [dataArray containsObject:@"1"]?YES:NO;
        self.buttonsArray[1].selected = [dataArray containsObject:@"2"]?YES:NO;
        self.buttonsArray[2].selected = [dataArray containsObject:@"3"]?YES:NO;
        self.buttonsArray[3].selected = [dataArray containsObject:@"4"]?YES:NO;
    }else
    {
        for (WLApplicationDriverSettingOrderDetailButton *btn in self.buttonsArray) {
            btn.selected = YES;
        }
    }
}
- (NSArray *)titleArray
{
    if (_titleArray == nil) {
        _titleArray = @[ @"小费",@"油费",@"过路费",@"停车费"];
    }
    return _titleArray;
}
- (NSMutableArray *)buttonsArray
{
    if (_buttonsArray == nil) {
        _buttonsArray = [NSMutableArray arrayWithCapacity:self.titleArray.count];
    }
    return _buttonsArray;
}
@end
