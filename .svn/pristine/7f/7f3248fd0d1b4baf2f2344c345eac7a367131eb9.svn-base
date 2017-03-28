//
//  WL_AddressBook_MyAddressBook_ViewController.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/8.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  手机通讯录主控制器

#import "WL_AddressBook_MyAddressBook_ViewController.h"

#import "WL_AddressBook_LinkManDetail_ViewController.h"

#import "WL_AddressBook_MyAddressBook_Linkman_ViewController.h"

#import "WL_AddressBook_MyAddressBook_Search_ViewController.h"

#import "APAddressBook.h"
#import "APContact.h"
#import "ContactDataHelper.h"
#import "WL_AddressBook_MyAddressBook_Cell.h"
#import "WL_ContactIndex_View.h"
//#import "WL_Customer_DB_Operation.h"
//#import "WL_DBHelper.h"
#import "WL_Alert_View.h"
#import "WL_AddressBook_Content_Model.h"
#import "WL_AddressBook_Search_View.h"
#import "WL_AddressBook_MyAddressBook_AttentionMessage_Model.h"


@interface WL_AddressBook_MyAddressBook_ViewController ()<UITableViewDelegate, UITableViewDataSource>
//显示通讯录的tableView
@property (nonatomic,strong)UITableView *tableView;
//头部数据源
@property (nonatomic,strong)NSMutableArray *titleArray;
//数据源
@property (nonatomic,strong)NSMutableArray *dataArray;
//已有电话的数组
@property (nonatomic,strong)NSArray *phoneArray;
//所有手机联系人
@property (nonatomic,strong)NSArray *allContacts;
//搜索的过滤数据
@property (nonatomic,strong)NSMutableArray *filterArray;
//纪录多选的数组
@property (nonatomic,strong)NSIndexPath *selectIndexPath;
//纪录当前是单选还是多选
@property (nonatomic,assign)ChooseType type;
//索引条
@property (nonatomic,strong)WL_ContactIndex_View *indexView;

/** 网络请求时需要用到的弹框 */
@property(nonatomic, strong)WL_TipAlert_View *alert;

@end

@implementation WL_AddressBook_MyAddressBook_ViewController
#pragma mark ----LazyLoad

- (NSMutableArray *)titleArray{
    
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)filterArray{
    
    if (!_filterArray) {
        _filterArray = [NSMutableArray array];
    }
    return _filterArray;
}
- (WL_ContactIndex_View *)indexView{
    
    if (!_indexView) {
        _indexView = [WL_ContactIndex_View new];
        WS(weakSelf);
        _indexView.SelectIndex = ^(NSInteger index){
            
            [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        };
        [self.view addSubview:_indexView];
        
        
        [_indexView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.view.mas_right).offset(-5);
            make.centerY.equalTo(self.view.mas_centerY);
            make.height.equalTo(@(ScreenHeight - 64));
            make.width.equalTo(@18);
            
        }];
    }
    
    return _indexView;
}
- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView registerClass:[WL_AddressBook_MyAddressBook_Cell class] forCellReuseIdentifier:@"cell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [WLTools stringToColor:@"#f7f7f8"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        
        
        // 添加 searchbar 到 headerview
        
        //头部搜索框SearchView
        WL_AddressBook_Search_View *searchView = [[WL_AddressBook_Search_View alloc] initWithSearchPlaceholder:@"手机通讯录" backgroundColor:[UIColor whiteColor] frame:CGRectMake(0, 0, ScreenWidth, 37.0) clickAction:^{
            WL_AddressBook_MyAddressBook_Search_ViewController *searchVc = [[WL_AddressBook_MyAddressBook_Search_ViewController alloc] init];
            [self.navigationController pushViewController:searchVc animated:YES];
        }];
        _tableView.tableHeaderView = searchView;

        [self.view addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.view.mas_top);
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.bottom.equalTo(self.view.mas_bottom);
            
        }];
    }
    
    return _tableView;
    
}

//初始化方法
- (instancetype)initWithType:(ChooseType)chooseType{
    
    self = [super init];
    if (self) {
        
        self.type = chooseType;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"手机通讯录";
    
    self.view.backgroundColor = [WLTools stringToColor:@"#f7f7f8"];
    
    
    [self showHud];

    
    //获取通讯录
    [self getAllContact];
    
    //注册弹框
    [self creatTipAlertView];
}

#pragma mark - 注册弹框
- (void)creatTipAlertView
{
    self.alert = [WL_TipAlert_View sharedAlert];
    
}



//获取系统通讯录，过滤相应数据
- (void)getAllContact
{
    
    
    
    
    WlLog(@"%ld",(unsigned long)[APAddressBook access]);
    
    if ([APAddressBook access] == APAddressBookAccessDenied) {
        
        WL_Alert_View *alertView = [WL_Alert_View new];
        
        [[UIApplication sharedApplication].keyWindow addSubview:alertView];
        
        
        [alertView setAlertType:AlertTypeNormal title:@"温馨提示" message:@"请到设置->隐私中打开相关权限" cancelButtonTitle:@"取消" andOtherButtonTitle:@"确认"];
        
        [alertView hide:NO];
        
        
        
    }
    
    
    APAddressBook *addressBook = [[APAddressBook alloc]init];
    
    
    [addressBook loadContacts:^(NSArray *contacts, NSError *error) {
        
        NSMutableArray *modelArray = [NSMutableArray array];
        NSMutableArray *uperArray = [NSMutableArray array];
        
        for (APContact *contact in contacts) {
            
            
            WL_AddressBook_Content_Model *model = [[WL_AddressBook_Content_Model alloc]init];
            model.name = [NSString stringWithFormat:@"%@%@",contact.lastName?contact.lastName:@"",contact.firstName?contact.firstName:@""];
            NSString *phone = @"";
            if (contact.phones.count > 0) {
                
                for (NSString * judgePhone in contact.phones) {
                    NSString *string = [[ContactDataHelper shareManager] trimmingString:judgePhone];
                    if ([RegexTools isMobileNumber:string]) {
                        
                        phone = string;
                        break;
                    }
                    
                }
            }
            
            if (contact.phones.count > 0 && [phone isEqualToString:@""]) {
                
                phone = [[ContactDataHelper shareManager] trimmingString: contact.phones[0]];
                
            }
            
            
            model.phone = phone;
            
            NSString *pinYin = @"";
            if (model.name.length > 0) {
                
                pinYin = [[ContactDataHelper shareManager] transformMandarinToLatin:model.name];
                NSString *uper = [[pinYin substringToIndex:1] uppercaseString];
                
                char c = [uper characterAtIndex:0];
                //判断是否为大写字母
                if (isupper(c)) {
                    
                    model.uperCharater = uper;
                }else{
                    
                    model.uperCharater = @"#";
                }
                [uperArray addObject:model.uperCharater];
                
                
            }else{
                
                
                if (phone.length > 0 ) {
                    
                    model.uperCharater = @"#";
                    model.name = phone;
                    [uperArray addObject:model.uperCharater];
                }
                
            }
            
            if ([model.name isEqualToString:@"1111111"]) {
                
                WlLog(@"%@---%@",contact.photo,contact.thumbnail);
                
            }
            
            
            //安卓说加载用户头像卡  统一默认图
            //            model.headerImage = contact.photo;
            
            [modelArray addObject:model];
            
        }
        
        self.allContacts = modelArray;
        
        [self.titleArray addObjectsFromArray:[uperArray sortedArrayUsingSelector:@selector(compare:)]];
        
        self.titleArray = [[ContactDataHelper shareManager] arrayWithMemberIsOnly:self.titleArray];
        
        
        
        for (int i = 0; i<self.titleArray.count; i++) {
            
            NSMutableArray *array = [NSMutableArray array];
            
            for (WL_AddressBook_Content_Model *model in modelArray) {
                
                
                if ([model.uperCharater isEqualToString:self.titleArray[i]]) {
                    
                    [array addObject:model];
                }
                
            }
            
            [self.dataArray addObject:array];
            
        }
        
        [self.tableView reloadData];
        
        self.indexView.dataSource = self.titleArray;
        
        if (!error) {
            
            
        }
        
        
    }];
    
}
#pragma mark  --tableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.tableView == tableView) {
        return self.dataArray.count;
    }
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    WlLog(@"%ld",(unsigned long)self.dataArray.count);
    
    if (self.tableView == tableView) {
        
        return [self.dataArray[section] count];
    }
    return self.filterArray.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WL_AddressBook_MyAddressBook_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.phoneArray = self.phoneArray;
    
    if (self.tableView == tableView) {
        
        WL_AddressBook_Content_Model *model = self.dataArray[indexPath.section][indexPath.row];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.isSelected = model.isSelected;
        
        [cell configCellWithModel:model];
        
        NSArray *cellArr = self.dataArray[indexPath.section];
        cell.lineView.hidden = indexPath.row == cellArr.count - 1 ? YES : NO;
        
    }else{
        
        WL_AddressBook_Content_Model *model = self.filterArray[indexPath.row];
        
        [cell configCellWithModel:model];
        
    }
    
    return cell;
    
}

#pragma mark  tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (tableView == self.tableView) {
        return 30;
    }
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 64.0f;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (tableView == self.tableView) {
        
        UIView *view = [UIView new];
        view.backgroundColor = [WLTools stringToColor:@"#f7f7f8"];
        view.frame = CGRectMake(0, 0, ScreenWidth, 33);
        
        UILabel *label = [UILabel new];
        label.textColor = [WLTools stringToColor:@"#868686"];
        label.text = self.titleArray[section];
        label.font = WLFontSize(13);
        [view addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left).offset(10);
            make.bottom.equalTo(view.mas_bottom).offset(-6);
            
        }];
        return view;
        
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [WLTools stringToColor:@"#f7f7f8"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WL_AddressBook_MyAddressBook_Cell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //发送验证请求
    [self sendRequestToAttentionWithPhone:cell.phoneLabel.text withName:cell.nameLabel.text];
  
    
}

#pragma mark - 发送验证请求
- (void)sendRequestToAttentionWithPhone:(NSString *)phone withName:(NSString *)name
{
    if ([phone isEqualToString:@""] || phone == nil) {
        [self.alert createTip:@"手机号码不能为空"];
        return;
    }
    if ([phone isEqualToString:@"0"]) {
        [self.alert createTip:@"手机号码格式不正确"];
        return;
    }
    
    
    //请求URL
    NSString *urlStr = addSearchFriendsUrl;
    //请求参数
    //从本地获取密码
    NSString *userPassword = [WLUserTools getUserPassword];////[[NSUserDefaults standardUserDefaults] objectForKey:@"userPassword"];
    //给userPassowrd进行RSA加密
    NSString *rsaUserPassword = [MyRSA encryptString:userPassword publicKey:RSAKey];
    //从本地获取用户id
    NSString *userId = [WLUserTools getUserId];
    //获取用户电话号码
    NSString *my_phone = [WLUserTools getUserMobile];
    //请求参数集合
    NSDictionary *params = @{
                             @"user_id" : userId,
                             @"user_password" : rsaUserPassword,
                             @"friend_mobile" : phone,
                             @"my_mobile" : my_phone
                                 };
    [self showHud];
    [[WLHttpManager shareManager] requestWithURL:urlStr RequestType:RequestTypePost Parameters:params Success:^(id responseObject)
    {
        
        WL_Network_Model *baseModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (![baseModel.result isEqualToString:@"1"]) {
            [self.alert createTip:baseModel.msg];
            [self hidHud];
            return;
        }
        WL_AddressBook_MyAddressBook_AttentionMessage_Model *attentionModel = [WL_AddressBook_MyAddressBook_AttentionMessage_Model mj_objectWithKeyValues:baseModel.data];
        if ([attentionModel.isreg isEqualToString:@"0"])
        {
            //没有注册, 跳转到未注册的控制器去
            WL_AddressBook_MyAddressBook_Linkman_ViewController *myLinkmanVc = [[WL_AddressBook_MyAddressBook_Linkman_ViewController alloc] init];
            myLinkmanVc.name = name;
            myLinkmanVc.phoneNum = phone;
            [self.navigationController pushViewController:myLinkmanVc animated:YES];
            
        }
        else
        {
            //已经注册, 跳转到常用联系人详情去
            WL_AddressBook_LinkManDetail_ViewController *linkManDetailVc = [[WL_AddressBook_LinkManDetail_ViewController alloc] init];
            linkManDetailVc.view_id = attentionModel.user_id;
            if (attentionModel.company.count == 0 || attentionModel.company == nil) {
                //不在同一个组织
                linkManDetailVc.isCompany = @"0";
            }
            else
            {
                //同一个组织
                linkManDetailVc.isCompany = @"1";
            }
            [self.navigationController pushViewController:linkManDetailVc animated:YES];
        }

        [self hidHud];
    }
    Failure:^(NSError *error)
    {
        //弹框提示错误信息
        if (error.code == -1009)
        {
            [self.alert createTip:@"似乎已断开与互联网的连接"];
        }
        else
        {
            [self.alert createTip:@"服务器错误,请稍后重试"];
        }
        
        //隐藏菊花
        [self hidHud];
    }];
}

- (void)dealloc
{
    [self.alert removeFromSuperview];
}




@end
