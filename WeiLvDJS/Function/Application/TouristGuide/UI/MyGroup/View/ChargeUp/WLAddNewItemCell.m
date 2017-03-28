//
//  WLAddNewItemCell.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLAddNewItemCell.h"

#define cellIdentifier @"WLAddNewItemCell"

@interface WLAddNewItemCell ()
@property (nonatomic, strong) UIButton *addBtn;
@end

@implementation WLAddNewItemCell

+ (WLAddNewItemCell *)cellWithTableView:(UITableView*)tableView{
    WLAddNewItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLAddNewItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
        self.exclusiveTouch = YES;
        self.multipleTouchEnabled = NO;
    }
    return self;
}

- (void)setupUI{
    
    self.addBtn = [[UIButton alloc] init];
    [self.addBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.addBtn setTitle:@"添加新的报价方式" forState:UIControlStateNormal];
    [self.addBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    self.addBtn.frame = CGRectMake(0, 0, ScreenWidth, 44);
    self.addBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self addSubview:self.addBtn];
    
}
@end
