  //
//  WL_Mine_PersonInfo_ViewController.m
//  WeiLvDJS
//
//  Created by liuxin on 16/9/12.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Mine_PersonInfo_ViewController.h"
#import "WL_Mine_PersonInfo_changeInfo_ViewController.h" //修改具体信息的界面
#import "WL_Mine_PersonInfo_QRcode_ViewController.h" //二维码界面
#import "WL_Personinfo_TableViewCell.h"//信息载体cell
#import "WL_Mine_personInfo_changeSex_view.h" //改变性别公司名称的view
#import "WL_Mine_personInfo_Authentication_ViewController.h" //实名认证

#import "WL_Mine_personInfo_Company.h"//公司信息的model

#import <AVFoundation/AVFoundation.h>//相机
#import <AssetsLibrary/AssetsLibrary.h>//相册
#import "WL_Mine_personInfo_userInfoModel.h" //数据模型
#import "WL_Mine_personInfo_regionViewController.h"//选择地区

#import "STPickerArea.h" //现在地区
#import "WLNetworkAccountHandler.h"

@interface WL_Mine_PersonInfo_ViewController ()<UITableViewDataSource,UITableViewDelegate,WL_Mine_PersonInfo_changeInfo_ViewControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,STPickerAreaDelegate>

@property (nonatomic, strong) UITableView * personTableView;

@property (nonatomic, strong) NSMutableArray * userInofLabelArr;
@property (nonatomic, strong) NSMutableArray * userInofArr;
@property (nonatomic, strong) NSMutableArray * compyInfoLabelArr;
@property (nonatomic, strong) NSMutableArray * compyInfoArr;

@property(nonatomic,strong)WL_Mine_personInfo_changeSex_view *ChoseCompanyAlertView;//选择公司的弹出框
@property(nonatomic,strong)WL_Mine_personInfo_changeSex_view *choseSexView;//选择性别的弹出框


//时间选择器背景视图
@property(nonatomic,strong)UIView *timerView;
@property(nonatomic,strong)UIDatePicker *dataPicker;
//数据模型
@property(nonatomic,strong)WL_Mine_personInfo_userInfoModel *PersonInfoModel;
@property(nonatomic,copy)NSString *isAuthentication;
@property(nonatomic,strong)WL_TipAlert_View *personinfoAlert;

//选择性别
@property(nonatomic,strong)UIView *pickBackView;
@property(nonatomic,strong)UIPickerView *choseSexPickView;
@property(nonatomic,strong)NSMutableArray *arrSex;
@property(nonatomic,strong)NSString *disSex;
@property(nonatomic,strong)NSString *isValidate;//是否认证

@property (nonatomic, strong) NSMutableArray *cityArray; //地区数组

@end

@implementation WL_Mine_PersonInfo_ViewController

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatTitleName];
    [self loadCitys];
    
    //注册弹出框
    [self creatPersonAlertView];
    [self creatLeftTitleArr];
    [self.view addSubview:self.personTableView];
   // [self creatTimerView];//创建时间选择器
    [self loadDataFromServer];//从服务器下载数据
    //注册观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeAddressBack:) name:@"changeAddress" object:nil];
    // Do any additional setup after loading the view.
    //创建性别选择器（不是这个）
    //[self creatChoseSexView];
}

#pragma mark----创建弹出框
-(void)creatPersonAlertView
{
    self.personinfoAlert = [WL_TipAlert_View sharedAlert];
}
-(void)creatTitleName
{
    self.view.backgroundColor = BgViewColor;
    self.titleItem.title = @"个人资料";
    
}

- (NSMutableArray *)cityArray
{
    if (!_cityArray) {
        _cityArray = [NSMutableArray array];
    }
    return _cityArray;
}

- (void)loadCitys
{
    WS(weakSelf);
    [WLNetworkAccountHandler requestCityListWithDataBlock:^(WLResponseType responseType, id data, NSString *message) {
        //dispatch_group_leave(group);
        if (responseType == WLResponseTypeSuccess) {
            weakSelf.cityArray = data;
        }
    }];
}

- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area provinceID:(nonnull NSString *)provinceID cityID:(nonnull NSString *)cityID areaID:(nonnull NSString *)areaID
{
    NSString *text = [NSString stringWithFormat:@"%@-%@-%@", province, city, area];
    [self changeCity:cityID chooseCity:text];
}

- (void)changeCity:(NSString *)cityID chooseCity:(NSString *)str
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];

    params[@"city_id"] = [NSString stringWithFormat:@"%@",cityID];

    [[WLNetworkDriverHandler sharedInstance] requestChangePersonalInfoWith:params iSEmail:NO ResultBlock:^(BOOL success, NSString *message) {
        if (success) {
            [_userInofArr replaceObjectAtIndex:5 withObject:str];
            [self.personTableView reloadData];
        }
        else
        {
            [[WL_TipAlert_View sharedAlert] createTip:@"地址保存失败,请稍后重试"];
        }
    }];
}

#pragma mark----属性标题数据源
-(void)creatLeftTitleArr
{

    _userInofLabelArr = [[NSMutableArray alloc] initWithObjects:@"头像",@"昵称",@"二维码名片",@"微叮号",@"性别",@"所在城市",@"邮箱",@"个性签名", nil];
    _compyInfoLabelArr = [[NSMutableArray alloc] initWithObjects:@"",@"姓名",@"手机号",@"部门",@"职位", nil];
    _userInofArr = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",@"",@"",@"",@"", nil];
    _compyInfoArr = [[NSMutableArray alloc] init];
}
#pragma mark----创建tableView
-(UITableView *)personTableView{
    if (_personTableView == nil) {
        _personTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
        _personTableView.delegate = self;
        _personTableView.dataSource = self;
        _personTableView.tableHeaderView = [[UIView alloc] init];
        //_personTableView.tableHeaderView.backgroundColor = [UIColor redColor];
        //不显示分割线
        _personTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_personTableView setShowsVerticalScrollIndicator:NO];
        _personTableView.backgroundColor = BgViewColor;
        
    }
    return  _personTableView;
}

#pragma mark---tableView代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_compyInfoArr.count == 0) {
        return 1;
    }
    else
    {
        return _compyInfoArr.count + 1;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return _userInofLabelArr.count;
    }
    else
    {
        return _compyInfoLabelArr.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 60;
    }
    else
    {
        return 50;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15.0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *cellIndentifier1 = @"cellIndentifier1";
        WL_Personinfo_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier1];
        if (cell == nil) {
            cell = [[WL_Personinfo_TableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier1];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        }
        
        cell.titleName.text = [_userInofLabelArr objectAtIndex:indexPath.row];
        if (_userInofArr.count != 0) {
            cell.rightTitleName.text = [_userInofArr objectAtIndex:indexPath.row];
        }
        
        [cell changeViewPath:indexPath and:_PersonInfoModel.avatar]; //实名认证图标
        
        return cell;
    }
    else
    {
        static NSString *cellIndentifier1 = @"cellIndentifier12";
        WL_Personinfo_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier1];
        if (cell == nil) {
            cell = [[WL_Personinfo_TableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier1];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        }
        cell.titleName.text = [_compyInfoLabelArr objectAtIndex:indexPath.row];
        
        if (_compyInfoArr.count != 0) {

            WL_Mine_personInfo_CompanyInfoModel * model = _compyInfoArr[indexPath.section - 1];
            if (indexPath.row == 0) {
                cell.titleName.text = model.company_name;
            }
            if (indexPath.row == 1) {
                cell.rightTitleName.text = model.staff_name;
            }
            if (indexPath.row == 2) {
                cell.rightTitleName.text = model.mobile;
            }
            if (indexPath.row == 3) {
                cell.rightTitleName.text = model.department_name;
            }
            if (indexPath.row == 4) {
                cell.rightTitleName.text = model.position_name;
            }
            
            [cell changeViewPath:indexPath and:[NSString stringWithFormat:@"%@/%@",model.logo_base_url,model.logonail_path]];
        }
        return cell;
    }
    
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                //设置头像
                UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"更换头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
                [actionSheet showInView:self.view];
            }
                break;
            case 1:
            {
                //昵称
                WL_Mine_PersonInfo_changeInfo_ViewController *VC = [[WL_Mine_PersonInfo_changeInfo_ViewController alloc] init];
                VC.delegate = self;
                VC.title = [_userInofLabelArr objectAtIndex:indexPath.row];
                VC.path = indexPath;
                VC.PersonStr = [_userInofArr objectAtIndex:indexPath.row];
                [self.navigationController pushViewController:VC animated:YES];
                
            }
                break;
            case 2:
            {
                //WL_Mine_personInfo_CompanyInfoModel * model = _compyInfoArr[0];
                //二维码名片
                WL_Mine_PersonInfo_QRcode_ViewController *QRVC = [[WL_Mine_PersonInfo_QRcode_ViewController alloc] init];
                QRVC.userName = _PersonInfoModel.username;
                QRVC.nickName = _PersonInfoModel.nickname;
                QRVC.phoneNO = [WLUserTools getUserMobile];//model.mobile;
                QRVC.headImage = _PersonInfoModel.avatar;
                [self.navigationController pushViewController:QRVC animated:YES];
                
            }
                break;
            case 4:
            {
                //选择性别
                [self.choseSexView showFromSuperView];
                self.choseSexView.isSEX = YES;
                [self.choseSexView setView:[[NSMutableArray alloc] initWithObjects:@"女",@"男",@"未知",nil]];
                __weak typeof(self)WeakSelf = self;
                self.choseSexView.titleBlick = ^(NSString *str){
                    [WeakSelf changeSix:str];
                };
            }
                break;
            case 5:
            {
                //地区
                STPickerArea *pickerArea = [[STPickerArea alloc] initWithArray:self.cityArray];
                [pickerArea setDelegate:self];
                [pickerArea setContentMode:STPickerContentModeBottom];
                [pickerArea show];
                
//                WL_Mine_personInfo_regionViewController *regionVc = [[WL_Mine_personInfo_regionViewController alloc] init];
//                regionVc.didStr = _PersonInfoModel.region_name;
//                //regionVc.proviceId = _PersonInfoModel.province_id;
//                //regionVc.cityId = _PersonInfoModel.city_id;
//                regionVc.personInfo = @"Person";
//                [self.navigationController pushViewController:regionVc animated:YES];
                
            }
                break;
            case 6:
            {
                //邮箱
                WL_Mine_PersonInfo_changeInfo_ViewController *VC = [[WL_Mine_PersonInfo_changeInfo_ViewController alloc] init];
                VC.delegate = self;
                VC.title = [_userInofLabelArr objectAtIndex:indexPath.row];
                VC.path = indexPath;
                VC.PersonStr = [_userInofArr objectAtIndex:indexPath.row];
                [self.navigationController pushViewController:VC animated:YES];
            }
                break;
                
            case 7:
            {
                //签名
                WL_Mine_PersonInfo_changeInfo_ViewController *VC = [[WL_Mine_PersonInfo_changeInfo_ViewController alloc] init];
                VC.delegate = self;
                VC.title = [_userInofLabelArr objectAtIndex:indexPath.row];
                VC.path = indexPath;
                VC.PersonStr = [_userInofArr objectAtIndex:indexPath.row];
                [self.navigationController pushViewController:VC animated:YES];
                
            }
                break;
            default:
                break;
        }
    }
//    else
//    {
//        //选择公司
//        [self.ChoseCompanyAlertView showFromSuperView];
//        self.choseSexView.isSEX = NO;
//        [self.ChoseCompanyAlertView setView:_compyInfoLabelArr];
//        __weak typeof(self)WeakSelf = self;
//        self.ChoseCompanyAlertView.titleBlick = ^(NSString *str){
//            [WeakSelf.ChoseCompanyAlertView hiddenFromSuperView];
//            [WeakSelf.compyInfoLabelArr replaceObjectAtIndex:0 withObject:str];
//            NSInteger index = [WeakSelf.compyInfoLabelArr indexOfObject:str];
//            WL_Mine_personInfo_Company *model = [WeakSelf.compyInfoArr objectAtIndex:index];
//            //公司信息更换
//            [WeakSelf changeImageOfCompany:model];
//            
//            [WeakSelf.personTableView reloadData];
//        };
//    }
    
}
#pragma mark-------选择公司名称的弹出框
-(WL_Mine_personInfo_changeSex_view *)ChoseCompanyAlertView
{
    if (_ChoseCompanyAlertView == nil) {
        _ChoseCompanyAlertView = [WL_Mine_personInfo_changeSex_view new];
        [[UIApplication sharedApplication].keyWindow addSubview:_ChoseCompanyAlertView];
        _ChoseCompanyAlertView.hidden = YES;
    }
    return _ChoseCompanyAlertView;
}
#pragma mark----选择性别
-(WL_Mine_personInfo_changeSex_view *)choseSexView
{
    if (_choseSexView == nil) {
        _choseSexView = [WL_Mine_personInfo_changeSex_view new];
        [[UIApplication sharedApplication].keyWindow addSubview:_choseSexView];
        _choseSexView.hidden = YES;
    }
    return _choseSexView;
}
#pragma mark----修改信息之后的回调
-(void)changeBack_infor:(WL_Mine_PersonInfo_changeInfo_ViewController *)Vc Str:(NSString *)strImage index:(NSIndexPath *)Pathindex
{
//    if (Pathindex.section == 0&&Pathindex.row==1) {
//        _PersonInfoModel.user_name = strImage;
//    }
    [_userInofArr replaceObjectAtIndex:Pathindex.row withObject:strImage];
    [self.personTableView reloadData];
}
#pragma mark----时间选择器
-(void)creatTimerView
{
    CGFloat height,btnHeight,topHeiht;
    if (IsiPhone5||IsiPhone4) {
        height = 200;
        btnHeight = 35;
        topHeiht = 4;
    }
    else
    {
        height = 250;
        btnHeight = 40;
        topHeiht = 5;
    }
    _timerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _timerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [[UIApplication sharedApplication].keyWindow addSubview:_timerView];
    _timerView.hidden = YES;
    //时间选择器视图的点击隐藏
    UITapGestureRecognizer *timeViewHidenTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenTimeVew)];
    [_timerView addGestureRecognizer:timeViewHidenTap];
    //创建日期的轮播
    self.dataPicker = [[UIDatePicker alloc] init];
    
    self.dataPicker.frame = CGRectMake(0, ScreenHeight-height, ScreenWidth, height);
    self.dataPicker.backgroundColor = [UIColor whiteColor];
    self.dataPicker.date = [NSDate date];
    self.dataPicker.datePickerMode = UIDataDetectorTypePhoneNumber;
    [_timerView addSubview:self.dataPicker];
    UIView *btnView = [[UIView alloc] init];
    btnView.frame = CGRectMake(0, ScreenHeight-height-btnHeight, ScreenWidth, btnHeight);
    btnView.backgroundColor = [UIColor whiteColor];
    [_timerView addSubview:btnView];
    //取消按钮
    UIButton *btnTap = [UIButton buttonWithType:UIButtonTypeSystem];
    btnTap.frame = CGRectMake(20, topHeiht, 50, btnHeight-2*topHeiht);
    [btnTap addTarget:self action:@selector(timeFrombtn:) forControlEvents:UIControlEventTouchUpInside];
    btnTap.tag = 501;
    [btnTap setTintColor:[WLTools stringToColor:@"#4977e7"]];
    [btnTap setTitle:@"取消" forState:UIControlStateNormal];
    [btnView addSubview:btnTap];
    //确定按钮
    UIButton *btnTap2 = [UIButton buttonWithType:UIButtonTypeSystem];
    btnTap2.frame = CGRectMake(ScreenWidth-70, topHeiht, 50, btnHeight-2*topHeiht);
    [btnTap2 addTarget:self action:@selector(timeFrombtn:) forControlEvents:UIControlEventTouchUpInside];
    btnTap2.tag = 502;
    [btnTap2 setTintColor:[WLTools stringToColor:@"#4977e7"]];
    [btnTap2 setTitle:@"确定" forState:UIControlStateNormal];
    [btnView addSubview:btnTap2];
}
#pragma mark----出生日期的选择和取消按钮
-(void)timeFrombtn:(UIButton *)btn
{
    if (btn.tag == 501) {
        //取消按钮呗点击
        
    }
    else
    {
        //NSDate *date = self.dataPicker.date;
        //NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置自己需要的格式
        //[dateFormatter setDateFormat:@"yyyy-MM-dd"];
        //转换成字符串
        //NSString *timeStr = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
        
        
        //[self UPdateNewInfo:timeStr indexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
        
        
        
        
    }
    [self showAndHidden:YES];
}
//时间轮播点击空白时候隐藏事件
-(void)hiddenTimeVew
{
    [self showAndHidden:YES];
}
//显示和隐藏的动画
-(void)showAndHidden:(BOOL)isHidden
{
    CATransition *animation = [CATransition animation];
    
    animation.duration = 0.3;
    
    animation.type = kCATransitionFade;
    
    [_timerView.layer addAnimation:animation forKey:nil];
    _timerView.hidden = isHidden;
    
}
#pragma mark----下载数据
-(void)loadDataFromServer
{
    
    [[WLNetworkDriverHandler sharedInstance] requestUserInfoWithDataBlock:^(WLResponseType responseType, id data, NSString *message) {
        //隐藏菊花
        [self hidHud];
        if (responseType == 0) {
            _PersonInfoModel = [[WL_Mine_personInfo_userInfoModel alloc] initWithDict:data];
            _compyInfoArr = [_PersonInfoModel.companyArray copy];
            
            [self reloadNewData];
        }
        else
        {
            [[WL_TipAlert_View sharedAlert] createTip:@"网络请求失败,请稍后重试"];
        }
        
    }];
}
#pragma mark----更新数据源
-(void)reloadNewData
{
//昵称
    NSString *nickName = @"";
    nickName = [WLTools judgeString:_PersonInfoModel.nickname]?_PersonInfoModel.nickname:@"";
    [_userInofArr replaceObjectAtIndex:1 withObject:nickName];
    
    NSString *username = @"";
    username = [WLTools judgeString:_PersonInfoModel.username]?_PersonInfoModel.username:@"";
    [_userInofArr replaceObjectAtIndex:3 withObject:username];
    
//性别
    NSString *sex = @"未知";
    if (_PersonInfoModel.gender == 0) {
        sex = @"女";
    }
    else if (_PersonInfoModel.gender == 1)
    {
        sex = @"男";
    }
    else
    {
        sex = @"未知";
    }
    [_userInofArr replaceObjectAtIndex:4 withObject:sex];
////生日
//    NSString *brithday = @"";
//    brithday = [WLTools judgeString:_PersonInfoModel.birthday]?_PersonInfoModel.birthday:@"";
//    if ([brithday hasSuffix:@"00:00:00"]) {
//        brithday = [brithday stringByReplacingOccurrencesOfString:@"00:00:00" withString:@""];
//    }
//    [_userInofArr replaceObjectAtIndex:4 withObject:brithday];
    
//地区
    [_userInofArr replaceObjectAtIndex:5 withObject:[NSString stringWithFormat:@"%@-%@",_PersonInfoModel.province,_PersonInfoModel.city]];
    
// 邮箱
    [_userInofArr replaceObjectAtIndex:6 withObject:_PersonInfoModel.email];
    
// 签名
    [_userInofArr replaceObjectAtIndex:7 withObject:_PersonInfoModel.note];

//    //实名认证
//    [_personTableView reloadData];
    
//更新头像
    WL_Personinfo_TableViewCell *cell = [_personTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_PersonInfoModel.avatar]] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
    
//公司数组
//    for (WL_Mine_personInfo_CompanyInfoModel * model in _PersonInfoModel.companyArray) {
//        [self changeImageOfCompany:model];
//    }
    
////公司信息填充
//    if (self.compyInfoArr.count>0) {
//        WL_Mine_personInfo_Company *model = [[WL_Mine_personInfo_Company alloc] init];
//        
//        [self changeImageOfCompany:model];
//    }

   [self.personTableView reloadData];
}
#pragma mark-----公司信息
-(void)changeImageOfCompany:(WL_Mine_personInfo_Company *)model
{
    model.showArr = [[NSMutableArray alloc] initWithObjects:@"--",@"--",@"--",@"--",@"--", nil];
    //标题
    [model.showArr replaceObjectAtIndex:0 withObject:model.company_name];
    
    //姓名
    if ([WLUserTools getUserName]) {
       [model.showArr replaceObjectAtIndex:1 withObject:[WLUserTools getUserName]];
    }

    //电话
    if ([WLUserTools getUserMobile]) {
       [model.showArr replaceObjectAtIndex:2 withObject:[WLUserTools getUserMobile]];
    }
    
    //部门
    if (model.department.count != 0) {
        NSDictionary *dict = [model.department objectAtIndex:0];
        NSString *department_name = dict[@"department_name"];
        [model.showArr replaceObjectAtIndex:3 withObject:department_name];
    }
    
    //职位
    if (model.position_name) {
        [model.showArr replaceObjectAtIndex:4 withObject:model.position_name];
    }
}
#pragma mark----选择图片或者照相机
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            //照相
            
            //先判断是否有权限调用摄像头
            NSString *mediaType = AVMediaTypeVideo;
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
            if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在设置-隐私-相机中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                //  DLog(@"相机权限受限");
                return;
                
            }
            
            [self openPhotoToViewController:self sourceType:UIImagePickerControllerSourceTypeCamera];

        }
            break;
        case 1:
        {
            //相册
            [self openPhotoToViewController:self sourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
        }
            break;

        default:
            break;
    }
}
//压缩图片
- (UIImage *)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark UIimagePickerControllerDelegate
-(UIImagePickerController *)openPhotoToViewController:(UIViewController*)viewController sourceType:(UIImagePickerControllerSourceType)sourceType
{
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]&&mediaTypes.count>0) {
        UIImagePickerController *imagePick = [[UIImagePickerController alloc] init];
        imagePick.mediaTypes = [[NSArray alloc] initWithObjects:(NSString*)kUTTypeImage,nil];//mediaTypes;
        imagePick.navigationBarHidden = YES;
        imagePick.allowsEditing = YES;
        imagePick.delegate = self;
        imagePick.sourceType = sourceType;
        [viewController presentViewController:imagePick animated:YES completion:nil];
        return imagePick;
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"设备不支持" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [alert show];
    }
    return nil;
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    //判断是静态图片还是视频
    UIImage *editedImage = nil;
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        
        if ([info objectForKey:UIImagePickerControllerEditedImage]!= nil) {
            
            //获取编辑之后的图片
            editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        }
        else
        {
            //获取原始的图像
            editedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
//        //判断是调用的相机还是图片库，如果是照相机的话，将图像保存到媒体库
//        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
//            //将图片保存到媒体库
//            UIImageWriteToSavedPhotosAlbum(editedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
//            
//        }
        
//        UIImage *image = [self imageWithImageSimple:editedImage scaledToSize:CGSizeMake(ScreenWidth, 500)];
        
       
        
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self upDataHeadImageView:editedImage];
    
    //刷新头像图片
   }
- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
    //    NSString *str=nil;
    //    if (!error)
    //        str=@"picture saved with no error.";
    //    else
    //        str=@"error occured while saving the picture%@";
}

#pragma mark-----上传头像步骤1
-(void)upDataHeadImageView:(UIImage *)headImage
{
    [[WLNetworkDriverHandler sharedInstance] sengheadImgWithData:headImage block:^(BOOL success, NSString *base_url, NSString *path) {
        if (success) {
            [self upDataHeadImageViewAgain:base_url path:path imgage:headImage];
        }
        else
        {
            [[WL_TipAlert_View sharedAlert]createTip:@"头像上传失败"];
        }
    }];
}

#pragma mark-----上传头像步骤2
- (void)upDataHeadImageViewAgain:(NSString *)baseurl path:(NSString *)path imgage:(UIImage *)image
{
    __weak typeof(self)weakSelf = self;
    [[WLNetworkDriverHandler sharedInstance] sengheadImgAgainWithData:baseurl path:path block:^(BOOL success, NSString *message) {
        if (success) {
            NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
            WL_Personinfo_TableViewCell *cell = [weakSelf.personTableView cellForRowAtIndexPath:path];
            cell.headImageView.image = image;
        }
        else
        {
            [[WL_TipAlert_View sharedAlert]createTip:@"头像上传失败"];
        }
    }];
}

#pragma mark----通知改变信息的方法
-(void)changeAddressBack:(NSNotification *)dict
{
    
    if (dict) {
        //_PersonInfoModel.province_id = dict.userInfo[@"proviceID"];
        //_PersonInfoModel.city_id = dict.userInfo[@"cityID"];
        //_PersonInfoModel.area_id =dict.userInfo[@"countryID"];
        //_PersonInfoModel.address = dict.userInfo[@"address"];
        
        //[_userInofArr replaceObjectAtIndex:5 withObject:dict.userInfo[@"address"]];
        
        NSMutableDictionary * params = [NSMutableDictionary dictionary];
        params[@"city_id"] = [NSString stringWithFormat:@"%@",dict.userInfo[@"cityID"]];
        
        [[WLNetworkDriverHandler sharedInstance] requestChangePersonalInfoWith:params iSEmail:NO ResultBlock:^(BOOL success, NSString *message) {
            if (success) {
                [_userInofArr replaceObjectAtIndex:5 withObject:dict.userInfo[@"address"]];
                [_personTableView reloadData];
            }
            else
            {
                [[WL_TipAlert_View sharedAlert] createTip:@"地址保存失败,请稍后重试"];
            }
        }];
    }
}

- (void)changeSix:(NSString *)str
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    if ([str isEqual:@"男"]) {
        params[@"gender"] = [NSString stringWithFormat:@"1"];
    }
    else if ([str isEqual:@"女"]) {
        params[@"gender"] = [NSString stringWithFormat:@"0"];
    }
    else
    {
        params[@"gender"] = [NSString stringWithFormat:@"2"];
    }
    
    
    [[WLNetworkDriverHandler sharedInstance] requestChangePersonalInfoWith:params iSEmail:NO ResultBlock:^(BOOL success, NSString *message) {
        if (success) {
            [_choseSexView hiddenFromSuperView];
            [_userInofArr replaceObjectAtIndex:4 withObject:str];
            [_personTableView reloadData];
        }
        else
        {
            [[WL_TipAlert_View sharedAlert] createTip:@"性别保存失败,请稍后重试"];
        }
    }];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark----创建性别选择器
-(void)creatChoseSexView
{
    CGFloat height,btnHeight,topHeiht;
    if (IsiPhone5||IsiPhone4) {
        height = 200;
        btnHeight = 35;
        topHeiht = 4;
    }
    else
    {
        height = 250;
        btnHeight = 40;
        topHeiht = 5;
    }
    self.arrSex = [[NSMutableArray alloc] initWithObjects:@"女",@"男",@"未知", nil];
    _pickBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _pickBackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [[UIApplication sharedApplication].keyWindow addSubview:_pickBackView];
    _pickBackView.hidden = YES;
    //选择器
    //性别选择器
    _choseSexPickView = [[UIPickerView alloc] init];
    _choseSexPickView.frame = CGRectMake(0, ScreenHeight-height, ScreenWidth, height);
    _choseSexPickView.backgroundColor = [UIColor whiteColor];
    _choseSexPickView.delegate = self;
    _choseSexPickView.dataSource = self;
    _choseSexPickView.userInteractionEnabled = YES;
    [_pickBackView addSubview:_choseSexPickView];
    UITapGestureRecognizer *timeViewHidenTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sexhiddenTimeVew)];
    [_pickBackView addGestureRecognizer:timeViewHidenTap];
    //创建日期的轮播
    
    UIView *btnView = [[UIView alloc] init];
    btnView.frame = CGRectMake(0, ScreenHeight-height-btnHeight, ScreenWidth, btnHeight);
    btnView.backgroundColor = [UIColor whiteColor];
    [_pickBackView addSubview:btnView];
    //取消按钮
    UIButton *btnTap = [UIButton buttonWithType:UIButtonTypeSystem];
    btnTap.frame = CGRectMake(5, topHeiht, 50, btnHeight-2*topHeiht);
    [btnTap addTarget:self action:@selector(sexFrombtn:) forControlEvents:UIControlEventTouchUpInside];
    btnTap.tag = 1001;
    [btnTap setTintColor:[WLTools stringToColor:@"#4977e7"]];
    [btnTap setTitle:@"取消" forState:UIControlStateNormal];
    [btnView addSubview:btnTap];
    //确定按钮
    UIButton *btnTap2 = [UIButton buttonWithType:UIButtonTypeSystem];
    btnTap2.frame = CGRectMake(ScreenWidth-55, topHeiht, 50, btnHeight-2*topHeiht);
    [btnTap2 addTarget:self action:@selector(sexFrombtn:) forControlEvents:UIControlEventTouchUpInside];
    btnTap2.tag = 1002;
    [btnTap2 setTintColor:[WLTools stringToColor:@"#4977e7"]];
    [btnTap2 setTitle:@"确定" forState:UIControlStateNormal];
    [btnView addSubview:btnTap2];

    
}
#pragma mark----出生日期的选择和取消按钮
-(void)sexFrombtn:(UIButton *)btn
{
    if (btn.tag == 1001) {
        //取消按钮呗点击
        WlLog(@"取消按钮呗点击");
    }
    else
    {
        ////[self.rightTitleArrTop replaceObjectAtIndex:3 withObject:self.disSex];
        [self.personTableView reloadData];
    }
    [self sexhiddenTimeVew];
    
}
//时间轮播点击空白时候隐藏事件
-(void)sexhiddenTimeVew
{
    [self sexshowAndHidden:YES];
}
//显示和隐藏的动画
-(void)sexshowAndHidden:(BOOL)isHidden
{
    CATransition *animation = [CATransition animation];
    
    animation.duration = 0.3;
    
    animation.type = kCATransitionFade;
    
    [_pickBackView.layer addAnimation:animation forKey:nil];
    _pickBackView.hidden = isHidden;
    
    
}
#pragma mark-----pickerView代理
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return  self.arrSex.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
           return [self.arrSex objectAtIndex:row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    self.disSex = [self.arrSex objectAtIndex:row];
    
    
}
#pragma mark---是否实名认证
-(void)checkRealName
{
    
    NSString *user_id = [WLUserTools getUserId];
    
    NSString *user_PassWord= [WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:user_PassWord publicKey:RSAKey];
    
    NSDictionary *dict = @{@"user_id":user_id,@"user_password":encryptStr};
    
    WS(weakSelf);
    
    [weakSelf showHud];
    
    [[WLHttpManager shareManager]requestWithURL:CheckRealNameUrl RequestType:RequestTypePost Parameters:dict Success:^(id responseObject) {
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        [weakSelf hidHud];
        WL_Mine_personInfo_Authentication_ViewController *VC =[[WL_Mine_personInfo_Authentication_ViewController alloc]init];
        
        if ([network_Model.result isEqualToString:@"1"])
        {
            VC.isValue =@"1";
            
            
        }else
        {
            
            
            
            //跳转去实名认证
            VC.isValue =@"2";
            
            
                }
        
        [weakSelf.navigationController pushViewController:VC animated:YES];

    } Failure:^(NSError *error) {
        
        [weakSelf hidHud];
        
    }];
    
}
@end
