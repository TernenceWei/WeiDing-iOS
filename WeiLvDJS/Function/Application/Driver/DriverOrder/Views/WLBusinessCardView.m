//
//  WLBusinessCardView.m
//  WeiLvDJS
//
//  Created by ternence on 2016/12/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLBusinessCardView.h"

@interface WLBusinessCardView ()

@property (nonatomic, copy) void(^onPhoneCallAction)(NSString *phoneNO);
@property (nonatomic, copy) void(^onCancelAction)();
@property (nonatomic, strong) NSArray *textArray;

@end

@implementation WLBusinessCardView

- (instancetype)initWithFrame:(CGRect)frame
                    textArray:(NSArray *)textArray
              phoneCallAction:(void(^)(NSString *phoneNO))phoneCallAction
                 cancelAction:(void(^)())cancelAction
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.onPhoneCallAction = phoneCallAction;
        self.onCancelAction = cancelAction;
        self.textArray = textArray;
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    UIView *bgView = [[UIView alloc] init];
    bgView.bounds = CGRectMake(0, 0, ScaleW(251), ScaleH(306));
    bgView.center = self.center;
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 6;
    bgView.layer.masksToBounds = YES;
    [self addSubview:bgView];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bgView.width, ScaleH(36))];
    topView.backgroundColor = Color1;
    [bgView addSubview:topView];
    
    UIButton *iconBtn = [UIButton buttonWithTitle:@"名片" titleColor:[UIColor whiteColor] font:[UIFont WLFontOfSize:14] imageName:@"mingpian" target:nil action:nil];
    iconBtn.frame = CGRectMake(ScaleW(15), 0, topView.width, topView.height);
    iconBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    iconBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    [topView addSubview:iconBtn];
    
    UILabel *nameLabel = [UILabel labelWithText:self.textArray[0] textColor:[UIColor blackColor] fontSize:24];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.frame = CGRectMake(0, topView.bottom + ScaleH(40), topView.width, ScaleH(30));
    [bgView addSubview:nameLabel];
    
    UILabel *roleLabel = [UILabel labelWithText:self.textArray[1] textColor:[WLTools stringToColor:@"#929292"] fontSize:14];
    roleLabel.textAlignment = NSTextAlignmentCenter;
    roleLabel.frame = CGRectMake(0, nameLabel.bottom + ScaleH(10), topView.width, ScaleH(20));
    [bgView addSubview:roleLabel];
    
    UILabel *phoneLabel = [UILabel labelWithText:self.textArray[2] textColor:Color3 fontSize:15];
    phoneLabel.textAlignment = NSTextAlignmentCenter;
    phoneLabel.frame = CGRectMake(0, roleLabel.bottom + ScaleH(40), topView.width, ScaleH(30));
    [bgView addSubview:phoneLabel];
    
    CGFloat buttonW = ScaleW(162);
    UIButton *callBtn = [[UIButton alloc] init];
    callBtn.frame = CGRectMake((bgView.width - buttonW) / 2, phoneLabel.bottom + ScaleH(40), buttonW, ScaleH(35));
    [callBtn setTitle:@"拨打电话" forState:UIControlStateNormal];
    [callBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [callBtn addTarget:self action:@selector(callBtnDidClicked) forControlEvents:UIControlEventTouchUpInside];
    callBtn.backgroundColor = Color1;
    callBtn.layer.cornerRadius = ScaleH(35) / 2;
    callBtn.layer.masksToBounds = YES;
    [bgView addSubview:callBtn];
    
    
    UIButton *cancelBtn = [[UIButton alloc] init];
    [cancelBtn setImage:[UIImage imageNamed:@"guanbimingpian"] forState:UIControlStateNormal];
    cancelBtn.frame = CGRectMake(bgView.right, bgView.top - 30, 44, 44);
    [cancelBtn addTarget:self action:@selector(cancelBtnDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];

}

- (void)callBtnDidClicked
{
    self.onPhoneCallAction(self.textArray[2]);
}

- (void)cancelBtnDidClicked
{
    if (self.onCancelAction) {
        self.onCancelAction();
    }
}
@end
