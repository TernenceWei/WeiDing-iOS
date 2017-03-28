//
//  WL_PayAmountCell.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/30.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_PayAmountCell.h"

@implementation WL_PayAmountCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.amountLabel =[WLTools allocLabel:@"金额" font:WLFontSize(14) textColor:BlackColor frame:CGRectMake(12.5, 0, 40, 45) textAlignment:NSTextAlignmentLeft];
        
        [self.contentView addSubview:self.amountLabel];
        
        
        CGFloat toolBarH=0;
        
        if (IsiPhone4)
        {
            
            toolBarH=33;
            
        }
        else if(IsiPhone5)
        {
            
            toolBarH=33;
            
        }
        else if (IsiPhone6)
        {
            
            toolBarH=35;
            
        }
        else if (IsiPhone6P)
        {
            
            toolBarH =42;
        }
        
        
        //给键盘 添加 setInputAccessoryView 可以点击完成 让键盘退出
        UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, toolBarH)];
        [topView setBarStyle:UIBarStyleDefault];
        
        topView.backgroundColor = [UIColor whiteColor];
        
        UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
        NSArray * buttonsArray = @[btnSpace,doneButton];
        
        [topView setItems:buttonsArray];
        
        self.amountTextfield = [[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth-25-200, 0, 200, 45)];
        
        self.amountTextfield.placeholder = @"请输入金额";
        
        //self.amountTextfield.returnKeyType = UIReturnKeyDone;
        
        self.amountTextfield.keyboardType = UIKeyboardTypeDecimalPad;
        
        self.amountTextfield.textAlignment = NSTextAlignmentRight;
        
        self.amountTextfield.font =WLFontSize(17);
        
        self.amountTextfield.textColor = BlackColor;
        
        self.amountTextfield.delegate =self;
        
        [self.amountTextfield addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
        
        [self.amountTextfield setInputAccessoryView:topView];
        
        [self.contentView addSubview:self.amountTextfield];
        
        
        self.yuanLabel = [WLTools allocLabel:@"元" font:WLFontSize(14) textColor:BlackColor frame:CGRectMake(ScreenWidth-25, 0, 15, 45) textAlignment:NSTextAlignmentRight];
        
        [self.contentView addSubview:self.yuanLabel];
        
        
    }
    
    
    return self;
}

-(void)dismissKeyBoard
{
    
    [self.amountTextfield resignFirstResponder];
}


-(void)textChange:(UITextField *)textField
{
    
    if (self.amountTextfield.text.length>=1&&[[self.amountTextfield.text substringToIndex:1] isEqualToString:@"."]) {
        
        self.amountTextfield.text = @"";
        
    }
    if (self.amountTextfield.text.length>=1&&[[self.amountTextfield.text substringToIndex:1] isEqualToString:@"0"]) {
        
        if ([self.amountTextfield.text intValue]>=1) {
            
            self.amountTextfield.text =[NSString stringWithFormat:@"%d",[self.amountTextfield.text intValue]];
            
        }else if ([self.amountTextfield.text isEqualToString:@"00"])
        {
            self.amountTextfield.text =[NSString stringWithFormat:@"%d",[self.amountTextfield.text intValue]];
        }
        
    }
    
    if ([self.amountTextfield.text rangeOfString:@"."].location!=NSNotFound) {
        
        NSInteger index =[self.amountTextfield.text rangeOfString:@"."].location;
        
        NSString *str=[self.amountTextfield.text substringFromIndex:index+1];
        
        
        if (self.amountTextfield.text.length>index+1) {
            
            NSString *originString = [self.amountTextfield.text substringWithRange:NSMakeRange(index+1, 1)];
            
            if ([originString isEqualToString:@"."]) {
                
                self.amountTextfield.text = [self.amountTextfield.text substringToIndex:index+1];
            }
            
            
        }
        
        if (str.length>=2) {
            
            self.amountTextfield.text= [self.amountTextfield.text substringToIndex:index+3];
            
        }
        
    }
    
    if (self.amountTextfield.text.length>12) {
        
        self.amountTextfield.text=[self.amountTextfield.text substringToIndex:12];
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField

{
    [self.amountTextfield resignFirstResponder];
    
    return YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
