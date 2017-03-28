//
//  WL_DepartMentNext_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 2016/11/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_DepartMentNext_ViewController.h"

#import "WL_DepartmentModel.h"

#import "WL_StaffModel.h"

#import "WL_CorporateStructure_Cell.h"

#import "WL_Staff_TableViewCell.h"

#import "WL_DepartMentNext_ViewController.h"

#import "JHCusomHistory.h"

#import "WL_ShareArray.h"

#import "WL_EditPrivateLetter_ViewController.h"

#import "WL_Save_Model.h"

#import "WL_MyFriendList_Cell.h"

#import "WL_SearchResultModel.h"


static NSString *CorporateStructureCell = @"CorporateStructure_Cell";

static NSString *StaffTableViewCell = @"Staff_TableViewCell";

@interface WL_DepartMentNext_ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate,UISearchResultsUpdating>

@property(nonatomic,strong)NSMutableArray *departmentArray;

@property(nonatomic,strong)NSMutableArray *staffArray;

@property (nonatomic,strong) UISearchController *searchVC;

@property(nonatomic,strong)NSMutableArray *searchArray;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property(nonatomic,strong)UIView *bottomDetailView;

@property(nonatomic,strong)UILabel *selectedNum;

@property(nonatomic,strong)UIButton *sureButton;

@property(nonatomic,strong)UIView *inputAccessoryView;

@property(nonatomic,strong)UIButton *sureButton2;

@property(nonatomic,strong)UILabel *selectedNum2;

@property(nonatomic,strong)NSMutableString *string;

@property(nonatomic,assign)NSInteger type;

@property(nonatomic,strong)JHCusomHistory *history;

@property(nonatomic,strong)NSMutableDictionary *originArray;//进入页面时用于存储临时字典

@property(nonatomic,strong)WL_NoData_View *noDataView;

@property(nonatomic,strong)WL_NoData_View *noDataView2;

@property(nonatomic,strong)UITableViewController *tableVC;

@end

@implementation WL_DepartMentNext_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = BgViewColor;

    self.originArray = [NSMutableDictionary dictionaryWithDictionary:[WL_ShareArray shareArray].saveArray];
    
    ////增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(customerKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(customerKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    WL_DepartmentModel *mo = self.array[1];
    
    self.navigationItem.title = mo.department_name;
    
    [self createUI];
    
    [self initData];

}


-(NSMutableArray *)searchArray
{
    if (_searchArray==nil) {
        
        _searchArray =[[NSMutableArray alloc]init];
    }
    return _searchArray;
}

-(void)initData

{
    NSString *userId = [WLUserTools getUserId];
    
    NSString *passWord =[WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:passWord publicKey:RSAKey];
    
    NSDictionary *paramaters =@{@"user_id":userId,@"user_password":encryptStr,@"department_id":self.model.department_id,@"company_id":self.model.company_id,@"type":@"1"};
    
    [self showHud];
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager]requestWithURL:UserGetMyCompanyDepartmentListUrl RequestType:RequestTypePost Parameters:paramaters Success:^(id responseObject) {
        
        WlLog(@"%@",responseObject);
        
        [weakSelf hidHud];
        
        WL_Network_Model *netModel =[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([netModel.result integerValue]==1) {
            
            weakSelf.departmentArray =[WL_DepartmentModel mj_objectArrayWithKeyValuesArray:netModel.data[@"department_list"]];
            
            weakSelf.staffArray = [WL_StaffModel mj_objectArrayWithKeyValuesArray:netModel.data[@"staff_list"]];
            
            if (weakSelf.departmentArray.count==0&&self.staffArray.count==0) {
                
                weakSelf.type = 1;
                
                //weakSelf.noDataView.hidden = NO;
                
                [weakSelf hideNoData:NO andType:WLNetworkTypeNOData];
                
            }else if (self.departmentArray.count==0&&self.staffArray.count!=0)
            {
                weakSelf.type =2;
                
                weakSelf.noDataView.hidden=YES;
                
            }else if (self.departmentArray.count !=0 && self.staffArray.count!=0)
            {
                weakSelf.type = 3;
                
                weakSelf.noDataView.hidden=YES;
                
            }else if (self.departmentArray.count!=0&&self.staffArray.count==0)
            {
                weakSelf.type =4;
                
                weakSelf.noDataView.hidden=YES;
            }
            WlLog(@"%@",self.departmentArray);
            
            WlLog(@"%@",self.staffArray);
            
            //[self createUI];
            
            [weakSelf.tableView reloadData];
            
            dispatch_async(dispatch_get_main_queue(), ^{
               
            [weakSelf.history.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.array.count-1 inSection:0]atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
 
            });
    }
        
    } Failure:^(NSError *error) {
       
        [weakSelf hidHud];
        
        if (error.code==-1009) {
            
            [weakSelf hideNoData:NO andType:WLNetworkTypeNONetWork];
            
        }else
        {
            [weakSelf hideNoData:NO andType:WLNetworkTypeSeverError];
        }

    }];
 }

//无数据提示
- (WL_NoData_View *)noDataView {
    
    if (_noDataView == nil) {
    
        WS(ws);
        
        _noDataView = [[WL_NoData_View alloc] initWithFrame:CGRectMake(0,56+45, ScreenWidth, ScreenHeight-64-45-56-50) andRefreshBlock:^{
        
            [ws initData];
            
        }];
        
      _noDataView.hidden = YES;
    }
    
    return _noDataView;
}
//无数据提示
- (WL_NoData_View *)noDataView2 {
    
    if (_noDataView2 == nil) {
        
        //WS(ws);
        
        _noDataView2 = [[WL_NoData_View alloc] initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight-64-50) andRefreshBlock:^{
            
            //[ws initData];
            
        }];
        
        
        
        _noDataView2.hidden = YES;
    }
    
    return _noDataView2;
}



#pragma makr - 设置无数据提示的显示、隐藏及类型
- (void)hideNoData:(BOOL)hidden andType:(WLNetworkType)type {
    
    self.noDataView.hidden = hidden;
    
    self.noDataView2.hidden = hidden;
    
    if (!hidden) {
        
        self.noDataView.type = type;
        
        self.noDataView2.type = type;
        
    }
}

-(void)createUI
{
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-50) style:UITableViewStylePlain];
    
    self.tableView.dataSource =self;
    
    self.tableView.delegate =self;
    
    self.tableView.rowHeight = 65;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = BgViewColor;
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:self.noDataView];
    
    [self.tableView registerClass:[WL_CorporateStructure_Cell class] forCellReuseIdentifier:CorporateStructureCell];
    
    [self.tableView registerClass:[WL_Staff_TableViewCell class] forCellReuseIdentifier:StaffTableViewCell];
    
    //self.saveArr =[[NSMutableArray alloc]initWithArray:self.dataArr];
    
    //创建一个tableViewController自带一个tableView
     self.tableVC = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    self.tableVC .tableView.delegate = self;
    
    self.tableVC .tableView.dataSource = self;
    
    self.tableVC .tableView.rowHeight = 65;
    
    self.tableVC .tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    
    [self.tableVC.view addSubview:self.noDataView2];
    
    self.searchVC = [[UISearchController alloc] initWithSearchResultsController:self.tableVC ];
    
    self.searchVC.searchResultsUpdater =self;
    
    self.searchVC.delegate =self;
    
    self.searchVC.searchBar.placeholder = @"找人";
    
    self.searchVC.hidesNavigationBarDuringPresentation = YES;
    
    self.tableView.tableHeaderView = self.searchVC.searchBar;
    
    UIImageView *barImageView = [[[self.searchVC.searchBar.subviews firstObject] subviews] firstObject];
    
    barImageView.layer.borderColor = BgViewColor.CGColor;
    
    barImageView.layer.borderWidth = 1;
    
    self.definesPresentationContext = YES;
    
    self.searchVC.searchBar.barTintColor = BgViewColor;
    
    [self.searchVC.searchBar sizeToFit];
    
    self.bottomDetailView =[[UIView alloc]initWithFrame:CGRectMake(0,ScreenHeight-50-64, ScreenWidth, 50)];
    
    self.bottomDetailView.backgroundColor =[UIColor whiteColor];
    
    [self.view addSubview:self.bottomDetailView];
    
    self.selectedNum = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 50)];
    
    self.selectedNum.font = WLFontSize(14);
    
    self.selectedNum.textColor = [WLTools stringToColor:@"#879efa"];
    
    self.selectedNum.text = @"已选择：";
    
    [self.bottomDetailView addSubview:self.selectedNum];
    
    self.sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.sureButton setFrame:CGRectMake(ScreenWidth-110-10, 7.5, 110, 35)];
    
    [self.sureButton setBackgroundColor:[WLTools stringToColor:@"#879efa"]];
    
    self.sureButton.layer.cornerRadius =3.0;
    
    self.sureButton.layer.masksToBounds = YES;
    
    self.sureButton.enabled = NO;
    
    self.sureButton.alpha =0.4;
    
    [self.sureButton setTitle:@"确认" forState:UIControlStateNormal];
    
    [self.sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.sureButton addTarget:self action:@selector(sureButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bottomDetailView addSubview:self.sureButton];
    
    [self setLabelNumber];
    
    [self.searchVC.searchBar setInputAccessoryView:self.inputAccessoryView];
}

-(void)sureButton:(UIButton *)button
{
    
   //1的时候WL_EditPrivateLetter_ViewController 在self.navigationController.viewControllers的第3个位置
    
    if ([[DEFAULTS objectForKey:@"adressbook"]isEqualToString:@"1"]) {
      
        NSArray *arr= self.navigationController.viewControllers;
        WlLog(@"%@",arr);
        
        WL_EditPrivateLetter_ViewController *VC =self.navigationController.viewControllers[2];
        
        [VC reloadCellectionViewWith:[WL_ShareArray shareArray].saveArray];
        
        [self.navigationController popToViewController:VC animated:YES];
        
        //2的时候WL_EditPrivateLetter_ViewController 在self.navigationController.viewControllers的第4个位置
    }else if ([[DEFAULTS objectForKey:@"adressbook"]isEqualToString:@"2"])
    {
        NSArray *arr= self.navigationController.viewControllers;
        WlLog(@"%@",arr);
        
        WL_EditPrivateLetter_ViewController *VC =self.navigationController.viewControllers[3];
        
        [VC reloadCellectionViewWith:[WL_ShareArray shareArray].saveArray];
        
        [self.navigationController popToViewController:VC animated:YES];
    }
}
- (UIView *)inputAccessoryView{
    
    if (!_inputAccessoryView) {
        
        _inputAccessoryView = [[UIView alloc]initWithFrame:(CGRect){0,0,ScreenWidth,50}];
        
        [_inputAccessoryView setBackgroundColor:[UIColor whiteColor]];
        
        self.selectedNum2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 50)];
        
        self.selectedNum2.font = WLFontSize(14);
        
        self.selectedNum2.textColor = [WLTools stringToColor:@"#879efa"];
        
        self.selectedNum2.text = @"已选择：";
        
        [_inputAccessoryView addSubview:self.selectedNum2];
        
        //self.sureButton2 =[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-110-10, 7.5, 110, 35)];
        
        self.sureButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.sureButton2 setFrame:CGRectMake(ScreenWidth-110-10, 7.5, 110, 35)];
        
        [self.sureButton2 setBackgroundColor:[WLTools stringToColor:@"#879efa"]];
        
        self.sureButton2.layer.cornerRadius =3.0;
        
        self.sureButton2.layer.masksToBounds = YES;
        
        self.sureButton2.enabled =NO;
        
        self.sureButton2.alpha =0.4;
        
        [self.sureButton2 addTarget:self action:@selector(sureButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.sureButton2 setTitle:@"确认" forState:UIControlStateNormal];
        
        [self.sureButton2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_inputAccessoryView addSubview:self.sureButton2];
        
    }
    return _inputAccessoryView;
}

#pragma mark --UISearchControllerDelegate

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {

    
    NSString *userId = [WLUserTools getUserId];
    
    NSString *passWord =[WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:passWord publicKey:RSAKey];
    
    NSDictionary *paramaters =@{@"user_id":userId,@"user_password":encryptStr,@"keyword":self.searchVC.searchBar.text,@"company_id":self.model.company_id};
    
    [[WLHttpManager shareManager]requestWithURL:WLSearchCompanyUserUrl RequestType:RequestTypePost Parameters:paramaters Success:^(id responseObject) {
        
        WlLog(@"%@",responseObject);
        
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        
        if ([net_model.result integerValue]==1) {
            
          self.searchArray =[WL_SearchResultModel mj_objectArrayWithKeyValuesArray:net_model.data];
            
        }
        
        //搜索数据源变了  ->让搜索控制器 内部的结果视图控制器的tableView的刷新
        UITableViewController *tableVC = (UITableViewController *)searchController.searchResultsController;
        
        [tableVC.tableView reloadData];
        
        if (self.searchArray.count==0) {
            
            [self hideNoData:NO andType:WLNetworkTypeNOData];
        }else
        {
            self.noDataView2.hidden = YES;
        }
        
        
    } Failure:^(NSError *error) {
        
        if (error.code==-1009) {
            
            [self hideNoData:NO andType:WLNetworkTypeNONetWork];
        }else
        {
            [self hideNoData:NO andType:WLNetworkTypeSeverError];
        }
    
    }];

}

- (void)willPresentSearchController:(UISearchController *)searchController
{
    self.searchVC.searchBar.barTintColor = [WLTools stringToColor:@"#4877e7"];
    
    UIImageView *barImageView = [[[self.searchVC.searchBar.subviews firstObject] subviews] firstObject];
    
    barImageView.layer.borderColor = [WLTools stringToColor:@"#4877e7"].CGColor;
    
    barImageView.layer.borderWidth = 1;
    
    UIButton *canceLBtn = [self.searchVC.searchBar valueForKey:@"cancelButton"];
    
    [canceLBtn setTitle:@"取消" forState:UIControlStateNormal];
    
    [canceLBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
- (void)didPresentSearchController:(UISearchController *)searchController
{
    self.searchVC.searchBar.barTintColor = [WLTools stringToColor:@"#4877e7"];
    
    UIImageView *barImageView = [[[self.searchVC.searchBar.subviews firstObject] subviews] firstObject];
    
    barImageView.layer.borderColor = [WLTools stringToColor:@"#4877e7"].CGColor;
    
    barImageView.layer.borderWidth = 1;
    
    UIButton *canceLBtn = [self.searchVC.searchBar valueForKey:@"cancelButton"];
    
    [canceLBtn setTitle:@"取消" forState:UIControlStateNormal];
    
    [canceLBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
-(void)willDismissSearchController:(UISearchController *)searchController
{
    self.searchVC.searchBar.barTintColor = BgViewColor;
    
    UIImageView *barImageView = [[[self.searchVC.searchBar.subviews firstObject] subviews] firstObject];
    
    barImageView.layer.borderColor = BgViewColor.CGColor;
    
    barImageView.layer.borderWidth = 1;
    
    
}
- (void)didDismissSearchController:(UISearchController *)searchController {
    
    self.searchVC.searchBar.barTintColor = BgViewColor;
    
    UIImageView *barImageView = [[[self.searchVC.searchBar.subviews firstObject] subviews] firstObject];
    
    barImageView.layer.borderColor = BgViewColor.CGColor;
    
    barImageView.layer.borderWidth = 1;
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (tableView==self.tableView) {
        
        if (self.type==1) {
            
            return 1;
        }else if (self.type==2)
            
        {
            return 2;
        }else if (self.type==3)
        {
            return 3;
        }
        
        return 2;
        
    }
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView==self.tableView) {
        
        if (self.type==1) {
            
            return 1;
            
        }else if (self.type ==2)
        {
            if (section==0) {
                
                return 1;
            }else if (section==1)
            {
                return self.staffArray.count;
            }
        }else if (self.type==3)
        {
           
            if (section==0) {
                
                
                return 1;
                
            }else if (section==1) {
                
                return self.departmentArray.count;
            }else
                
                return self.staffArray.count;
            
        }else if (self.type==4)
        {
            if (section==0) {
                
                
                return 1;
                
            }else if (section==1) {
                
                return self.departmentArray.count;
        }
        
        }
        
    }
    
    return self.searchArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (tableView==self.tableView) {
        
        if (section==0||section==1) {
            
            return 0.01;
        }
        return 15;
    }
    
    return 0.01;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (tableView ==self.tableView) {
        
    
        UIView *sectionView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
        
        sectionView.backgroundColor = BgViewColor;
        
        return sectionView;
        
    }
    
    return nil;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView ==self.tableView) {
        
        if (self.type==1) {
            
            if (indexPath.section==0) {
                
                return 56;
            }
            
        }else if (self.type==2)
        {
            if (indexPath.section==0) {
                
                return 56;
                
            }else if (indexPath.section==1)
            {
                return 60;
            }
            
        }else if (self.type==3)
            
        {
            if (indexPath.section==0) {
                
                return 56;
                
            }else if (indexPath.section==1)
            {
                return 45;
            }else
                
                return 60;
        }
        
        if (indexPath.section==0) {
            
            return 56;
            
        }
        
        return 45;

        
    }
    
    return 65;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (tableView==self.tableView) {
        
        if (self.type==1) {
     
        UITableViewCell *cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
                
        UILabel *line =[[UILabel alloc]initWithFrame:CGRectMake(0, 55.5, ScreenWidth, 0.5)];
                
        line.backgroundColor = bordColor;
                
        [cell.contentView addSubview:line];
 
        NSMutableArray *title =[[NSMutableArray alloc]init];
            
        for (WL_DepartmentModel *model in self.array) {
                
                [title addObject:model.department_name];
        }
            
        self.history = [[JHCusomHistory alloc] initWithFrame:CGRectMake(0,0, CGRectGetWidth(self.view.frame),55) andItems:title andItemClickBlock:^(NSInteger i) {
                
                WlLog(@"%lu",i);
                
        [self popToViewControllerWith:i];
                
            }];
            
        UICollectionViewCell *ce = [self.history.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.array.count-1 inSection:0]];
            
        [self.history.collectionView scrollRectToVisible:ce.frame animated:YES];
            
        [cell.contentView addSubview:self.history];
  
        return cell;
  
        }else if (self.type==2)
        {
            if (indexPath.section==0) {
                
                UITableViewCell *cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
                    
                    
                UILabel *line =[[UILabel alloc]initWithFrame:CGRectMake(0, 55.5, ScreenWidth, 0.5)];
                    
                line.backgroundColor = bordColor;
                    
                [cell.contentView addSubview:line];
                
                NSMutableArray *title =[[NSMutableArray alloc]init];
                
                for (WL_DepartmentModel *model in self.array) {
                    
                    [title addObject:model.department_name];
                }
                
                self.history = [[JHCusomHistory alloc] initWithFrame:CGRectMake(0,0, CGRectGetWidth(self.view.frame),55) andItems:title andItemClickBlock:^(NSInteger i) {
                    
                    WlLog(@"%lu",i);
                    
                    [self popToViewControllerWith:i];
                    
                }];
                

                [cell.contentView addSubview:self.history];
                
                return cell;
         
            }else if (indexPath.section==1)
            {
                WL_Staff_TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:StaffTableViewCell];
                
                if (cell==nil) {
                    
                    cell =[[WL_Staff_TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:StaffTableViewCell];
                    
                    
                }
                cell.selectionStyle =UITableViewCellSelectionStyleNone;
                
                WL_StaffModel *model = self.staffArray [indexPath.row];
                
                cell.model = model;
                
                WS(weakSelf);
                
                cell.buttonSelectBlock = ^(NSIndexPath *index,UIButton *button)
                {
                    
                    
                    WL_Save_Model *saveMod = [[WL_Save_Model alloc]init];
                    
                    saveMod.user_id =model.user_id;
                    
                    saveMod.real_name = model.real_name;
                    
                    saveMod.photo =model.photo;
                    
                    saveMod.user_name = model.department_name;
                    
                    saveMod.mobile = model.user_mobile;
                    
                    
                    if (button.selected) {
                        
                        [[WL_ShareArray shareArray].saveArray setObject:saveMod forKey:saveMod.user_id];
                    }else
                    {
                        [[WL_ShareArray shareArray].saveArray removeObjectForKey:saveMod.user_id];
                    }
                    
                    
                    [weakSelf  setLabelNumber];
                    
                    
                    WlLog(@"%@",[WL_ShareArray shareArray].saveArray);
                };
                
                
                for (NSString *key in [[WL_ShareArray shareArray].saveArray allKeys]) {
                    
                    
                    if ([model.user_id isEqualToString:key]) {
                        
                        cell.selectImageView.selected =YES;
                    }
                    
                }

                return cell;

            }
        }else if (self.type==3)
        {
            
            if (indexPath.section==0)
            {
                
            UITableViewCell *cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
                    
                    
            UILabel *line =[[UILabel alloc]initWithFrame:CGRectMake(0, 55.5, ScreenWidth, 0.5)];
                    
            line.backgroundColor = bordColor;
                    
            [cell.contentView addSubview:line];
                
                NSMutableArray *title =[[NSMutableArray alloc]init];
                
                for (WL_DepartmentModel *model in self.array) {
                    
                    [title addObject:model.department_name];
                }
                
                self.history = [[JHCusomHistory alloc] initWithFrame:CGRectMake(0,0, CGRectGetWidth(self.view.frame),55) andItems:title andItemClickBlock:^(NSInteger i) {
                    
                    WlLog(@"%lu",i);
                    
                    [self popToViewControllerWith:i];
                    
                }];
  
                [cell.contentView addSubview:self.history];
                
                UICollectionViewCell *ce = [self.history.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.array.count-1 inSection:0]];
                
                [self.history.collectionView scrollRectToVisible:ce.frame animated:YES];
            
                return cell;
                    
                
            }else if (indexPath.section ==1)
            {
                
                
                    
                WL_CorporateStructure_Cell *cell =[tableView dequeueReusableCellWithIdentifier:CorporateStructureCell];
                if (cell==nil) {
                    
                    cell = [[WL_CorporateStructure_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CorporateStructureCell];
                    
                    
                }
                cell.selectionStyle =UITableViewCellSelectionStyleNone;
                
                WL_DepartmentModel *model = self.departmentArray[indexPath.row];
                
                if (indexPath.row == self.departmentArray.count-1) {
                    
                    cell.line.hidden = YES;
                }
                
                cell.model = model;

                return cell;
 
            }else if (indexPath.section==2)
            {
                WL_Staff_TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:StaffTableViewCell];
                
                if (cell==nil) {
                    
                    cell =[[WL_Staff_TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:StaffTableViewCell];
                    
                }
                
                cell.selectionStyle =UITableViewCellSelectionStyleNone;
                
                WL_StaffModel *model = self.staffArray [indexPath.row];
                
                cell.model = model;
                
                
                WS(weakSelf);
                
                cell.buttonSelectBlock = ^(NSIndexPath *index,UIButton *button)
                {
                    
                    
                    WL_Save_Model *saveMod = [[WL_Save_Model alloc]init];
                    
                    saveMod.user_id =model.user_id;
                    
                    saveMod.real_name = model.real_name;
                    
                    saveMod.photo =model.photo;
                    
                    saveMod.user_name = model.department_name;
                    
                    saveMod.mobile = model.user_mobile;
                    
                    
                    if (button.selected) {
                        
                        [[WL_ShareArray shareArray].saveArray setObject:saveMod forKey:saveMod.user_id];
                    }else
                    {
                        [[WL_ShareArray shareArray].saveArray removeObjectForKey:saveMod.user_id];
                    }
                    
                    
                    [weakSelf  setLabelNumber];
                    
                    
                    WlLog(@"%@",[WL_ShareArray shareArray].saveArray);
                };
                
                
                for (NSString *key in [[WL_ShareArray shareArray].saveArray allKeys]) {
                    
                    
                    if ([model.user_id isEqualToString:key]) {
                        
                        cell.selectImageView.selected =YES;
                    }
                    
                }

                return cell;
            }

        }else if (self.type==4)
        {
            
            
            if (indexPath.section==0) {
                
                    UITableViewCell *cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
                    
                    
                    UILabel *line =[[UILabel alloc]initWithFrame:CGRectMake(0, 55.5, ScreenWidth, 0.5)];
                    
                    line.backgroundColor = bordColor;
                    
                
                    [cell.contentView addSubview:line];
                

                NSMutableArray *title =[[NSMutableArray alloc]init];
                
                  for (WL_DepartmentModel *model in self.array) {
                    
                    [title addObject:model.department_name];
                }
                
                self.history = [[JHCusomHistory alloc] initWithFrame:CGRectMake(0,0, CGRectGetWidth(self.view.frame),55) andItems:title andItemClickBlock:^(NSInteger i) {
                    
                    WlLog(@"%lu",i);
                    
                    [self popToViewControllerWith:i];
                    
                }];

                [cell.contentView addSubview:self.history];
                    
                 return cell;
   
            }else if (indexPath.section==1)
            {
    
                WL_CorporateStructure_Cell *cell =[tableView dequeueReusableCellWithIdentifier:CorporateStructureCell];
                if (cell==nil) {
                    
                    cell = [[WL_CorporateStructure_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CorporateStructureCell];
      
                }
                cell.selectionStyle =UITableViewCellSelectionStyleNone;
                
                WL_DepartmentModel *model = self.departmentArray[indexPath.row];
                
                if (indexPath.row == self.departmentArray.count-1) {
                    
                    cell.line.hidden = YES;
                }
                
                cell.model = model;

                return cell;
              }
 
        }

    }
    
    static NSString *cellID2 = @"cellID2";
    
    WL_MyFriendList_Cell *cell =[tableView dequeueReusableCellWithIdentifier:cellID2];
    
    if (cell==nil) {
        
        cell =[[WL_MyFriendList_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID2];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    WL_SearchResultModel *mode = self.searchArray[indexPath.row];
    
    cell.searchResult = mode;
    
    cell.path =indexPath;
    
    cell.selectImageView.selected =NO;
    
    cell.buttonSelectBlock = ^(NSIndexPath *index,UIButton *button)
    {
        
        WL_SearchResultModel *mod = self.searchArray[index.row];
        
        WL_Save_Model *saveMode =[[WL_Save_Model alloc]init];
        
        saveMode.user_id = mod.user_id;
        
        saveMode.photo =mod.photo;
        
        saveMode.real_name = mod.real_name;
        
        saveMode.user_name = mod.user_name;
        
        saveMode.mobile =mod.user_mobile;
        
        if (button.selected) {
            
            [[WL_ShareArray shareArray].saveArray setObject:saveMode forKey:saveMode.user_id];
            
        }else
        {
            [[WL_ShareArray shareArray].saveArray removeObjectForKey:saveMode.user_id];
        }
        
        [self setLabelNumber];
    };
    
    for (NSString *key in [[WL_ShareArray shareArray].saveArray allKeys]) {
        
        if ([mode.user_id isEqualToString:key]) {
            
            cell.selectImageView.selected =YES;
        }
        
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell isKindOfClass:[WL_CorporateStructure_Cell class]]) {
     
        WL_DepartmentModel *model = self.departmentArray[indexPath.row];
        
        WL_DepartMentNext_ViewController *VC = [[WL_DepartMentNext_ViewController alloc]init];
        
        VC.model = model;
        
        BOOL same = false;
        
        for (WL_DepartmentModel *mod  in self.array) {
            
            if ([model.department_name isEqualToString:mod.department_name]) {
              
                same = YES;
            }
        }
        
        if (!same) {
        
            [self.array addObject:model];
        }
        
        VC.array = self.array;
        
        [self.navigationController pushViewController:VC animated:YES];
        
    }
    

 }

-(void)NavigationLeftEvent
{
    
//    [self.array removeObject:[self.array lastObject]];
//    
//    [self.navigationController popViewControllerAnimated:YES];
    
    
    if ([[DEFAULTS objectForKey:@"adressbook"]isEqualToString:@"1"]) {
       
        NSArray *arr = self.navigationController.viewControllers;
        
        [self.navigationController popToViewController:arr[3] animated:YES];
        
        [WL_ShareArray shareArray].saveArray = [NSMutableDictionary dictionaryWithDictionary:self.originArray];
    }else if ([[DEFAULTS objectForKey:@"adressbook"]isEqualToString:@"2"])
    {
        NSArray *arr = self.navigationController.viewControllers;
        
        [self.navigationController popToViewController:arr[4] animated:YES];
        
        [WL_ShareArray shareArray].saveArray = [NSMutableDictionary dictionaryWithDictionary:self.originArray];
    }
}

-(void)popToViewControllerWith:(NSInteger )index
{
    
    if ([[DEFAULTS objectForKey:@"adressbook"]isEqualToString:@"1"]) {
       
        NSArray *arr = self.navigationController.viewControllers;
        
        WlLog(@"%@",arr);
        
        [self.array removeObjectsInRange:NSMakeRange(index+1, self.array.count-index-1)];
        
        [self.navigationController popToViewController:arr[5+index-2] animated:YES];
        
    }else if ([[DEFAULTS objectForKey:@"adressbook"]isEqualToString:@"2"])
    {
        NSArray *arr = self.navigationController.viewControllers;
        
        WlLog(@"%@",arr);
        
        [self.array removeObjectsInRange:NSMakeRange(index+1, self.array.count-index-1)];
        
        [self.navigationController popToViewController:arr[6+index-2] animated:YES];
        
    }
   
  }

#pragma mark 键盘出现
- (void)customerKeyboardWillShow:(NSNotification *)aNotification
{
    CGRect rect = [aNotification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    self.tableVC.tableView.height = ScreenHeight - rect.size.height;
    
}
#pragma mark 键盘消失
- (void)customerKeyboardWillHide:(NSNotification *)aNotification
{
    
    self.tableVC.tableView.height = ScreenHeight -64 -50;
}

-(void)setLabelNumber
{
    
    self.selectedNum.text = [NSString stringWithFormat:@"已选择:%lu人",(unsigned long)[[WL_ShareArray shareArray].saveArray allKeys].count];
    
    self.selectedNum2.text = [NSString stringWithFormat:@"已选择:%lu人",(unsigned long)[[WL_ShareArray shareArray].saveArray allKeys].count];
    
    if ([[WL_ShareArray shareArray].saveArray allKeys].count>0) {
        
        self.sureButton2.enabled =YES;
        
        self.sureButton.enabled = YES;
        
        self.sureButton.alpha = 1;
        
        self.sureButton2.alpha = 1;
        
    }else if ([[WL_ShareArray shareArray].saveArray allKeys].count==0)
    {
        self.sureButton2.enabled =NO;
        
        self.sureButton.enabled = NO;
        
        self.sureButton.alpha =0.4;
        
        self.sureButton2.alpha =0.4;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
