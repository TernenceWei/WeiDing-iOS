//
//  WLFeedBackViewController.m
//  WeiLvDJS
//
//  Created by hsliang on 2017/3/10.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLFeedBackViewController.h"

#define Spacing ScaleH(5)
#define howMAXZF 140

@interface WLFeedBackViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView * ideaTextView;
@property (nonatomic, strong) UILabel * placeholderLabel;
@property (nonatomic, strong) UILabel * InputHowLabel;
@property (nonatomic, assign) BOOL iscan;

@end

@implementation WLFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNav];
    [self createUI];
}

- (void)setupNav
{
    self.view.backgroundColor = BgViewColor;
    self.titleItem.title = @"打小报告";
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnClick)];
    [rightBtn setTintColor:[WLTools stringToColor:@"#00cc99"]];
    [self.titleItem setRightBarButtonItem:rightBtn];
}

- (void)createUI
{
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, ScreenWidth, ScaleH(180))];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer * downKeyboardTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(downKeyboardTapClick)];
    [self.view addGestureRecognizer:downKeyboardTap];
    
    _ideaTextView = [[UITextView alloc] initWithFrame:CGRectMake(Spacing, Spacing, backView.frame.size.width - Spacing *2, backView.frame.size.height - Spacing *2)];
    _ideaTextView.delegate = self;
    _ideaTextView.font = [UIFont WLFontOfSize:14.0];
    //_ideaTextView.text = @"^_^亲，您有什么想法，请和我们说";
    [backView addSubview:_ideaTextView];
    
    _placeholderLabel = [UILabel labelWithText:@"^_^亲，您有什么想法，请和我们说" textColor:[WLTools stringToColor:@"#929292"] fontSize:14.0];
    _placeholderLabel.frame = CGRectMake(ScaleW(5), ScaleH(10), _ideaTextView.frame.size.width, ScaleH(20));
    [_ideaTextView addSubview:_placeholderLabel];
    
    _InputHowLabel = [UILabel labelWithText:@"0/140" textColor:[WLTools stringToColor:@"#b5b5b5"] fontSize:13.0];
    _InputHowLabel.frame = CGRectMake(ScaleW(5), _ideaTextView.frame.size.height - ScaleH(20), _ideaTextView.frame.size.width - ScaleW(10), ScaleH(20));
    _InputHowLabel.textAlignment = NSTextAlignmentRight;
    [_ideaTextView addSubview:_InputHowLabel];
}

- (void)rightBtnClick
{
    NSString * contentText = _ideaTextView.text;
    if (contentText.length != 0) {
        //[self sendContentText:[self stringContainsEmoji:contentText]];
        [self sendContentText:contentText];
    }
    else
    {
        UIAlertView * noContentAlert = [[UIAlertView alloc] initWithTitle:@"内容为空不能提交!!!" message:nil delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [noContentAlert show];
    }
}

- (void)sendContentText:(NSString *)content
{
    
    [[WLNetworkDriverHandler sharedInstance] requestFeedBackWith:content ResultBlock:^(BOOL success,NSInteger status, NSString *message) {
        if (success == WLResponseTypeSuccess) {
            if (status == 200) {
                [[WL_TipAlert_View sharedAlert] createTip:@"提交成功"];
                [self NavigationLeftEvent];
            }
            else
            {
                [[WL_TipAlert_View sharedAlert] createTip:[NSString stringWithFormat:@"%@",message]];
            }
        }
        else
        {
            [[WL_TipAlert_View sharedAlert] createTip:[NSString stringWithFormat:@"%@",message]];
        }
    }];
}

-(NSString *)stringContainsEmoji:(NSString *)string
{
    NSMutableArray *wori = [NSMutableArray array];
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop)
     {
         const unichar hs = [substring characterAtIndex:0];
         if (0xd800 <= hs && hs <= 0xdbff)
         {
             if (substring.length > 1)
             {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f)
                 {
                     NSString *stringggg = [substring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                     [wori addObject:stringggg];
                     
                     
                     //                                            returnValue = YES;
                     NSLog(@"%hu",ls);
                     
                 }
             }
         }
         
         else if (substring.length > 1)
         {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3)
             {
                 
                 NSLog(@"%hu",ls);
                 
             }
         }
         else
         {
             if (0x2100 <= hs && hs <= 0x27ff)
             {
                 
                 NSLog(@"%hu",hs);
                 
             }
             else if (0x2B05 <= hs && hs <= 0x2b07)
             {
                 
                 NSLog(@"%hu",hs);
                 
             } else if (0x2934 <= hs && hs <= 0x2935)
             {
                 
                 NSLog(@"%hu",hs);
                 
             }
             else if (0x3297 <= hs && hs <= 0x3299)
             {
                 
                 NSLog(@"%hu",hs);
                 
             }
             else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50)
             {
                 //                                        returnValue = YES;
                 NSLog(@"%hu",hs);
                 
             }
             else
             {
                 [wori addObject:substring];
             }
         }
         
     }];
    
    
    NSString *string33 = nil;
    NSString *lastString = @"";
    for (NSString *value in wori) {
        string33 = [NSString stringWithFormat:@"%@%@", lastString, value];
        lastString = [NSString stringWithFormat:@"%@", string33];
    }
    return string33;
}

- (void)downKeyboardTapClick
{
    [_ideaTextView resignFirstResponder];
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _placeholderLabel.hidden = YES;
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    NSInteger strlength = 0;
    NSString * textViewtext = textView.text;
    NSInteger ZMstrlength = 0;
    char* p = (char*)[textViewtext cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[textViewtext lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            if (strlength <= howMAXZF) {
                strlength++;
            }
        }
        else {
            p++;
            if (strlength <= howMAXZF) {
                ZMstrlength ++;
            }
        }
    }

    if (strlength > howMAXZF)
    {
        //截取到最大位置的字符(由于超出截部分在should时被处理了所在这里这了提高效率不再判断)
        NSString *s = [textViewtext substringToIndex:(strlength - ZMstrlength)/2 + ZMstrlength];
        [textView setText:s];

        _InputHowLabel.text = [NSString stringWithFormat:@"%d/%d",howMAXZF,howMAXZF];
    }
    else
    {
        _InputHowLabel.text = [NSString stringWithFormat:@"%ld/%d",(long)strlength,howMAXZF];
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@""]) {
        return YES;
    }
    _iscan = YES;

    NSInteger strlength = 0;
    NSString * textViewtext = textView.text;
    
    char* p = (char*)[textViewtext cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[textViewtext lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
            
            if (strlength >= howMAXZF) {
                _iscan = NO;
            }
            else if (strlength == (howMAXZF - 1))
            {
                if (text.length > 1) {
                    _iscan = NO;
                }
            }
        }
        else {
                p++;
        }
    }
    
    if (_iscan)
    {
        return YES;
    }
    else
    {
        [[WL_TipAlert_View sharedAlert] createTip:[NSString stringWithFormat:@"只能输入%d个字符",howMAXZF]];
        return NO;  
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
