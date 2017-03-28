//
//  WL_AddressBook_Organization_TitleScrollView.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_Organization_TitleScrollView.h"

@interface WL_AddressBook_Organization_TitleScrollView ()

@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, copy) void(^onSelectAction)(NSString *departID, NSArray *newArray);

@end

@implementation WL_AddressBook_Organization_TitleScrollView
- (NSMutableArray *)buttonArray
{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (instancetype)initWithFrame:(CGRect)frame
                  companyName:(NSString *)companyName
                    dataArray:(NSArray *)dataArray
                 selectAction:(void (^)(NSString *, NSArray *))selectAction
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.dataArray = [dataArray mutableCopy];
        self.onSelectAction = selectAction;
        for (int i = 0; i < dataArray.count + 1; i++) {

            UIButton *titleButton = [[UIButton alloc] init];
            titleButton.titleLabel.font = WLFontSize(16);
            [titleButton setTitleColor:Color1 forState:UIControlStateNormal];
            [titleButton setTitleColor:[WLTools stringToColor:@"#868686"] forState:UIControlStateDisabled];
            
            CGFloat originalX = 0;
            if (i == 0) {
                [titleButton setTitle:companyName forState:UIControlStateNormal];
                [titleButton setTitle:companyName forState:UIControlStateDisabled];
                titleButton.tag = 0;
                [titleButton setImage:[UIImage imageWithColor:[WLTools stringToColor:@"#ffffff"]] forState:UIControlStateNormal];
            }else{
                WL_AddressBook_Organization_Department_Model *departmentModel = dataArray[i - 1];
                [titleButton setTitle:departmentModel.department_name forState:UIControlStateNormal];
                [titleButton setTitle:departmentModel.department_name forState:UIControlStateDisabled];
                [titleButton setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
                titleButton.tag = departmentModel.department_id.integerValue;
                
                UIButton *lastButton = self.buttonArray[i - 1];
                originalX = lastButton.right +  2;
                
            }
            
            CGFloat width = [WLUITool sizeWithString:[titleButton titleForState:UIControlStateNormal] font:WLFontSize(16)].width + 20;
            titleButton.frame = CGRectMake(originalX, 0, width, self.height);
            [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
            titleButton.enabled = i != dataArray.count;
            [self addSubview:titleButton];
            [self.buttonArray addObject:titleButton];
        
        }
        
        UIButton *lastBtn = [self.buttonArray lastObject];
        self.contentSize = CGSizeMake(lastBtn.right + 12.5, 0);
        if (lastBtn.right + 12.5 > ScreenWidth) {
            [self setContentOffset:CGPointMake(lastBtn.right + 12.5 - ScreenWidth, 0) animated:YES];
        }else{
            [self setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        
        
    }
    return self;
}


- (void)titleButtonClick:(UIButton *)button{
    
    int count = 0;
    for (int i = 0; i < self.buttonArray.count; i++){
        if (button == self.buttonArray[i]){
            count = i;
        }
    }
    NSUInteger index = self.buttonArray.count - 1;
    //通过遍历,将下标之后的按钮从scrollView中移除,同时也从数组中移除
    for (NSUInteger i = index; i > count; i--) {
        
        UIButton *btn = self.buttonArray[i];
        [btn removeFromSuperview];
        [self.buttonArray removeObjectAtIndex:i];
        [self.dataArray removeObjectAtIndex:i - 1];
        
    }
    if (button.x + button.width + 12.5 > ScreenWidth) {
        [self setContentOffset:CGPointMake(button.x + button.width + 12.5 - ScreenWidth, 0) animated:YES];
    }else{
        [self setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    UIButton *lastBtn = [self.buttonArray lastObject];
    lastBtn.enabled = NO;
    self.onSelectAction([NSString stringWithFormat:@"%ld", button.tag], self.dataArray);
    
}

@end
