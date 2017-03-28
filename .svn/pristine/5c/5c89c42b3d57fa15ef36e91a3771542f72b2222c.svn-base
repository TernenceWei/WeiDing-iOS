//
//  WLCommentCell.m
//  WeiLvDJS
//
//  Created by xiaobai2268 on 2016/10/31.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLCommentCell.h"

@implementation WLCommentCell

//- (void)awakeFromNib {
//    // Initialization code
//}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.commentImage =[UIImageView new];
        
        self.commentImage.image =[UIImage imageNamed:@"tripRemark"];
        
        [self.contentView addSubview:self.commentImage];
        
        [self.commentImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(10);
            
            make.top.mas_equalTo(15);
            
            make.size.mas_equalTo(CGSizeMake(15, 15));
            
        }];
        
        
        self.commentLabel =[UILabel new];
        
        self.commentLabel.font =WLFontSize(12);
        
        self.commentLabel.textColor =BlackColor;
        
        self.commentLabel.text = @"我的备注";
        
        [self.contentView addSubview:self.commentLabel];
        
        [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.commentImage.mas_right).offset(10);
            
            make.height.mas_equalTo(15);
            
            make.top.mas_equalTo(15);
            
        }];
        
        UILabel *line =[UILabel new];
        
        line.backgroundColor =bordColor;
        
        [self.contentView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(44.5);
            
            make.left.mas_equalTo(0);
            
            make.size.mas_equalTo(CGSizeMake(ScreenWidth, 0.5));
            
        }];
        
        
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
        
        
        self.commentTextView =[UITextView new];
        
        self.commentTextView.delegate =self;
        
        self.commentTextView.font =WLFontSize(14);
        
        self.commentTextView.returnKeyType = UIReturnKeyDone;
        
        [self.commentTextView setInputAccessoryView:topView];
        
        [self.contentView addSubview:self.commentTextView];
        
        [self.commentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(10);
            
            make.top.mas_equalTo(45);
            
            make.size.mas_equalTo(CGSizeMake(ScreenWidth-20, 105));
            
        }];
        
        
        self.placeHoderLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, ScreenWidth-20, 12)];
        
        self.placeHoderLabel.text=@"点击此处添加备注信息";
        
        self.placeHoderLabel.textColor=[UIColor grayColor];
        
        self.placeHoderLabel.font=WLFontSize(14);
        
        self.placeHoderLabel.numberOfLines=0;
        
        [self.commentTextView addSubview:self.placeHoderLabel];
        
        
    }
    
    return self;
}

-(void)setText:(NSString *)text
{
    
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (self.commentTextView.text.length==0) {
        
        self.placeHoderLabel.hidden=NO;
        
    }else if (self.commentTextView.text){
        
        self.placeHoderLabel.hidden=YES;
    }
    //该判断用于联想输入
    if (self.commentTextView.text.length > 30)
    {
        
        [[WL_TipAlert_View sharedAlert]createTip:@"最多输入30个字"];
        
        self.commentTextView.text = [self.commentTextView.text substringToIndex:30];
        
    }
    
    
}

- (BOOL) textView: (UITextView *) textView  shouldChangeTextInRange: (NSRange) range replacementText: (NSString *)text {
    if( [@"\n" isEqualToString: text]){
        
        [self.commentTextView resignFirstResponder];
        //你的响应方法
        return YES;
    }
    return YES;
}



-(void)dismissKeyBoard
{
    
    [self.commentTextView resignFirstResponder];
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    self.placeHoderLabel.hidden=YES;
    
    return YES;
}


-(BOOL)textViewShouldEndEditing:(UITextView *)textView

{
    
    [self.commentTextView resignFirstResponder];
    
    if (self.commentTextView.text.length ==0) {
        
        self.placeHoderLabel.hidden=NO;
    }
    
    
    return YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
