//
//  WLApplicationGuidePriceDetailTableViewCell.m
//  WeiLvDJS
//
//  Created by whw on 16/10/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLApplicationGuidePriceDetailTableViewCell.h"

@implementation WLApplicationGuidePriceDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatView];
        
    }
    return self;
}

-(void)creatView{
    _label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 30)];
    _label.textAlignment = NSTextAlignmentLeft;
    _label.font = [UIFont systemFontOfSize:14];
    _label.textColor = [WLTools stringToColor:@"#6f7378"];
    
    [self addSubview:_label];
    
    _textView = [[XKPEPlaceholderTextView alloc] init];
    _textView.frame = CGRectMake(110, 10, 260, 30);
    _textView.font = [UIFont systemFontOfSize:12];
    
    [self addSubview:_textView];
    
    //跳转按钮
    _nextImageView = [[UIImageView alloc] init];
    _nextImageView.frame = CGRectMake(ScreenWidth - 20, 13, 11, 18);
    _nextImageView.image = [UIImage imageNamed:@"arrow"];
    [self addSubview:_nextImageView];
    
    
    _chooseTypelabel = [[UILabel alloc] init];
    _chooseTypelabel.frame = _textView.frame;
    _chooseTypelabel.textColor = [WLTools stringToColor:@"#6f7378"];
    //cell.chooseTypelabel.text = self.rightArray[indexPath.row];
    [self addSubview:_chooseTypelabel];
}



//textView代理方法
-(void)textViewDidEndEditing:(UITextView *)textView{
    //当退出编辑
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
