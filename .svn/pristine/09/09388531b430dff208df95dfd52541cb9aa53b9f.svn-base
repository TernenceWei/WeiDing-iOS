//
//  WL_Alert_View.m
//  WeiLv
//
//  Created by nicz on 16/6/20.
//  Copyright © 2016年 WeiLv Technology. All rights reserved.
//

#import "WL_Alert_View.h"

#define ALERT_VIEW_MAX_FONTSIZE 18.0

#define ALERT_VIEW_MIDDLE_FONTSIZE 15.0

#define ALERT_VIEW_MIN_FONTSIZE 14.0

@interface WL_Alert_View ()

@property(weak, nonatomic) UIView *purchaseTipView;

@end

@implementation WL_Alert_View

- (instancetype)init {

    self = [super init];
    
    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    
    self.hidden = YES;
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    [self setLayout];
    
    return self;
}

- (void)setLayout {

    //背景视图
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.frame];
    
    backgroundView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapBgGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapCancel:)];
    
    [backgroundView addGestureRecognizer:tapBgGesture];
    
    backgroundView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:backgroundView];
    
    //对话框
    UIView *alertView = [UIView new];
    
    alertView.layer.masksToBounds = YES;
    
    alertView.layer.cornerRadius = 3.0;
    
    alertView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:alertView];
    
    self.alertView = alertView;
    
    //标题
    UILabel *titleLabel = [UILabel new];
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [alertView addSubview:titleLabel];
    
    self.titleLabel = titleLabel;
    
    //邮轮采购定价提示
    UIView *purchaseTipView = [UIView new];
    
    [alertView addSubview:purchaseTipView];
    
    self.purchaseTipView = purchaseTipView;
    
    //内容
    UILabel *messageLabel = [UILabel new];
    
    messageLabel.numberOfLines = 0;
    
    [alertView addSubview:messageLabel];
    
    self.messageLabel = messageLabel;
    
    //取消按钮
    UILabel *cancelBtn = [UILabel new];
    
    cancelBtn.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapCancelGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapCancel:)];
    
    [cancelBtn addGestureRecognizer:tapCancelGesture];
    
    cancelBtn.font = WLFontSize(ALERT_VIEW_MIDDLE_FONTSIZE);
    
    cancelBtn.textAlignment = NSTextAlignmentCenter;
    
    cancelBtn.layer.masksToBounds = YES;
    
    cancelBtn.layer.borderWidth = 1;
    
    cancelBtn.layer.borderColor = [WLTools stringToColor:@"#dcdcdc"].CGColor;
    
    [alertView addSubview:cancelBtn];
    
    self.cancelBtn = cancelBtn;
    
    //其他按钮
    UILabel *otherBtn = [UILabel new];
    
    otherBtn.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapOtherGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapOther:)];
    
    [otherBtn addGestureRecognizer:tapOtherGesture];
    
    otherBtn.font = WLFontSize(ALERT_VIEW_MIDDLE_FONTSIZE);
    
    otherBtn.textColor = [UIColor whiteColor];
    
    otherBtn.textAlignment = NSTextAlignmentCenter;
    
    otherBtn.layer.masksToBounds = YES;
    
    otherBtn.backgroundColor = [WLTools stringToColor:@"#60b5f6"];
    
    [alertView addSubview:otherBtn];
    
    self.otherBtn = otherBtn;
}

- (void)setAlertType:(AlertType)type title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle andOtherButtonTitle:(NSString *)otherTitle {
    
    [self hide:NO];

    CGFloat width = ScreenWidth * 0.87;
    
    CGFloat marginWidth = 20.0;
    
    CGFloat marginHeight = 15.0;
    
    CGFloat messageFontSize = (type == AlertTypeCall) ? ALERT_VIEW_MAX_FONTSIZE : ALERT_VIEW_MIN_FONTSIZE;
    
    CGFloat titleFontSize = (type == AlertTypeCall) ? ALERT_VIEW_MIDDLE_FONTSIZE : 16.0;
    
    //对话框
    NSDictionary *attributes = @{NSFontAttributeName: WLFontSize(messageFontSize),
                                 NSParagraphStyleAttributeName: [self getParagraphStyleWithFontSize:8]};
    
    CGFloat contentHeight = [message boundingRectWithSize:CGSizeMake(width - marginWidth * 2, width) options: NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height;
    
    CGFloat height = contentHeight + marginHeight * 5 + titleFontSize + 40.0;
    
    [self.alertView setWidth:width];
    
    [self.alertView setHeight:height];
    
    [self.alertView setTop:(self.height - height) / 2];
    
    [self.alertView setLeft:(self.width - width) / 2];
    
    //标题
    [self.titleLabel setWidth:width - marginWidth * 2];
    
    [self.titleLabel setHeight:titleFontSize];
    
    [self.titleLabel setTop:marginHeight];
    
    [self.titleLabel setLeft:marginWidth];
    
    self.titleLabel.text = title;
    
    self.titleLabel.font = WLFontSize(titleFontSize);
    
    self.titleLabel.textColor = (type == AlertTypeCall) ? [WLTools stringToColor:@"#2f2f2f"] : [WLTools stringToColor:@"#60b5f6"];
    
    //邮轮采购定价提示
    if (type == AlertTypePurchase) {
        
        [self.purchaseTipView setTop:CGRectGetMaxY(self.titleLabel.frame) + marginHeight];
    
        for (id obj in self.purchaseTipView.subviews) {
        
            [obj removeFromSuperview];
        }
        
        [self.purchaseTipView widthEqualToView:self.titleLabel];
        
        [self.purchaseTipView setHeight:ALERT_VIEW_MIN_FONTSIZE + 10.0];
        
        [self.purchaseTipView setLeft:marginWidth];
        
        [self.alertView setHeight:height + self.purchaseTipView.height];
        
        CGFloat iconSize = ALERT_VIEW_MIN_FONTSIZE;
        
        //已填完提示图标
        UIImageView *completeIcon = [UIImageView new];
        
        [completeIcon setWidth:iconSize];
        
        [completeIcon setHeight:iconSize];
        
        [completeIcon setTop:0.0];
        
        [completeIcon setLeft:0.0];
        
        completeIcon.image = [UIImage imageNamed:@"cruise_purchase_completed"];
        
        [self.purchaseTipView addSubview:completeIcon];
        
        //已填完提示
        UILabel *completeLabel = [UILabel new];
        
        [completeLabel setWidth:ALERT_VIEW_MIN_FONTSIZE * 7];
        
        [completeLabel setHeight:ALERT_VIEW_MIN_FONTSIZE];
        
        [completeLabel setTop:0.0];
        
        [completeLabel setLeft:CGRectGetMaxX(completeIcon.frame) + 5.0];
        
        completeLabel.text = @"已填完舱房定价";
        
        completeLabel.font = WLFontSize(ALERT_VIEW_MIN_FONTSIZE);
        
        completeLabel.textColor = [WLTools stringToColor:@"#2f2f2f"];
        
        [self.purchaseTipView addSubview:completeLabel];
        
        //未填完提示图标
        UIImageView *uncompleteIcon = [UIImageView new];
        
        [uncompleteIcon setWidth:iconSize];
        
        [uncompleteIcon setHeight:iconSize];
        
        [uncompleteIcon setTop:0.0];
        
        [uncompleteIcon setLeft:CGRectGetMaxX(completeLabel.frame) + 5.0];
        
        uncompleteIcon.image = [UIImage imageNamed:@"cruise_purchase_uncompleted"];
        
        [self.purchaseTipView addSubview:uncompleteIcon];
        
        //未填完提示
        UILabel *uncompleteLabel = [UILabel new];
        
        [uncompleteLabel setWidth:ALERT_VIEW_MIN_FONTSIZE * 7];
        
        [uncompleteLabel setHeight:ALERT_VIEW_MIN_FONTSIZE];
        
        [uncompleteLabel setTop:0.0];
        
        [uncompleteLabel setLeft:CGRectGetMaxX(uncompleteIcon.frame) + 5.0];
        
        uncompleteLabel.text = @"未填完舱房定价";
        
        uncompleteLabel.font = WLFontSize(ALERT_VIEW_MIN_FONTSIZE);
        
        uncompleteLabel.textColor = [WLTools stringToColor:@"#2f2f2f"];
        
        [self.purchaseTipView addSubview:uncompleteLabel];
        
        [self.alertView setHeight:self.alertView.height - marginHeight];
        
    } else {
    
        [self.purchaseTipView setTop:CGRectGetMaxY(self.titleLabel.frame) + (marginHeight * 3) / 2];
    }
    
    //内容
    [self.messageLabel widthEqualToView:self.titleLabel];
    
    [self.messageLabel setHeight:contentHeight];
    
    [self.messageLabel setTop:CGRectGetMaxY(self.purchaseTipView.frame)];
    
    [self.messageLabel setLeft:marginWidth];
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:message attributes:attributes];
    
    self.messageLabel.attributedText = attributeStr;
    
    self.messageLabel.font = WLFontSize(messageFontSize);
    
    self.messageLabel.textColor = (type == AlertTypeCall) ? [WLTools stringToColor:@"#60b5f6"] : [WLTools stringToColor:@"#2f2f2f"];
    
    self.messageLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    if(contentHeight < marginWidth){
        
        self.messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    //取消按钮
    CGFloat buttonWidth = (self.messageLabel.width - marginWidth) / 2;
    
    CGFloat buttonHeight = 34.0;
    
    [self.cancelBtn setWidth:buttonWidth];
    
    [self.cancelBtn setHeight:buttonHeight];
    
    [self.cancelBtn setTop:self.alertView.height - marginHeight - self.cancelBtn.height];
    
    [self.cancelBtn setLeft:marginWidth];
    
    self.cancelBtn.text = cancelTitle;
    
    self.cancelBtn.layer.cornerRadius = buttonHeight / 2;
    
    if(type == AlertTypeHighlight){
        
        self.cancelBtn.textColor = [WLTools stringToColor:@"#60b5f6"];
        
    }else{
        
        self.cancelBtn.textColor = [WLTools stringToColor:@"#6f7378"];
    }
    
    //其他按钮
    [self.otherBtn widthEqualToView:self.cancelBtn];
    
    [self.otherBtn heightEqualToView:self.cancelBtn];
    
    [self.otherBtn setTop:self.cancelBtn.top];
    
    [self.otherBtn setLeft:CGRectGetMaxX(self.cancelBtn.frame) + marginWidth];
    
    self.otherBtn.text = otherTitle;
    
    self.otherBtn.layer.cornerRadius = buttonHeight / 2;
}

//设置段落样式
- (NSMutableParagraphStyle *)getParagraphStyleWithFontSize:(CGFloat)size {
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    paraStyle.lineSpacing = size;
    
    paraStyle.hyphenationFactor = 1.0;
    
    paraStyle.firstLineHeadIndent = 0.0;
    
    paraStyle.paragraphSpacingBefore = 0.0;
    
    paraStyle.headIndent = 0;
    
    paraStyle.tailIndent = 0;
    
    return paraStyle;
}

- (void)onTapCancel:(UITapGestureRecognizer *)tap {
    
    [self hide:YES];
    
    if (self.cancelButtonClicked) {
        self.cancelButtonClicked();
    }
}

- (void)hide:(BOOL)hidden {
    
    CATransition *animation = [CATransition animation];
    
    animation.duration = 0.3;
    
    animation.type = kCATransitionFade;
    
    [self.layer addAnimation:animation forKey:nil];
    
    self.hidden = hidden;
}

- (void)onTapOther:(UITapGestureRecognizer *)tap {
    
    [self hide:YES];
    
    if(self.otherButtonClicked){
        
        self.otherButtonClicked();
    }
}

@end
