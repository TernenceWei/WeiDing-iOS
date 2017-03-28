//
//  WHUCalendarCell.m
//  TEST_Calendar
//
//  Created by SuperNova(QQ:422596694) on 15/11/5.
//  Copyright (c) 2015年 SuperNova(QQ:422596694). All rights reserved.
//

#import "WHUCalendarCell.h"
@interface WHUCalendarCell()
@property(nonatomic,strong) CALayer* lineLayer;
@property(nonatomic,strong) CALayer* infoLayer;
@end
@implementation WHUCalendarCell
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
   
    if(self){
        
        self.backgroundColor=[UIColor whiteColor];
        
        self.view=[[UIView alloc] init];
       
        self.view.translatesAutoresizingMaskIntoConstraints=NO;
        
        [self addSubview:self.view];
        
        [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
          
            make.edges.mas_equalTo(self);
            
        }];

        _selectImage =[UIImageView new];
        
        [self.view addSubview:_selectImage];
        
        [_selectImage mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.size.mas_equalTo(CGSizeMake(32*AUTO_IPHONE6_WIDTH_375, 32*AUTO_IPHONE6_WIDTH_375));
            
            make.center.mas_equalTo(self.view);
            
        }];

        _lbl=[[UILabel alloc] init];
        
        _lbl.translatesAutoresizingMaskIntoConstraints=NO;
        
        _lbl.font=WLFontSize(12);
        
        _lbl.textColor = [WLTools stringToColor:@"#b0b7c1"];
        
        _lbl.textAlignment=NSTextAlignmentCenter;
    
        NSDictionary* viewDic=@{@"lbl":_lbl};
        
        [self.view addSubview:_lbl];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(==0)-[lbl]-(==0)-|" options:0 metrics:nil views:viewDic]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(==0)-[lbl]-(==0)-|" options:0 metrics:nil views:viewDic]];
        
        
        _origin =[UIImageView new];
        
        _origin.image =[UIImage imageNamed:@"tripBotomOrigin"];
        
        [self.view addSubview:_origin];
        
        [_origin mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.mas_equalTo(self.view);
            
            make.top.mas_equalTo(_selectImage.mas_bottom).offset(2);
            
            make.size.mas_equalTo(CGSizeMake(5, 5));
            
        }];

    }
    return self;
}


-(void)setSelected:(BOOL)selected{
   
    [super setSelected:selected];

    if(selected){
    
        self.origin.image =[UIImage imageNamed:@"tripBotomOrigin"];
        
        self.item.click =YES;
        
    }
    
    else{
     
        self.origin.image =[UIImage imageNamed:@"1"];
     
        self.item.click =NO;
    }
  
}



-(void)layoutSubviews{
    [super layoutSubviews];
   
    if(_rowIndex<_total-7){

    }
    if((_rowIndex+1)%7!=0){

     }
  
    
}

@end
