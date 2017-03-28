//
//  WL_SelectedFriend_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 2016/11/16.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_SelectedFriend_ViewController.h"

#import "WL_ShareArray.h"

#import "WL_MyFriendList_Cell.h"

#import "WL_Save_Model.h"

#import "WL_AddressBook_MyFriend_Model.h"

#import "WL_EditPrivateLetter_ViewController.h"

@interface WL_SelectedFriend_ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property(nonatomic,strong)UIView *bottomDetailView;

@property(nonatomic,strong)UILabel *selectedNum;

@property(nonatomic,strong)UIButton *sureButton;

@property(nonatomic,strong)NSMutableDictionary *originDictionary;

@end

@implementation WL_SelectedFriend_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title =@"已选择的好友";
    
    self.view.backgroundColor = BgViewColor;
    
    self.originDictionary =[NSMutableDictionary dictionaryWithDictionary:[WL_ShareArray shareArray].saveArray] ;
    
    self.dataArr =[NSMutableArray arrayWithArray:[[WL_ShareArray shareArray].saveArray allValues]];
    
    [self createUI];
}

-(NSMutableArray *)dataArr

{
    if (_dataArr==nil) {
        
        _dataArr =[[NSMutableArray alloc]init];
    }
    return _dataArr;
}
-(void)createUI
{
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    
    self.tableView.dataSource =self;
    
    self.tableView.delegate =self;
    
    self.tableView.rowHeight = 65;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = BgViewColor;
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableView];
    
    
    self.bottomDetailView =[[UIView alloc]initWithFrame:CGRectMake(0,ScreenHeight-50-64, ScreenWidth, 50)];
    
    self.bottomDetailView.backgroundColor =[UIColor whiteColor];
    
    [self.view addSubview:self.bottomDetailView];
    
    self.selectedNum = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 50)];
    
    self.selectedNum.font = WLFontSize(14);
    
    self.selectedNum.textColor = [WLTools stringToColor:@"#879efa"];
    
    self.selectedNum.text = @"已选择：";
    
    [self.bottomDetailView addSubview:self.selectedNum];
    
    //self.sureButton =[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-110-10, 7.5, 110, 35)];
    
    self.sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.sureButton setFrame:CGRectMake(ScreenWidth-110-10, 7.5, 110, 35)];
    
    [self.sureButton setBackgroundColor:[WLTools stringToColor:@"#879efa"]];
    
    self.sureButton.layer.cornerRadius =3.0;
    
    self.sureButton.layer.masksToBounds = YES;
    
    [self.sureButton setTitle:@"确认" forState:UIControlStateNormal];
    
    [self.sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.sureButton addTarget:self action:@selector(sureButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bottomDetailView addSubview:self.sureButton];
    
    [self setLabelNumber];

}

-(void)NavigationLeftEvent
{
    
    [WL_ShareArray shareArray].saveArray = [NSMutableDictionary  dictionaryWithDictionary:self.originDictionary];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)sureButton:(UIButton *)button
{
    
    if ([[DEFAULTS objectForKey:@"adressbook"]isEqualToString:@"1"]) {
        WL_EditPrivateLetter_ViewController *VC =self.navigationController.viewControllers[2];
        
        [VC reloadCellectionViewWith:[WL_ShareArray shareArray].saveArray];
        
        [self.navigationController popViewControllerAnimated:YES];
    }else if ([[DEFAULTS objectForKey:@"adressbook"]isEqualToString:@"2"])
    {
        WL_EditPrivateLetter_ViewController *VC =self.navigationController.viewControllers[3];
        
        [VC reloadCellectionViewWith:[WL_ShareArray shareArray].saveArray];
        
        [self.navigationController popViewControllerAnimated:YES];
    }

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataArr.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        static NSString *cellID = @"cellID";
        
        WL_MyFriendList_Cell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (cell==nil) {
            
            cell =[[WL_MyFriendList_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.path =indexPath;
    
        if (indexPath.row == self.dataArr.count-1) {
            
            cell.line.hidden =YES;
        }
        WL_Save_Model *model = self.dataArr[indexPath.row];;
    
        WS(weakSelf);
        
        cell.buttonSelectBlock = ^(NSIndexPath *index,UIButton *button)
        {
            
            WL_Save_Model *saveMod =self.dataArr[index.row];
            
        if (button.selected) {
                
                [[WL_ShareArray shareArray].saveArray setObject:saveMod forKey:saveMod.user_id];
            }else
            {
                [[WL_ShareArray shareArray].saveArray removeObjectForKey:saveMod.user_id];
            }
            
            
            [weakSelf  setLabelNumber];
            
        };
        
        
        for (NSString *key in [[WL_ShareArray shareArray].saveArray allKeys]) {
            
            
            if ([model.user_id isEqualToString:key]) {
                
                cell.selectImageView.selected =YES;
            }
            
        }
    
    WL_AddressBook_MyFriend_Model *mood = [[WL_AddressBook_MyFriend_Model alloc]init];
    
    mood.user_id = model.user_id;
    mood.real_name =model.real_name;
    mood.title = model.user_name;
    mood.img=model.photo;
    
    mood.user_mobile =model.mobile;
    
    cell.model =mood;
        
    return cell;
        
    

}

-(void)setLabelNumber
{
    self.selectedNum.text = [NSString stringWithFormat:@"已选择:%lu人",(unsigned long)[[WL_ShareArray shareArray].saveArray allKeys].count];
    
}

@end
