//
//  WL_SectionIndexView.m
//  WeiLvDJS
//
//  Created by jyc on 2016/11/14.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_SectionIndexView.h"

@interface WL_SectionIndexView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *sectionArray;

@end

static NSString *cellID = @"cellID";

@implementation WL_SectionIndexView

-(instancetype)initWithFrame:(CGRect)frame andSectionArray:(NSMutableArray *)array
{
    if (self =[super initWithFrame:frame]) {
        
        self.sectionArray = array;
        
        [self createUI];
        
    }

    return self;
}

-(NSMutableArray *)sectionArray
{
    if (_sectionArray==nil) {
        
        _sectionArray =[[NSMutableArray alloc]init];
    }

    return _sectionArray;
}

-(void)createUI

{
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(4, 0, 14, self.sectionArray.count *20)];
    
    self.tableView.backgroundColor =[UIColor clearColor];
    
    self.tableView.scrollEnabled = NO;
    
    self.tableView.delegate =self;
    
    self.tableView.dataSource =self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    
    [self addSubview:self.tableView];
    
    [self.tableView reloadData];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sectionArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell==nil) {
        
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.backgroundColor =[UIColor clearColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = [NSString stringWithFormat:@" %@",self.sectionArray[indexPath.row]];
    
    cell.textLabel.font =WLFontSize(14);
    
    cell.textLabel.textColor = [WLTools stringToColor:@"#4877e7"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(didSelectCellIndex:)]) {
        
        [self.delegate performSelector:@selector(didSelectCellIndex:) withObject:indexPath];
    }
}

@end
