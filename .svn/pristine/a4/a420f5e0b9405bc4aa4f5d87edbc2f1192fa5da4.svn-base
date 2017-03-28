//
//  WL_Application_TourGuide_Price_TableViewCell4.m
//  WeiLvDJS
//
//  Created by jyc on 16/10/11.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_TourGuide_Price_TableViewCell4.h"

@implementation WL_Application_TourGuide_Price_TableViewCell4

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    _addButon = [[UIButton alloc] initWithFrame:CGRectMake(120, 15, 11, 18)];
    [_addButon setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    [_addButon addTarget:self action:@selector(addCell) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addButon];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(140, 15, 190, 15)];
    _label.font = [UIFont systemFontOfSize:14];
    _label.textColor = [WLTools stringToColor:@"#4977e7"];
    _label.textAlignment = NSTextAlignmentLeft;
    _label.text = @"添加新的报价方式";
    [self addSubview:_label];
}

-(void)addCell{
//    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
//    for (int i = 0; i < 3; i++) {
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
//        [indexPaths addObject:indexPath];
//    }
//    
//    WL_Application_TourGuide_info_ViewController *appVc = [[ WL_Application_TourGuide_info_ViewController alloc] init];
//    [appVc.InformationTableView beginUpdates];
//    [appVc.InformationTableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
//    [appVc.InformationTableView endUpdates];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
