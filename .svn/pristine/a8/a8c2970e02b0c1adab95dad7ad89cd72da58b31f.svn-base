//
//  WLRemarkCell.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLRemarkCell.h"
#import "XKPEPlaceholderTextView.h"

#define cellIdentifier @"WLRemarkCell"

@interface WLRemarkCell ()<UITextViewDelegate>
@property (nonatomic, assign) BOOL canEdit;
@property (nonatomic, copy) void(^onKeyboardBlock)(BOOL keyboardShow,CGFloat height, NSUInteger section);
@property (nonatomic, strong) NSString *middleRemark;
@end

@implementation WLRemarkCell

+ (WLRemarkCell *)cellWithTableView:(UITableView*)tableView
                             remark:(NSString *)remark
                                tag:(NSUInteger)tag
                            canEdit:(BOOL)canEdit
                      keyboardBlock:(void (^)(BOOL, CGFloat, NSUInteger))keyboardBlock
                       middleRemark:(NSString *)middleRemark{
    
    WLRemarkCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLRemarkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.tag = tag;
    cell.middleRemark = middleRemark;
    cell.canEdit = canEdit;
    cell.onKeyboardBlock = keyboardBlock;
    [cell setupUIWithRemark:remark];
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

    }
    return self;
}

- (void)setupUIWithRemark:(NSString *)remark
{

    self.textView = [[XKPEPlaceholderTextView alloc] init];
    self.textView.layer.borderWidth = 0.5;
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.borderColor = [UIColor grayColor].CGColor;
    self.textView.layer.cornerRadius = 5;
    self.textView.textColor = [WLTools stringToColor:@"#2f2f2f"];
    self.textView.placeholderColor = [WLTools stringToColor:@"#868686"];
    self.textView.font = [UIFont WLFontOfSize:14];
    self.textView.frame = CGRectMake(ScaleW(12), ScaleH(5), ScreenWidth - ScaleW(24), ScaleH(90));
    self.textView.text = remark;
    self.textView.delegate = self;
    [self addSubview:self.textView];
    if (self.canEdit) {
        self.textView.userInteractionEnabled = YES;
    }else{
       self.textView.userInteractionEnabled = NO;
    }
    
    if (![self.middleRemark isEqualToString:@""] && self.middleRemark != nil) {
        self.textView.text = self.middleRemark;
    }
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.onKeyboardBlock(YES, 282, self.tag);
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.onKeyboardBlock(NO, 0, self.tag);

}

- (void)textViewDidChange:(UITextView *)textView
{
    self.onKeyboardBlock(NO, 20, self.tag);

}

- (void)prepareForReuse
{
    [super prepareForReuse];
    for (UIView *subV in self.subviews) {
        [subV removeFromSuperview];
    }
}

- (NSString *)getUploadeRemark
{
    return self.textView.text;
}

@end
