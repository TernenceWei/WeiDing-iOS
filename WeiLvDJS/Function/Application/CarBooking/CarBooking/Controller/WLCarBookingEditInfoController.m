//
//  WLCarBookingEditInfoController.m
//  WeiLvDJS
//
//  Created by ternence on 2017/1/19.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLCarBookingEditInfoController.h"
#import "XKPEPlaceholderTextView.h"
#import "WLDataCarBookingHandler.h"

@interface WLCarBookingEditInfoController ()<UITextViewDelegate>

@property (nonatomic, strong) XKPEPlaceholderTextView *textView;
@property (nonatomic, assign) BOOL isRemark;
@property (nonatomic, copy)   void(^onSaveAction)(NSString *firstTitle, NSString *secondTitle);
@property (nonatomic, strong) UIBarButtonItem *rightItem;
@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *mobileField;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) NSString *originalName;
@property (nonatomic, strong) NSString *originalPhone;

@end

@implementation WLCarBookingEditInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)setupNavigationBar
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveBtnClick)];
    self.navigationItem.rightBarButtonItem = item;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont WLFontOfSize:15];
    attrs[NSForegroundColorAttributeName] = Color1;
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    
    NSMutableDictionary *disAttrs = [NSMutableDictionary dictionary];
    disAttrs[NSFontAttributeName] = [UIFont WLFontOfSize:15];
    disAttrs[NSForegroundColorAttributeName] = Color3;
    [item setTitleTextAttributes:disAttrs forState:UIControlStateDisabled];

    self.rightItem = item;
    self.rightItem.enabled = NO;

}

- (void)setOriginalName:(NSString *)name phone:(NSString *)phone
{
    _originalName = name;
    _originalPhone = phone;
    
}

- (void)setSaveAction:(void (^)(NSString *, NSString *))saveAction remark:(BOOL)remark
{
    _isRemark = remark;
    self.onSaveAction = saveAction;
    [self setupUI];
}

- (void)setupUI{
    
    if (_isRemark) {
        self.title = @"备注信息";
        
        self.textView = [[XKPEPlaceholderTextView alloc] init];
        self.textView.textColor = Color2;
        self.textView.placeholderColor = Color3;
        self.textView.font = [UIFont WLFontOfSize:14];
        self.textView.frame = CGRectMake(0, ScaleH(5), ScreenWidth, ScaleH(100));
        self.textView.placeholder = @"给司机捎句话";
        self.textView.delegate = self;
        [self.view addSubview:self.textView];
        [self.textView becomeFirstResponder];
        
        self.countLabel = [UILabel labelWithText:@"0/70" textColor:Color2 fontSize:13];
        self.countLabel.frame = CGRectMake(0, ScaleH(80), ScreenWidth - ScaleW(15), 20);
        self.countLabel.textAlignment = NSTextAlignmentRight;
        [self.view addSubview:self.countLabel];
        
        NSString *remark = [[WLDataCarBookingHandler  sharedInstance] getCarBookingRemark];
        if (remark) {
            self.textView.text = remark;
            [self textViewDidChange:self.textView];
        }
        
    }else{
        self.view.backgroundColor = BgViewColor;
        self.title = @"用车人";
        NSArray *titleArray = @[@"姓名",@"手机号码"];
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(90))];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bgView];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(ScaleW(12), ScaleH(45), ScreenWidth, 1)];
        line.backgroundColor = bordColor;
        [self.view addSubview:line];
        
        NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"CarBookingSavedUserInfo"];
        NSMutableArray *fieldArray = [@[@"", [WLUserTools getUserMobile]]mutableCopy];
        if (_originalName) {
            if (_originalPhone) {
                fieldArray = [@[_originalName, _originalPhone]mutableCopy];
            }else{
                fieldArray = [@[_originalName, [dict objectForKey:@"phone"]]mutableCopy];
            }
            
        }else{
            if (_originalPhone) {
                fieldArray = [@[[dict objectForKey:@"name"], _originalPhone]mutableCopy];
            }else{
                if (dict) {
                    fieldArray = [@[[dict objectForKey:@"name"], [dict objectForKey:@"phone"]]mutableCopy];
                }
            }
            
        }
        
        for (int i = 0; i < 2; i++) {
            
            UILabel *label = [UILabel labelWithText:titleArray[i] textColor:Color2 fontSize:15];
            label.frame = CGRectMake(ScaleW(12), ScaleH(45) * i, ScaleW(80), ScaleH(45));
            [bgView addSubview:label];
            
            UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(92), ScaleH(45) * i, ScreenWidth -  ScaleW(92), ScaleH(45))];
            field.font = [UIFont WLFontOfSize:15];
            field.clearButtonMode = UITextFieldViewModeWhileEditing;
            field.returnKeyType = UIReturnKeyDone;
            field.text = fieldArray[i];
            field.textColor = Color2;
            [field addTarget:self action:@selector(textFieldTextDidChange) forControlEvents:UIControlEventEditingChanged];
            [bgView addSubview:field];
            
            if (i == 0) {
                self.nameField = field;
                [self.nameField becomeFirstResponder];
            }else{
                self.mobileField = field;
                field.keyboardType = UIKeyboardTypePhonePad;
            }
            
        }
        
        self.rightItem.enabled = (self.nameField.text.length && self.mobileField.text.length);
        
    }
}

- (void)saveBtnClick{
    
    [self.view endEditing:YES];
    if (self.isRemark) {
        
        NSString *temp = self.textView.text;
        [[WLDataCarBookingHandler sharedInstance] saveCarBookingRemark:temp];
        self.onSaveAction(temp ,nil);
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
        NSString *name = self.nameField.text;
        NSString *mobile = self.mobileField.text;
        if (mobile.length != 11) {
            [[WL_TipAlert_View sharedAlert] createTip:@"请输入正确的手机号码"];
            return;
        }
        NSString *twoChar = [mobile substringToIndex:2];
        if (twoChar.integerValue >= 13 && twoChar.integerValue <= 18) {
            
        }else{
            [[WL_TipAlert_View sharedAlert] createTip:@"请输入正确的手机号码"];
            return;
        }
        if (name.length > 20) {
            [[WL_TipAlert_View sharedAlert] createTip:@"姓名最多只能输入20个字符"];
            return;
        }
        
        NSDictionary *dict = @{@"name": name, @"phone": mobile};
        [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"CarBookingSavedUserInfo"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self.onSaveAction(name ,mobile);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}

#define MAX_STARWORDS_LENGTH 70

- (void)textViewDidChange:(UITextView *)textView
{
    self.rightItem.enabled = textView.text.length;
    NSString *toBeString = textView.text;
    NSString *lang = [textView.textInputMode primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"])// 简体中文输入
    {
        //获取高亮部分
        UITextRange *selectedRange = [textView markedTextRange];
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            if (toBeString.length > MAX_STARWORDS_LENGTH)
            {
                textView.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH];
            }
        }
        
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else
    {
        if (toBeString.length > MAX_STARWORDS_LENGTH)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_STARWORDS_LENGTH];
            if (rangeIndex.length == 1)
            {
                textView.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_STARWORDS_LENGTH)];
                textView.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
    self.countLabel.text = [NSString stringWithFormat:@"%ld/70",textView.text.length];
}

- (void)textFieldTextDidChange
{
    self.rightItem.enabled = (self.nameField.text.length && self.mobileField.text.length);
    if (self.mobileField.text.length > 11) {
        self.mobileField.text = [self.mobileField.text substringToIndex:11];
    }
}
@end
