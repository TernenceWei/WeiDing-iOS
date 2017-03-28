//
//  WLQuotePriceView.m
//  WeiLvDJS
//
//  Created by whw on 17/2/9.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLQuotePriceView.h"

@interface WLApplicationDriverSettingOrderButton : UIButton

@end
@implementation WLApplicationDriverSettingOrderButton

- (instancetype)init
{
    if (self = [super init])
    {
        [self setImage:[UIImage imageNamed:@"Driver_Order_NoSelected"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"Driver_Order_Selected"] forState:UIControlStateSelected];
        
        [self setTitleColor:[WLTools stringToColor:@"#333333"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont WLFontOfSize:14];
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return self;
}

@end
@interface WLQuotePriceView ()

@property (nonatomic, weak) UITextField *priceTextField;/**< 价格 */
@property (nonatomic, weak) UIButton *quoteButton;/**< 竞价按钮 */
@property(nonatomic, strong) NSArray *buttonsTitleArray;/**< 保存所有按钮文字的数组 */
@property (nonatomic, strong) NSMutableArray *allButtonsArray;/**< 保存所有按钮的数组 */
@property (nonatomic, strong) NSMutableArray *selectedButtonArray;/**< 保存高亮按钮的数组 */
@property (nonatomic, weak)  WLApplicationDriverSettingOrderButton *allSelectedButton;/**< 全选按钮 */
@end

@implementation WLQuotePriceView
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [WLTools stringToColor:@"#ffffff"];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.buttonsTitleArray = @[ @"含小费",@"含油费",@"含过路费",@"含停车费", ];
        [self setupUI];
    }
    return self;
}
- (void)setupUI
{

    UILabel *tipLabel = [[UILabel alloc]init];
    UITextField *priceTextField = [[UITextField alloc]init];
    UIButton *cancelButton = [[UIButton alloc]init];
    UIButton *quoteButton = [[UIButton alloc]init];

    
    tipLabel.font = [UIFont WLFontOfSize:17];
    tipLabel.textColor = Color1;
    tipLabel.text = @"请输入您的报价并耐心等待:";
    
    
//    leftLabel.text = @"¥";
//    leftLabel.font = [UIFont WLFontOfSize:24];
//    leftLabel.textColor = Color2;
    
    priceTextField.keyboardType = UIKeyboardTypeDecimalPad;
    priceTextField.textColor = Color2;
    priceTextField.font = [UIFont WLFontOfSize:24];
    priceTextField.borderStyle = UITextBorderStyleLine;
    priceTextField.layer.borderColor = Color4.CGColor;
    priceTextField.layer.borderWidth = 0.5;
    
    [cancelButton setTitleColor:Color2 forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont WLFontOfSize:17];
    cancelButton.layer.borderColor = Color4.CGColor;
    cancelButton.layer.borderWidth = 0.5;
    
    [quoteButton setTitleColor:Color1 forState:UIControlStateNormal];
    quoteButton.titleLabel.font = [UIFont WLFontOfSize:17];
    quoteButton.layer.borderColor = Color4.CGColor;
    quoteButton.layer.borderWidth = 0.5;
//    quoteButton.userInteractionEnabled = NO;
    
    cancelButton.tag = 20;
    quoteButton.tag = 21;
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [quoteButton setTitle:@"确定报价" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    [quoteButton addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    

    [self addSubview:tipLabel];
//    [self addSubview:leftLabel];
    [self addSubview:priceTextField];
    [self addSubview:cancelButton];
    [self addSubview:quoteButton];
    
//    [iconImage mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).offset(ScaleH(32));
//        make.left.equalTo(self).offset(ScaleW(15));
//    }];
//    
//    [driveCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(iconImage);
//        make.left.equalTo(iconImage.mas_right).offset(ScaleW(9));
//    }];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(ScaleH(32));
        make.left.equalTo(self).offset(ScaleW(25));
    }];
    
//    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(tipLabel.mas_bottom).offset(ScaleH(19));
//        make.left.equalTo(self).offset(ScaleW(25));
//        make.width.offset(ScaleW(15));
//    }];
    [priceTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipLabel.mas_bottom).offset(ScaleH(10));
        make.left.equalTo(self).offset(ScaleW(20));
        make.right.equalTo(self).offset(- ScaleW(20));
        make.height.offset(ScaleH(50));
    }];
    
    CGFloat buttonH = 15;
    CGFloat buttonW = ScaleW(120);
    
    for (int i = 0; i <= self.buttonsTitleArray.count; i++)
    {
        WLApplicationDriverSettingOrderButton *button = [[WLApplicationDriverSettingOrderButton alloc]init];
        if (i == self.buttonsTitleArray.count) {
            button.tag = 200;
            [button setTitle:@"全选" forState:UIControlStateNormal];
            self.allSelectedButton = button;
        }else{
            [self.allButtonsArray addObject:button];
            [button setTitle:self.buttonsTitleArray[i] forState:UIControlStateNormal];
        }
        
        [button addTarget:self action:@selector(didChoseSettingButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    
        
        CGFloat btnT = ScaleH(30) + (ScaleH(25) + buttonH)*(i/2);
        CGFloat bthL = ScaleW(23) + (buttonW +ScaleW(20))*(i%2);
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(priceTextField.mas_bottom).offset(btnT);
                make.left.equalTo(self).offset(bthL);
                make.width.offset(buttonW);
            }];
       
        
    }
    
    
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(self);
        make.height.offset(ScaleH(55));
    }];
    [quoteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        make.left.equalTo(cancelButton.mas_right);
        make.width.height.equalTo(cancelButton);
    }];
    self.priceTextField = priceTextField;
    self.quoteButton = quoteButton;

}

- (void)didMoveToSuperview /**< 默认全选 */
{
    [super didMoveToSuperview];
    [self didChoseSettingButton:self.allSelectedButton];
}
#pragma mark - 设置选项按钮的点击事件
- (void)didChoseSettingButton:(WLApplicationDriverSettingOrderButton *)button
{
    button.selected = !button.selected;
    if (button.tag == 200) {/**< 说明点击的是全选按钮 */
        for(WLApplicationDriverSettingOrderButton *otherButton in self.allButtonsArray){
            otherButton.selected = button.selected;
        }
        [self.selectedButtonArray removeAllObjects];/**< 防止重复添加 */
        button.selected == YES ?[self.selectedButtonArray addObjectsFromArray:self.buttonsTitleArray]:[self.selectedButtonArray removeAllObjects];
    }else {
        if (button.selected) {
            if (self.selectedButtonArray.count == self.buttonsTitleArray.count -1) {
                self.allSelectedButton.selected = YES;
                [self.selectedButtonArray removeAllObjects];
                [self.selectedButtonArray addObjectsFromArray:self.buttonsTitleArray];
            }else
            {
               [self.selectedButtonArray addObject:button.currentTitle];
            }
        }else
        {
            if (self.selectedButtonArray.count == self.buttonsTitleArray.count) {
                self.allSelectedButton.selected = NO;
                [self.selectedButtonArray removeAllObjects];
                [self.selectedButtonArray addObjectsFromArray:self.buttonsTitleArray];
                [self.selectedButtonArray removeObject:button.currentTitle];
            }else
            {
                [self.selectedButtonArray removeObject:button.currentTitle];
            }
        }
    }
//    WlLog(@" self.selectedButtonArray %@",self.selectedButtonArray);
    
}
#pragma mark - 确定按钮的点击事件
- (void)didClickButton:(UIButton *)sender
{
    if (sender.tag == 21) {
        if (![WLRegularExpression ba_isMoneyNumberString:self.priceTextField.text]) {
            [[WL_TipAlert_View sharedAlert] createTip:@"请输入正确的金额."];
            return;
        }
        if([self.priceTextField.text doubleValue] *100 <= 0)
        {
            [[WL_TipAlert_View sharedAlert] createTip:@"请输入正确的金额."];
            return;
        }
    }
    
    if (self.buttonCallBack) {
        WS(weakSelf);
        self.buttonCallBack(sender.tag,weakSelf.priceTextField.text,[weakSelf getParasFromArray:weakSelf.selectedButtonArray]);
    }
    
}

- (NSString *)getParasFromArray:(NSMutableArray *)titleArray
{
    NSMutableString *strM = [NSMutableString string];
    if ([titleArray isKindOfClass:[NSMutableArray class]]) {
        if ([titleArray containsObject:@"含小费"]) {
            strM = [strM stringByAppendingString:@"1,"].mutableCopy;
        }
        if ([titleArray containsObject:@"含油费"]) {
           strM = [strM stringByAppendingString:@"2,"].mutableCopy;
        }
        if ([titleArray containsObject:@"含过路费"]) {
           strM = [strM stringByAppendingString:@"3,"].mutableCopy;
        }
        if ([titleArray containsObject:@"含停车费"]) {
           strM = [strM stringByAppendingString:@"4,"].mutableCopy;
        }
    }
    if(strM.length >0){
        strM = [strM substringToIndex:strM.length -1].mutableCopy;
    }
    return strM.copy;
}
//- (void)didPriceTextFieldEdit:(UITextField *)textField
//{
//    self.quoteButton.userInteractionEnabled = textField.text.length>0?YES:NO;
//}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.priceTextField becomeFirstResponder];
}
#pragma mark -懒加载
- (NSMutableArray *)allButtonsArray
{
    if (_allButtonsArray == nil) {
        _allButtonsArray = [NSMutableArray array];
    }
    return _allButtonsArray;
}
- (NSMutableArray *)selectedButtonArray
{
    if (_selectedButtonArray == nil) {
        _selectedButtonArray = [NSMutableArray array];
    }
    return _selectedButtonArray;
}
@end






















