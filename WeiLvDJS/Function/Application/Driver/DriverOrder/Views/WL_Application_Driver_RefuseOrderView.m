//
//  WL_Application_Driver_RefuseOrderView.m
//  WeiLvDJS
//
//  Created by whw on 16/12/21.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_RefuseOrderView.h"
#define buttonH 15
@interface WL_Application_Driver_RefuseOrderButton : UIButton

@end
@implementation WL_Application_Driver_RefuseOrderButton

- (instancetype)init
{
    if (self = [super init])
    {
        [self setImage:[UIImage imageNamed:@"Driver_Order_NoSelected"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"Driver_Order_Selected"] forState:UIControlStateSelected];
        
        [self setTitleColor:[WLTools stringToColor:@"#333333"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont WLFontOfSize:17];
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return self;
}

@end


@interface WL_Application_Driver_RefuseOrderView()<UITextViewDelegate>
/** 拒绝订单原因数组 */
@property(nonatomic, strong) NSArray *refuseReasonsArray;
/**< 保存被点击按钮的数组 */
@property (nonatomic, strong) NSMutableArray *selectedButtonArray;

/**< 确定拒绝按钮 */
@property (nonatomic, weak) UIButton *sureButton;
/**< 保存其他原因输入框的内容 */
@property (nonatomic, copy) NSString *otherTitle;
@end
@implementation WL_Application_Driver_RefuseOrderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.refuseReasonsArray = @[ @"价格太低", @"订单信息不全", @"车辆暂时无法正常行驶", @"其他原因" ];
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    UILabel *topLabel = [[UILabel alloc]init];
    UITextView *otherTextView = [[UITextView alloc]init];
    otherTextView.layer.borderColor = [WLTools stringToColor:@"#e4e4e4"].CGColor;
    otherTextView.layer.borderWidth = 1.0;
    UIButton *cancelButton = [[UIButton alloc]init];
    UIButton *sureButton = [[UIButton alloc]init];
    
    topLabel.text = @"请选择您拒绝的理由:";
    topLabel.textColor = [WLTools stringToColor:@"#333333"];
    topLabel.font = [UIFont WLFontOfBoldSize:17];
    
    [self addSubview:topLabel];
    
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(ScaleH(33));
        make.left.equalTo(self).offset(ScaleW(17));
    }];
    
    for (int i = 0; i < self.refuseReasonsArray.count; ++i)
    {
        WL_Application_Driver_RefuseOrderButton *reasonButton = [[WL_Application_Driver_RefuseOrderButton alloc]init];
        [reasonButton setTitle:self.refuseReasonsArray[i] forState:UIControlStateNormal];
        [reasonButton addTarget:self action:@selector(didChoseReasonButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:reasonButton];
        
       [reasonButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
           make.top.equalTo(topLabel.mas_bottom).offset(ScaleH(30) + (ScaleH(25) + buttonH)*i);
           make.left.equalTo(self).offset(ScaleW(23));
           make.right.equalTo(self).offset(-ScaleW(20));
       }];
        
    }
    
    [self addSubview:otherTextView];
    otherTextView.font = [UIFont WSFontOfSize:14];
    otherTextView.delegate = self;
    otherTextView.hidden = YES;
    [otherTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLabel.mas_bottom).offset(ScaleH(200));
        make.left.equalTo(self).offset(ScaleW(14));
        make.right.equalTo(self).offset(-ScaleW(14));
        make.height.offset(ScaleH(86));
    }];
    
    
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.tag = 100;
    [cancelButton setTitleColor:[WLTools stringToColor:@"#333333"] forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont WLFontOfBoldSize:17];
    cancelButton.layer.borderColor = [WLTools stringToColor:@"#e4e4e4"].CGColor;
    cancelButton.layer.borderWidth = 1;
    [cancelButton addTarget:self action:@selector(didClickOrderButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [sureButton setTitleColor:[WLTools stringToColor:@"#ffffff"] forState:UIControlStateNormal];
    [sureButton setTitle:@"确定拒绝" forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont WLFontOfBoldSize:17];
    sureButton.backgroundColor = [WLTools stringToColor:@"#e4e4e4"];
    [sureButton setTitleColor:[WLTools stringToColor:@"#929292"] forState:UIControlStateDisabled];
    sureButton.layer.borderColor = [WLTools stringToColor:@"#e4e4e4"].CGColor;
    sureButton.layer.borderWidth = 1;
    sureButton.tag = 101;
    [sureButton addTarget:self action:@selector(didClickOrderButton:) forControlEvents:UIControlEventTouchUpInside];
    sureButton.enabled = NO;
    [self addSubview:cancelButton];
    [self addSubview:sureButton];
    
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(self);
        make.height.offset(ScaleH(44));
    }];
    
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        make.left.equalTo(cancelButton.mas_right);
        make.width.height.equalTo(cancelButton);
    }];
    
    self.reasonTextView = otherTextView;
    self.sureButton = sureButton;
}

#pragma mark - 按钮的点击事件
- (void)didChoseReasonButton:(WL_Application_Driver_RefuseOrderButton *)button
{
    
    button.selected = !button.selected;
    if (button.selected)
    {
        if (![self.selectedButtonArray containsObject:button.currentTitle]) {
            [self.selectedButtonArray addObject:button.currentTitle];
        }
    }else
    {
        if ([self.selectedButtonArray containsObject:button.currentTitle]) {
            [self.selectedButtonArray removeObject:button.currentTitle];
        }
    }
    
    if ([button.currentTitle isEqualToString:self.refuseReasonsArray.lastObject])//说明点击的是其他原因按钮
    {
        self.reasonTextView.hidden = !button.selected;
        if (self.reasonTextView.hidden)
        {
            if ([self.selectedButtonArray containsObject:self.otherTitle]) {
                [self.selectedButtonArray removeObject:self.otherTitle];
            }
            [self.reasonTextView resignFirstResponder];
        }else
        {
          if(self.otherTitle.length > 0)
          {
              if (![self.selectedButtonArray containsObject:self.otherTitle]) {
                  [self.selectedButtonArray addObject:self.otherTitle];
              }
          }
        }
        [self.selectedButtonArray removeObject:button.currentTitle];//移除其他原因提示
        if(self.otherReasonCallBlack)
        {
            self.otherReasonCallBlack(button.selected);
        }
    }
    self.sureButton.enabled = self.selectedButtonArray.count > 0;
    
    if (self.sureButton.enabled)
    {
        self.sureButton.backgroundColor = [WLTools stringToColor:@"#00cc99"];
    }else
    {
        self.sureButton.backgroundColor = [WLTools stringToColor:@"#e4e4e4"];
    }
}

- (void)didClickOrderButton:(UIButton *)button
{
    if (button.tag == 100)//点击的是取消按钮
    {
        if (self.ButtonCallBlack)
        {
            self.ButtonCallBlack(nil);
        }
    }else if(button.tag == 101)//点击的是确定拒绝按钮
    {
        __weak typeof(self) weakSelf = self;
        if (self.ButtonCallBlack)
        {
            if (!self.reasonTextView.hidden) {
                if([self.selectedButtonArray containsObject:self.otherTitle])
                {
                    [self.selectedButtonArray removeObject:self.otherTitle];//目的还为了让其他原因放到最后;
                    [self.selectedButtonArray addObject:self.otherTitle];
                }else if (self.otherTitle.length > 0)
                {
                   [self.selectedButtonArray addObject:self.otherTitle];
                }
            }
            
            
             self.ButtonCallBlack(weakSelf.selectedButtonArray.copy);
        }
    
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 0) {
        self.sureButton.enabled = YES;
        self.sureButton.backgroundColor = [WLTools stringToColor:@"#00cc99"];
      
    }else
    {
      if(self.sureButton.enabled == NO)
      {
      self.sureButton.backgroundColor = [WLTools stringToColor:@"#e4e4e4"];
      }
    }
    self.otherTitle = textView.text;
}
#pragma mark -懒加载
- (NSMutableArray *)selectedButtonArray
{
    if (_selectedButtonArray == nil) {
        _selectedButtonArray = [NSMutableArray array];
    }
    return _selectedButtonArray;
}
@end











