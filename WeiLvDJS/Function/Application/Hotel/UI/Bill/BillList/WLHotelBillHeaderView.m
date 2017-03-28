//
//  WLHotelBillHeaderView.m
//  WeiLvDJS
//
//  Created by ternence on 16/11/16.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLHotelBillHeaderView.h"

@interface WLHotelBillHeaderView ()
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) NSArray *textArray;

@end

@implementation WLHotelBillHeaderView

- (instancetype)initWithFrame:(CGRect)frame textArray:(NSArray *)textArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = HEXCOLOR(0xf0f3f8);
        self.textArray = textArray;
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI{
    
    self.leftLabel = [[UILabel alloc] init];
    self.leftLabel.textColor = HEXCOLOR(0x2f2f2f);
    self.leftLabel.font = [UIFont WLFontOfSize:14];
    self.leftLabel.textAlignment = NSTextAlignmentLeft;
    self.leftLabel.frame = CGRectMake(ScaleW(12), 0, ScreenWidth / 2, self.bounds.size.height);
    self.leftLabel.text = self.textArray[0];
    [self addSubview:self.leftLabel];
    
    self.rightLabel = [[UILabel alloc] init];
    self.rightLabel.textAlignment = NSTextAlignmentRight;
    self.rightLabel.frame = CGRectMake(ScreenWidth - ScaleW(12) - ScreenWidth / 2, 0, ScreenWidth / 2, self.bounds.size.height);
    self.rightLabel.attributedText = [self getRightText];
    [self addSubview:self.rightLabel];

}


- (NSAttributedString *)getRightText
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = HEXCOLOR(0x2f2f2f);
    attrs[NSFontAttributeName] = [UIFont WLFontOfSize:14];
    NSAttributedString *string1 = [[NSAttributedString alloc] initWithString:@"金额：" attributes:attrs];
    
    NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc] initWithAttributedString:string1];
    
    NSMutableDictionary *attrs2 = [NSMutableDictionary dictionary];
    attrs2[NSForegroundColorAttributeName] = HEXCOLOR(0xff872f);
    attrs2[NSFontAttributeName] = [UIFont WLFontOfSize:15];
    NSAttributedString *string2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@", self.textArray[1]] attributes:attrs2];
    [mutableString  appendAttributedString:string2];
    
    return mutableString;
    
}

@end
