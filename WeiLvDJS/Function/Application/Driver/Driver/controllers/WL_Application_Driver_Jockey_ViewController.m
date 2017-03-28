//
//  WL_Application_Driver_ Jockey_ViewController.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/18.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  [应用] --> [司机] --> [司机] 控制器

#import "WL_Application_Driver_Jockey_ViewController.h"

#import "WL_Application_Driver_inforMation_TableViewCell1.h"//显示基本信息

#import "WL_Application_Driver_inforMation_TableViewCell2.h"//显示身份证

#import "WL_Application_Driver_inforMation_TableViewCell3.h"//输入框
#import "WL_Application_Driver_ChangeInformation_VC.h"
#import <AVFoundation/AVFoundation.h>//相机
#import <AssetsLibrary/AssetsLibrary.h>//相册·
#import "WL_Application_Driver_Infomation_model.h" //司机信息模型

#import "WL_Mine_personInfo_regionViewController.h"//选择地区

#import "WL_Application_Driver_inforMation_TableViewCell0.h"

#import "WL_warmPrompt_View.h"

#import "NSDictionary+DefaultValue.h"

#import "WLDriverInfoModel.h"

#import "STPickerArea.h" //现在地区
#import "WLNetworkAccountHandler.h"

#import "WLPhotoCheckView.h"

//#import "HcdDateTimePickerView.h"

#import "WLDataHotelHandler.h"

#import "WL_Mine_personInfo_changeSex_view.h" //改变性别view
#import "TLDatePickerAppearance.h"
#define DriverCacheFilePath [NSString stringWithFormat:@"%@/DriverCache.plist",NSHomeDirectory()];

@interface WL_Application_Driver_Jockey_ViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,UIScrollViewDelegate,WL_Application_Driver_ChangeInformation_VCDelegate,UIPickerViewDelegate,UIPickerViewDataSource,STPickerAreaDelegate>
{
    dispatch_group_t group;
}

@property(nonatomic,strong)UITableView *InforMationTableView;
//左侧信息
@property(nonatomic,strong)NSMutableArray *leftTitleAllArr;//左侧信息
@property(nonatomic,strong)NSMutableArray *leftTitleTopArr;//左侧信息
@property(nonatomic,strong)NSMutableArray *leftFirstArr;//左侧第一分区的信息；
@property(nonatomic,strong)NSMutableArray *leftTitleCenterArr;//左侧信息
@property(nonatomic,strong)NSMutableArray *leftTitleBottomArr;//左侧信息
//右侧信息
@property(nonatomic,strong)NSMutableArray *rightTitleAllArr;//右侧信息
@property(nonatomic,strong)NSMutableArray *rightTitleTopArr;//右侧信息
@property(nonatomic,strong)NSMutableArray *rightFirstArr;
@property(nonatomic,strong)NSMutableArray *rightTitleCenterArr;//右侧信息
@property(nonatomic,strong)NSMutableArray *rightTitleBottomArr;//右侧信息

@property(nonatomic,assign)NSInteger indexSection;
@property(nonatomic,assign)NSInteger indexTag;
//选择器
@property(nonatomic,strong)UIView *pickBackView;
@property(nonatomic,strong)UIPickerView *chosePickView;

@property(nonatomic,strong)NSMutableArray *arrSex;//性别
@property(nonatomic,strong)NSMutableArray *arrAge;//性别
@property(nonatomic,strong)NSMutableArray *arrDriverAge;//性别
@property(nonatomic,strong)NSString *choseType;
@property(nonatomic,strong)NSString *didSelectStr;

//数据是否为空
@property(nonatomic,assign)BOOL IsInfomation;

@property(nonatomic,strong)UIImageView *imageView1;//身份证正面
@property(nonatomic,strong)UIImageView *imageView2;//身份证反面
@property(nonatomic,strong)UIImageView *imageView3;//驾照正面
@property(nonatomic,strong)UIImageView *imageView4;//驾照反面

@property(nonatomic,strong)WL_TipAlert_View *AlertTitle;//弹出提示框

@property(nonatomic,assign)CGFloat height;//第一分区的高度；


@property(nonatomic,strong)UIImageView *showPhotoImageView;

@property(nonatomic,strong)UIView *showPhotoView;//查看图片的view

@property(nonatomic,assign)BOOL identityCard;


@property(nonatomic,assign)BOOL image1Set;//第一次提交的时候判断是否给1，2，3，4 设置过图片，来决定sd——image 是否继续加载
@property(nonatomic,assign)BOOL image2Set;
@property(nonatomic,assign)BOOL image3Set;
@property(nonatomic,assign)BOOL image4Set;

@property(nonatomic,strong)WL_warmPrompt_View *warningWindow;

@property(nonatomic,strong)NSMutableDictionary *cacheDictionary;

@property(nonatomic,strong)NSMutableDictionary *photoDictionary;

@property(nonatomic,strong)NSFileManager *fm;

@property(nonatomic,copy)NSString *plistPath;

@property(nonatomic,assign)BOOL canEdit;//判断是否能编辑
@property(nonatomic,assign)BOOL canEditChange;//判断是否能编辑提交
@property (nonatomic, assign) BOOL isNoInfo; // 是否有数据（第一次）
@property (nonatomic, assign) BOOL ischooseSex;
@property (nonatomic, assign) BOOL isarchiveDataSex;

@property (nonatomic, assign) BOOL isClick;
//司机个人信息
@property(nonatomic,strong) WLDriverInfoDataModel * InfoDatamodel;
@property(nonatomic,strong) WLDriverInfoModel *InfoModel;

@property(nonatomic,strong)WL_Mine_personInfo_changeSex_view *choseSexView;//选择性别的弹出框

@property (nonatomic, strong) NSMutableArray *cityArray; //地区数组
@property (nonatomic, strong) WLPhotoCheckView *checkView ;
@property (nonatomic, strong) NSString * thisImgid1;
@property (nonatomic, strong) NSString * thisImgid2;
@property (nonatomic, strong) NSString * thisImgid3;
@property (nonatomic, strong) NSString * thisImgid4;

@property (nonatomic, strong) NSString * audit_memo;

@end

@implementation WL_Application_Driver_Jockey_ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    //监听键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.indexTag = 101;
    self.indexSection = 1;
    //注册观察者---修改地址的回调
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DriverchangeAddressBack:) name:@"DriverChangeAddress" object:nil];
    
    [self creatPersonAlertView];//创建弹出提示框

    
    //设置Nav内容
    [self setupNav];
    //图片中转
    [self creatUiImageViewImage];
    //创建数据源
    [self creatDataSourceArr];
    
    //创建tableView
    [self.view addSubview:self.InforMationTableView];
    //创建分享按钮
    //[self creatSharkBtnView];
    [self creatTimerView];//创建选择器
    [self loadCitys];
    
    [self loadDriverInforFromServer];
    
    self.canEdit = YES;
    self.canEditChange = NO;
    [self setNavigationRightTitle:@"编辑" fontSize:15 titleColor:[WLTools stringToColor:@"#00cc99"] isEnable:YES];
    
    if (_driverStatus == WLDriverStatusUnAutherized) {
        //未认证
        [self setNavigationRightTitle:@"提交" fontSize:15 titleColor:[WLTools stringToColor:@"#00cc99"] isEnable:YES];
        self.canEditChange = YES;
        //[self archiveData];
    }
    
//    else if (_driverStatus == WLDriverStatusReviewing) {
//        //审核中
//    }
//    else if (_driverStatus == WLDriverStatusAutherized) {
//         //已认证
//    }
//    else if (_driverStatus == WLDriverStatusAuthenticationFailed) {
//        //认证失败
//    }
//    else if (_driverStatus == WLDriverStatusForbidden) {
//        //已禁用
//    }
}

- (void)archiveData
{
    NSArray * arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * fileName = [arr.firstObject stringByAppendingPathComponent:@"archiverModel"];
    
    NSData *undata = [[NSData alloc] initWithContentsOfFile:fileName];
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:undata];
    
    WLDriverInfoModel *unModel = [unarchiver decodeObjectForKey:@"InfoModel"];
    
    if (unModel != nil) {
        _InfoModel = unModel;
        _isarchiveDataSex = YES;
        [self reloadNewdataFromServer:_InfoModel];
    }
    
    [unarchiver finishDecoding];
}

- (NSMutableArray *)cityArray
{
    if (!_cityArray) {
        _cityArray = [NSMutableArray array];
    }
    return _cityArray;
}

-(NSMutableDictionary *)photoDictionary
{
    if (_photoDictionary==nil) {
        
        _photoDictionary =[[NSMutableDictionary alloc]init];
    }

    return _photoDictionary;
}
-(NSMutableDictionary *)cacheDictionary
{
    if (_cacheDictionary==nil) {
        
        _cacheDictionary =[[NSMutableDictionary alloc]init];
    }

    return _cacheDictionary;
}

- (WLDriverInfoModel *)InfoDatamodel
{
    if (_InfoModel == nil) {
        _InfoModel = [[WLDriverInfoModel alloc] init];
    }
    return _InfoModel;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)setupNav
{
    self.title = @"司机资料";
    self.view.backgroundColor = BgViewColor;
    
}



#pragma mark----左侧数据源
-(NSMutableArray *)leftTitleTopArr
{
    //最上层
    if (_leftTitleTopArr == nil) {
        _leftTitleTopArr = [[NSMutableArray alloc] initWithObjects:@"姓名",@"年龄",@"性别",@"手机号码",@"现居城市",@"详细地址",@"身份证号",@"身份证", nil];
    }
    return _leftTitleTopArr;
}
-(NSMutableArray *)leftTitleCenterArr
{
    //中间
    if (_leftTitleCenterArr == nil) {
        _leftTitleCenterArr = [[NSMutableArray alloc] initWithObjects:@"驾照号码",@"驾驶证", nil];
    }
    return _leftTitleCenterArr;
}
-(NSMutableArray *)leftFirstArr
{
    if (_leftFirstArr==nil) {
        
        _leftFirstArr = [[NSMutableArray alloc]initWithObjects:@"", nil];
    }

    return _leftFirstArr;
}
-(NSMutableArray *)leftTitleBottomArr
{
    //底层
    if (_leftTitleBottomArr ==nil) {
        _leftTitleBottomArr = [[NSMutableArray alloc] initWithObjects:@"", nil];
    }
    return _leftTitleBottomArr;
}
-(NSMutableArray *)leftTitleAllArr
{
    if (_leftTitleAllArr == nil) {
       
        _leftTitleAllArr = [[NSMutableArray alloc] initWithObjects:self.leftFirstArr,self.leftTitleTopArr,self.leftTitleCenterArr,self.leftTitleBottomArr, nil];
    }
    return _leftTitleAllArr;
}

-(NSMutableArray *)rightFirstArr
{
    if (_rightFirstArr==nil) {
        
        _rightFirstArr =[NSMutableArray arrayWithObjects:@"", nil];
    }
    return _rightFirstArr;
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

#pragma mark----右侧数据源
-(NSMutableArray *)rightTitleTopArr
{
    //最上层
    if (_rightTitleTopArr == nil) {
        _rightTitleTopArr = [[NSMutableArray alloc] initWithObjects:@"未填写",@"未填写",@"未填写",[WLUserTools getUserMobile],@"未填写",@"未填写",@"未填写",@"未填写", nil];
    }
    return _rightTitleTopArr;
}

-(NSMutableArray *)rightTitleCenterArr
{
    //中间
    if (_rightTitleCenterArr == nil) {
        
        _rightTitleCenterArr = [[NSMutableArray alloc] initWithObjects:@"未填写",@"", nil];
    }
    return _rightTitleCenterArr;
}

-(NSMutableArray *)rightTitleBottomArr
{
    //底层
    if (_rightTitleBottomArr ==nil) {
        _rightTitleBottomArr = [[NSMutableArray alloc] initWithObjects:@"", nil];
    }
    return _rightTitleBottomArr;
}
-(NSMutableArray *)rightTitleAllArr
{
    if (_rightTitleAllArr == nil) {
        _rightTitleAllArr = [[NSMutableArray alloc] initWithObjects:self.rightFirstArr,self.rightTitleTopArr,self.rightTitleCenterArr,self.rightTitleBottomArr, nil];
    }
    return _rightTitleAllArr;
}

#pragma mark----创建tableView
-(UITableView *)InforMationTableView{
    if (_InforMationTableView == nil) {
        
        _InforMationTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
        _InforMationTableView.delegate = self;
        _InforMationTableView.dataSource = self;

        [_InforMationTableView setShowsVerticalScrollIndicator:NO];
        _InforMationTableView.backgroundColor = BgViewColor;
        
    }
    return  _InforMationTableView;
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
    _InfoModel.province_id = provinceID;
    _InfoModel.city_id = cityID;
    NSString *text = [NSString stringWithFormat:@"%@-%@-%@", province, city, area];
    [self.rightTitleTopArr replaceObjectAtIndex:4 withObject:text];
    [self.InforMationTableView reloadData];
}

#pragma mark---tableView代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.leftTitleAllArr objectAtIndex:section] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section ==0) {
        
//        if ([self.perinfoModel.status isEqualToString:@"0"]) {
//         
//            return self.height;
//        }
        return 0.01;
        
        
        
    }else if ((indexPath.section == 1&&indexPath.row==7)||(indexPath.section == 2&&indexPath.row==1)) {
        if (IsiPhone4||IsiPhone5) {
            return 105;
        }
        else
        {
            return 120;
        }

    }
    else if(indexPath.section==3)
    {
        if (IsiPhone4||IsiPhone5) {
            return 95;
        }
        else
        {
            return 110;
        }

    }
    else
    {
        if (IsiPhone4||IsiPhone5) {
            return 44;
        }
        else
        {
        return 50;
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        if (_driverStatus == WLDriverStatusAuthenticationFailed) {
            if (_canEditChange) {
                return 0;
            }
            else
            {
                return ScaleH(90) + 40;
            }
            
        }else if(_driverStatus == WLDriverStatusReviewing||_driverStatus == WLDriverStatusAutherized){
            if (_canEditChange) {
                return 0;
            }
            else
            {
                if (IsiPhone4||IsiPhone5) {
                    return ScaleH(130);
                }
                else
                {
                    return ScaleH(110);
                }
            }
        }

        return 0;
    }
    
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        if (_driverStatus == WLDriverStatusAuthenticationFailed) {
            UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(90))];
            headView.backgroundColor = [UIColor whiteColor];
            
            //(ScaleW(10), ScaleH(65), ScaleW(40), ScaleH(40));//WLColor(140, 157, 244, 1).CGColor;
            UILabel * reultLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, ScaleW(100), ScaleH(15))];
            reultLabel.text = @"审核失败原因:";
            reultLabel.font = WLFontSize(12);
            reultLabel.textColor = [UIColor lightGrayColor];
            [headView addSubview:reultLabel];
            
            UILabel * resultContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(reultLabel.frame.origin.x, reultLabel.frame.origin.y + reultLabel.frame.size.height, headView.frame.size.width - 20, ScaleH(50))];
            resultContentLabel.textColor = [WLTools stringToColor:@"#6f7378"];
            resultContentLabel.text = [NSString stringWithFormat:@"%@",(_audit_memo == NULL)?@"":_audit_memo];
            reultLabel.font = WLFontSize(14);
            resultContentLabel.numberOfLines = 2;
            [headView addSubview:resultContentLabel];
            
            return headView;
        }else if(_driverStatus == WLDriverStatusReviewing) {
            
            UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(110))];
            headView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
            UIImageView *tipImageView = [[UIImageView alloc]init];
            UILabel *statusLabel = [[UILabel alloc]init];
            UILabel *lineLabel = [[UILabel alloc]init];
            
            statusLabel.font = [UIFont WLFontOfSize:14];
            statusLabel.textColor = Color2;
            lineLabel.backgroundColor = Color4;
            
            [headView addSubview:tipImageView];
            [headView addSubview:statusLabel];
            [headView addSubview:lineLabel];
            
            [tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(headView).offset(ScaleH(15));
                make.centerX.equalTo(headView);
            }];
            [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(tipImageView.mas_bottom).offset(ScaleH(10));
                make.centerX.equalTo(headView);
            }];
            [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.equalTo(headView);
                make.height.offset(0.8);
            }];
           tipImageView.image = [UIImage imageNamed:@"shenhezhongNew"];
           statusLabel.text = @"审核中!";
            return headView;
        }else if(_driverStatus == WLDriverStatusAutherized) {
            
            UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(110))];
             headView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
            UIImageView *tipImageView = [[UIImageView alloc]init];
            UILabel *statusLabel = [[UILabel alloc]init];
            UILabel *lineLabel = [[UILabel alloc]init];
            
            statusLabel.font = [UIFont WLFontOfSize:14];
            statusLabel.textColor = Color2;
            lineLabel.backgroundColor = Color4;
            
            [headView addSubview:tipImageView];
            [headView addSubview:statusLabel];
            [headView addSubview:lineLabel];
            
            [tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(headView).offset(ScaleH(15));
                make.centerX.equalTo(headView);
            }];
            [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(tipImageView.mas_bottom).offset(ScaleH(10));
                make.centerX.equalTo(headView);
            }];
            [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.equalTo(headView);
                make.height.offset(0.8);
            }];
            tipImageView.image = [UIImage imageNamed:@"renzhengchenggong"];
            statusLabel.text = @"已认证成功!";
            return headView;
        }
        return nil;
    }
    else
    {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [WLTools stringToColor:@"#f2f2f2"];
        view.frame = CGRectMake(0, 0, ScreenWidth, 40);
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(15, 10, ScreenWidth-10, 20);
        label.textAlignment = NSTextAlignmentLeft;
        label.font = WLFontSize(14);
        label.textColor = [WLTools stringToColor:@"#929292"];
        [view addSubview:label];
        
        if (section == 1) {
            label.text = @"个人资料信息";
        }
        else if (section == 2)
        {
            label.text = @"驾驶信息";
        }
        else if (section == 3)
        {
            label.text = @"备注信息";
        }
        return view;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
       
//        if ([self.perinfoModel.status isEqualToString:@"0"]) {
//           
//            static NSString *cellIndentifier0 = @"cellIndentifier0";
//            WL_Application_Driver_inforMation_TableViewCell0 *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier0];
//        if (cell == nil) {
//        cell = [[WL_Application_Driver_inforMation_TableViewCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier0];
//            }
//        cell.noPassLabel.text = @"未通过原因";
//        
//        cell.noPassReasonLabel.text = self.perinfoModel.reason;
//    
//        return cell;
//            
//        }
        WL_Application_Driver_inforMation_TableViewCell0 *cell0 = [[WL_Application_Driver_inforMation_TableViewCell0 alloc]init];
        
        return cell0;
        
    }else if ((indexPath.section==1&&indexPath.row<7)||(indexPath.section==2&&indexPath.row == 0)) {
        
        static NSString *cellIndentifier1 = @"cellIndentifier1";
        WL_Application_Driver_inforMation_TableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier1];
        if (cell == nil) {
            cell = [[WL_Application_Driver_inforMation_TableViewCell1 alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier1];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        }
        //标题信息
        cell.titleName.text = [NSString stringWithFormat:@"%@",[[self.leftTitleAllArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
        //详细信息
        cell.rightTitleName.text = [NSString stringWithFormat:@"%@",[[self.rightTitleAllArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
        
        if (self.canEditChange == YES) {
            cell.nextImageView.hidden = NO;
        }
        else
        {
            cell.nextImageView.hidden = YES;
        }
        
        return cell;

    }
    else if ((indexPath.section==1&&indexPath.row==7)||(indexPath.section==2&&indexPath.row==1))
    {
        static NSString *cellIndentifier2 = @"cellIndentifier2";
       WL_Application_Driver_inforMation_TableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier2];
        if (cell == nil) {
            cell = [[WL_Application_Driver_inforMation_TableViewCell2 alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier2];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        }
        
        WS(weakSelf);
         __weak typeof(cell)weakCell = cell;
        
        cell.textLabel.text = [[self.leftTitleAllArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        cell.textLabel.textColor = [WLTools stringToColor:@"#6f7378"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        if (indexPath.section == 1) {
             //身份证
            
            [cell setTextStr:indexPath];

            NSString *strUrl1 = [[NSString alloc] init];
            NSString *strUrl2 = [[NSString alloc] init];
                
                for (WLDriverInfoImgModel * model in _InfoDatamodel.ImgArray) {
                    NSLog(@"%f==%@",model.file_type,[NSString stringWithFormat:@"%@%@",model.base_url,model.path]);
                    if (model.file_type == 1) {
                        _image1Set = YES;
                        _thisImgid1 = model.this_Id;
                        strUrl1 = [NSString stringWithFormat:@"%@%@",model.base_url,model.path];
                        [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",model.base_url,model.path]] placeholderImage:[UIImage imageNamed:@"WLPersonInfoIDCardBack"]];
                    }
                    else if (model.file_type == 2)
                    {
                        _image2Set = YES;
                        _thisImgid2 = model.this_Id;
                        strUrl2 = [NSString stringWithFormat:@"%@%@",model.base_url,model.path];
                        [cell.imageView2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",model.base_url,model.path]] placeholderImage:[UIImage imageNamed:@"WLPersonInfoIDCardFont"]];
                    }
                }
            
            
            
            cell.imageViewBack = ^(NSInteger tag){
        
                
                if (self.canEditChange == NO) {
                    // 弹框提示
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle:@"提示"
                                          message:@"资料处于不可编辑状态，如需编辑修改，请点击右上角的编辑"
                                          delegate:self
                                          cancelButtonTitle:@"知道了"
                                          otherButtonTitles:nil, nil];
                    [alert show];
                    return ;
                }

                
                weakSelf.identityCard =YES;
                
                NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:3];
                WL_Application_Driver_inforMation_TableViewCell3 *cell = [weakSelf.InforMationTableView cellForRowAtIndexPath:path];
                [cell.inputTextView resignFirstResponder];

                weakSelf.indexTag = tag;
                weakSelf.indexSection = indexPath.section;
               
               
                if (self.IsInfomation) {
                   
                    if (self.indexTag==101) {
                        
                        weakSelf.showPhotoImageView.hidden =NO;
                        
                        weakSelf.showPhotoImageView.image= weakCell.imageView1.image;
                        
                        [self showPhotoViewHidden:NO];
                        
                    }else
                    {
                        
                        weakSelf.showPhotoImageView.hidden =NO;
                        
                        weakSelf.showPhotoImageView.image = weakCell.imageView2.image;
                        
                        [self showPhotoViewHidden:NO];
                    }
  
                }else
                {
//                    if (_image1Set) {
//                        if (self.indexTag==101) {
//                            [self showImg:weakCell.imageView1.image urlstr:strUrl1];
//                        }
//                        else
//                        {
//                            [self showImg:weakCell.imageView2.image urlstr:strUrl2];
//                        }
//                        
//                    }
//                    else if (_image2Set)
//                    {
//                        if (self.indexTag==101) {
//                            [self showImg:weakCell.imageView1.image urlstr:strUrl1];
//                        }
//                        else
//                        {
//                            [self showImg:weakCell.imageView2.image urlstr:strUrl2];
//                        }
//                    }
//                    else
//                    {
                        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"更换图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
                        actionSheet.tag = 601;
                        [actionSheet showInView:self.view];
//                    }
                }
                
            };
        }
        else if(indexPath.section==2)
        {
            NSString *strUrl3 = [[NSString alloc] init];
            NSString *strUrl4 = [[NSString alloc] init];
            
            [cell setTextStr:indexPath];
            
            for (WLDriverInfoImgModel * model in _InfoDatamodel.ImgArray) {
                if (model.file_type == 3) {
                    _image3Set = YES;
                    _thisImgid3 = model.this_Id;
                    strUrl3 = [NSString stringWithFormat:@"%@%@",model.base_url,model.path];
                    [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",model.base_url,model.path]] placeholderImage:[UIImage imageNamed:@"WLPersonInfoIDCardBack"]];
                }
                else if (model.file_type == 4)
                {
                    _image4Set = YES;
                    _thisImgid4 = model.this_Id;
                    strUrl4 = [NSString stringWithFormat:@"%@%@",model.base_url,model.path];
                    [cell.imageView2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",model.base_url,model.path]] placeholderImage:[UIImage imageNamed:@"WLPersonInfoIDCardFont"]];
                }
            }
            
            cell.imageViewBack = ^(NSInteger tag){

                
                if (self.canEditChange == NO) {
                    // 弹框提示
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle:@"提示"
                                          message:@"资料处于不可编辑状态，如需编辑修改，请点击右上角的编辑"
                                          delegate:self
                                          cancelButtonTitle:@"知道了"
                                          otherButtonTitles:nil, nil];
                    [alert show];
                    return ;
                }
                
                
                weakSelf.identityCard =NO;
                
                NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:3];
                WL_Application_Driver_inforMation_TableViewCell3 *cell = [weakSelf.InforMationTableView cellForRowAtIndexPath:path];
                [cell.inputTextView resignFirstResponder];
                
                //标记行
                weakSelf.indexTag = tag;
                weakSelf.indexSection = indexPath.section;
                
               
                if (self.IsInfomation) {
                    if (self.indexTag==101) {
                        
                        weakSelf.showPhotoImageView.hidden =NO;
                        
                        weakSelf.showPhotoImageView.image= weakCell.imageView1.image;
                        
                        [self showPhotoViewHidden:NO];
                        
                    }else
                    {
                        
                        weakSelf.showPhotoImageView.hidden =NO;
                        
                        weakSelf.showPhotoImageView.image = weakCell.imageView2.image;
                        
                        [self showPhotoViewHidden:NO];
                    }
  
                }else
                {
//                    if (_image3Set) {
//                        if (self.indexTag==101) {
//                            [self showImg:weakCell.imageView1.image urlstr:strUrl3];
//                        }
//                        else
//                        {
//                            [self showImg:weakCell.imageView2.image urlstr:strUrl4];
//                        }
//                        
//                    }
//                    else if (_image4Set)
//                    {
//                        if (self.indexTag==101) {
//                            [self showImg:weakCell.imageView1.image urlstr:strUrl3];
//                        }
//                        else
//                        {
//                            [self showImg:weakCell.imageView2.image urlstr:strUrl4];
//                        }
//                    }
//                    else
//                    {
                        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"更换图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
                        actionSheet.tag = 602;
                        [actionSheet showInView:self.view];
//                    }
                
                }
    
            };
    
        }
        return cell;

    }
    else
    {
    static NSString *cellIndentifier3 = @"cellIndentifier3";
    WL_Application_Driver_inforMation_TableViewCell3 *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier3];
    if (cell == nil) {
        cell = [[WL_Application_Driver_inforMation_TableViewCell3 alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier3];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    }
        cell.inputTextView.delegate = self;
        cell.inputTextView.placeholder = @"请输入备注信息";
        cell.inputTextView.returnKeyType = UIReturnKeyDone;
        cell.inputTextView.text = [self.rightTitleBottomArr objectAtIndex:0];

    return cell;
    }
    return nil;
}

#pragma mark----点击方法

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 不要弹框
    if (self.canEditChange == NO) {
//        // 弹框提示
//        UIAlertView *alert = [[UIAlertView alloc]
//                              initWithTitle:@"提示"
//                              message:@"资料处于不可编辑状态，如需编辑修改，请点击右上角的编辑"
//                              delegate:self
//                              cancelButtonTitle:@"知道了"
//                              otherButtonTitles:nil, nil];
//        [alert show];
        return ;
    }
    _isClick = YES;
    
//    __block WL_Application_Driver_Jockey_ViewController *weakSelf = self;
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:3];
    WL_Application_Driver_inforMation_TableViewCell3 *cell = [_InforMationTableView cellForRowAtIndexPath:path];
    [cell.inputTextView resignFirstResponder];
    switch (indexPath.section) {
        case 1:
        {
            //第一列
            switch (indexPath.row) {
                case 0:
                {
                    //姓名
                    WL_Application_Driver_ChangeInformation_VC *vc = [[WL_Application_Driver_ChangeInformation_VC alloc] init];
                    vc.indexPath = indexPath;
                    vc.sendStr = @"请输入您的姓名";
                    vc.delegate = self;
                    vc.title = [_leftTitleTopArr objectAtIndex:indexPath.row];
                    vc.infoStr = [_rightTitleTopArr objectAtIndex:indexPath.row];
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
                    break;
                case 1:
                {
                    
                    WS(weakSelf);
                    TLDatePicker *picker = [[TLDatePicker alloc]initWithDatePickerMode:DatePickerYearMonthMode MinDate:[NSDate dateWithTimeIntervalSince1970:-473414400] MaxDate:[NSDate date]];
                    TLDatePickerAppearance *datePicker = [[TLDatePickerAppearance alloc]initWithDatePicker:picker DatePickerMode:DatePickerDateMode completeBlock:^(NSDate *date) {
                        NSTimeInterval HSLtimeStamp= [date timeIntervalSince1970];
                        //-----------
                        weakSelf.InfoModel.birthday = [NSString stringWithFormat:@"%ld",(long)HSLtimeStamp];
                        NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
                        formatter1.dateFormat = @"yyyy";
                        NSString *str1 = [formatter1 stringFromDate:[NSDate date]];
                        NSInteger changeage = [str1 integerValue] - [[WLDataHotelHandler TimeIntervalChangeWithYYString:[NSString stringWithFormat:@"%ld",(long)HSLtimeStamp]] integerValue];
                        [weakSelf.rightTitleTopArr replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%ld",(long)changeage]]; // 生日时间戳，要转换
                        
                        [weakSelf.InforMationTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                    }];
                    [datePicker show];

                }
                    break;

                case 2:
                {
                    //选择性别
                    [self.choseSexView showFromSuperView];
                    self.choseSexView.isSEX = YES;
                    [self.choseSexView setView:[[NSMutableArray alloc] initWithObjects:@"女",@"男",nil]];
                    __weak typeof(self)WeakSelf = self;
                    self.choseSexView.titleBlick = ^(NSString *str){
                        _ischooseSex = YES;
                        [WeakSelf changeSix:str];
                    };
                    //性别
//                    _ischooseSex = YES;
//                     self.didSelectStr = [_rightTitleTopArr objectAtIndex:2];
//                     self.choseType = @"sex";
//                    [self.chosePickView reloadAllComponents];
//                    NSInteger index = [self.arrSex indexOfObject:self.didSelectStr];
//                    if (index<=0||index>3) {
//                        index = 0;
//                        [self.chosePickView selectRow:index inComponent:0 animated:YES];
//                    }
//                    else
//                    {
//                        [self.chosePickView selectRow:index inComponent:0 animated:YES];
//                    }
//
//                     self.didSelectStr = [self.arrSex objectAtIndex:index];
//                     [self showAndHidden:NO];
                }
                    break;

                case 3:
                {
                    //联系电话
                    WL_Application_Driver_ChangeInformation_VC *vc = [[WL_Application_Driver_ChangeInformation_VC alloc] init];
                    vc.indexPath = indexPath;
                    vc.sendStr = @"请输入您的联系电话";
                    vc.delegate = self;
                    vc.title = [_leftTitleTopArr objectAtIndex:indexPath.row];
                    vc.infoStr = [_rightTitleTopArr objectAtIndex:indexPath.row];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;

                case 4:
                {
                    if (self.cityArray.count != 0) {
                        STPickerArea *pickerArea = [[STPickerArea alloc] initWithArray:self.cityArray];
                        [pickerArea setDelegate:self];
                        [pickerArea setContentMode:STPickerContentModeBottom];
                        [pickerArea show];
                    }
                    else
                    {
                        [[WL_TipAlert_View sharedAlert] createTip:@"没获取到后台的城市数据"];
                    }
                }
                    break;

                case 5:
                {
                    //详细地址
                    WL_Application_Driver_ChangeInformation_VC *vc = [[WL_Application_Driver_ChangeInformation_VC alloc] init];
                    vc.indexPath = indexPath;
                    vc.sendStr = @"请输入您的详细地址";
                    vc.delegate = self;
                    vc.title = [_leftTitleTopArr objectAtIndex:indexPath.row];
                    vc.infoStr = [_rightTitleTopArr objectAtIndex:indexPath.row];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;

                case 6:
                {
                    //身份证号
                    WL_Application_Driver_ChangeInformation_VC *vc = [[WL_Application_Driver_ChangeInformation_VC alloc] init];
                    vc.indexPath = indexPath;
                    vc.sendStr = @"请输入您的身份证号码";
                    vc.delegate = self;
                    vc.title = [_leftTitleTopArr objectAtIndex:indexPath.row];
                    vc.infoStr = [_rightTitleTopArr objectAtIndex:indexPath.row];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;

                default:
                    break;
            }
        }
            break;
        case 2:
        {
            //第二列
            switch (indexPath.row) {
                case 0:
                {
                    //驾照号码
                    WL_Application_Driver_ChangeInformation_VC *vc = [[WL_Application_Driver_ChangeInformation_VC alloc] init];
                    vc.indexPath = indexPath;
                    vc.sendStr = @"请输入您的驾照号码";
                    vc.delegate = self;
                    vc.title = [_leftTitleCenterArr objectAtIndex:indexPath.row];
                    vc.infoStr = [_rightTitleCenterArr objectAtIndex:indexPath.row];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 1:
                {
//                    //驾龄
//                     self.didSelectStr = [_rightTitleCenterArr objectAtIndex:1];
//                      self.choseType = @"driver";
//                    [self.chosePickView reloadAllComponents];
//                     NSInteger index = [self.arrDriverAge indexOfObject:self.didSelectStr];
//                    if (index<0||index>40) {
//                        index = 0;
//                        [self.chosePickView selectRow:index inComponent:0 animated:YES];
//                    }
//                    else
//                    {
//                        [self.chosePickView selectRow:index inComponent:0 animated:YES];
//                    }
//                    self.didSelectStr = [self.arrDriverAge objectAtIndex:index];
//                     [self showAndHidden:NO];
                }
                    break;

                default:
                    break;
            }
        }
            break;
        default:
            break;
    }

}

- (void)changeSix:(NSString *)str
{
    if ([str isEqual:@"男"]) {
        _InfoModel.gender = 1;
        [_rightTitleTopArr replaceObjectAtIndex:2 withObject:@"男"];
    }
    else if ([str isEqual:@"女"]) {
        _InfoModel.gender = 0;
        [_rightTitleTopArr replaceObjectAtIndex:2 withObject:@"女"];
    }
    else
    {
        _InfoModel.gender = 2;
        [_rightTitleTopArr replaceObjectAtIndex:2 withObject:@"未知"];
    }
    [_choseSexView hiddenFromSuperView];
    [self.InforMationTableView reloadData];
}

-(void)showPhotoViewHidden:(BOOL)isHidden
{
    CATransition *animation = [CATransition animation];
    
    animation.duration = 0.3;
    
    animation.type = kCATransitionFade;
    if (IsiPhone5||IsiPhone4)
    {
        _showPhotoImageView.frame = CGRectMake(0, 100, ScreenWidth, 300);
    }
    else
    {
        _showPhotoImageView.frame = CGRectMake(0, 200, ScreenWidth, 300);
    }
    
    [self.showPhotoView.layer addAnimation:animation forKey:nil];
    
    self.showPhotoView.hidden = isHidden;
    
}


#pragma mark---查看图片的图片显示载体
-(UIImageView *)showPhotoImageView
{
    if (_showPhotoImageView == nil) {
        
        _showPhotoImageView = [[UIImageView alloc] init];
        
        if (IsiPhone5||IsiPhone4) {
            
            _showPhotoImageView.frame = CGRectMake(0, 100, ScreenWidth, 300);
        }
        else
        {
            _showPhotoImageView.frame = CGRectMake(0, 200, ScreenWidth, 300);
        }
        
        _showPhotoImageView.backgroundColor = [UIColor whiteColor];
        
        [_showPhotoImageView setUserInteractionEnabled:YES];
        
        [_showPhotoImageView setMultipleTouchEnabled:YES];
    }
    return _showPhotoImageView;
}

#pragma mark-----查看图片
-(UIView *)showPhotoView
{
    if (_showPhotoView == nil) {
        _showPhotoView = [[UIView alloc] init];
        _showPhotoView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        _showPhotoView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        _showPhotoView.userInteractionEnabled = YES;
        [[UIApplication sharedApplication].keyWindow addSubview:_showPhotoView];
        _showPhotoView.hidden = YES;
        [_showPhotoView addSubview:self.showPhotoImageView];
        //添加点击隐藏的事件
        UITapGestureRecognizer *showPhotoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPhototFromSupperView)];
        [_showPhotoView addGestureRecognizer:showPhotoTap];
          //确定按钮
        UIButton *btnTap2 = [UIButton buttonWithType:UIButtonTypeSystem];
        btnTap2.frame = CGRectMake(ScreenWidth-60,ScreenHeight -50, 50, 30);
        [btnTap2 addTarget:self action:@selector(photoShowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btnTap2.tag = 302;
        [btnTap2 setTintColor:[UIColor whiteColor]];
        [btnTap2 setTitle:@"更改" forState:UIControlStateNormal];
        [_showPhotoView addSubview:btnTap2];
        
    }
    return _showPhotoView;
}

#pragma mark --- 删除 或者更改图片
-(void)photoShowBtnClick:(UIButton *)btn
{
    if (!_canEditChange) {
        // 弹框提示
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"资料处于不可编辑状态，如需编辑修改，请点击右上角的编辑"
                              delegate:self
                              cancelButtonTitle:@"知道了"
                              otherButtonTitles:nil, nil];
        [alert show];
        return ;
    }
   if(btn.tag == 302)
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"更换图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
        actionSheet.tag = 601;
        [actionSheet showInView:self.showPhotoView];
    }
}
-(void)showPhototFromSupperView
{
    [self showPhotoViewHidden:YES];
    
}
#pragma mark----创建分享按钮
-(void)creatSharkBtnView
{
    UIView *bottomView = [[UIView alloc] init];
    bottomView.frame = CGRectMake(0, ScreenHeight-60-64, ScreenWidth, 60);
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    //分享按钮
    UIButton *btnShark = [UIButton buttonWithType:UIButtonTypeSystem];
    btnShark.frame = CGRectMake(ScreenWidth*0.2, 10, ScreenWidth*0.6, 40);
    btnShark.backgroundColor = [WLTools stringToColor:@"#4977e7"];
    btnShark.layer.cornerRadius = 5;
    btnShark.layer.masksToBounds = YES;
    [btnShark addTarget:self action:@selector(sharkBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnShark setTintColor:[UIColor whiteColor]];
    [btnShark setTitle:@"分享至好友" forState:UIControlStateNormal];
    [bottomView addSubview:btnShark];
    
}
-(void)sharkBtnClick:(UIButton *)btn
{
    WlLog(@"分享按钮被点击");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark----选择图片或者照相机
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
  
    [self showPhotoViewHidden:YES];
    
    switch (buttonIndex) {
        case 0:
        {
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
            [self openPhotoToViewController:self sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
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
        //判断是调用的相机还是图片库，如果是照相机的话，将图像保存到媒体库
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            //将图片保存到媒体库
            UIImageWriteToSavedPhotosAlbum(editedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
            
        }
        //        UIImage *image = [self imageWithImageSimple:editedImage scaledToSize:CGSizeMake(ScreenWidth, 500)];

    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    //更新图片
    [self updataImageView:editedImage];
    
    
}
- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
    
}
#pragma mark----更新图片
-(void)updataImageView:(UIImage *)imageData
{
    NSIndexPath *path = nil;
    if (self.indexSection==1) {
        path = [NSIndexPath indexPathForRow:7 inSection:1];
    }
    else
    {
       path = [NSIndexPath indexPathForRow:1 inSection:2];
    }
    WL_Application_Driver_inforMation_TableViewCell2 *cell = [_InforMationTableView cellForRowAtIndexPath:path];
    if (self.indexTag == 101) {
        //cell.imageView1.image = imageData;
        if (self.indexSection == 1) {
            
            if (self.IsInfomation)
            {
               
                [self updataPhotoImageWith:@"img1"and:imageData];
                
            }else
            {
                self.imageView1.image = imageData;
                
                NSData *data = UIImageJPEGRepresentation(imageData, 0.5);
                
                NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                
                [self.photoDictionary setObject:encodedImageStr forKey:@"img1"];
                
                [self.cacheDictionary setObject:self.photoDictionary forKey:@"photo"];
                
                self.image1Set = YES;
                
                cell.imageView1.image =imageData;
            }
 
        }
        else
        {
            
        if (self.IsInfomation) {
                
        [self updataPhotoImageWith:@"img3"and:imageData];
                
        }else
        {
            self.imageView3.image = imageData;
            
            NSData *data = UIImageJPEGRepresentation(imageData, 0.5);
            
            NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            
            [self.photoDictionary setObject:encodedImageStr forKey:@"img3"];
            
            [self.cacheDictionary setObject:self.photoDictionary forKey:@"photo"];
            
            cell.imageView1.image =imageData;
            
            self.image3Set =YES;
        }
 
        }
    }
    else
    {
        //cell.imageView2.image = imageData;
        
        if (self.indexSection == 1) {
            
        if (self.IsInfomation)
        {

            [self updataPhotoImageWith:@"img2"and:imageData];
                
        }else
        {
            self.imageView2.image = imageData;
            
            NSData *data = UIImageJPEGRepresentation(imageData, 0.5);
            
        NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            
            [self.photoDictionary setObject:encodedImageStr forKey:@"img2"];
            
            [self.cacheDictionary setObject:self.photoDictionary forKey:@"photo"];
            
            cell.imageView2.image =imageData;
            
            self.image2Set =YES;
        }
            
            
        }
        else
        {
            if (self.IsInfomation) {
               
                [self updataPhotoImageWith:@"img4"and:imageData];
                
            }else
            {
                self.imageView4.image = imageData;
                
                NSData *data = UIImageJPEGRepresentation(imageData, 0.5);
                
                NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                
                [self.photoDictionary setObject:encodedImageStr  forKey:@"img4"];
                
                [self.cacheDictionary setObject:self.photoDictionary forKey:@"photo"];
                
                cell.imageView2.image =imageData;
                
                self.image4Set=YES;
            }
     
        }

    }
}
#pragma mark----输入代理

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (self.canEditChange == NO) {
        
        return NO;
    }
    
    return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:3];
        WL_Application_Driver_inforMation_TableViewCell3 *cell = [_InforMationTableView cellForRowAtIndexPath:path];
        [cell.inputTextView resignFirstResponder];
        return NO;
    }
    else
    {
        return YES;
    }
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:3];
    WL_Application_Driver_inforMation_TableViewCell3 *cell = [_InforMationTableView cellForRowAtIndexPath:path];
    [cell.inputTextView resignFirstResponder];
    return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:3];
    WL_Application_Driver_inforMation_TableViewCell3 *cell = [_InforMationTableView cellForRowAtIndexPath:path];
    [cell.inputTextView resignFirstResponder];
    
}
#pragma mark-----键盘通知
-(void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 取出键盘最终的frame
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 取出键盘弹出需要花费的时间
    double duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 修改transform
    __weak typeof(self)WeakSelf = self;
    
    [UIView animateWithDuration:duration animations:^{
        CGFloat ty = [UIScreen mainScreen].bounds.size.height - rect.origin.y;
        WeakSelf.view.transform = CGAffineTransformMakeTranslation(0, - ty);
       
        if (ty==0) {
            NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:3];
            WL_Application_Driver_inforMation_TableViewCell3 *cell = [WeakSelf.InforMationTableView cellForRowAtIndexPath:path];
            
            _InfoModel.memo = cell.inputTextView.text;
            [WeakSelf.rightTitleBottomArr replaceObjectAtIndex:0 withObject:cell.inputTextView.text];
        }
    }];
    
}

#pragma mark----如果是编辑状态，则单独提交图片接口

-(void)updataPhotoImageWith:(NSString *)imageString and:(UIImage *)image
{
    NSString * typeStr = [[NSString alloc] init];
    NSString * chooseImgid = [[NSString alloc] init];
    if ([imageString isEqual:@"img1"]) {
        typeStr = @"identity1";
        chooseImgid = _thisImgid1;
    }
    if ([imageString isEqual:@"img2"]) {
        typeStr = @"identity2";
        chooseImgid = _thisImgid2;
    }
    if ([imageString isEqual:@"img3"]) {
        typeStr = @"driverimg1";
        chooseImgid = _thisImgid3;
    }
    if ([imageString isEqual:@"img4"]) {
        typeStr = @"driverimg2";
        chooseImgid = _thisImgid4;
    }
    
    //显示菊花
    [self showHud];
    [[WLNetworkDriverHandler sharedInstance] requesteditImgDriverInfoWith:_InfoModel.this_id fileid:chooseImgid type:typeStr changeImg:image ResultBlock:^(BOOL success, NSString *message) {
        //隐藏菊花
        [self hidHud];
        if (success) {
            [self loadDriverInforFromServer];

        }
        else
        {
            [self.AlertTitle createTip:message];
        }
    }];
    
    if (_isClick) {
        [self isSendInfo];
    }

}
#pragma mark----滑动的代理

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:3];
    WL_Application_Driver_inforMation_TableViewCell3 *cell = [_InforMationTableView cellForRowAtIndexPath:path];
    [cell.inputTextView resignFirstResponder];
}
-(void)NavigationLeftEvent
{
    if (!_IsInfomation) {
        
        [self isNill];
        
        NSMutableData * data = [[NSMutableData alloc] init];
        NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [archiver encodeObject:_InfoModel forKey:@"InfoModel"];
        [archiver finishEncoding];
        
        NSArray * arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString * fileName = [arr.firstObject stringByAppendingPathComponent:@"archiverModel"];
        if (_InfoModel != nil) {
            if ([data writeToFile:fileName atomically:YES]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)isNill
{
    _InfoModel.this_id = (_InfoModel.this_id == nil)?@"":_InfoModel.this_id;
    _InfoModel.user_id = (_InfoModel.user_id == nil)?@"":_InfoModel.user_id;
    _InfoModel.company_id = (_InfoModel.company_id == nil)?@"":_InfoModel.company_id;
    _InfoModel.name = (_InfoModel.name == nil)?@"":_InfoModel.name;
    _InfoModel.birthday = (_InfoModel.birthday == nil)?@"":_InfoModel.birthday;
    //_InfoModel.gender = [_InfoModel.gender = nil]?@"":_InfoModel.gender
    _InfoModel.mobile = (_InfoModel.mobile == nil)?[WLUserTools getUserMobile]:_InfoModel.mobile;
    _InfoModel.province_id = (_InfoModel.province_id == nil)?@"":_InfoModel.province_id;
    _InfoModel.city_id = (_InfoModel.city_id == nil)?@"":_InfoModel.city_id;
    _InfoModel.address = (_InfoModel.address == nil)?@"":_InfoModel.address;
    _InfoModel.id_card = (_InfoModel.id_card == nil)?@"":_InfoModel.id_card;
    _InfoModel.driving_license = (_InfoModel.driving_license == nil)?@"":_InfoModel.driving_license;
    _InfoModel.body_name = (_InfoModel.body_name == nil)?@"":_InfoModel.body_name;
    _InfoModel.memo = (_InfoModel.memo == nil)?@"":_InfoModel.memo;
    _InfoModel.auditor_id = (_InfoModel.auditor_id == nil)?@"":_InfoModel.auditor_id;
    _InfoModel.audit_status = (_InfoModel.audit_status == nil)?@"":_InfoModel.audit_status;
    _InfoModel.audit_at = (_InfoModel.audit_at == nil)?@"":_InfoModel.audit_at;
    _InfoModel.audit_memo = (_InfoModel.audit_memo == nil)?@"":_InfoModel.audit_memo;
    _InfoModel.is_disabled = (_InfoModel.is_disabled == nil)?@"":_InfoModel.is_disabled;
    _InfoModel.created_at = (_InfoModel.created_at == nil)?@"":_InfoModel.created_at;
    _InfoModel.updated_at = (_InfoModel.updated_at == nil)?@"":_InfoModel.updated_at;
    
    _InfoModel.IDFrontImg = (_InfoModel.IDFrontImg == nil)?_imageView1.image:_InfoModel.IDFrontImg;
    _InfoModel.IDBackImg = (_InfoModel.IDBackImg == nil)?_imageView2.image:_InfoModel.IDBackImg;
    _InfoModel.cardIDFrontImg = (_InfoModel.cardIDFrontImg == nil)?_imageView3.image:_InfoModel.cardIDFrontImg;
    _InfoModel.cardIDBackImg = (_InfoModel.cardIDBackImg == nil)?_imageView4.image:_InfoModel.cardIDBackImg;
    if (!_ischooseSex && _InfoModel.gender == 0) {
        _InfoModel.gender = 2;
    }
}

- (void)naocaiCunchu
{
    self.fm = [NSFileManager defaultManager];
    
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //取得第一个Documents文件夹的路径
    
    NSString *filePath = [pathArray objectAtIndex:0];
    
    //把TestPlist文件加入
    
    self.plistPath = [filePath stringByAppendingPathComponent:@"DriverCache.plist"];
    
   
    
    if (![self.fm fileExistsAtPath:self.plistPath]) {
      
    //开始创建文件
     [self.fm createFileAtPath:self.plistPath contents:nil attributes:nil];
  
    }
    
    
    
    
    if (![self.photoDictionary objectForKey:@"img1"]) {
        
        [self.photoDictionary setObject:@"" forKey:@"img1"];
    }
    
    if (![self.photoDictionary objectForKey:@"img2"]) {
        
        [self.photoDictionary setObject:@"" forKey:@"img2"];
    }
    
    if (![self.photoDictionary objectForKey:@"img3"]) {
        
        [self.photoDictionary setObject:@"" forKey:@"img3"];
    }
    
    if (![self.photoDictionary objectForKey:@"img4"]) {
        
        [self.photoDictionary setObject:@"" forKey:@"img4"];
    }
    
    [self.cacheDictionary setObject:self.photoDictionary forKey:@"photo"];
    
    [self.cacheDictionary writeToFile:self.plistPath atomically:YES];
    
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:3];
   
    WL_Application_Driver_inforMation_TableViewCell3 *cell = [_InforMationTableView cellForRowAtIndexPath:path];
    [cell.inputTextView resignFirstResponder];

    [self.navigationController popViewControllerAnimated:YES];

}
#pragma mark----修改回调代理
-(void)changeDriverInformation:(WL_Application_Driver_ChangeInformation_VC *)VC Str:(NSString *)strImage index:(NSIndexPath *)path
{
    if (path.section==1) {
        if (path.row==0) {
            //姓名
            _InfoModel.name = strImage;
        }
        else if (path.row==3)
        {
           //联系电话
            _InfoModel.mobile = strImage;
        }
        else if (path.row==5)
        {
           //详细地址
            _InfoModel.address = strImage;
        }
        else if (path.row==6)
        {
           //省份证号
            _InfoModel.id_card = strImage;
        }
        [_rightTitleTopArr replaceObjectAtIndex:path.row withObject:strImage];
    }
    else
    {
        if (path.row==0) {
            _InfoModel.driving_license = strImage;

        }
      [_rightTitleCenterArr replaceObjectAtIndex:path.row withObject:strImage];
    }
    [_InforMationTableView reloadData];
}
#pragma mark----选择年龄和性别
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
    self.choseType = @"age";
    _pickBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _pickBackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [[UIApplication sharedApplication].keyWindow addSubview:_pickBackView];
    _pickBackView.hidden = YES;
    //选择器
    //性别选择器
    _chosePickView = [[UIPickerView alloc] init];
    _chosePickView.frame = CGRectMake(0, ScreenHeight-height, ScreenWidth, height);
    _chosePickView.backgroundColor = [UIColor whiteColor];
    _chosePickView.delegate = self;
    _chosePickView.dataSource = self;
    _chosePickView.userInteractionEnabled = YES;
    [_pickBackView addSubview:_chosePickView];
    UITapGestureRecognizer *timeViewHidenTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenTimeVew)];
    [_pickBackView addGestureRecognizer:timeViewHidenTap];
    //创建日期的轮播
   
    UIView *btnView = [[UIView alloc] init];
    btnView.frame = CGRectMake(0, ScreenHeight-height-btnHeight, ScreenWidth, btnHeight);
    btnView.backgroundColor = [UIColor whiteColor];
    [_pickBackView addSubview:btnView];
    //取消按钮
    UIButton *btnTap = [UIButton buttonWithType:UIButtonTypeSystem];
    btnTap.frame = CGRectMake(5, topHeiht, 50, btnHeight-2*topHeiht);
    [btnTap addTarget:self action:@selector(timeFrombtn:) forControlEvents:UIControlEventTouchUpInside];
    btnTap.tag = 501;
    [btnTap setTintColor:[WLTools stringToColor:@"#00cc99"]];
    [btnTap setTitle:@"取消" forState:UIControlStateNormal];
    [btnView addSubview:btnTap];
    //确定按钮
    UIButton *btnTap2 = [UIButton buttonWithType:UIButtonTypeSystem];
    btnTap2.frame = CGRectMake(ScreenWidth-55, topHeiht, 50, btnHeight-2*topHeiht);
    [btnTap2 addTarget:self action:@selector(timeFrombtn:) forControlEvents:UIControlEventTouchUpInside];
    btnTap2.tag = 502;
    [btnTap2 setTintColor:[WLTools stringToColor:@"#00cc99"]];
    [btnTap2 setTitle:@"确定" forState:UIControlStateNormal];
    [btnView addSubview:btnTap2];
}
#pragma mark----出生日期的选择和取消按钮
-(void)timeFrombtn:(UIButton *)btn
{
    if (btn.tag == 501) {
        //取消按钮点击
    }
    else
    {
        if ([self.choseType isEqualToString:@"age"]) {
            //年龄
            [_rightTitleTopArr replaceObjectAtIndex:1 withObject:self.didSelectStr];
        }
        else if ([self.choseType isEqualToString:@"sex"])
        {
            //性别
             [_rightTitleTopArr replaceObjectAtIndex:2 withObject:self.didSelectStr];
        }
        
        else if ([self.choseType isEqualToString:@"driver"])
        {
            //驾龄
             [_rightTitleCenterArr replaceObjectAtIndex:1 withObject:self.didSelectStr];
        }
  
    }
    [self.InforMationTableView reloadData];
    [self hiddenTimeVew];
    
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
    
    [_pickBackView.layer addAnimation:animation forKey:nil];
    _pickBackView.hidden = isHidden;
    
    if (isHidden == YES) {
        self.choseType = @"";
    }
 }
#pragma mark-----选择器数据源
-(void)creatDataSourceArr
{
    //年龄
    self.arrAge = [[NSMutableArray alloc] init];
    for (int i =10 ; i<65; i++) {
        NSString *str = [NSString stringWithFormat:@"%d",i];
        [self.arrAge addObject:str];
    }
    //驾龄
    self.arrDriverAge = [[NSMutableArray alloc] init];
    for (int i =1 ; i<40; i++) {
        NSString *str = [NSString stringWithFormat:@"%d",i];
        [self.arrDriverAge addObject:str];
    }
    //性别
     self.arrSex = [[NSMutableArray alloc] initWithObjects:@"女",@"男", nil];

  
}

#pragma mark-----pickerView代理
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([self.choseType isEqualToString:@"age"]) {
        return self.arrAge.count;
    }
    else if ([self.choseType isEqualToString:@"sex"])
    {
        return self.arrSex.count;
    }
    
    else if ([self.choseType isEqualToString:@"driver"])
    {
        return self.arrDriverAge.count;
    }
    return 0;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([self.choseType isEqualToString:@"age"]) {
        return [self.arrAge objectAtIndex:row];
    }
    else if ([self.choseType isEqualToString:@"sex"])
    {
        return [self.arrSex objectAtIndex:row];
    }
    
    else if ([self.choseType isEqualToString:@"driver"])
    {
        return [self.arrDriverAge objectAtIndex:row];
    }
    return nil;

    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([self.choseType isEqualToString:@"age"]) {
        self.didSelectStr = [self.arrAge objectAtIndex:row];
//         self.perinfoModel.age = self.didSelectStr;
        
        [self.cacheDictionary setObject:self.didSelectStr forKey:@"age"];
            }
    else if ([self.choseType isEqualToString:@"sex"])
    {
        self.didSelectStr = [self.arrSex objectAtIndex:row];
       
        //性别修改
        if ([self.didSelectStr isEqualToString:@"女"]) {
            _InfoModel.gender = 0;
            
            [self.cacheDictionary setObject:@"0" forKey:@"sex"];
        }
        else
        {
            _InfoModel.gender = 1;
            
            [self.cacheDictionary setObject:@"1" forKey:@"sex"];
        }

    }
    
    else if ([self.choseType isEqualToString:@"driver"])
    {
        self.didSelectStr = [self.arrDriverAge objectAtIndex:row];
        
        [self.cacheDictionary setObject:self.didSelectStr forKey:@"years"];
    }
    
}
#pragma mark-----下载数据
-(void)loadDriverInforFromServer
{
    //显示菊花
    [self showHud];
    [WLNetworkManager requestDriverInfoWithResultBlock:^(BOOL success, NSString *message, NSDictionary *dataDic) {
        
        //隐藏菊花
        [self hidHud];
        
        if (success) {
            self.IsInfomation = YES;
            _InfoDatamodel = [[WLDriverInfoDataModel alloc] initWithDict:dataDic];

            // 是否可以编辑
            if ([_InfoDatamodel.opt_status integerValue] == 1) {
                self.canEdit = NO;
            }
            else if ([_InfoDatamodel.opt_status integerValue] == 2)
            {
                self.canEdit = YES;
            }
            
            for (WLDriverInfoImgModel * mmodel in _InfoDatamodel.ImgArray) {
                if ([mmodel.name isEqual:@"identity1"]) {
                    _image1Set = YES;
                }
                if ([mmodel.name isEqual:@"identity2"]) {
                    _image2Set = YES;
                }
                if ([mmodel.name isEqual:@"driverimg1"]) {
                    _image3Set = YES;
                }
                if ([mmodel.name isEqual:@"driverimg2"]) {
                    _image4Set = YES;
                }
            }
            _InfoModel = [[WLDriverInfoModel alloc] initWithDict:_InfoDatamodel.InfoDic];
            
            if (_InfoModel.audit_status == 0) {
                _driverStatus = WLDriverStatusAuthenticationFailed;
            }
            _audit_memo = _InfoModel.audit_memo;
            
            [self reloadNewdataFromServer:_InfoModel];
        }
        else
        {
            _InfoModel = [[WLDriverInfoModel alloc] init];
            _InfoModel.mobile = (_InfoModel.mobile == nil)?[WLUserTools getUserMobile]:_InfoModel.mobile;
            self.IsInfomation = NO;
            
            if (_driverStatus == WLDriverStatusUnAutherized) {
                self.canEditChange = YES;
                [self archiveData];
            }
        }
    }];
}

-(void)reloadNewdataFromServer:(WLDriverInfoModel *)infoModel
{
    [self.rightTitleTopArr replaceObjectAtIndex:0 withObject:infoModel.name];
    
    if (![infoModel.birthday isEqual:@"0"]) {
        if ([infoModel.birthday isEqual:@""]) {
            [self.rightTitleTopArr replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@""]];
        }
        else
        {
            //当前年份
            NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
            formatter1.dateFormat = @"yyyy";
            //formatter1.dateFormat = @"yyyyMMddHHmmss";
            NSString *str1 = [formatter1 stringFromDate:[NSDate date]];
            
            NSInteger changeage = [str1 integerValue] - [[WLDataHotelHandler TimeIntervalChangeWithYYString:infoModel.birthday] integerValue];
            
            [self.rightTitleTopArr replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%ld",(long)changeage]]; // 生日时间戳，要转换
        }
    }
    else
    {
        [self.rightTitleTopArr replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@""]];
    }
    
    if (infoModel.gender == 0) {
        if (_driverStatus == WLDriverStatusUnAutherized && !_isarchiveDataSex) {
            [self.rightTitleTopArr replaceObjectAtIndex:2 withObject:@""];
        }
        else
        {
            [self.rightTitleTopArr replaceObjectAtIndex:2 withObject:@"女"];
        }
    }
    else if(infoModel.gender == 1)
    {
        [self.rightTitleTopArr replaceObjectAtIndex:2 withObject:@"男"];
    }
    else
    {
        [self.rightTitleTopArr replaceObjectAtIndex:2 withObject:@"未知"];
    }
    
    if (_IsInfomation) {
        if ([_InfoDatamodel.province isEqual:@"0"]) {
            _InfoDatamodel.province = @"";
            _InfoDatamodel.city = @"";
            [self.rightTitleTopArr replaceObjectAtIndex:4 withObject:[NSString stringWithFormat:@""]];
        }
        else
        {
            [self.rightTitleTopArr replaceObjectAtIndex:4 withObject:[NSString stringWithFormat:@"%@-%@",_InfoDatamodel.province,_InfoDatamodel.city]];
        }
    }
    else
    {
        [self.rightTitleTopArr replaceObjectAtIndex:4 withObject:[NSString stringWithFormat:@""]];
    }
    
    [self.rightTitleTopArr replaceObjectAtIndex:3 withObject:infoModel.mobile];
//    [self.rightTitleTopArr replaceObjectAtIndex:4 withObject:[NSString stringWithFormat:@"%@-%@",_InfoDatamodel.province,_InfoDatamodel.city]];
    [self.rightTitleTopArr replaceObjectAtIndex:5 withObject:infoModel.address];
    [self.rightTitleTopArr replaceObjectAtIndex:6 withObject:infoModel.id_card];
    //第二分区
    [self.rightTitleCenterArr replaceObjectAtIndex:0 withObject:infoModel.driving_license];
    //第三分区
    [self.rightTitleBottomArr replaceObjectAtIndex:0 withObject:infoModel.memo];

    for (WLDriverInfoImgModel * model in _InfoDatamodel.ImgArray) {
        [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",model.base_url,model.path]] placeholderImage:[UIImage imageNamed:@"WLPersonInfoIDCardFont"]];
        [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",model.base_url,model.path]] placeholderImage:[UIImage imageNamed:@"WLPersonInfoIDCardBack"]];
        
        [self.imageView4 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",model.base_url,model.path]] placeholderImage:[UIImage imageNamed:@"WLPersonInfoIDCardFont"]];
        
        [self.imageView3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",model.base_url,model.path]] placeholderImage:[UIImage imageNamed:@"WLPersonInfoIDCardBack"]];
    }
    
    //刷新数据
    [self.InforMationTableView reloadData];
}

#pragma mark----点击提交
-(void)NavigationRightEvent
{
    if (!_canEdit) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你当前有尚未出发或未结束的订单，不能编辑！！" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if (_canEditChange) {
        _canEditChange = NO;
        [self setNavigationRightTitle:@"编辑" fontSize:15 titleColor:[WLTools stringToColor:@"#00cc99"] isEnable:YES];
        [self isSendInfo];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"编辑后需要重新提交审核，确认是否编辑？！" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"确认编辑",nil];
        alert.tag = 19900820;
        [alert show];
    }
}

- (void)isSendInfo
{
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:3];
    WL_Application_Driver_inforMation_TableViewCell3 *cell = [self.InforMationTableView cellForRowAtIndexPath:path];
    _InfoModel.memo = cell.inputTextView.text;
    
    if(_IsInfomation)
    {
        if ([self editisNull]) {
            //[[WL_TipAlert_View sharedAlert] createTip:@"姓名、手机号不能为空"];
            
            _canEditChange = YES;
            [self setNavigationRightTitle:@"提交" fontSize:15 titleColor:[WLTools stringToColor:@"#00cc99"] isEnable:YES];
            
            return;
        }
        
        if ([_InfoModel.province_id isEqual:@"0"]) {
            _InfoModel.province_id = @"";
        }
        if ([_InfoModel.city_id isEqual:@"0"]) {
            _InfoModel.city_id = @"";
        }
        if ([_InfoModel.birthday isEqual:@"0"]) {
            _InfoModel.birthday = @"";
        }
        
        //显示菊花
        [self showHud];
        [[WLNetworkDriverHandler sharedInstance] requestEditDriverInfoWith:_InfoModel ResultBlock:^(BOOL success, NSString *message) {
            //隐藏菊花
            [self hidHud];
            
            if (success) {
                [[WL_TipAlert_View sharedAlert] createTip:@"提交信息成功"];
                [_InforMationTableView reloadData];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                [[WL_TipAlert_View sharedAlert] createTip:message];
            }
        }];
    }
    else
    {
        [self adddriverInfo];
    }
}

- (void)adddriverInfo
{
    if ([self isNull]) {
        _canEditChange = YES;
        [self setNavigationRightTitle:@"提交" fontSize:15 titleColor:[WLTools stringToColor:@"#00cc99"] isEnable:YES];
        
        return;
    }
    _InfoModel.IDFrontImg = self.imageView1.image;
    _InfoModel.IDBackImg = self.imageView2.image;
    _InfoModel.cardIDFrontImg = self.imageView3.image;
    _InfoModel.cardIDBackImg = self.imageView4.image;
    //显示菊花
    [self showHud];
    
    [[WLNetworkDriverHandler sharedInstance] requestAddDriverInfoWith:_InfoModel ResultBlock:^(BOOL success, NSString *message) {
        //隐藏菊花
        [self hidHud];
        
        if (success) {
            [[WL_TipAlert_View sharedAlert] createTip:@"提交信息成功"];
            _driverStatus = WLDriverStatusReviewing;
            [_InforMationTableView reloadData];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [[WL_TipAlert_View sharedAlert] createTip:@"网络请求失败,请稍后重试"];
        }
    }];
}

- (BOOL)isNull
{
    
    if (_InfoModel.name.length == 0) {
        [[WL_TipAlert_View sharedAlert] createTip:@"姓名不能为空"];
        return YES;
    }
    if (_InfoModel.mobile.length == 0) {
        [[WL_TipAlert_View sharedAlert] createTip:@"手机号不能为空"];
        return YES;
    }
    if (_InfoModel.province_id == nil||_InfoModel.city_id == nil||[_InfoModel.province_id integerValue] == 0||[_InfoModel.city_id integerValue] == 0) {
        [[WL_TipAlert_View sharedAlert] createTip:@"现居城市不能为空"];
        return YES;
    }
    if (!self.image1Set || !self.image2Set || !self.image3Set || !self.image4Set) {
        [[WL_TipAlert_View sharedAlert] createTip:@"证件照不能为空"];
        return YES;
    }
    return NO;
}

- (BOOL)editisNull
{
    if (_InfoModel.name.length == 0) {
        [[WL_TipAlert_View sharedAlert] createTip:@"姓名不能为空"];
        return YES;
    }
    if (_InfoModel.mobile.length == 0) {
        [[WL_TipAlert_View sharedAlert] createTip:@"手机号不能为空"];
        return YES;
    }

  if (_InfoModel.province_id == nil||_InfoModel.city_id == nil||[_InfoModel.province_id integerValue] == 0||[_InfoModel.city_id integerValue] == 0) {
        [[WL_TipAlert_View sharedAlert] createTip:@"现居城市不能为空"];
        return YES;
    }

    return NO;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==19900820) {
        
        if (buttonIndex==0) {
  
        }else if (buttonIndex==1)
        {
            _canEditChange = YES;
            [self setNavigationRightTitle:@"提交" fontSize:15 titleColor:[WLTools stringToColor:@"#00cc99"] isEnable:YES];
            [_InforMationTableView reloadData];
        }
        
    }else if (alertView.tag==103)
        
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark----编辑状态单独修改资料

-(void)editInfomationAnd:(NSDictionary*)dict

{
    [self showHudWithString:@"保存中..."];
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager] requestWithURL:DriverEditDriverUrl RequestType:RequestTypePost Parameters:dict Success:^(id responseObject) {
       
        [weakSelf hidHud];
   
        if ([responseObject[@"status"]integerValue]==1) {
            
             UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"您的个人信息已成功提交审核,工作人员将在3～5个工作日内完成审核，请耐心等待" delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
            
            alertView.tag =103;
            
            [alertView show];
            
        }else{
        
            [self.AlertTitle createTip:responseObject[@"msg"]];
            
        }

    } Failure:^(NSError *error) {
        [weakSelf hidHud];
        [self.AlertTitle createTip:@"保存失败"];
        
    }];

}

#pragma mark----通知改变信息的方法---选择城市
-(void)DriverchangeAddressBack:(NSNotification *)dict
{
    [self.rightTitleTopArr replaceObjectAtIndex:4 withObject:[NSString stringWithFormat:@"%@",dict.userInfo[@"address"]]];
    [self.InforMationTableView reloadData];
   
}



-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark----字典转json
- (NSString*)dictionaryToJson:(NSDictionary *)dic {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
#pragma mark----创建弹出框
-(void)creatPersonAlertView
{
    self.AlertTitle = [WL_TipAlert_View sharedAlert];
}
#pragma mark----创建图片保存的
-(void)creatUiImageViewImage
{
    CGFloat width,boreHeight;
    if (IsiPhone4||IsiPhone5) {
        width = (ScreenWidth-180+20+30)/2;
        boreHeight = 80;
        
    }
    else
    {
        width = (ScreenWidth-180)/2;
        boreHeight = 85;
       
        
    }
  
    self.imageView1 = [[UIImageView alloc] init];
    self.imageView1.frame = CGRectMake(0, 0, width, boreHeight);
    self.imageView1.image = [UIImage imageNamed:@"WLPersonInfoIDCardFont"];
  //  [self.view addSubview:self.imageView1];
    self.imageView2 = [[UIImageView alloc] init];
    self.imageView2.frame = CGRectMake(0, 0, width, boreHeight);
    self.imageView2.image = [UIImage imageNamed:@"WLPersonInfoIDCardBack"];
  //  [self.view addSubview:self.imageView2];
    self.imageView3 = [[UIImageView alloc] init];
    self.imageView3.frame = CGRectMake(0, 0, width, boreHeight);
    self.imageView3.image = [UIImage imageNamed:@"WLPersonInfoIDCardFont"];
  //  [self.view addSubview:self.imageView3];
    self.imageView4 = [[UIImageView alloc] init];
    self.imageView4.frame = CGRectMake(0, 0, width, boreHeight);
    self.imageView4.image = [UIImage imageNamed:@"WLPersonInfoIDCardBack"];
   // [self.view addSubview:self.imageView4];
}

// 照片查看器==
- (void)showImg:(UIImage *)Img urlstr:(NSString *)Imgurl
{
    __weak __typeof(self)weakSelf = self;
    
    WLPhotoCheckView * imgView = [[WLPhotoCheckView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) image:Img imageUrl:[NSURL URLWithString:Imgurl] tapAction:^{
        //[imgView removeFromSuperview];
        
        [weakSelf.checkView removeFromSuperview];
        weakSelf.checkView = nil;
        
    } modifyAction:^(BOOL isDelete){
        BOOL isAllEditor;
        if (!isAllEditor) {
            // 弹框提示
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"提示"
                                  message:@"资料处于可编辑状态时，才能更换照片资料。"
                                  delegate:self
                                  cancelButtonTitle:@"知道了"
                                  otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        else
        {
            //设置头像
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"更换照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
            [actionSheet showInView:self.view];
        }
        
        [weakSelf.checkView removeFromSuperview];
        weakSelf.checkView = nil;
    }];
    
    [self.navigationController.view addSubview:imgView];
    
    self.checkView = imgView;
}

@end
