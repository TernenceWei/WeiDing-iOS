//
//  WL_BankCardsList_View.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BankCardsList_View.h"
#import "WL_BankCardsList_Cell.h"
@interface WL_BankCardsList_View()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray *nameArray;
@end

@implementation WL_BankCardsList_View

-(instancetype)init
{
    self = [super init];
    
    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    
    //self.hidden = YES;
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    [self setLayout];
    
    return self;
}

-(void)setLayout
{
    
    self.nameArray =[NSArray arrayWithObjects:@"中国工商银行",@"中国建设银行",@"招商银行",@"中国银行",@"广发银行", @"浦发银行",@"平安银行",@"农业银行",@"中国邮政储蓄银行",@"中信银行",@"北京银行",@"广大银行",@"兴业银行",@"民生银行",nil];
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, ScreenHeight-180, ScreenWidth, 180) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource =self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.tableView.backgroundColor =[UIColor whiteColor];
    
    [self addSubview:self.tableView];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.nameArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    static NSString *cellID = @"cellID";
    
    WL_BankCardsList_Cell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell==nil) {
        
        cell =[[WL_BankCardsList_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
    }
    
    cell.bankName.text = self.nameArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellDidBlock) {
        
        self.cellDidBlock(self.nameArray[indexPath.row]);
    
    }
}
@end
