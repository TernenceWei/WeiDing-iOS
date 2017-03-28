//
//  WL_MyFriendList_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 2016/11/14.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_MyFriendList_ViewController.h"
#import "WL_SectionIndexView.h"
#import "WL_AddressBook_MyFriend_Model.h"
#import "WL_MyFriendList_Cell.h"
#import "WL_ShareArray.h"
#import "WL_Save_Model.h"
#import "WL_SelectedFriend_ViewController.h"
#import "WL_EditPrivateLetter_ViewController.h"
#import "WL_SearchResultModel.h"
#import "WLNetworkMessageHandler.h"

@interface WL_MyFriendList_ViewController ()<UISearchControllerDelegate,UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource,sectionIndexViewDelegate>

@property (nonatomic, strong) UISearchController *searchVC;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *searchArray;
@property (nonatomic, strong) NSMutableArray *sectionArray;
@property (nonatomic, strong) NSMutableArray *rowArray;
@property (nonatomic, strong) WL_Network_Model *netModel;
@property (nonatomic, strong) UIView *bottomDetailView;
@property (nonatomic, strong) UILabel *selectedNum;
@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) UIView *inputAccessoryView;
@property (nonatomic, strong) UILabel *selectedNum2;
@property (nonatomic, strong) UIButton *sureButton2;
@property (nonatomic, strong) NSMutableDictionary *originDictionary;
@property (nonatomic, strong) UITableViewController *tableVC;
@property (nonatomic, strong) WL_NoData_View *noDataView;

@end

@implementation WL_MyFriendList_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"微叮好友";
    self.view.backgroundColor = BgViewColor;
    ////增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(customerKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(customerKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.originDictionary =[NSMutableDictionary dictionaryWithDictionary:[WL_ShareArray shareArray].saveArray];
    [self getMyFriendListData];
    
}

-(NSMutableArray *)sectionArray
{
    if (_sectionArray==nil) {
        _sectionArray =[[NSMutableArray alloc]init];
    }
    return _sectionArray;
}

-(NSMutableArray *)rowArray
{
    if (_rowArray==nil) {
        _rowArray=[[NSMutableArray alloc]init];
    }

    return _rowArray;
}

-(NSMutableArray *)searchArray
{
    if (_searchArray==nil) {
        _searchArray =[[NSMutableArray alloc]init];
    }
    return _searchArray;
}

-(void)getMyFriendListData{
    
    NSString *userId = [WLUserTools getUserId];
    
    NSString *passWord =[WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:passWord publicKey:RSAKey];
    
    NSString *sort_mode = @"2";//按照字母顺序来请求
    
    NSDictionary *paramaters =@{@"user_id":userId,@"user_password":encryptStr,@"sort_mode":sort_mode};
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager]requestWithURL:MyFriendListUrl RequestType:RequestTypePost Parameters:paramaters Success:^(id responseObject) {
       
        WlLog(@"%@",responseObject);
        
        self.netModel =[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([self.netModel.result integerValue]==1) {
            
            if ([self.netModel.data isKindOfClass:[NSDictionary class]]) {
              
                NSArray *array = [self.netModel.data allKeys];
                
                self.sectionArray = [NSMutableArray arrayWithArray:array];
                
                [self.sectionArray sortUsingSelector:@selector(compare:)];
                
                
                
                for (int i = 0;i<self.sectionArray.count;i++)
                {
                    
                    NSMutableArray *modelArray= [[NSMutableArray alloc]init];
                    
                    NSArray *array = [self.netModel.data objectForKey:self.sectionArray[i]];
                    
                    for (NSDictionary *dic in array) {
                        
                        WL_AddressBook_MyFriend_Model *model =[WL_AddressBook_MyFriend_Model mj_objectWithKeyValues:dic];
                        
                        [modelArray addObject:model];
                    }
                    [self.rowArray addObject:modelArray];
                    
                }

                weakSelf.noDataView.hidden = YES;
                
                weakSelf.tableView.hidden = NO;
                
            }else
            {
                [weakSelf hideNoData:NO andType:WLNetworkTypeNOData];
                
                weakSelf.tableView.hidden =YES;
            }
            
          
        [self createUI];
       
        }
        
        
    } Failure:^(NSError *error) {
    
        
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
        
        _noDataView = [[WL_NoData_View alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) andRefreshBlock:^{
            // [ws initData];
            
        }];
        _noDataView.hidden = YES;
    }
    return _noDataView;
}

#pragma makr - 设置无数据提示的显示、隐藏及类型
- (void)hideNoData:(BOOL)hidden andType:(WLNetworkType)type {
    
    self.noDataView.hidden = hidden;
    if (!hidden) {
        self.noDataView.type = type;
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
    
    //创建一个tableViewController自带一个tableView
    self.tableVC = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.tableVC.tableView.delegate = self;
    self.tableVC.tableView.dataSource = self;
    self.tableVC.tableView.rowHeight = 65;
    self.tableVC.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self.tableVC.view addSubview:self.noDataView];

    
    self.searchVC = [[UISearchController alloc] initWithSearchResultsController:self.tableVC];
    self.searchVC.searchResultsUpdater =self;
    self.searchVC.delegate =self;
    self.searchVC.searchBar.placeholder = @"找人";
    self.searchVC.searchBar.showsCancelButton = YES;
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
    WL_SectionIndexView * sectionView =[[WL_SectionIndexView alloc]initWithFrame:CGRectMake(ScreenWidth-20-10, 100, 20, self.sectionArray.count*20) andSectionArray:self.sectionArray];
    sectionView.backgroundColor =[UIColor clearColor];
    sectionView.delegate = self;
    sectionView.centerY = self.view.centerY;
    [self.view addSubview:sectionView];
    
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

-(void)NavigationLeftEvent
{
    [WL_ShareArray shareArray].saveArray = [NSMutableDictionary dictionaryWithDictionary:self.originDictionary];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)sureButton:(UIButton *)button
{
    //1的时候WL_EditPrivateLetter_ViewController 在self.navigationController.viewControllers的第3个位置
    if ([[DEFAULTS objectForKey:@"adressbook"]isEqualToString:@"1"]) {
        WL_EditPrivateLetter_ViewController *VC =self.navigationController.viewControllers[2];
        [VC reloadCellectionViewWith:[WL_ShareArray shareArray].saveArray];
        [self.navigationController popToViewController:VC animated:YES];
        
    //2的时候WL_EditPrivateLetter_ViewController 在self.navigationController.viewControllers的第4个位置
    }else if ([[DEFAULTS objectForKey:@"adressbook"]isEqualToString:@"2"]){
       
        WlLog(@"%@",self.navigationController.viewControllers);
        WL_EditPrivateLetter_ViewController *VC =self.navigationController.viewControllers[3];
        [VC reloadCellectionViewWith:[WL_ShareArray shareArray].saveArray];
        [self.navigationController popToViewController:VC animated:YES];
    }
    
}

-(void)didSelectCellIndex:(NSIndexPath *)indexPath
{
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
    [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}

#pragma mark --UISearchControllerDelegate

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    self.noDataView.hidden =YES;
    WS(weakSelf);
    [WLNetworkMessageHandler searchFriendOrGroupWithText:self.searchVC.searchBar.text
                                                    type:@"1"
                                               dataBlock:^(WLResponseType responseType, id data, NSString *message) {
                                                   
                                                   if (responseType == WLResponseTypeSuccess) {
                                                       
                                                       weakSelf.searchArray = (NSMutableArray *)data;
                                                       if (weakSelf.searchArray.count==0) {
                                                           [weakSelf hideNoData:NO andType:WLNetworkTypeNOData];
                                                       }else{
                                                           weakSelf.noDataView.hidden =YES;
                                                       }
                                                       
                                                       //搜索数据源变了  ->让搜索控制器 内部的结果视图控制器的tableView的刷新
                                                       UITableViewController *tableVC = (UITableViewController *)searchController.searchResultsController;
                                                       [tableVC.tableView reloadData];
                                                       
                                                   }else if (responseType == WLResponseTypeNoNetwork){
                                                       
                                                       [weakSelf hideNoData:NO andType:WLNetworkTypeNONetWork];
                                                       
                                                   }else{
                                                       
                                                       [weakSelf hideNoData:NO andType:WLNetworkTypeSeverError];
                                                       
                                                   }
                                               }];
    
 
}

#pragma mark - UISearchControllerDelegate
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
        return self.sectionArray.count;
    }
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.tableView) {
        NSArray *array = self.rowArray[section];
        return array.count;
    }
    return self.searchArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView==self.tableView) {
        if (section==0) {
            return 27;
        }
        return 34;
    }
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView ==self.tableView) {
        CGFloat height = 0;
        CGFloat top = 0;
        if (section==0) {
            top = 8;
            height = 27;
        }else        {
            top = 12;
            height =34;
        }
        
        UIView *sectionView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, height)];
        sectionView.backgroundColor = BgViewColor;
        UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(10, top, 50, 18)];
        title.textColor = WLColor(134, 134, 134, 1);
        title.font = WLFontSize(16);
        title.text = self.sectionArray[section];
        [sectionView addSubview:title];
        return sectionView;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tableView) {
        
        static NSString *cellID = @"cellID";
        WL_MyFriendList_Cell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell =[[WL_MyFriendList_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.path =indexPath;
        NSMutableArray * array = self.rowArray[indexPath.section];
        WL_AddressBook_MyFriend_Model *model = array[indexPath.row];
        if (indexPath.row == array.count-1) {
            cell.line.hidden =YES;
        }
        WS(weakSelf);
        cell.buttonSelectBlock = ^(NSIndexPath *index,UIButton *button){
            NSMutableArray * array = self.rowArray[index.section];
            
            WL_AddressBook_MyFriend_Model *model = array[index.row];
            WL_Save_Model *saveMod = [[WL_Save_Model alloc]init];
            saveMod.user_id =model.user_id;
            saveMod.real_name = model.real_name;
            saveMod.photo =model.img;
            saveMod.user_name = model.title;
            saveMod.mobile = model.user_mobile;
            if (button.selected) {
                [[WL_ShareArray shareArray].saveArray setObject:saveMod forKey:saveMod.user_id];
            }else{
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
        cell.model =model;
        return cell;
    
    }
    static NSString *cellID2 = @"cellID2";
    WL_MyFriendList_Cell *cell =[tableView dequeueReusableCellWithIdentifier:cellID2];
    if (cell==nil) {
        cell =[[WL_MyFriendList_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID2];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    WL_SearchResultModel *mode = self.searchArray[indexPath.row];
    cell.nameLabel.text = mode.user_name;
    [cell.logoImageView sd_setImageWithURL:[NSURL URLWithString:mode.photo] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
    cell.telPhone.text = mode.user_mobile;
    cell.nameLabel.text =mode.user_name;
    cell.path =indexPath;
    cell.selectImageView.selected =NO;
    cell.buttonSelectBlock = ^(NSIndexPath *index,UIButton *button){
        
        WL_SearchResultModel *mod = self.searchArray[index.row];
        WL_Save_Model *saveMode =[[WL_Save_Model alloc]init];
        saveMode.user_id = mod.user_id;
        saveMode.photo =mod.photo;
        saveMode.real_name = mod.real_name;
        saveMode.user_name = mod.user_name;
        saveMode.mobile =mod.user_mobile;
        if (button.selected) {
            [[WL_ShareArray shareArray].saveArray setObject:saveMode forKey:saveMode.user_id];
            
        }else{
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

-(void)setLabelNumber{
    
    self.selectedNum.text = [NSString stringWithFormat:@"已选择:%lu人",(unsigned long)[[WL_ShareArray shareArray].saveArray allKeys].count];
    self.selectedNum2.text = [NSString stringWithFormat:@"已选择:%lu人",(unsigned long)[[WL_ShareArray shareArray].saveArray allKeys].count];
    
    if ([[WL_ShareArray shareArray].saveArray allKeys].count>0) {
        
        self.sureButton2.enabled =YES;
        self.sureButton.enabled = YES;
        self.sureButton.alpha =1;
        self.sureButton2.alpha =1;
        
    }else if ([[WL_ShareArray shareArray].saveArray allKeys].count==0){
        self.sureButton2.enabled =NO;
        self.sureButton.enabled = NO;
        self.sureButton.alpha =0.4;
        self.sureButton2.alpha =0.4;
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
